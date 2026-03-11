<?php

namespace App\Database\Migrations;

use CodeIgniter\Database\Migration;

class CreateRhSchema extends Migration
{
    public function up()
    {
        // 1. direction
        $this->forge->addField([
            'dir_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'dir_abbreviation' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'dir_nom' => ['type' => 'VARCHAR', 'constraint' => 100, 'null' => true],
        ]);
        $this->forge->addPrimaryKey('dir_code');
        $this->forge->createTable('direction');

        // 2. rang_hierarchique
        $this->forge->addField([
            'rhq_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'rhq_rang' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'rhq_niveau' => ['type' => 'VARCHAR', 'constraint' => 10, 'null' => true],
        ]);
        $this->forge->addPrimaryKey('rhq_code');
        $this->forge->createTable('rang_hierarchique');

        // 3. tache_suppl
        $this->forge->addField([
            'tsup_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'tsup_tache' => ['type' => 'VARCHAR', 'constraint' => 100, 'null' => true],
        ]);
        $this->forge->addPrimaryKey('tsup_code');
        $this->forge->createTable('tache_suppl');

        // 4. type_contrat
        $this->forge->addField([
            'tcontrat_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'tcontrat_nom' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
        ]);
        $this->forge->addPrimaryKey('tcontrat_code');
        $this->forge->createTable('type_contrat');

        // 5. type_entree
        $this->forge->addField([
            'e_type_code' => ['type' => 'VARCHAR', 'constraint' => 50],
            'e_type_motif' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
        ]);
        $this->forge->addPrimaryKey('e_type_code');
        $this->forge->createTable('type_entree');

        // 6. sortie_type
        $this->forge->addField([
            's_type_code' => ['type' => 'VARCHAR', 'constraint' => 50],
            's_type_motif' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
        ]);
        $this->forge->addPrimaryKey('s_type_code');
        $this->forge->createTable('sortie_type');

        // 7. statut_armp
        $this->forge->addField([
            'stt_armp_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'stt_armp_statut' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
        ]);
        $this->forge->addPrimaryKey('stt_armp_code');
        $this->forge->createTable('statut_armp');

        // 8. type_document
        $this->forge->addField([
            'tdoc_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'tdoc_nom' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
        ]);
        $this->forge->addPrimaryKey('tdoc_code');
        $this->forge->createTable('type_document');

        // 9. position_
        $this->forge->addField([
            'pos_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'pos_type' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
        ]);
        $this->forge->addPrimaryKey('pos_code');
        $this->forge->createTable('position_');

        // 10. motif_affectation
        $this->forge->addField([
            'm_aff_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'm_aff_motif' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'm_aff_type' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
        ]);
        $this->forge->addPrimaryKey('m_aff_code');
        $this->forge->createTable('motif_affectation');

        // 11. etablissement
        $this->forge->addField([
            'etab_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'etab_nom' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'etab_adresse' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
        ]);
        $this->forge->addPrimaryKey('etab_code');
        $this->forge->createTable('etablissement');

        // 12. stagiaire
        $this->forge->addField([
            'stgr_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'stgr_nom' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'stgr_prenom' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'stgr_nom_prenom' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'stgr_contact' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'stgr_filiere' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'stgr_niveau' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'stgr_sexe' => ['type' => 'BOOLEAN', 'null' => true],
            'stgr_adresse' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
        ]);
        $this->forge->addPrimaryKey('stgr_code');
        $this->forge->addUniqueKey('stgr_contact');
        $this->forge->createTable('stagiaire');

        // 13. assiduite
        $this->forge->addField([
            'asdt_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'asdt_remarque' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'asdt_nb_abscence' => ['type' => 'INTEGER', 'null' => true],
            'asdt_nb_retard' => ['type' => 'INTEGER', 'null' => true],
        ]);
        $this->forge->addPrimaryKey('asdt_code');
        $this->forge->createTable('assiduite');

        // 14. service
        $this->forge->addField([
            'srvc_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'srvc_nom' => ['type' => 'VARCHAR', 'constraint' => 100, 'null' => true],
            'dir_code' => ['type' => 'INTEGER', 'null' => true],
        ]);
        $this->forge->addPrimaryKey('srvc_code');
        $this->forge->addForeignKey('dir_code', 'direction', 'dir_code', 'CASCADE', 'SET NULL');
        $this->forge->createTable('service');

        // 15. poste
        $this->forge->addField([
            'pst_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'tsup_code' => ['type' => 'INTEGER', 'null' => true],
            'rhq_code' => ['type' => 'INTEGER', 'null' => true],
            'pst_fonction' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
            'pst_mission' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
            'srvc_code' => ['type' => 'INTEGER', 'null' => true],
            'dir_code' => ['type' => 'INTEGER', 'null' => true],
        ]);
        $this->forge->addPrimaryKey('pst_code');
        $this->forge->addForeignKey('tsup_code', 'tache_suppl', 'tsup_code', 'CASCADE', 'SET NULL');
        $this->forge->addForeignKey('rhq_code', 'rang_hierarchique', 'rhq_code', 'CASCADE', 'SET NULL');
        $this->forge->addForeignKey('srvc_code', 'service', 'srvc_code', 'CASCADE', 'SET NULL');
        $this->forge->addForeignKey('dir_code', 'direction', 'dir_code', 'CASCADE', 'SET NULL');
        $this->forge->createTable('poste');

        // 16. occupation_poste
        $this->forge->addField([
            'occpst_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'pst_code' => ['type' => 'INTEGER', 'null' => true],
            'quota' => ['type' => 'INTEGER', 'null' => true],
            'nb_occupe' => ['type' => 'INTEGER', 'null' => true],
            'nb_vacant' => ['type' => 'INTEGER', 'null' => true],
            'nb_encessation' => ['type' => 'INTEGER', 'null' => true],
        ]);
        $this->forge->addPrimaryKey('occpst_code');
        $this->forge->addUniqueKey('pst_code');
        $this->forge->addForeignKey('pst_code', 'poste', 'pst_code', 'CASCADE', 'CASCADE');
        $this->forge->createTable('occupation_poste');

        // 17. employe
        $this->forge->addField([
            'emp_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'emp_matricule' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'emp_nom' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'emp_prenom' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'emp_titre' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'emp_sexe' => ['type' => 'BOOLEAN', 'null' => true],
            'emp_datenaissance' => ['type' => 'DATE', 'null' => true],
            'emp_im_armp' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'emp_im_etat' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'date_entree' => ['type' => 'DATE', 'null' => true],
            'date_sortie' => ['type' => 'DATE', 'null' => true],
            's_type_code' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'e_type_code' => ['type' => 'VARCHAR', 'constraint' => 50],
            'emp_mail' => ['type' => 'VARCHAR', 'constraint' => 100, 'null' => true],
            'emp_cin' => ['type' => 'VARCHAR', 'constraint' => 100, 'null' => true],
        ]);
        $this->forge->addPrimaryKey('emp_code');
        $this->forge->addUniqueKey('emp_im_armp');
        $this->forge->addUniqueKey('emp_im_etat');
        $this->forge->addUniqueKey('emp_mail');
        $this->forge->addForeignKey('s_type_code', 'sortie_type', 's_type_code', 'CASCADE', 'SET NULL');
        $this->forge->addForeignKey('e_type_code', 'type_entree', 'e_type_code', 'CASCADE', 'RESTRICT');
        $this->forge->createTable('employe');

        // 18. pos_emp
        $this->forge->addField([
            'emp_code' => ['type' => 'INTEGER'],
            'pos_code' => ['type' => 'INTEGER'],
            'date_' => ['type' => 'DATE', 'null' => true],
        ]);
        $this->forge->addPrimaryKey(['emp_code', 'pos_code']);
        $this->forge->addForeignKey('emp_code', 'employe', 'emp_code', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('pos_code', 'position_', 'pos_code', 'CASCADE', 'CASCADE');
        $this->forge->createTable('pos_emp');

        // 19. contact
        $this->forge->addField([
            'id_contact' => ['type' => 'INTEGER', 'auto_increment' => true],
            'numero' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'emp_code' => ['type' => 'INTEGER'],
        ]);
        $this->forge->addPrimaryKey('id_contact');
        $this->forge->addUniqueKey('numero');
        $this->forge->addForeignKey('emp_code', 'employe', 'emp_code', 'CASCADE', 'CASCADE');
        $this->forge->createTable('contact');

        // 20. statut_emp
        $this->forge->addField([
            'emp_code' => ['type' => 'INTEGER'],
            'stt_armp_code' => ['type' => 'INTEGER'],
            'date_' => ['type' => 'DATE', 'null' => true],
        ]);
        $this->forge->addPrimaryKey(['emp_code', 'stt_armp_code']);
        $this->forge->addForeignKey('emp_code', 'employe', 'emp_code', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('stt_armp_code', 'statut_armp', 'stt_armp_code', 'CASCADE', 'CASCADE');
        $this->forge->createTable('statut_emp');

        // 21. affectation
        $this->forge->addField([
            'affec_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'affec_date_debut' => ['type' => 'DATE', 'null' => true],
            'affec_date_fin' => ['type' => 'DATE', 'null' => true],
            'affec_commentaire' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
            'm_aff_code' => ['type' => 'INTEGER', 'null' => true],
            'emp_code' => ['type' => 'INTEGER'],
            'pst_code' => ['type' => 'INTEGER'],
            'affec_etat' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
            'tcontrat_code' => ['type' => 'INTEGER', 'null' => true],
        ]);
        $this->forge->addPrimaryKey('affec_code');
        $this->forge->addForeignKey('m_aff_code', 'motif_affectation', 'm_aff_code', 'CASCADE', 'SET NULL');
        $this->forge->addForeignKey('emp_code', 'employe', 'emp_code', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('pst_code', 'poste', 'pst_code', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('tcontrat_code', 'type_contrat', 'tcontrat_code', 'CASCADE', 'SET NULL');
        $this->forge->createTable('affectation');

        // 22. sortie
        $this->forge->addField([
            'emp_code' => ['type' => 'INTEGER'],
            's_type_code' => ['type' => 'VARCHAR', 'constraint' => 50],
            'commentaire' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
            'date_sortie' => ['type' => 'DATE'],
        ]);
        $this->forge->addPrimaryKey(['emp_code', 's_type_code', 'date_sortie']);
        $this->forge->addForeignKey('emp_code', 'employe', 'emp_code', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('s_type_code', 'sortie_type', 's_type_code', 'CASCADE', 'CASCADE');
        $this->forge->createTable('sortie');

        // 23. competence
        $this->forge->addField([
            'comp_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'comp_intitule' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'comp_domaine' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'comp_description' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
        ]);
        $this->forge->addPrimaryKey('comp_code');
        $this->forge->createTable('competence');

        // 24. comp_employe
        $this->forge->addField([
            'emp_code' => ['type' => 'INTEGER'],
            'comp_code' => ['type' => 'INTEGER'],
            'niveau_acquis' => ['type' => 'INTEGER', 'null' => true],
        ]);
        $this->forge->addPrimaryKey(['emp_code', 'comp_code']);
        $this->forge->addForeignKey('emp_code', 'employe', 'emp_code', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('comp_code', 'competence', 'comp_code', 'CASCADE', 'CASCADE');
        $this->forge->createTable('comp_employe');

        // 25. comp_poste
        $this->forge->addField([
            'pst_code' => ['type' => 'INTEGER'],
            'comp_code' => ['type' => 'INTEGER'],
            'niveau_requis' => ['type' => 'INTEGER', 'null' => true],
        ]);
        $this->forge->addPrimaryKey(['pst_code', 'comp_code']);
        $this->forge->addForeignKey('pst_code', 'poste', 'pst_code', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('comp_code', 'competence', 'comp_code', 'CASCADE', 'CASCADE');
        $this->forge->createTable('comp_poste');

        // 26. doc_emp
        $this->forge->addField([
            'tdoc_code' => ['type' => 'INTEGER'],
            'affec_code' => ['type' => 'INTEGER'],
            'doc_emp_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'doc_emp_date' => ['type' => 'DATE', 'null' => true],
            'doc_emp_statut' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'tdoc_matricule' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'usage' => ['type' => 'VARCHAR', 'constraint' => 100, 'null' => true],
            'commentaire' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
        ]);
        $this->forge->addPrimaryKey(['tdoc_code', 'affec_code']);
        $this->forge->addUniqueKey('doc_emp_code');
        $this->forge->addUniqueKey('tdoc_matricule');
        $this->forge->addForeignKey('tdoc_code', 'type_document', 'tdoc_code', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('affec_code', 'affectation', 'affec_code', 'CASCADE', 'CASCADE');
        $this->forge->createTable('doc_emp');

        // 27. eval_stage
        $this->forge->addField([
            'evstg_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'evstg_lieu' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'evstg_note' => ['type' => 'INTEGER', 'null' => true],
            'evstg_aptitude' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'evstg_date_eval' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'asdt_code' => ['type' => 'INTEGER', 'null' => true],
        ]);
        $this->forge->addPrimaryKey('evstg_code');
        $this->forge->addForeignKey('asdt_code', 'assiduite', 'asdt_code', 'CASCADE', 'SET NULL');
        $this->forge->createTable('eval_stage');

        // 28. stage
        $this->forge->addField([
            'stg_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'stg_duree' => ['type' => 'INTEGER', 'null' => true],
            'stg_date_debut' => ['type' => 'DATE', 'null' => true],
            'stg_date_fin' => ['type' => 'DATE', 'null' => true],
            'stg_theme' => ['type' => 'VARCHAR', 'constraint' => 255, 'null' => true],
            'evstg_code' => ['type' => 'INTEGER', 'null' => true],
            'stgr_code' => ['type' => 'INTEGER', 'null' => true],
            'etab_code' => ['type' => 'INTEGER', 'null' => true],
        ]);
        $this->forge->addPrimaryKey('stg_code');
        $this->forge->addForeignKey('evstg_code', 'eval_stage', 'evstg_code', 'CASCADE', 'SET NULL');
        $this->forge->addForeignKey('stgr_code', 'stagiaire', 'stgr_code', 'CASCADE', 'SET NULL');
        $this->forge->addForeignKey('etab_code', 'etablissement', 'etab_code', 'CASCADE', 'SET NULL');
        $this->forge->createTable('stage');

        // 29. doc_stage
        $this->forge->addField([
            'tdoc_code' => ['type' => 'INTEGER'],
            'stg_code' => ['type' => 'INTEGER'],
            'doc_stg_code' => ['type' => 'INTEGER', 'auto_increment' => true],
            'doc_stg_date' => ['type' => 'DATE', 'null' => true],
            'tdoc_matricule' => ['type' => 'VARCHAR', 'constraint' => 50, 'null' => true],
            'doc_stage_statut' => ['type' => 'VARCHAR', 'constraint' => 50, 'default' => 'en attente'],
        ]);
        $this->forge->addPrimaryKey(['tdoc_code', 'stg_code']);
        $this->forge->addUniqueKey('doc_stg_code');
        $this->forge->addForeignKey('tdoc_code', 'type_document', 'tdoc_code', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('stg_code', 'stage', 'stg_code', 'CASCADE', 'CASCADE');
        $this->forge->createTable('doc_stage');

        // 30. stage_carriere
        $this->forge->addField([
            'emp_code' => ['type' => 'INTEGER'],
            'pst_code' => ['type' => 'INTEGER'],
            'stg_code' => ['type' => 'INTEGER'],
            'stg_carriere_code' => ['type' => 'INTEGER', 'auto_increment' => true],
        ]);
        $this->forge->addPrimaryKey(['emp_code', 'pst_code', 'stg_code']);
        $this->forge->addUniqueKey('stg_carriere_code');
        $this->forge->addForeignKey('emp_code', 'employe', 'emp_code', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('pst_code', 'poste', 'pst_code', 'CASCADE', 'CASCADE');
        $this->forge->addForeignKey('stg_code', 'stage', 'stg_code', 'CASCADE', 'CASCADE');
        $this->forge->createTable('stage_carriere');

        // 31. users
        $this->forge->addField([
            'id' => ['type' => 'INTEGER', 'auto_increment' => true],
            'username' => ['type' => 'VARCHAR', 'constraint' => 150],
            'password' => ['type' => 'VARCHAR', 'constraint' => 255],
            'nom' => ['type' => 'VARCHAR', 'constraint' => 150, 'null' => true],
            'prenom' => ['type' => 'VARCHAR', 'constraint' => 150, 'null' => true],
            'role' => ['type' => 'VARCHAR', 'constraint' => 100, 'null' => true],
            'created_at' => ['type' => 'TIMESTAMP', 'default' => new \CodeIgniter\Database\RawSql('CURRENT_TIMESTAMP')],
            'updated_at' => ['type' => 'TIMESTAMP', 'default' => new \CodeIgniter\Database\RawSql('CURRENT_TIMESTAMP')],
        ]);
        $this->forge->addPrimaryKey('id');
        $this->forge->addUniqueKey('username');
        $this->forge->createTable('users');
    }

    public function down()
    {
        $this->forge->dropTable('users', true);
        $this->forge->dropTable('stage_carriere', true);
        $this->forge->dropTable('doc_stage', true);
        $this->forge->dropTable('stage', true);
        $this->forge->dropTable('eval_stage', true);
        $this->forge->dropTable('doc_emp', true);
        $this->forge->dropTable('comp_poste', true);
        $this->forge->dropTable('comp_employe', true);
        $this->forge->dropTable('competence', true);
        $this->forge->dropTable('sortie', true);
        $this->forge->dropTable('affectation', true);
        $this->forge->dropTable('statut_emp', true);
        $this->forge->dropTable('contact', true);
        $this->forge->dropTable('pos_emp', true);
        $this->forge->dropTable('employe', true);
        $this->forge->dropTable('occupation_poste', true);
        $this->forge->dropTable('poste', true);
        $this->forge->dropTable('service', true);
        $this->forge->dropTable('assiduite', true);
        $this->forge->dropTable('stagiaire', true);
        $this->forge->dropTable('etablissement', true);
        $this->forge->dropTable('motif_affectation', true);
        $this->forge->dropTable('position_', true);
        $this->forge->dropTable('type_document', true);
        $this->forge->dropTable('statut_armp', true);
        $this->forge->dropTable('sortie_type', true);
        $this->forge->dropTable('type_entree', true);
        $this->forge->dropTable('type_contrat', true);
        $this->forge->dropTable('tache_suppl', true);
        $this->forge->dropTable('rang_hierarchique', true);
        $this->forge->dropTable('direction', true);
    }
}
