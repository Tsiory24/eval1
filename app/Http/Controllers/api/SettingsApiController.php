<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\Setting;
use App\Utils\ResponseUtil;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class SettingsApiController extends Controller
{
    public function index(){
        $settings = Setting::first();
        return ResponseUtil::responseStandard(
            'success',
            [
                'remise' => $settings,
            ]
        );
    }

    public function update(Request $request){
        DB::beginTransaction();
        try {
            $remise = $request->input('remise');
            if (!$remise) {
                return ResponseUtil::responseStandard(
                    'error',
                    null,
                    'remise requis'
                );
            }
            $settings = Setting::first();
            $settings->remise = $remise;
            $settings->save();
            DB::commit();
            return ResponseUtil::responseStandard(
                'success',
                ['message' => 'remise mis a jour avec success'],
                null
            );
        } catch (\Throwable $th) {
            DB::rollBack();
        }

    }
}
