<?php
// diag_db.php
$host = 'localhost';
$db   = 'gprh';
$user = 'postgres';
$pass = 'admin';
$port = "5432";
$dsn = "pgsql:host=$host;port=$port;dbname=$db";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
     $pdo = new PDO($dsn, $user, $pass, $options);
     echo "Connexion PDO OK.\n";
     
     $stmt = $pdo->query("SELECT count(*) as cnt FROM service");
     $row = $stmt->fetch();
     echo "Nombre de services : " . $row['cnt'] . "\n";
     
     if ($row['cnt'] > 0) {
         $stmt = $pdo->query("SELECT * FROM service LIMIT 5");
         while ($r = $stmt->fetch()) {
             echo "- " . $r['srvc_nom'] . "\n";
         }
     } else {
         echo "La table service est vide !\n";
     }
} catch (\PDOException $e) {
     echo "Erreur Connexion : " . $e->getMessage() . "\n";
}
