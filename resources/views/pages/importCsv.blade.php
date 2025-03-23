@extends('layouts.master')

@section('content')
<div class="tablet">
    <div class="tablet__head">
        <div class="tablet__head-label">
            <h3 class="tablet__head-title">{{ __('Import CSV File') }}</h3>
        </div>
    </div>

    <div class="tablet__body">
        <div class="tablet__items">
            <div class="tablet__item">
                <div class="tablet__item__info">
                    @if(session('success'))
                        <div class="alert alert-success">
                            {{ session('success') }}
                        </div>
                    @endif

                    <!-- Formulaire d'importation CSV -->
                    <form action="{{ route('importCsv.upload') }}" method="POST" enctype="multipart/form-data">
                        @csrf

                        <!-- File Input -->
                        <div class="form-group mb-4">
                            <label for="file">{{ __('Choose CSV File') }}</label>
                            <input type="file" name="file" id="file" class="form-control" required>
                        </div>

                        <!-- Select Type -->
                        <div class="form-group mb-4">
                            <label for="type">{{ __('Select Type') }}</label>
                            <select name="type" id="type" class="form-control">
                                @foreach($types as $type)
                                    <option value="{{ $type }}">{{ ucfirst($type) }}</option>
                                @endforeach
                            </select>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="btn btn-primary">
                            <i class="fa fa-upload"></i> {{ __('Upload CSV') }}
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="tablet__footer">
        <!-- Footer content if needed -->
    </div>
</div>
@endsection
