<?php
namespace App\Services\Invoice;

use App\Models\Offer;
use App\Models\Invoice;
use App\Models\InvoiceLine;
use App\Repositories\Tax\Tax;
use App\Repositories\Money\Money;
use App\Utils\ResponseUtil;
use Illuminate\Support\Facades\DB;

class InvoiceService
{
    public function invoices()
    {
        $invoices = DB::select("
            SELECT 
                i.id, 
                i.external_id, 
                i.status, 
                i.invoice_number, 
                i.created_at,
                i.sent_at, 
                i.due_at, 
                i.client_id, 
                c.company_name, 
                i.offer_id,
                COALESCE(SUM(il.price * il.quantity), 0) AS total_amount
            FROM invoices i
            LEFT JOIN clients c ON i.client_id = c.id
            LEFT JOIN invoice_lines il ON i.id = il.invoice_id
            GROUP BY i.id, c.company_name
        ");
    
        return ResponseUtil::responseStandard(
            'success',
            [
                'invoices' => $invoices,
            ]
        );
    }
    public function detailsSommePrixInvoices(){
        $detailsSommePrixInvoices = InvoiceLine::whereNotNull('invoice_id')->with('invoice')->get();
        return ResponseUtil::responseStandard(
            'success',
            [
                'detailsSommePrixInvoices' => $detailsSommePrixInvoices,
            ]
        );
    }
}