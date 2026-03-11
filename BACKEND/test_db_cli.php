<?php
// Script de test connexion DB et services
// Placer ce fichier dans BACKEND/public/test_db.php par exemple, ou exécuter via CLI à la racine BACKEND

define('FCPATH', __DIR__ . DIRECTORY_SEPARATOR . 'public' . DIRECTORY_SEPARATOR);
chdir(__DIR__);

require 'app/Config/Paths.php';
$paths = new Config\Paths();

require 'system/bootstrap.php';

use Config\Database;
use App\Models\referentiel\ServiceModel;

try {
    echo "Test Connexion DB...\n";
    $db = Database::connect();
    $db->initialize();
    echo "Connexion OK.\n";

    echo "Listing Services...\n";
    $builder = $db->table('service');
    $query = $builder->get();
    $results = $query->getResultArray();
    
    echo "Nombre de services trouvés : " . count($results) . "\n";
    foreach ($results as $row) {
        echo "- " . $row['srvc_nom'] . " (ID: " . $row['srvc_code'] . ")\n";
    }

} catch (\Throwable $e) {
    echo "ERREUR : " . $e->getMessage() . "\n";
    echo $e->getTraceAsString();
}
