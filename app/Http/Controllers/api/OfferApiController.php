<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\Offer;
use App\Models\Setting;
use App\Utils\ResponseUtil;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Services\Offer\OfferService;

class OfferApiController extends Controller
{
    protected $offerService;

    public function __construct(OfferService $offerService){
        $this->offerService = $offerService;
    }
    public function offers()
    {
        // Récupérer les offres avec les clients associés
        $offers = $this->offerService->offers();

        // Compter les offres par statut
        $offersByStatus = $this->offerService->offerByStatus();
        

        return ResponseUtil::responseStandard(
            'success',
            [
                'offers' => $offers,
                'offers_by_status' => $offersByStatus,
            ]
        );
    }

}
