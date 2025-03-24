<?php

namespace App\Api\v1\Services;

use App\Models\Payment;
use App\Services\Invoice\GenerateInvoiceStatus;
use App\Services\Invoice\InvoiceCalculator;
use Exception;
use Illuminate\Support\Facades\DB;

class PaymentService
{
    public function updatePayement($externalId,$amount): void{
        DB::beginTransaction();
        try {
            $payment = Payment::where('external_id',$externalId)->first();
            $payment->amount = 0;
            $payment->save();
            $invoice = $payment->invoice()->first();
            $invoiceCalculator = new InvoiceCalculator($invoice);
            $amountDue = $invoiceCalculator->getAmountDue()->getAmount();
            if($amountDue < $amount){
                throw new Exception("le nouveau montant ".$amount." depasse le montant restant ".$amountDue." total price ".$invoiceCalculator->getTotalPrice()->getAmount()." sum paiments ".$invoiceCalculator->getInvoice()->payments()->sum('amount'));
            }
            $payment->amount = $amount;
            $status = new GenerateInvoiceStatus($invoice);
            $payment->save();
            $status->createStatus();
            DB::commit();
        } catch (\Throwable $th) {
            DB::rollBack();
            throw $th;
        }
        
    }
}
