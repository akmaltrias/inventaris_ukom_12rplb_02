<?php

namespace App\Models;

use CodeIgniter\Model;

class PinjamBarangModel extends Model
{
    protected $DBGroup          = 'default';
    protected $table            = 'pinjam_barang';
    protected $primaryKey       = 'id_pinjam';
    protected $useAutoIncrement = true;
    protected $insertID         = 0;
    protected $returnType       = 'array';
    protected $useSoftDeletes   = false;
    protected $protectFields    = true;
    protected $allowedFields    = ['id_pinjam', 'barang_pinjam', 'peminjam', 'tgl_pinjam', 'jml_pinjam', 'kondisi'];

    // Dates
    protected $useTimestamps = false;
    protected $dateFormat    = 'datetime';
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';

    public function getPinjam()
    {
        return $this->db->table('peminjaman')
            ->get()->getResultArray();
    }

    public function insert_pinjam($peminjam, $barang_pinjam, $jumlah)
    {
        //         $a_procedure = "CALL add_foobar (?,?,?)";
        // $a_result = $this->db->query( $a_procedure, array('first'=>'Foo','last'=>'Bar’,'mood'=>'Testy') );

        // $procedure = "CALL pinjam_barang(?,?,?)";
        $data = array('in_peminjam' => $peminjam, 'in_idbarangpinjam' => $barang_pinjam, 'in_jmlpinjam' => $jumlah);
        dd($data);

        $query = $this->db->query("CALL pinjam_barang(?,?,?)",);
        $data = $query->getRow();
        return $data;
    }
}
