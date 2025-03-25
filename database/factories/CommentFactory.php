<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */


use App\Models\Task;
use App\Models\User;
use App\Models\Comment;
use Faker\Generator as Faker;


$factory->define(Comment::class, function (Faker $faker) {
    $task = factory(Task::class)->create();
    $user = User::where('id', '!=', 1)->inRandomOrder()->first();

    return [
        'external_id' => \Ramsey\Uuid\Uuid::uuid4()->toString(),
        'user_id' => $user->id,
        'source_type' => Task::class,
        'source_id' => $task->id,
        'description' => $faker->paragraph(rand(2, 10))
    ];
});
