<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\Invoice;
use App\Models\InvoiceLine;
use App\Models\Offer;
use App\Models\Payment;
use App\Services\Dashboard\DashboardService;
use App\Utils\ResponseUtil;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashBoardApiController extends Controller
{

    protected $dashboardService;

    public function __construct(DashboardService $dashboardService){
        $this->dashboardService = $dashboardService;
    }

    

    public function dashboard(Request $request)
    {
        $year = $request->input('year',2025);
        $dashboard = $this->dashboardService->dashboard($year);
        return $dashboard;
    }

  
    
}
