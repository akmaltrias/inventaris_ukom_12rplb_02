<?php

namespace App\Models;

use CodeIgniter\Model;

class UsersModel extends Model
{
    protected $DBGroup          = 'default';
    protected $table            = 'user';
    protected $primaryKey       = 'id_user';
    protected $useAutoIncrement = true;
    protected $insertID         = 0;
    protected $returnType       = 'array';
    protected $useSoftDeletes   = false;
    protected $protectFields    = true;
    protected $allowedFields    = ['id_user', 'nama', 'username', 'password', 'level', 'foto_profil'];

    // Dates
    protected $useTimestamps = false;
    protected $dateFormat    = 'datetime';
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';

    public function getUser($id = false)
    {
        if ($id == false) {
            return $this->db->table('list_user')
                ->get()->getResultArray();
        }

        return $this->where(['id_user' => $id])->first();
    }

    public function getNewId()
    {
        $query = $this->db->query("SELECT newkodeuser()");
        $row = $query->getRow();
        return $row;
    }
}
