<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\LogPinjamModel;

class AktivitasPinjam extends BaseController
{
    protected $logPinjam;

    public function __construct()
    {
        $this->logPinjam = new LogPinjamModel();
    }
    public function index()
    {
        $data = [
            'title' => 'Log Aktivitas Pinjam',
            'log' => $this->logPinjam->getLogPinjam()
        ];

        return view('log_pinjam/index', $data);
    }
}
