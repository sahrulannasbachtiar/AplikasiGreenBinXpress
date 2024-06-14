<?php

namespace App\Controllers;

use App\Models\SampahModel;
use CodeIgniter\RESTful\ResourceController;

class Sampah extends ResourceController
{
    protected $modelName = 'App\Models\SampahModel';
    protected $format    = 'json';

    public function index()
    {
        
        return $this->respond($this->model->orderBy('id_sampah', 'DESC')->findAll());
    }

    public function show($id = null)
    {
        $data = $this->model->find($id);
        if ($data) {
            $data['koin'] = $this->calculateKoin($data['jenis_sampah'], $data['berat_sampah']);
            return $this->respond($data);
        } else {
            return $this->failNotFound('Data tidak ditemukan');
        }
    }

    public function create()
    {
        $data = $this->request->getPost();
        $data['koin'] = $this->calculateKoin($data['jenis_sampah'], $data['berat_sampah']);
        $this->model->insert($data);
        $response = [
            'status' => 200,
            'error' => null,
            'messages' => [
                'success' => 'Sampah berhasil ditambahkan. Tunggu pengempul untuk mengambil sampahmu!'
            ]
        ];
        return $this->respondCreated($response);
    }

    public function update($id = null)
    {
        $data = $this->request->getVar();
        $data['koin'] = $this->calculateKoin($data['jenis_sampah'], $data['berat_sampah']);
        $this->model->update($id, $data);
        $response = [
            'status' => 200,
            'error' => null,
            'messages' => [
                'success' => 'Edit sampah berhasil. Refresh terlebih dahulu!'
            ]
        ];
        return $this->respond($response);
    }

    public function delete($id = null)
    {
        $model = new SampahModel();
        $data = $model->where('id_sampah', $id)->delete($id);
        if ($data) {
            $model->delete($id);
            $response = [
                'status' => 200,
                'error' => null,
                'messages' => [
                    'success' => 'Data sampah berhasil dihapus. Refresh terlebih dahulu!'
                ]
            ];
            return $this->respondDeleted($response);
        }else {
            return $this->failNotFound('Data tidak ditemukan');
        }
    }

    private function calculateKoin($jenis_sampah, $berat_sampah)
    {
        switch ($jenis_sampah) {
            case 'Organik':
                return 3000 * $berat_sampah;
            case 'Anorganik':
                return 5000 * $berat_sampah;
            case 'B3':
                return 20000 * $berat_sampah;
            default:
                return 0;
        }
    }
}