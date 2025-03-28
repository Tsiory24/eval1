<?php
namespace App\Services\Dashboard;

use App\Http\Requests\Request;
use App\Models\Invoice;
use App\Models\InvoiceLine;
use App\Models\Offer;
use App\Models\Payment;
use App\Utils\ResponseUtil;
use Illuminate\Support\Facades\DB;

class DashboardService
{
    public function paymentMensuelle($year)
    {
        // Exécuter une requête SQL brute pour obtenir les paiements par mois, avec 0 pour les mois sans paiements
        $paymentsByMonth = DB::select(
            DB::raw('
                SELECT 
                    months.month,
                    COALESCE(SUM(p.amount), 0) AS total_amount
                FROM 
                    (SELECT 1 AS month UNION ALL 
                    SELECT 2 UNION ALL 
                    SELECT 3 UNION ALL 
                    SELECT 4 UNION ALL 
                    SELECT 5 UNION ALL 
                    SELECT 6 UNION ALL 
                    SELECT 7 UNION ALL 
                    SELECT 8 UNION ALL 
                    SELECT 9 UNION ALL 
                    SELECT 10 UNION ALL 
                    SELECT 11 UNION ALL 
                    SELECT 12) AS months
                LEFT JOIN payments p 
                    ON MONTH(p.payment_date) = months.month 
                    AND YEAR(p.payment_date) = :year
                    AND p.deleted_at IS NULL
                GROUP BY months.month
                ORDER BY months.month
            '),
            ['year' => $year]
        );
        return $paymentsByMonth;
    }

    public function nombreParTypePayment($year)
    {
        // Exécuter une requête SQL brute pour obtenir le nombre de paiements par type
        $paymentTypes = DB::select(
            DB::raw('
                SELECT payment_source, COUNT(*) AS payment_count
                FROM payments
                WHERE YEAR(payment_date) = :year
                GROUP BY payment_source
                ORDER BY payment_count DESC
            '),
            ['year' => $year]
        );

        // Retourner les résultats sous forme de réponse API
        
        return $paymentTypes;
    }

    public function paymentParAn()
    {
        // Exécuter une requête SQL brute pour obtenir la somme des paiements par année
        $paymentParYear = DB::select(
            DB::raw('
                SELECT 
                    YEAR(payment_date) AS year, 
                    SUM(amount) AS total_amount
                FROM 
                    payments
                where 
                    deleted_at is null
                GROUP BY 
                    YEAR(payment_date)
                ORDER BY 
                    year DESC
            ')
        );
        
        // Retourner la réponse sous forme de JSON
        return $paymentParYear;
    }

    public function invoiceLineParAn()
    {
        // Exécuter une requête SQL brute pour obtenir la somme des prix * quantités par année
        $invoiceLineParYear = DB::select(
            DB::raw('
                SELECT 
                    YEAR(created_at) AS year, 
                    SUM(price * quantity) AS total_amount
                FROM 
                    invoice_lines
                WHERE 
                    invoice_id IS NOT NULL  -- Filtrer les lignes avec un invoice_id non nul
                GROUP BY 
                    YEAR(created_at)  -- Grouper par année
                ORDER BY 
                    year DESC  -- Trier par année décroissante
            ')
        );

        // Retourner la réponse sous forme de JSON
        return $invoiceLineParYear;
    }

    public function aPayer(){
        $invoicelines = InvoiceLine::whereNotNull('invoice_id')->get();
        $payments = Payment::all();
        return ResponseUtil::responseStandard(
            'success',
            [
                'invoicelines' => $invoicelines,
                'payments' => $payments,
            ]
        );
    }

    public function dashboard($year)
    {
        $offersCount = Offer::count();
        
        $invoicesCount = Invoice::count();
        // $totalAmountInvoice = InvoiceLine::whereNotNull('invoice_id')->sum('price');
        // $totalAmountInvoice = InvoiceLine::whereNotNull('invoice_id')
        // ->selectRaw('SUM(price * quantity) as total_amount')
        // ->first();
        $totalAmountInvoice = InvoiceLine::whereNotNull('invoice_id')
            ->selectRaw('COALESCE(SUM(price * quantity), 0) as total_amount')
            ->first();
        $totalAmountInvoice = $totalAmountInvoice->total_amount;

        // $totalAmountInvoice = $totalAmountInvoice ? $totalAmountInvoice->total_amount : 0;
        $sumPayement = Payment::sum('amount');
        $sumPayementDue = $totalAmountInvoice - $sumPayement;
        $paymentMensuelles = $this->paymentMensuelle($year);
        $nombreParTypePayment = $this->nombreParTypePayment($year);
        $paymentParAn = $this->paymentParAn();
        $invoiceLineParAn = $this->invoiceLineParAn();
        // Envoi de la réponse avec toutes les données dans le format standard
        return ResponseUtil::responseStandard(
            'success',
            [
                'offers_count' => $offersCount,
                'invoices_count' => $invoicesCount,
                'total_amount_invoice' => $totalAmountInvoice,
                'sum_payment' => $sumPayement,
                'sum_payment_due' => $sumPayementDue,
                'payment_mensuelles' => $paymentMensuelles,
                'nombre_par_type_payment' => $nombreParTypePayment,
                'payment_par_an' => $paymentParAn,
                'invoiceline_par_an' => $invoiceLineParAn,
            ]
        );
    }

}