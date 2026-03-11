<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');

// ========== API Routes ==========
$routes->group('api', ['namespace' => 'App\Controllers\auth'], function ($routes) {

    // ===== Routes publiques (sans JWT) =====
    $routes->post('auth/login', 'AuthController::login');
    $routes->post('auth/logout', 'AuthController::logout');
    $routes->get('test/services', '\App\Controllers\utilitaire\TestServiceController::index'); // Test brut SQL
    $routes->get('test/services-real', '\App\Controllers\referentiel\ServiceController::index'); // Test vrai Controller sans Auth

    // ===== Routes protégées (avec JWT) =====
    $routes->group('', ['filter' => 'jwtauth'], function ($routes) {
        // Déconnexion
        $routes->post('auth/logout', 'AuthController::logout');

        // ⭐ Route de test Hello World
        $routes->get('test/hello', 'TestController::hello');




        // Ajoute ici toutes tes autres routes protégées...
    });

    // Routes protégées pour le Dashboard
    $routes->group('', ['namespace' => '\\App\\Controllers\\dashboard', 'filter' => 'jwtauth'], function ($routes) {
        $routes->get('dashboard', 'DashboardController::index');
    });

    // Routes protégées pour les postes
    $routes->group('', ['namespace' => '\\App\\Controllers\\poste', 'filter' => 'jwtauth'], function ($routes) {
        $routes->get('postes', 'PosteController::index'); // Liste (GET /api/postes)
        $routes->get('postes/list', 'PosteController::index'); // Alias pour compatibilité
        $routes->get('postes/stats', 'PosteController::stats'); // Stats
        $routes->get('postes/(:num)', 'PosteController::show/$1'); // Détail (GET /api/postes/{id})
        $routes->post('postes/(:num)/competences', 'PosteController::addCompetence/$1');
        $routes->delete('postes/(:num)/competences/(:num)', 'PosteController::removeCompetence/$1/$2');
        $routes->get('postes/fonctions', 'PosteController::fonctions'); // Liste des fonctions
        $routes->put('postes/(:num)/quota', 'PosteController::updateQuota/$1'); // Mise à jour quota
    });

    // Routes protégées pour les référentiels
    $routes->group('', ['namespace' => '\\App\\Controllers\\referentiel', 'filter' => 'jwtauth'], function ($routes) {
        $routes->get('directions/list', 'DirectionController::index');
        $routes->get('services/list', 'ServiceController::index');
        $routes->get('positions/list', 'PositionController::index');
        $routes->get('rangs/list', 'ReferentielController::rangs');
        $routes->get('types-entree/list', 'TypeEntreeController::index');
        $routes->get('types-document/list', 'TypeDocumentController::index');
        $routes->get('sorties-type/list', 'SortieTypeController::index');
        $routes->get('types-contrat/list', 'TypeContratController::index');
        $routes->get('referentiels/statuts-armp', 'StatutArmpController::index');
    });

    // Routes protégées pour les employés
    $routes->group('', ['namespace' => '\\App\\Controllers\\employe', 'filter' => 'jwtauth'], function ($routes) {
        $routes->get('employes/encadreurs', 'EmployeController::getEncadreurs'); // Liste des encadreurs
        $routes->get('employes/export/xlsx', 'EmployeController::exportXlsx'); // Export XLSX
        $routes->get('employes/stats', 'EmployeController::stats'); // Stats
        $routes->get('employes', 'EmployeController::index'); // Liste avec filtres
        $routes->get('employes/list', 'EmployeController::index'); // Alias
        $routes->get('employes/(:num)/parcours', 'EmployeController::parcours/$1');
        $routes->get('employes/(:num)', 'EmployeController::show/$1'); // Détail
        $routes->post('employes', 'EmployeController::create'); // Création
        $routes->put('employes/(:num)', 'EmployeController::update/$1'); // Mise à jour

        // Compétences Employé
        $routes->get('employes/(:num)/competences', 'EmployeController::getCompetences/$1');
        $routes->post('employes/(:num)/competences', 'EmployeController::addCompetence/$1');
        $routes->delete('employes/(:num)/competences/(:num)', 'EmployeController::removeCompetence/$1/$2');

        // Finir carrière
        $routes->put('employes/(:num)/finir-carriere', 'EmployeController::finirCarriere/$1');

        // Récupérer les sorties d'un employé
        $routes->get('employes/(:num)/sorties', 'EmployeController::getSorties/$1');

        // Réintégration
        $routes->post('employes/(:num)/reintegration', 'EmployeController::reintegration/$1');
    });

    // Routes protégées pour les affectations
    $routes->group('', ['namespace' => '\\App\\Controllers\\affectation', 'filter' => 'jwtauth'], function ($routes) {
        $routes->get('affectations/stats', 'AffectationController::stats'); // Stats
        $routes->get('affectations/list', 'AffectationController::index');
        $routes->post('affectations', 'AffectationController::create');
        $routes->get('motifs-affectation', 'AffectationController::motifs');
        $routes->put('affectations/(:num)/cloturer', 'AffectationController::cloturer/$1');
    });

    // Routes protégées pour les stagiaires (module stage)
    $routes->group('', ['namespace' => '\\App\\Controllers\\stage', 'filter' => 'jwtauth'], function ($routes) {
        $routes->get('stagiaires/stats', 'StagiaireController::stats'); // Stats
        $routes->get('stagiaires', 'StagiaireController::index');
        $routes->post('stagiaires', 'StagiaireController::create');
        $routes->get('stagiaires/(:num)', 'StagiaireController::show/$1');
        $routes->put('stagiaires/(:num)', 'StagiaireController::update/$1');
        $routes->delete('stagiaires/(:num)', 'StagiaireController::delete/$1');
    });

    // Routes protégées pour les stages
    $routes->group('', ['namespace' => '\\App\\Controllers\\stage', 'filter' => 'jwtauth'], function ($routes) {
        $routes->get('stages/stats', 'StageController::stats'); // Stats
        $routes->get('stages', 'StageController::index');
        $routes->post('stages', 'StageController::create');
        $routes->get('stages/(:num)', 'StageController::show/$1');
        $routes->put('stages/(:num)', 'StageController::update/$1');
        $routes->delete('stages/(:num)', 'StageController::delete/$1');
        $routes->post('stages/(:num)/carriere', 'StageController::assignCarriere/$1');
        $routes->get('stages/(:num)/convention', 'StageController::telechargerConvention/$1');
        $routes->get('stages/(:num)/demande-attestation', 'StageController::telechargerDemandeAttestation/$1');
        $routes->get('stages/demandes', 'StageController::listerDemandesStage');
        $routes->get('stages/demandes/stats', 'StageController::statsDemandes');
        $routes->put('stages/demandes/(:num)/valider', 'StageController::validerDemandeStage/$1');
    });

    // Routes protégées pour les établissements (module stage)
    $routes->group('', ['namespace' => '\\App\\Controllers\\stage', 'filter' => 'jwtauth'], function ($routes) {
        $routes->get('etablissements', 'EtablissementController::index');
        $routes->post('etablissements', 'EtablissementController::create');
        $routes->get('etablissements/(:num)', 'EtablissementController::show/$1');
        $routes->put('etablissements/(:num)', 'EtablissementController::update/$1');
        $routes->delete('etablissements/(:num)', 'EtablissementController::delete/$1');
    });

    // Routes additionnelles pour Postes
    $routes->group('', ['namespace' => '\\App\\Controllers\\poste', 'filter' => 'jwtauth'], function ($routes) {
        $routes->get('postes/by-service/(:num)', 'PosteController::byService/$1');
    });

    // Routes protégées pour assiduité (module stage)
    $routes->group('', ['namespace' => '\\App\\Controllers\\stage', 'filter' => 'jwtauth'], function ($routes) {
        $routes->get('assiduites', 'AssiduiteController::index');
        $routes->post('assiduites', 'AssiduiteController::create');
        $routes->get('assiduites/(:num)', 'AssiduiteController::show/$1');
        $routes->put('assiduites/(:num)', 'AssiduiteController::update/$1');
        $routes->delete('assiduites/(:num)', 'AssiduiteController::delete/$1');
    });

    // Routes protégées pour évaluation de stage (module stage)
    $routes->group('', ['namespace' => '\\App\\Controllers\\stage', 'filter' => 'jwtauth'], function ($routes) {
        $routes->get('eval-stages', 'EvalStageController::index');
        $routes->post('eval-stages', 'EvalStageController::create');
        $routes->get('eval-stages/(:num)', 'EvalStageController::show/$1');
        $routes->put('eval-stages/(:num)', 'EvalStageController::update/$1');
        $routes->delete('eval-stages/(:num)', 'EvalStageController::delete/$1');
        $routes->get('stages/(:num)/eval', 'EvalStageController::getByStage/$1');
    });

    // Routes protégées pour compétences
    $routes->group('', ['namespace' => '\\App\\Controllers\\competence', 'filter' => 'jwtauth'], function ($routes) {
        $routes->get('competences/stats', 'CompetenceController::stats'); // Stats
        $routes->get('competences', 'CompetenceController::index');
        $routes->post('competences', 'CompetenceController::create');
        $routes->get('competences/(:num)', 'CompetenceController::show/$1');
        $routes->put('competences/(:num)', 'CompetenceController::update/$1');
        $routes->delete('competences/(:num)', 'CompetenceController::delete/$1');
        $routes->get('competences/domaines', 'CompetenceController::domaines');
    });

    // Routes protégées pour les documents
    $routes->group('', ['namespace' => '\\App\\Controllers\\document', 'filter' => 'jwtauth'], function ($routes) {
        $routes->get('documents/stats', 'DocumentController::stats'); // Stats
        $routes->post('documents/demande', 'DocumentController::creerDemande');
        $routes->get('documents/demandes', 'DocumentController::listerDemandes');
        $routes->put('documents/demandes/(:num)/valider', 'DocumentController::validerDemande/$1');
        $routes->get('documents/demandes/(:num)/pdf', 'DocumentController::telechargerPdfDemande/$1');
    });
});
