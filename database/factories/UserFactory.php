<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Models\Department;
use App\Models\User;
use Faker\Generator as Faker;

$factory->define(User::class, function (Faker $faker) {
    return [
        'name' => $faker->name,
        'external_id' => $faker->uuid,
        'email' => $faker->email,
        'password' => bcrypt('password'),
        'address' => $faker->secondaryAddress(),
        'primary_number' => $faker->randomNumber(8),
        'secondary_number' => $faker->randomNumber(8),
        'remember_token' => null,
        'language' => 'en',
    ];
});

$factory->afterCreating(User::class, function ($user, $faker) {
    $departement = Department::inRandomOrder()->first();
    $user->department()->attach($departement->id);
});
