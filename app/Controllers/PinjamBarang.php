<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\BarangModel;
use App\Models\PinjamBarangModel;
use App\Models\UsersModel;

class PinjamBarang extends BaseController
{
    protected $pinjamBarang;
    protected $user;
    protected $barang;

    public function __construct()
    {
        $this->pinjamBarang = new PinjamBarangModel();
        $this->user = new UsersModel();
        $this->barang = new BarangModel();
    }

    public function index()
    {
        $data = [
            'title' => 'Data Peminjaman',
            'pinjam' => $this->pinjamBarang->getPinjam(),
        ];

        return view('pinjam/index', $data);
    }


    public function createPinjam()
    {
        $data = [
            'title' => 'Tambah Peminjaman',
            'validation' => \Config\Services::validation(),
            'user' => $this->user->findAll(),
            'barang' => $this->barang->findAll(),
        ];

        return view('pinjam/create', $data);
    }

    public function savePinjam()
    {
        //include helper form
        helper(['form']);
        //validasi input 
        if (!$this->validate([
            'peminjam' =>
            [
                'rules' => 'required[pinjam.peminjam]',
                'errors' =>
                [
                    'required' => 'Kolom {field} harus diisi',
                ]
            ],

            'barang_pinjam' =>
            [
                'rules' => 'required[pinjam.barang_pinjam]',
                'errors' =>
                [
                    'required' => 'Kolom {field} harus diisi',
                ]
            ],

            'jml_pinjam' =>
            [
                'rules' => 'required[pinjam.jml_pinjam]',
                'errors' =>
                [
                    'required' => 'Kolom {field} harus diisi',
                ]
            ]
        ])) {
            return redirect()->to(base_url() . '/pinjam/create')->withInput();
        }

        $jml_pinjam = $this->request->getVar('jml_pinjam');

        $peminjam = $this->request->getVar('peminjam');
        $barang_pinjam = $this->request->getVar('barang_pinjam');
        $jumlah = intval($jml_pinjam);

        $this->pinjamBarang->query("CALL pinjam_barang('" . $peminjam . "','" . $barang_pinjam . "','" . $jumlah . "');");

        session()->setFlashdata('pesan', 'Berhasil menambahkan peminjaman');
        return redirect()->to(base_url() . '/pinjam');
    }
}
