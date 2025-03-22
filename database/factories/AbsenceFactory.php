<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Absence;
use App\Models\User;
use Faker\Generator as Faker;

$factory->define(Absence::class, function (Faker $faker):array {
    $value = \App\Enums\AbsenceReason::values();
    $index = array_rand($value);
    $reason=$value[$index];
    return [
        'external_id' => \Ramsey\Uuid\Uuid::uuid4()->toString(),
        // 'reason' => $faker->word,
        'reason' => $reason->getReason(),
        'start_at' => now(),
        'end_at' => now()->addDays(3),
        'user_id' => factory(User::class),
    ];
});