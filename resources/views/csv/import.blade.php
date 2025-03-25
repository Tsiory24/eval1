@extends('layouts.master')

@section('content')
    <div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
        <div class="col-lg-6">
            <div class="card shadow-lg">
                <div class="card-body text-center">
                    <h3 class="text-primary">{{ __('Importation Donnée') }}</h3>
                    <p class="text-muted">{{ __('Importation des données fichier CSV') }}</p>

                    @if(session('success'))
                        <div class="alert alert-success">
                            <i class="icon fa fa-check"></i> {{ session('success') }}
                        </div>
                    @endif

                    @if(session('error'))
                        <div class="alert alert-danger">
                            {!! nl2br(e(session('error'))) !!}
                        </div>
                    @endif

                    <form action="{{ route('csv.process') }}" method="POST" enctype="multipart/form-data">
                        @csrf

                        <div class="form-group">
                            <label for="csv_project">{{ __('Choose project file') }}</label>
                            <input required type="file" class="form-control-file" id="csv_project" name="csv_project" accept=".csv">
                            @error('csv_project')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="csv_task">{{ __('Choose tasks file') }}</label>
                            <input required type="file" class="form-control-file" id="csv_task" name="csv_task" accept=".csv">
                            @error('csv_task')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="csv_invoice">{{ __('Choose invoice file') }}</label>
                            <input required type="file" class="form-control-file" id="csv_invoice" name="csv_invoice" accept=".csv">
                            @error('csv_invoice')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <button type="submit" class="btn btn-primary btn-block mt-3">
                            <i class="fa fa-upload"></i> {{ __('Import') }}
                        </button>
                    </form>
                </div>
            </div>

            <!--<div class="text-center mt-3">
                <a href="#" data-toggle="modal" data-target="#csv-help-modal" class="btn btn-link">
                    {{ __('Need help?') }} <i class="fa fa-question-circle"></i>
                </a>
            </div>-->
        </div>
    </div>

    <!-- Help Modal -->
    <div class="modal fade" id="csv-help-modal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">{{ __('CSV Import Help') }}</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h6>{{ __('CSV Format Requirements') }}</h6>
                    <ul>
                        <li>{{ __('First row must contain column headers') }}</li>
                        <li>{{ __('Column headers must match DTO property names') }}</li>
                        <li>{{ __('Date format: DD/MM/YYYY (e.g., 25/12/2023)') }}</li>
                        <li>{{ __('Time format: HH:MM (e.g., 14:30)') }}</li>
                        <li>{{ __('DateTime format: YYYY-MM-DD HH:MM:SS (e.g., 2023-12-25 14:30:00)') }}</li>
                        <li>{{ __('Boolean values: true/false, yes/no, 1/0') }}</li>
                        <li>{{ __('Lists: comma-separated (e.g., item1,item2,item3)') }}</li>
                    </ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ __('Close') }}</button>
                </div>
            </div>
        </div>
    </div>

    @push('scripts')
    <script>
        $(document).ready(function () {
            $('input[type="file"]').change(function() {
                var fileName = $(this).val().split('\\').pop();
                $(this).next('.custom-file-label').text(fileName);
            });
        });
    </script>
    @endpush
@endsection
