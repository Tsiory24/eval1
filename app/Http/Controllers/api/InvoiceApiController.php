<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\InvoiceLine;
use App\Models\Offer;
use App\Models\Setting;
use App\Services\Invoice\InvoiceService;
use App\Utils\ResponseUtil;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class InvoiceApiController extends Controller
{
    protected $invoiceService;

    public function __construct(InvoiceService $invoiceService){
        $this->invoiceService = $invoiceService;
    }

    public function invoices()
    {
        $invoices = $this->invoiceService->invoices();
        return $invoices;
    }

    public function detailsSommePrixInvoices(){
        $detailsSommePrixInvoices = $this->invoiceService->detailsSommePrixInvoices();
        return $detailsSommePrixInvoices;
    }
}
