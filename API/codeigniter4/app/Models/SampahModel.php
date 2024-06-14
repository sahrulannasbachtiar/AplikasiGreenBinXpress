<?php

namespace App\Models;

use CodeIgniter\Model;

class SampahModel extends Model
{
    protected $table = 'sampah';
    protected $primaryKey = 'id_sampah';
    protected $allowedFields = ['jenis_sampah', 'nama_sampah', 'berat_sampah', 'jenis_angkutan', 'koin'];

    protected $returnType = 'array';
    protected $useTimestamps = false;
}
