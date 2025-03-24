<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Utils\ResponseUtil;
use Illuminate\Http\Request;
use App\Api\v1\Services\PaymentService;
use App\Models\Payment;

class PaymentApiController extends Controller
{
    protected $paymentService;

    // Injection de dépendance pour PaymentService
    public function __construct(PaymentService $paymentService)
    {
        $this->paymentService = $paymentService;
    }

    public function updatePayment(Request $request)
    {
        // Récupérer les données envoyées
        $externalId = $request->input('externalId');
        $amount = $request->input('amount');
        // Validation des entrées
        if (!$externalId || !$amount) {
            return ResponseUtil::responseStandard(
                'error',
                null,
                'External ID et amount sont requis'
            );
        }

        try {
            // Appeler la méthode du PaymentService pour mettre à jour le paiement
            $this->paymentService->updatePayement($externalId, $amount);

            return ResponseUtil::responseStandard(
                'success',
                ['message' => 'Paiement mis à jour avec succès'],
                null
            );
        } catch (\Exception $e) {
            // Gérer les erreurs, retourner l'exception
            return ResponseUtil::responseStandard(
                'error',
                null,
                $e->getMessage()
            );
        }
    }

    public function deletePayment(Request $request)
{
    // Récupérer l'externalId de la requête
    $externalId = $request->input('externalId');

    // Vérifier si l'externalId est présent
    if (!$externalId) {
        return ResponseUtil::responseStandard(
            'error',
            null,
            'External ID est requis'
        );
    }

    try {
        // Trouver le paiement correspondant à l'externalId
        $payment = Payment::where('external_id', $externalId)->first();

        // Vérifier si le paiement existe
        if (!$payment) {
            return ResponseUtil::responseStandard(
                'error',
                null,
                'Paiement non trouvé'
            );
        }

        // Supprimer le paiement
        $payment->delete();

        // Retourner une réponse de succès
        return ResponseUtil::responseStandard(
            'success',
            null,
            'Paiement supprimé avec succès'
        );
    } catch (\Exception $e) {
        // Gérer les erreurs et retourner l'exception
        return ResponseUtil::responseStandard(
            'error',
            null,
            $e->getMessage()
        );
    }
}

  
public function payments(){
    $payements = Payment::all();
    return ResponseUtil::responseStandard(
        'success',
        [
            'payements' => $payements,
        ]
    );
}


}
