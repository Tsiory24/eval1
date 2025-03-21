<?php

namespace App\Services\Database;

use Illuminate\Support\Facades\DB;

    class ResetDatabase{
        public function resetDatabase(){
            DB::statement('SET FOREIGN_KEY_CHECKS=0;');

            $tablesExclues = ["migrations", "users", "roles", "role_user", "industries", "departments", "settings", "permissions", "business_hours", "permission_role", "statuses", "department_user"];

            $tables = DB::select("SHOW TABLES;");

            $databaseName = env('DB_DATABASE');

            $key = "Tables_in_{$databaseName}";

            foreach ($tables as $table) {
                $tableName = $table->$key;
                if (!in_array($tableName, $tablesExclues)) {
                    DB::table($tableName)->truncate();
                }
            }

            DB::statement('SET FOREIGN_KEY_CHECKS=1;');
        }
    }

?>