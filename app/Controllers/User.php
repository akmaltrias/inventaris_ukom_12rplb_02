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
            'title' => 'Data User',
            'user' => $this->user->getUser()
        ];

        return view('user/index', $data);
    }

    public function getDetailUser($id)
    {
        $data = [
            'title' => 'Detail User',
            'user' => $this->user->getUser($id)
        ];

        return view('user/detail', $data);
    }

    public function createUser()
    {
        $data = [
            'title' => 'Tambah User',
            'validation' => \Config\Services::validation()
        ];

        return view('user/create', $data);
    }

    public function saveCreate()
    {
        //include helper form
        helper(['form']);
        //validasi input 
        if (!$this->validate([
            'username' =>
            [
                'rules' => 'required|is_unique[user.username]',
                'errors' =>
                [
                    'required' => '{field} harus diisi',
                    'is_unique' => '{field} sudah terdaftar'
                ]
            ],

            'nama' =>
            [
                'rules' => 'required[user.nama]',
                'errors' =>
                [
                    'required' => '{field} harus diisi',
                ]
            ],

            'level' =>
            [
                'rules' => 'required[user.level]',
                'errors' =>
                [
                    'required' => 'Pilih  level user',
                ]
            ],

            'password' =>
            [
                'rules' => 'required[user.password]',
                'errors' =>
                [
                    'required' => '{field} harus diisi',
                ]
            ],
            'confpassword' =>
            [
                'rules' => 'matches[password]',
                'errors' =>
                [
                    'matches' => 'Konfirmasi password harus sama',
                ]
            ],

            'foto_profil' =>
            [
                'rules' => 'max_size[foto_profil,1024]|is_image[foto_profil]|mime_in[foto_profil,image/jpg,image/jpeg,image/png]',
                'errors' =>
                [
                    'max_size' => 'Ukuran Gambar Terlalu Besar',
                    'is_image' => 'File Yang Dipilih Bukan Gambar',
                    'mime_in' => 'File Yang Dipilih Bukan Gambar'
                ]
            ]
        ])) {
            return redirect()->to(base_url() . '/user/create')->withInput();
        }

        //ambil gambar
        $fileFoto = $this->request->getFile('foto_profil');
        //apakah tidak ada gambar
        if ($fileFoto->getError() == 4) {
            $namaFoto = 'default.png';
        } else {
            //generate nama sampul
            $namaFoto = $fileFoto->getRandomName();
            //pindahkan file ke folder img 
            $fileFoto->move('img', $namaFoto);
        }

        $newKodeUser = $this->user->getNewId();
        foreach ($newKodeUser as $newid)

            $data = [
                'id_user' => $newid,
                'nama' => $this->request->getVar('nama'),
                'username' => $this->request->getVar('username'),
                'password' => password_hash($this->request->getVar('password'), PASSWORD_DEFAULT),
                'foto_profil' => $namaFoto,
                'level' => $this->request->getVar('level')
            ];

        // dd($data);

        //simpan data
        $this->user->insert($data);

        session()->setFlashdata('pesan', 'data berhasil ditambahkan');

        return redirect()->to('http://localhost:8080/user');
    }

    public function updateUser($id)
    {
        $data = [
            'title' => 'Edit User',
            'validation' => \Config\Services::validation(),
            'user' => $this->user->getUser($id)
        ];

        return view('user/update', $data);
    }

    public function saveUpdate($id)
    {
        //untuk mengecek judul
        $userLama = $this->user->getUser($id);
        if ($userLama['username'] == $this->request->getVar('username')) {
            $rule_username = 'required';
        } else {
            $rule_username = 'required|is_unique[user.username]';
        }

        if (!$this->validate([
            'username' =>
            [
                'rules' => $rule_username,
                'errors' =>
                [
                    'required' => '{field} harus diisi',
                    'is_unique' => '{field} sudah terdaftar'
                ]
            ],
            'foto_profil' =>
            [
                'rules' => 'is_image[foto_profil]|mime_in[foto_profil,image/jpg,image/jpeg,image/png]',
                'errors' =>
                [
                    'is_image' => 'File Yang Dipilih Bukan Gambar',
                    'mime_in' => 'File Yang Dipilih Bukan Gambar'
                ]
            ]
        ])) {
            return redirect()->to(base_url() . '/user/update/' . $userLama['id_user'])->withInput();
        }

        //ambil gambar
        $fileFoto = $this->request->getFile('foto_profil');

        //cek gambar apakah tetap gambar lama
        if ($fileFoto->getError() == 4) {
            $namaSampul = $this->request->getVar('fotoLama');
        } else {
            //generate nama sampul baru
            $namaSampul = $fileFoto->getRandomName();
            //pindahkan file ke folder img 
            $fileFoto->move('img', $namaSampul);
            //hapus file lama
            $user = $this->user->find($id);;
            //hapus gambar dari folder img
            unlink('img/' . $user['foto_profil']);
        }

        $data = [
            'id_user' => $this->request->getVar('id_user'),
            'level' => $this->request->getVar('level'),
            'nama' => $this->request->getVar('nama'),
            'password' => $this->request->getVar('password'),
            'username' => $this->request->getVar('username'),
            'foto_profil' => $namaSampul,
        ];

        $this->user->save($data);

        session()->setFlashdata('pesan', 'data berhasil diupdate');
        return redirect()->to(base_url() . '/user');
    }

    public function delete($id)
    {
        //cari gambar dari id
        $user = $this->user->find($id);

        // dd($user);

        //cek jika file nya buku/default
        if ($user['foto_profil'] != 'default.png') {
            //hapus gambar dari folder img
            unlink('img/' . $user['foto_profil']);
        }

        $this->user->delete($id);
        session()->setFlashdata('pesan', 'data berhasil dihapus');
        return redirect()->to(base_url() . '/user');
    }
}
