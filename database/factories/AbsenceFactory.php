<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Absence;
use App\Models\User;
use Faker\Generator as Faker;

$factory->define(Absence::class, function (Faker $faker) {

    return [
        'external_id' => \Ramsey\Uuid\Uuid::uuid4()->toString(),
        'reason' => array_rand(\App\Enums\AbsenceReason::values()),
        'start_at' => now(),
        'end_at' => now()->addDays(3),
        'user_id' => 1,
    ];
});
