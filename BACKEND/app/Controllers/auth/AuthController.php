<?php

namespace App\Controllers\auth;

use CodeIgniter\RESTful\ResourceController;
use CodeIgniter\API\ResponseTrait;
use App\Models\user\AdminModel;
use App\Models\user\UserModel;
use Firebase\JWT\JWT;

class AuthController extends ResourceController
{
    use ResponseTrait;

    public function login()
    {
        /** @var \CodeIgniter\HTTP\IncomingRequest $request */
    $request = $this->request;
    
    $userModel = new UserModel();
    
    // Récupérer les données JSON
    $json = $request->getJSON();
        
        if (!$json) {
            return $this->fail('Données manquantes', 400);
        }
        
        $username = $json->username ?? null;
        $password = $json->password ?? null;

        if (!$username || !$password) {
            return $this->fail('username et mot de passe requis', 400);
        }

        $user = $userModel->where('username', $username)->first();

        if (!$user || !password_verify($password, $user['password'])) {
            return $this->failUnauthorized('Email ou mot de passe incorrect');
        }

        // Générer le token JWT
        $key = getenv('JWT_SECRET');
        if (!$key) {
            $key = 'MaCleSecreteUnique123456789ComplexeEtLongue';
        }
        
        $iat = time();
        $ttl = getenv('JWT_TIME_TO_LIVE');
        $ttl = $ttl ? (int)$ttl : 3600;  // ⭐ Garder TTL en variable
        $exp = $iat + $ttl;  // Timestamp absolu pour le JWT

        $payload = [
            'iss' => base_url(),
            'aud' => base_url(),
            'iat' => $iat,
            'exp' => $exp,
            'data' => [
                'id' => $user['id'],
                'username' => $user['username'],
                'nom' => $user['nom'],
                'prenom' => $user['prenom'],
                'role' => $user['role']
            ]
        ];

        $token = JWT::encode($payload, $key, 'HS256');

        // ⭐ NOUVEAU : Envoyer le token dans un cookie HttpOnly
        $this->response->setCookie([
            'name'     => 'auth_token',
            'value'    => $token,
            'expire'   => $ttl,
            'domain'   => '',
            'path'     => '/',
            'secure'   => false,  // Mettre true en production (HTTPS)
            'httponly' => true,   // ⭐ Empêche l'accès JavaScript (sécurité)
            'samesite' => 'Lax'   // Protection CSRF
        ]);

        // Retourner la réponse (sans le token dans le body)
        return $this->respond([
            'status' => 'success',
            'message' => 'Connexion réussie',
            'user' => [
                'id' => $user['id'],
                'username' => $user['username'],
                'nom' => $user['nom'],
                'prenom' => $user['prenom'],
                'role' => $user['role']
            ]
        ], 200);
    }

    /**
     * Déconnexion : Supprimer le cookie
     */
    public function logout()
    {
        // ⭐ Supprimer le cookie
        $this->response->deleteCookie('auth_token');
        
        return $this->respond([
            'status' => 'success',
            'message' => 'Déconnexion réussie'
        ], 200);
    }
}
