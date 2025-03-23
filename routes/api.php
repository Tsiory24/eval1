<?php

use Illuminate\Http\Request;
use App\Http\Controllers\api\AuthApiController;
use App\Http\Controllers\api\DashBoardApiController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::group(['namespace' => 'App\Api\v1\Controllers'], function () {
    Route::group(['middleware' => 'auth:api'], function () {
        Route::get('users', ['uses' => 'UserController@index']);
    });
});

Route::group(['prefix' => 'authentification'], function () {
    Route::post('/login', [AuthApiController::class, 'login']);
    Route::get('/logout', [AuthApiController::class, 'logout']);
});
Route::group(['prefix' => 'dashboard'], function () {
    Route::get('/', [DashBoardApiController::class, 'dashboard'])->name('api.dashborad');
    Route::get('/offers', [DashBoardApiController::class, 'offers'])->name('api.offers');
    Route::get('/invoices', [DashBoardApiController::class, 'invoices'])->name('api.invoices');
    Route::get('/payments', [DashBoardApiController::class, 'payments'])->name('api.payments');
    Route::get('/aPayer', [DashBoardApiController::class, 'aPayer'])->name('api.aPayer');
    Route::get('/detailsSommePrixInvoices', [DashBoardApiController::class, 'detailsSommePrixInvoices'])->name('api.detailsSommePrixInvoices');
});

