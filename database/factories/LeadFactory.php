<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Lead;
use App\Models\Client;
use App\Models\User;
use Faker\Generator as Faker;

$factory->define(Lead::class, function (Faker $faker) {
    $client = Client::inRandomOrder()->first();

    return [
        'title' => $faker->sentence,
        'external_id' => $faker->uuid,
        'description' => $faker->paragraph,
        'user_created_id' => 1,
        'user_assigned_id' => 1,
        'client_id' => $client->id,
        'status_id' => $faker->numberBetween(2, 7),
        'deadline' => $faker->dateTimeThisYear('now'),
        'created_at' => $faker->dateTimeThisYear('now'),
        'updated_at' => $faker->dateTimeThisYear('now'),
    ];
});

$factory->afterCreating(Lead::class, function ($lead, $faker) {
    $offersCount = $faker->numberBetween(0, 5);

    for ($i = 0; $i < $offersCount; $i++) {
        factory(\App\Models\Offer::class)->create([
            'client_id' => $lead->client_id,
            'source_id' => $lead->id,
        ]);
    }
});
