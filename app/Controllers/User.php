<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\UsersModel;

class User extends BaseController
{
    protected $user;
    public function __construct()
    {
        $this->user = new UsersModel();
    }
    public function index()
    {
        $data = [
            'title' => 'Dashboard',
            'user' => $this->user->getUser()
        ];

        return view('user/index', $data);
    }

    // public function getDetailUser($id)
    // {
    //     $data = [
    //         'title' => 'Detail User',
    //         'user' => $this->user->getUser($id)
    //     ];

    //     return view('user/detail', $data);
    // }

    public function createUser()
    {
        $data = [
            'title' => 'Tambah User'
        ];
        return view('user/create', $data);
    }

    public function saveCreate()
    {
        //validasi input 
        if (!$this->validate([
            'username' =>
            [
                'rules' => 'required|is_unique[komik.judul]',
                'errors' =>
                [
                    'required' => '{field} harus diisi',
                    'is_unique' => '{field} sudah terdaftar'
                ]
            ],

            'password' =>
            [
                'rules' => 'required|min_length[6]|max_length[200]',
                'errors' =>
                [
                    'required' => '{field} harus diisi'
                ]
            ],

            'confpassword' =>
            [
                'rules' => 'matches[password]',
                'errors' =>
                [
                    'required' => '{field} harus diisi'
                ]
            ],

            'foto_profil' =>
            [
                'rules' => 'max_size[sampul,1024]|is_image[sampul]|mime_in[sampul,image/jpg,image/jpeg,image/png]',
                'errors' =>
                [
                    'max_size' => 'Ukuran Gambar Terlalu Besar',
                    'is_image' => 'File Yang Dipilih Bukan Gambar',
                    'mime_in' => 'File Yang Dipilih Bukan Gambar'
                ]
            ]

        ])) {
            // $validation = \Config\Services::validation();

            // return redirect()->to(base_url() . '/komik/create')->withInput()->with('validation', $validation);

            return redirect()->to(base_url() . '/user/create')->withInput();
        }
    }
}
