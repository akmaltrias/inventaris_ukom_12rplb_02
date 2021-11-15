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

    public function getDetailUser($id)
    {
        $data = [
            'title' => 'Detail User',
            'user' => $this->user->getUser($id)
        ];

        return view('user/detail', $data);
    }
}
