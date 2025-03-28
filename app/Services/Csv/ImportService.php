<?php

namespace App\Services\Csv;

use App\Services\Exception\ImportException;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Log;
use ReflectionClass;
use ReflectionProperty;

class ImportService
{
    
    public function importCsv(string $filePath, string $className, string $filename): Collection
    {
        if (!file_exists($filePath)) {
            throw new \Exception("File not found: {$filePath}");
        }

        $handle = fopen($filePath, 'r');
        if (!$handle) {
            throw new \Exception("Could not open file: {$filePath}");
        }

        
        $headers = fgetcsv($handle);
        if (!$headers) {
            fclose($handle);
            throw new \Exception("Empty or invalid CSV file");
        }

        $results = collect();
        $reflection = new ReflectionClass($className);
        $count = 2;        
        
        $error = [];

        while (($row = fgetcsv($handle)) !== false) {
            $data = array_combine($headers, $row);
            $instance = new $className();
            

            foreach ($data as $property => $value) {
                $setterMethod = 'set' . ucfirst($property);
            
                try {
                    if (method_exists($instance, $setterMethod)) {
                        $instance->$setterMethod($value);
                    } 
                    // else if ($reflection->hasProperty($property)) {
                    //     $reflectionProperty = $reflection->getProperty($property);
                    //     $reflectionProperty->setAccessible(true);
                    //     $parsedValue = $this->parseValue($reflectionProperty, $value);
                    //     $reflectionProperty->setValue($instance, $parsedValue);
                    // }
                } catch (Exception $e) {
                    $error[] = $filename." ligne ".$count." : ".$e->getMessage();
                }
            }
            
            
            $results->push($instance);
            $count++;
        }
        
        fclose($handle);
        if(count($error) > 0){
            throw new ImportException("", $error);
        }

        return $results;
    }
    
    
    private function parseValue(ReflectionProperty $property, string $value)
    {
        if (empty($value)) {
            return null;
        }
        
        
        $type = $this->getPropertyType($property);
        
        try {
            switch ($type) {
                case 'int':
                case 'integer':
                    return (int) $value;
                    
                case 'float':
                case 'double':
                    return (float) $value;
                    
                case 'bool':
                case 'boolean':
                    return filter_var($value, FILTER_VALIDATE_BOOLEAN);
                    
                case 'array':
                    return array_map('trim', explode(',', $value));
                    
                case 'datetime':
                    return Carbon::createFromFormat('Y-m-d H:i:s', $value);
                    
                case 'date':
                    return Carbon::createFromFormat('d/m/Y', $value)->startOfDay();
                    
                case 'time':
                    return Carbon::createFromFormat('H:i', $value);
                    
                default:
                    return $value; 
            }
        } catch (\Exception $e) {
            Log::warning("Error parsing value: {$value} for type: {$type}", [
                'exception' => $e->getMessage()
            ]);
            return null;
        }
    }
    
    
    private function getPropertyType(ReflectionProperty $property): string
    {
        
        if (PHP_VERSION_ID >= 70400 && $property->hasType()) {
            $type = $property->getType();
            return $type->getName();
        }
        
        
        $docComment = $property->getDocComment();
        if ($docComment) {
            if (preg_match('/@var\s+([^\s]+)/', $docComment, $matches)) {
                return strtolower($matches[1]);
            }
        }
        
        return 'string'; 
    }
}
?>