<?php
namespace App\Services\Offer;

use App\Enums\OfferStatus;
use App\Models\Offer;
use Illuminate\Support\Facades\DB;

class OfferService
{
    public function offers(){
        $offers = Offer::with('client:id,company_name')->get();
        return $offers;
    }

    public function offerByStatus(){
        $invoiceStats= DB::select("
            SELECT status , count(id) as total from offers group by status
        ");

        $statMap = [];
        foreach ($invoiceStats as $stat) {
            $statMap[$stat->status] = $stat->total;
        }
        $statuses = OfferStatus::values();
        $totalStatus = [];
        foreach ($statuses as $status) {
            $total = $statMap[$status->getStatus()] ?? 0;
            $totalStatus[] = ['status' => $status->getStatus() , 'total' => $total];
        }
        return $totalStatus;
    }
}