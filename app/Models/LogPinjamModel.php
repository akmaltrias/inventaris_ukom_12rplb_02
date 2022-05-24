<?php

namespace App\Models;

use CodeIgniter\Model;

class LogPinjamModel extends Model
{
    protected $DBGroup          = 'default';
    protected $table            = 'log_pinjam';
    protected $primaryKey       = 'id';
    protected $useAutoIncrement = true;
    protected $insertID         = 0;
    protected $returnType       = 'array';
    protected $useSoftDeletes   = false;
    protected $protectFields    = true;
    protected $allowedFields    = ['id_user', 'id_pinjam', 'waktu', 'keterangan'];

    // Dates
    protected $useTimestamps = false;
    protected $dateFormat    = 'datetime';
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';

    public function getLogPinjam()
    {
        return $this->db->table('log_aktivitas_peminjaman')->orderBy('waktu', 'DESC')
            ->get()->getResultArray();
    }
}
