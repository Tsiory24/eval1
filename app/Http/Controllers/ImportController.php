<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ImportController extends Controller
{
    public function sendForm()
    {
        $types = ['payment', 'invoice'];
        return view('pages.importCsv', compact('types'));
    }

    /**
     * Gérer l'importation du fichier CSV
     */
    public function upload(Request $request)
    {
        //$request->validate([
          //  'file' => 'required|mimes:csv,txt|max:2048',
            //'type' => 'required|in:payment,invoice',
        //]);

        //$type = $request->input('type');

        // Stocker le fichier
        //$filePath = $request->file('file')->store('csv_files');

        return redirect()->back()->with('success', "Le fichier CSV a été importé avec succès !");
    }
}
