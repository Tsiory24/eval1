<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Payment;
use App\Services\Invoice\GenerateInvoiceStatus;
use Carbon\Carbon;
use Faker\Generator as Faker;

$factory->define(Payment::class, function (Faker $faker) {
    $invoice = \App\Models\Invoice::where('status', '!=', 'paid')
        ->has('invoiceLines')
        ->inRandomOrder()
        ->first();

    if (!$invoice) {
        return [];
    }

    $totalAmount = $invoice->invoiceLines->sum(function ($line) {
        return $line->quantity * $line->price;
    });

    $paidAmount = $invoice->payments()->sum('amount');
    $remainingAmount = $totalAmount - $paidAmount;

    if ($remainingAmount <= 0) {
        return [];
    }

    return [
        'external_id' => $faker->uuid,
        'invoice_id' => $invoice->id,
        'amount' => $faker->randomFloat(2, 10, min($remainingAmount, $totalAmount / 2)),
        'payment_date' => $faker->dateTimeBetween($invoice->sent_at, 'now + 2 years'),
        'payment_source' => array_rand(\App\Enums\PaymentSource::values()),
    ];
});
$factory->afterCreating(Payment::class, function ($payment, $faker) {
    $invoice = \App\Models\Invoice::find($payment->invoice_id);

    if(!$invoice->isSent()){
        $invoice->sent_at =  Carbon::now();

    }
    if ($invoice) {
        $status = new GenerateInvoiceStatus($invoice);
        $status->createStatus();
    }
});