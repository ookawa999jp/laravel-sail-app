<?php

use App\Http\Controllers\GameController;
use App\Http\Controllers\UtilityController;
use Illuminate\Support\Facades\Route;

// Route::get('/', function () {
//     return view('welcome');
// });

Route::get('/hello', fn () => view('hello', [
    'name' => '田中',
    'course' => 'Laravel',
]));

Route::get('/', fn () => view('index'));
Route::get('/curriculum', fn () => view('curriculum'));

// 世界の時間
Route::get('/world-time', [UtilityController::class, 'worldTime']);

// おみくじ
Route::get('/omikuji', [GameController::class, 'omikuji']);

// モンティ・ホール問題
Route::get('/monty-hall', [GameController::class, 'montyHall']);
