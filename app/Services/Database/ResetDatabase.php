<?php

namespace App\Services\Database;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Schema;

use Illuminate\Support\Facades\DB;

    class ResetDatabase{
        protected $excludedTables = [
            'business_hours',
            'departments',
            'industries',
            'migrations',
            'permissions',
            'permission_role',
            'role_user',
            'roles',
            'settings',
            'statuses'
        ];
        public function resetDatabase()
        {
            $superUser = Auth::user();

            if (!$superUser || (!$superUser->hasRole('administrator') && !$superUser->hasRole('owner'))) {
                return response()->json(['Message' => "Seuls les administrateurs peuvent reinitialiser la base de donnee"]);
            }

            $adminId = $superUser->id;

            try {
                // Désactiver les contraintes de clés étrangères
                Schema::disableForeignKeyConstraints();

                $tables = DB::select('SHOW TABLES');
                $tables = array_map('current', $tables);

                foreach ($tables as $table) {
                    if ($table === 'users') {
                        DB::table($table)->where('id', '!=', $adminId)->delete();
                    } elseif ($table === 'department_user' || $table === 'role_user') {
                        DB::table($table)->where('user_id', '!=', $adminId)->delete();
                    } elseif (!in_array($table, $this->excludedTables)) {
                        DB::table($table)->truncate();
                    }
                }

                // Réactiver les contraintes de clés étrangères
                Schema::enableForeignKeyConstraints();

                return response()->json(["Message" => "La base de donnee a ete reinitialise"]);
            } catch (\Exception $e) {
                return response()->json(["Message" => $e->getMessage(),"status" => "error"]);
            }
        }
    }

?>