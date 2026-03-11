<?php

namespace App\Database\Seeds;

use CodeIgniter\Database\Seeder;

class InitialSeeder extends Seeder
{
    public function run()
    {
        // 1. motif_affectation
        $this->db->table('motif_affectation')->insertBatch([
            ['m_aff_code' => 1, 'm_aff_motif' => 'Affectation Initiale', 'm_aff_type' => 'Permanente'],
            ['m_aff_code' => 2, 'm_aff_motif' => 'Mutation', 'm_aff_type' => 'Permanente'],
            ['m_aff_code' => 3, 'm_aff_motif' => 'Promotion', 'm_aff_type' => 'Permanente'],
            ['m_aff_code' => 5, 'm_aff_motif' => 'Détachement', 'm_aff_type' => 'Temporaire'],
        ]);

        // 2. direction
        $this->db->table('direction')->insertBatch([
            ['dir_code' => 1, 'dir_nom' => 'Direction Générale'],
            ['dir_code' => 2, 'dir_nom' => 'Comité de Recours et de Réglementation'],
            ['dir_code' => 3, 'dir_nom' => 'Comité de Règlement des Différends'],
            ['dir_code' => 4, 'dir_nom' => 'Direction de l\'Audit Interne'],
            ['dir_code' => 5, 'dir_nom' => 'Direction des Affaires Administratives et Financières'],
            ['dir_code' => 6, 'dir_nom' => 'Direction de la Formation et de la Documentation'],
            ['dir_code' => 7, 'dir_nom' => 'Direction du Système d\'Information'],
        ]);

        // 3. rang_hierarchique
        $this->db->table('rang_hierarchique')->insertBatch([
            ['rhq_code' => 1, 'rhq_rang' => 'HEE', 'rhq_niveau' => 'Niveau1'],
            ['rhq_code' => 2, 'rhq_rang' => 'Chef de Service', 'rhq_niveau' => 'Niveau2'],
            ['rhq_code' => 3, 'rhq_rang' => 'Cadre', 'rhq_niveau' => 'Niveau3'],
            ['rhq_code' => 4, 'rhq_rang' => 'Agent exécutant', 'rhq_niveau' => 'Niveau4'],
        ]);

        // 4. service
        $this->db->table('service')->insertBatch([
            ['srvc_code' => 1, 'srvc_nom' => 'Agence Comptable', 'dir_code' => 1],
            ['srvc_code' => 2, 'srvc_nom' => 'Service Ressource Humaines', 'dir_code' => 5],
            ['srvc_code' => 3, 'srvc_nom' => 'Service de Suivi Evaluation', 'dir_code' => 4],
            ['srvc_code' => 4, 'srvc_nom' => 'Service Administratif et Financier', 'dir_code' => 5],
            ['srvc_code' => 5, 'srvc_nom' => 'Service Coordination et Régulation', 'dir_code' => 4],
            ['srvc_code' => 6, 'srvc_nom' => 'Service de la Documentation', 'dir_code' => 6],
            ['srvc_code' => 7, 'srvc_nom' => 'Service de la Formation', 'dir_code' => 6],
            ['srvc_code' => 8, 'srvc_nom' => 'Service de Coordination Général des Activités', 'dir_code' => 1],
            ['srvc_code' => 9, 'srvc_nom' => 'Service d\'Administration Système et Réseau', 'dir_code' => 7],
            ['srvc_code' => 10, 'srvc_nom' => 'Service Section Recours', 'dir_code' => 2],
        ]);

        // 5. poste
        $this->db->table('poste')->insertBatch([
            ['pst_code' => 1, 'tsup_code' => null, 'rhq_code' => 1, 'pst_fonction' => 'Directeur Général', 'pst_mission' => 'Assurer la direction générale, la coordination et le contrôle des activités de l\'ARMP.', 'srvc_code' => null, 'dir_code' => 1],
            ['pst_code' => 2, 'tsup_code' => null, 'rhq_code' => 1, 'pst_fonction' => 'Président du Comité de Recours et de Réglementation', 'pst_mission' => 'Présider le comité, veiller à l\'application des textes et à la qualité des décisions.', 'srvc_code' => null, 'dir_code' => 2],
            ['pst_code' => 3, 'tsup_code' => null, 'rhq_code' => 1, 'pst_fonction' => 'Présidente du Comité de Règlement des Différends', 'pst_mission' => 'Présider le comité, garantir le traitement impartial des différends.', 'srvc_code' => null, 'dir_code' => 3],
            ['pst_code' => 4, 'tsup_code' => null, 'rhq_code' => 1, 'pst_fonction' => 'Directeur de l\'Audit Interne', 'pst_mission' => 'Planifier et superviser les missions d\'audit interne, évaluer les risques et proposer des recommandations.', 'srvc_code' => null, 'dir_code' => 4],
            ['pst_code' => 5, 'tsup_code' => null, 'rhq_code' => 1, 'pst_fonction' => 'Directeur des Affaires Administratives et Financières', 'pst_mission' => 'Gérer les ressources financières et administratives, superviser la comptabilité et le budget.', 'srvc_code' => null, 'dir_code' => 5],
            ['pst_code' => 6, 'tsup_code' => null, 'rhq_code' => 1, 'pst_fonction' => 'Directeur de la Formation et de la documentation', 'pst_mission' => 'Développer la politique de formation, gérer le centre de documentation et les ressources pédagogiques.', 'srvc_code' => null, 'dir_code' => 6],
            ['pst_code' => 7, 'tsup_code' => null, 'rhq_code' => 1, 'pst_fonction' => 'Directeur du Système d\'Information', 'pst_mission' => 'Piloter le système d\'information, garantir la sécurité et la performance des infrastructures.', 'srvc_code' => null, 'dir_code' => 7],
            ['pst_code' => 8, 'tsup_code' => null, 'rhq_code' => 2, 'pst_fonction' => 'Agent Comptable', 'pst_mission' => 'Tenir la comptabilité, effectuer les opérations financières et assurer le suivi budgétaire.', 'srvc_code' => 1, 'dir_code' => 1],
            ['pst_code' => 9, 'tsup_code' => null, 'rhq_code' => 2, 'pst_fonction' => 'Responsable des Ressources Humaines', 'pst_mission' => 'Gérer le personnel, les carrières, la paie et les relations sociales.', 'srvc_code' => 2, 'dir_code' => 5],
            ['pst_code' => 10, 'tsup_code' => null, 'rhq_code' => 2, 'pst_fonction' => 'Chef de service Suivi Evaluation', 'pst_mission' => 'Coordonner le suivi et l\'évaluation des projets, analyser les indicateurs de performance.', 'srvc_code' => 3, 'dir_code' => 4],
            ['pst_code' => 11, 'tsup_code' => null, 'rhq_code' => 2, 'pst_fonction' => 'Responsable Administratif et Financier', 'pst_mission' => 'Superviser les activités administratives et financières du service.', 'srvc_code' => 4, 'dir_code' => 5],
            ['pst_code' => 12, 'tsup_code' => null, 'rhq_code' => 2, 'pst_fonction' => 'Chef de service Coordination et Régulation', 'pst_mission' => 'Assurer la coordination des activités de régulation et veiller à leur conformité.', 'srvc_code' => 5, 'dir_code' => 4],
            ['pst_code' => 13, 'tsup_code' => null, 'rhq_code' => 2, 'pst_fonction' => 'Chef de Service de la Documentation', 'pst_mission' => 'Gérer les collections documentaires, assurer la veille informationnelle et la diffusion.', 'srvc_code' => 6, 'dir_code' => 6],
            ['pst_code' => 14, 'tsup_code' => null, 'rhq_code' => 2, 'pst_fonction' => 'Chef de Service de la FORMATION', 'pst_mission' => 'Organiser et animer les actions de formation, évaluer leur impact.', 'srvc_code' => 7, 'dir_code' => 6],
            ['pst_code' => 15, 'tsup_code' => null, 'rhq_code' => 2, 'pst_fonction' => 'Coordonnateur Général des Activités', 'pst_mission' => 'Coordonner l\'ensemble des activités opérationnelles et assurer la liaison entre les services.', 'srvc_code' => 8, 'dir_code' => 1],
            ['pst_code' => 16, 'tsup_code' => null, 'rhq_code' => 2, 'pst_fonction' => 'Chef de Service Administration Système et Réseau', 'pst_mission' => 'Administrer les serveurs, réseaux et assurer la maintenance technique.', 'srvc_code' => 9, 'dir_code' => 7],
            ['pst_code' => 17, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Agent Administratif', 'pst_mission' => 'Assurer les tâches administratives courantes, accueil, traitement des courriers.', 'srvc_code' => 4, 'dir_code' => 5],
            ['pst_code' => 18, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Personnel d\'Appui Ressources Humaines', 'pst_mission' => 'Assister le responsable RH dans la gestion administrative du personnel.', 'srvc_code' => 2, 'dir_code' => 5],
            ['pst_code' => 19, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Personnel d\'Appui Système Réseau', 'pst_mission' => 'Participer à la maintenance et à l\'exploitation des systèmes et réseaux.', 'srvc_code' => 9, 'dir_code' => 7],
            ['pst_code' => 20, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Personnel d\'Appui Web', 'pst_mission' => 'Contribuer à la gestion et à la mise à jour du site web.', 'srvc_code' => 9, 'dir_code' => 7],
            ['pst_code' => 21, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Personnel d\'Appui de l\'Agence Comptable', 'pst_mission' => 'Assister l\'agent comptable dans les tâches de saisie et de suivi.', 'srvc_code' => 1, 'dir_code' => 1],
            ['pst_code' => 22, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Personnel d\'Appui de la Documentation', 'pst_mission' => 'Aider à la gestion physique et numérique des documents.', 'srvc_code' => 6, 'dir_code' => 6],
            ['pst_code' => 23, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Personnel d\'Appui de la Formation', 'pst_mission' => 'Supporter logistique et administratif des sessions de formation.', 'srvc_code' => 7, 'dir_code' => 6],
            ['pst_code' => 24, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Personnel d\'Appui Administratif et Financier', 'pst_mission' => 'Assister le RAF dans les tâches administratives et financières.', 'srvc_code' => 4, 'dir_code' => 5],
            ['pst_code' => 25, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Webmaster', 'pst_mission' => 'Concevoir, développer et maintenir le site web de l\'ARMP.', 'srvc_code' => 9, 'dir_code' => 7],
            ['pst_code' => 26, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Secrétaire Particulière de la Direction Générale', 'pst_mission' => 'Assurer le secrétariat et la gestion de l\'agenda du Directeur Général.', 'srvc_code' => null, 'dir_code' => 1],
            ['pst_code' => 27, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Personnel d\'Appui Communication', 'pst_mission' => 'Participer aux actions de communication interne et externe.', 'srvc_code' => 8, 'dir_code' => 1],
            ['pst_code' => 28, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Dépositaire Comptable', 'pst_mission' => 'Gérer les fonds et valeurs, assurer la tenue de la caisse.', 'srvc_code' => 4, 'dir_code' => 5],
            ['pst_code' => 29, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Standardiste / Réceptionniste', 'pst_mission' => 'Accueillir les visiteurs, gérer le standard téléphonique.', 'srvc_code' => 4, 'dir_code' => 5],
            ['pst_code' => 30, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Aide Comptable', 'pst_mission' => 'Assister le comptable dans les travaux de saisie et de rapprochement.', 'srvc_code' => 4, 'dir_code' => 5],
            ['pst_code' => 31, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Agent Administratif', 'pst_mission' => 'Effectuer les tâches administratives pour le compte de la direction générale.', 'srvc_code' => 1, 'dir_code' => 1],
            ['pst_code' => 32, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Chauffeur', 'pst_mission' => 'Conduire les véhicules de service, assurer les déplacements professionnels.', 'srvc_code' => 4, 'dir_code' => 5],
            ['pst_code' => 33, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Coursier / Vaguemestre', 'pst_mission' => 'Assurer la distribution du courrier et des documents.', 'srvc_code' => 4, 'dir_code' => 5],
            ['pst_code' => 34, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Technicien de Surface', 'pst_mission' => 'Assurer le nettoyage et l\'entretien des locaux.', 'srvc_code' => 4, 'dir_code' => 5],
            ['pst_code' => 35, 'tsup_code' => null, 'rhq_code' => 4, 'pst_fonction' => 'Agent de sécurité', 'pst_mission' => 'Surveiller les locaux, contrôler les accès.', 'srvc_code' => 4, 'dir_code' => 5],
            ['pst_code' => 36, 'tsup_code' => null, 'rhq_code' => 3, 'pst_fonction' => 'Juriste', 'pst_mission' => 'Conseiller juridique, rédiger des actes et participer aux contentieux.', 'srvc_code' => 10, 'dir_code' => 2],
            ['pst_code' => 37, 'tsup_code' => null, 'rhq_code' => 3, 'pst_fonction' => 'Economiste', 'pst_mission' => 'Réaliser des études économiques, analyser les données sectorielles.', 'srvc_code' => 10, 'dir_code' => 2],
            ['pst_code' => 38, 'tsup_code' => null, 'rhq_code' => 3, 'pst_fonction' => 'Traducteur/Rédacteur', 'pst_mission' => 'Traduire des documents, rédiger des rapports et comptes-rendus.', 'srvc_code' => 10, 'dir_code' => 2],
        ]);

        // 6. occupation_poste
        $this->db->table('occupation_poste')->insertBatch([
            ['occpst_code' => 2, 'pst_code' => 2, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 3, 'pst_code' => 3, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 4, 'pst_code' => 4, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 5, 'pst_code' => 5, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 6, 'pst_code' => 6, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 9, 'pst_code' => 9, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 10, 'pst_code' => 10, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 11, 'pst_code' => 11, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 13, 'pst_code' => 13, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 14, 'pst_code' => 14, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 15, 'pst_code' => 15, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 18, 'pst_code' => 18, 'quota' => 2, 'nb_occupe' => 0, 'nb_vacant' => 2, 'nb_encessation' => 0],
            ['occpst_code' => 19, 'pst_code' => 19, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 20, 'pst_code' => 20, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 21, 'pst_code' => 21, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 22, 'pst_code' => 22, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 23, 'pst_code' => 23, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 26, 'pst_code' => 26, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 27, 'pst_code' => 27, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 29, 'pst_code' => 29, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 31, 'pst_code' => 31, 'quota' => 2, 'nb_occupe' => 0, 'nb_vacant' => 2, 'nb_encessation' => 0],
            ['occpst_code' => 32, 'pst_code' => 32, 'quota' => 15, 'nb_occupe' => 0, 'nb_vacant' => 15, 'nb_encessation' => 0],
            ['occpst_code' => 33, 'pst_code' => 33, 'quota' => 2, 'nb_occupe' => 0, 'nb_vacant' => 2, 'nb_encessation' => 0],
            ['occpst_code' => 34, 'pst_code' => 34, 'quota' => 3, 'nb_occupe' => 0, 'nb_vacant' => 3, 'nb_encessation' => 0],
            ['occpst_code' => 35, 'pst_code' => 35, 'quota' => 6, 'nb_occupe' => 0, 'nb_vacant' => 6, 'nb_encessation' => 0],
            ['occpst_code' => 36, 'pst_code' => 36, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 38, 'pst_code' => 38, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 24, 'pst_code' => 24, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 0, 'nb_encessation' => 1],
            ['occpst_code' => 30, 'pst_code' => 30, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 37, 'pst_code' => 37, 'quota' => 2, 'nb_occupe' => 0, 'nb_vacant' => 3, 'nb_encessation' => 0],
            ['occpst_code' => 28, 'pst_code' => 28, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 8, 'pst_code' => 8, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 17, 'pst_code' => 17, 'quota' => 2, 'nb_occupe' => 0, 'nb_vacant' => 2, 'nb_encessation' => 0],
            ['occpst_code' => 12, 'pst_code' => 12, 'quota' => 1, 'nb_occupe' => 1, 'nb_vacant' => 0, 'nb_encessation' => 0],
            ['occpst_code' => 25, 'pst_code' => 25, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 16, 'pst_code' => 16, 'quota' => 1, 'nb_occupe' => 1, 'nb_vacant' => 0, 'nb_encessation' => 0],
            ['occpst_code' => 7, 'pst_code' => 7, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
            ['occpst_code' => 1, 'pst_code' => 1, 'quota' => 1, 'nb_occupe' => 0, 'nb_vacant' => 1, 'nb_encessation' => 0],
        ]);

        // 7. position_
        $this->db->table('position_')->insertBatch([
            ['pos_code' => 1, 'pos_type' => 'en service'],
            ['pos_code' => 2, 'pos_type' => 'en cessation'],
            ['pos_code' => 3, 'pos_type' => 'sortie'],
        ]);

        // 8. sortie_type
        $this->db->table('sortie_type')->insertBatch([
            ['s_type_code' => 'RETRAITE', 's_type_motif' => 'Retraite'],
            ['s_type_code' => 'RENVOI', 's_type_motif' => 'Renvoi'],
            ['s_type_code' => 'ABROGATION', 's_type_motif' => 'Abrogation'],
        ]);

        // 9. statut_armp
        $this->db->table('statut_armp')->insertBatch([
            ['stt_armp_code' => 1, 'stt_armp_statut' => 'CNM'],
            ['stt_armp_code' => 2, 'stt_armp_statut' => 'Fonctionnaire/armp'],
            ['stt_armp_code' => 3, 'stt_armp_statut' => 'EFA/armp'],
            ['stt_armp_code' => 4, 'stt_armp_statut' => 'Nomination'],
            ['stt_armp_code' => 5, 'stt_armp_statut' => 'Mis en emploi'],
        ]);

        // 10. type_contrat
        $this->db->table('type_contrat')->insertBatch([
            ['tcontrat_code' => 1, 'tcontrat_nom' => 'Fonctionnaire'],
            ['tcontrat_code' => 2, 'tcontrat_nom' => 'ELD'],
            ['tcontrat_code' => 3, 'tcontrat_nom' => 'EFA'],
        ]);

        // 11. type_document
        $this->db->table('type_document')->insertBatch([
            ['tdoc_code' => 1, 'tdoc_nom' => 'Attestation de non interruption de service'],
            ['tdoc_code' => 3, 'tdoc_nom' => 'Certificat de travail'],
            ['tdoc_code' => 4, 'tdoc_nom' => 'Certificat administratif'],
            ['tdoc_code' => 5, 'tdoc_nom' => 'Attestation de stage'],
            ['tdoc_code' => 6, 'tdoc_nom' => 'Convention de stage'],
            ['tdoc_code' => 2, 'tdoc_nom' => 'Attestation d\'emploi'],
        ]);

        // 12. type_entree
        $this->db->table('type_entree')->insertBatch([
            ['e_type_code' => '1', 'e_type_motif' => 'Recrutement'],
            ['e_type_code' => '2', 'e_type_motif' => 'Nomination'],
            ['e_type_code' => '3', 'e_type_motif' => 'Transfert'],
            ['e_type_code' => '4', 'e_type_motif' => 'Promotion'],
        ]);

        // 13. users
        $this->db->table('users')->insert([
            'id' => 1,
            'username' => 'admin',
            'password' => '$2a$06$4lW7fvxHgGjrhzraqiD8yeqLySdn5Ps0u/mqt9LhxKDW2/aIst9O2',
            'nom' => 'Super',
            'prenom' => 'Administrateur',
            'role' => '0',
            'created_at' => '2025-12-15 23:19:48',
            'updated_at' => '2025-12-15 23:19:48',
        ]);
    }
}
