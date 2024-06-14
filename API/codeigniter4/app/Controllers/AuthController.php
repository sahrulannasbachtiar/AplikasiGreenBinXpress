<?php

namespace App\Controllers;

use App\Models\UserModel;
use CodeIgniter\Controller;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use CodeIgniter\API\ResponseTrait;

class AuthController extends Controller
{
    use ResponseTrait;

    public function register()
    {
        $userModel = new UserModel();
        $data = [
            'username' => $this->request->getVar('username'),
            'no_hp' => $this->request->getVar('no_hp'),
            'alamat' => $this->request->getVar('alamat'),
            'password' => password_hash($this->request->getVar('password'), PASSWORD_DEFAULT)
        ];

        if ($userModel->insert($data)) {
            return $this->respondCreated(['message' => 'Daftar Akun Berhasil']);
        } else {
            return $this->fail('Daftar Akun Berhasil');
        }
    }

    public function login()
    {
        $userModel = new UserModel();
        $username = $this->request->getVar('username');
        $password = $this->request->getVar('password');

        $user = $userModel->getUserByUsername($username);

        if (!$user || !password_verify($password, $user['password'])) {
            return $this->fail('Invalid username or password');
        }

        $key = getenv('JWT_SECRET');
        $iat = time(); // current timestamp value
        $exp = $iat + 3600; // Adding 1 hour in current time

        $payload = [
            'iat' => $iat,
            'exp' => $exp,
            'uid' => $user['id']
        ];

        $token = JWT::encode($payload, $key, 'HS256');

        return $this->respond([
            'message' => 'Login successful', 
            'token' => $token,
            'user' => [
                'username' => $user['username'],
                'no_hp' => $user['no_hp'],
                'alamat' => $user['alamat'],
            ]
        ]);
    }
}
