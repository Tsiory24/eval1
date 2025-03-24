<?php

use Illuminate\Http\Request;
use App\Http\Controllers\api\AuthApiController;
use App\Http\Controllers\api\DashBoardApiController;
use App\Http\Controllers\api\InvoiceApiController;
use App\Http\Controllers\api\OfferApiController;
use App\Http\Controllers\api\PaymentApiController;
use App\Http\Controllers\api\SettingsApiController;

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
    Route::get('/aPayer', [DashBoardApiController::class, 'aPayer'])->name('api.aPayer');
});

Route::group(['prefix' => 'offers'], function () {
    Route::get('/', [OfferApiController::class, 'offers'])->name('api.offers');
});

Route::group(['prefix' => 'invoices'], function () {
    Route::get('/', [InvoiceApiController::class, 'invoices'])->name('api.invoices');
    Route::get('/detailsSommePrixInvoices', [InvoiceApiController::class, 'detailsSommePrixInvoices'])->name('api.detailsSommePrixInvoices');
});

Route::group(['prefix' => 'payment'], function () {
    Route::post('/update', [PaymentApiController::class, 'updatePayment'])->name('api.updatePayment');
    Route::post('/delete', [PaymentApiController::class, 'deletePayment'])->name('api.deletePayment');
    Route::get('/payments', [PaymentApiController::class, 'payments'])->name('api.payments');
});

Route::group(['prefix' => 'settings'], function () {
    Route::get('/remise', [SettingsApiController::class, 'index'])->name('api.remise');
    Route::post('/update', [SettingsApiController::class, 'update'])->name('api.updateRemise');

});
