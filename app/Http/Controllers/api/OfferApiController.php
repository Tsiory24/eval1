<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\Offer;
use App\Models\Setting;
use App\Utils\ResponseUtil;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class OfferApiController extends Controller
{
    public function offers()
    {
        $offers = Offer::with('client:id,company_name')->get();

        return ResponseUtil::responseStandard(
            'success',
            [
                'offers' => $offers,
            ]
        );
    }
}
