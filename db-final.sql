-- =====================================================
-- SCHEMA COMPLET DE LA BASE DE DONNÉES GPRH
-- Version finale avec toutes les modifications intégrées
-- =====================================================

-- =====================================================
-- TABLES DE RÉFÉRENTIEL
-- =====================================================

CREATE TABLE statut_armp(
   stt_armp_code SERIAL,
   stt_armp_statut VARCHAR(50),
   PRIMARY KEY(stt_armp_code)
);

CREATE TABLE service(
   srvc_code SERIAL,
   srvc_nom VARCHAR(50),
   PRIMARY KEY(srvc_code)
);

CREATE TABLE direction(
   dir_code SERIAL,
   dir_nom VARCHAR(50),
   dir_abbreviation VARCHAR(50),
   srvc_code INTEGER NOT NULL,
   PRIMARY KEY(dir_code),
   FOREIGN KEY(srvc_code) REFERENCES service(srvc_code)
);

CREATE TABLE tache_suppl(
   tsup_code SERIAL,
   tsup_tache VARCHAR(50),
   PRIMARY KEY(tsup_code)
);

CREATE TABLE niveau_hierarchique(
   nivhq_code SERIAL,
   nivhq_niveau VARCHAR(50),
   PRIMARY KEY(nivhq_code)
);

CREATE TABLE rang_hierarchique(
   rhq_code SERIAL,
   rhq_rang VARCHAR(50),
   PRIMARY KEY(rhq_code)
);

CREATE TABLE statut_poste(
   stpst_code SERIAL,
   stpst_statut VARCHAR(50),
   PRIMARY KEY(stpst_code)
);

CREATE TABLE categ_poste_recrutement(
   ctgr_code SERIAL,
   ctgr_statut VARCHAR(50),
   PRIMARY KEY(ctgr_code)
);

CREATE TABLE indice_recrutement(
   idrec_code SERIAL,
   idrec_nom VARCHAR(50),
   PRIMARY KEY(idrec_code)
);

CREATE TABLE type_entree(
   e_type_code VARCHAR(50),
   e_type_motif VARCHAR(50),
   PRIMARY KEY(e_type_code)
);

CREATE TABLE sortie_type(
   s_type_code VARCHAR(50),
   s_type_motif VARCHAR(50),
   PRIMARY KEY(s_type_code)
);

CREATE TABLE position_(
   pos_code SERIAL,
   pos_type VARCHAR(50),
   PRIMARY KEY(pos_code)
);

-- =====================================================
-- TABLES PRINCIPALES
-- =====================================================

CREATE TABLE employe(
   emp_code SERIAL,
   emp_matricule VARCHAR(50),
   emp_nom VARCHAR(50),
   emp_prenom VARCHAR(50),
   emp_titre VARCHAR(50),
   emp_sexe BOOLEAN,
   emp_datenaissance DATE,
   emp_im_armp VARCHAR(50),
   emp_im_etat VARCHAR(50),
   emp_mail VARCHAR(100),
   date_entree DATE,
   date_sortie DATE,
   s_type_code VARCHAR(50),
   e_type_code VARCHAR(50) NOT NULL,
   PRIMARY KEY(emp_code),
   UNIQUE(emp_im_armp),
   UNIQUE(emp_im_etat),
   FOREIGN KEY(s_type_code) REFERENCES sortie_type(s_type_code),
   FOREIGN KEY(e_type_code) REFERENCES type_entree(e_type_code)
);

CREATE TABLE contact(
   id_contact SERIAL,
   numero VARCHAR(50),
   emp_code INTEGER NOT NULL,
   PRIMARY KEY(id_contact),
   UNIQUE(numero),
   FOREIGN KEY(emp_code) REFERENCES employe(emp_code)
);

CREATE TABLE poste(
   pst_code SERIAL,
   pst_fonction VARCHAR(50),
   pst_mission VARCHAR(50),
   tsup_code INTEGER,
   nivhq_code INTEGER NOT NULL,
   rhq_code INTEGER NOT NULL,
   ctgr_code INTEGER NOT NULL,
   idrec_code INTEGER NOT NULL,
   stpst_code INTEGER,
   srvc_code INTEGER,
   PRIMARY KEY(pst_code),
   FOREIGN KEY(tsup_code) REFERENCES tache_suppl(tsup_code),
   FOREIGN KEY(nivhq_code) REFERENCES niveau_hierarchique(nivhq_code),
   FOREIGN KEY(rhq_code) REFERENCES rang_hierarchique(rhq_code),
   FOREIGN KEY(ctgr_code) REFERENCES categ_poste_recrutement(ctgr_code),
   FOREIGN KEY(idrec_code) REFERENCES indice_recrutement(idrec_code),
   FOREIGN KEY(stpst_code) REFERENCES statut_poste(stpst_code),
   FOREIGN KEY(srvc_code) REFERENCES service(srvc_code)
);

CREATE TABLE occupation_poste(
   occpst_code SERIAL PRIMARY KEY,
   pst_code INTEGER,
   quota INTEGER,
   nb_occupe INTEGER,
   nb_vacant INTEGER,
   nb_encessation INTEGER,
   FOREIGN KEY(pst_code) REFERENCES poste(pst_code),
   CONSTRAINT occupation_poste_pst_code_unique UNIQUE (pst_code)
);

CREATE TABLE affectation(
   affec_code SERIAL,
   affec_date_debut DATE,
   affec_date_fin DATE,
   affec_commentaire VARCHAR(50),
   affec_type_contrat VARCHAR(50),
   m_aff_code INTEGER NOT NULL,
   emp_code INTEGER NOT NULL,
   pst_code INTEGER NOT NULL,
   PRIMARY KEY(affec_code),
   FOREIGN KEY(m_aff_code) REFERENCES motif_affectation(m_aff_code),
   FOREIGN KEY(emp_code) REFERENCES employe(emp_code),
   FOREIGN KEY(pst_code) REFERENCES poste(pst_code)
);

CREATE TABLE sortie(
   emp_code INTEGER NOT NULL,
   s_type_code VARCHAR(50) NOT NULL,
   commentaire VARCHAR(255),
   date_sortie DATE NOT NULL,
   PRIMARY KEY(emp_code, s_type_code, date_sortie),
   FOREIGN KEY(emp_code) REFERENCES employe(emp_code),
   FOREIGN KEY(s_type_code) REFERENCES sortie_type(s_type_code)
);

-- =====================================================
-- TABLES DE RELATION
-- =====================================================

CREATE TABLE motif_affectation(
   m_aff_code SERIAL,
   m_aff_motif VARCHAR(50),
   m_aff_type VARCHAR(50),
   PRIMARY KEY(m_aff_code)
);

CREATE TABLE pos_emp(
   emp_code INTEGER,
   pos_code INTEGER,
   date_ DATE,
   PRIMARY KEY(emp_code, pos_code),
   FOREIGN KEY(emp_code) REFERENCES employe(emp_code),
   FOREIGN KEY(pos_code) REFERENCES position_(pos_code)
);

CREATE TABLE statut_emp(
   emp_code INTEGER,
   stt_armp_code INTEGER,
   date_ DATE,
   PRIMARY KEY(emp_code, stt_armp_code),
   FOREIGN KEY(emp_code) REFERENCES employe(emp_code),
   FOREIGN KEY(stt_armp_code) REFERENCES statut_armp(stt_armp_code)
);

-- =====================================================
-- TABLES DOCUMENTS
-- =====================================================

CREATE TABLE type_document(
   tdoc_code SERIAL,
   tdoc_nom VARCHAR(50),
   PRIMARY KEY(tdoc_code)
);

CREATE TABLE doc_emp(
   tdoc_code INTEGER,
   affec_code INTEGER,
   doc_emp_statut VARCHAR(50),
   doc_emp_code SERIAL NOT NULL,
   doc_emp_date DATE,
   tdoc_matricule VARCHAR(50) UNIQUE NOT NULL,
   PRIMARY KEY(tdoc_code, affec_code),
   UNIQUE(doc_emp_code),
   FOREIGN KEY(tdoc_code) REFERENCES type_document(tdoc_code),
   FOREIGN KEY(affec_code) REFERENCES affectation(affec_code)
);

-- =====================================================
-- TABLES COMPÉTENCES
-- =====================================================

CREATE TABLE competence(
   comp_code SERIAL,
   comp_intitule VARCHAR(50),
   comp_domaine VARCHAR(50),
   comp_description VARCHAR(50),
   PRIMARY KEY(comp_code)
);

CREATE TABLE comp_employe(
   emp_code INTEGER,
   comp_code INTEGER,
   niveau_acquis INTEGER,
   PRIMARY KEY(emp_code, comp_code),
   FOREIGN KEY(emp_code) REFERENCES employe(emp_code),
   FOREIGN KEY(comp_code) REFERENCES competence(comp_code)
);

CREATE TABLE comp_poste(
   pst_code INTEGER,
   comp_code INTEGER,
   niveau_requis INTEGER,
   PRIMARY KEY(pst_code, comp_code),
   FOREIGN KEY(pst_code) REFERENCES poste(pst_code),
   FOREIGN KEY(comp_code) REFERENCES competence(comp_code)
);

CREATE TABLE fonction_direc(
   dir_code INTEGER,
   pst_code INTEGER,
   PRIMARY KEY(dir_code, pst_code),
   FOREIGN KEY(dir_code) REFERENCES direction(dir_code),
   FOREIGN KEY(pst_code) REFERENCES poste(pst_code)
);

-- =====================================================
-- TABLES STAGES
-- =====================================================

CREATE TABLE stagiaire(
   stgr_code SERIAL,
   stgr_nom VARCHAR(50),
   stgr_prenom VARCHAR(50),
   stgr_nom_prenom VARCHAR(50),
   stgr_contact VARCHAR(50),
   stgr_filiere VARCHAR(50),
   stgr_niveau VARCHAR(50),
   PRIMARY KEY(stgr_code),
   UNIQUE(stgr_contact)
);

CREATE TABLE etablissement(
   etab_code SERIAL,
   etab_nom VARCHAR(50),
   etab_adresse VARCHAR(50),
   PRIMARY KEY(etab_code)
);

CREATE TABLE assiduite(
   asdt_code SERIAL,
   asdt_remarque VARCHAR(50),
   asdt_nb_abscence INTEGER,
   asdt_nb_retard INTEGER,
   PRIMARY KEY(asdt_code)
);

CREATE TABLE eval_stage(
   evstg_code SERIAL,
   evstg_lieu VARCHAR(50),
   evstg_note INTEGER,
   evstg_aptitude VARCHAR(50),
   evstg_date_eval VARCHAR(50),
   asdt_code INTEGER NOT NULL,
   PRIMARY KEY(evstg_code),
   FOREIGN KEY(asdt_code) REFERENCES assiduite(asdt_code)
);

CREATE TABLE stage(
   stg_code SERIAL,
   stg_duree INTEGER,
   stg_date_debut DATE,
   stg_date_fin DATE,
   stg_theme VARCHAR(50),
   evstg_code INTEGER NULL,
   stgr_code INTEGER NOT NULL,
   etab_code INTEGER NOT NULL,
   PRIMARY KEY(stg_code),
   FOREIGN KEY(evstg_code) REFERENCES eval_stage(evstg_code),
   FOREIGN KEY(stgr_code) REFERENCES stagiaire(stgr_code),
   FOREIGN KEY(etab_code) REFERENCES etablissement(etab_code)
);

CREATE TABLE stage_carriere(
   emp_code INTEGER,
   pst_code INTEGER,
   stg_code INTEGER,
   stg_carriere_code SERIAL NOT NULL,
   PRIMARY KEY(emp_code, pst_code, stg_code),
   UNIQUE(stg_carriere_code),
   FOREIGN KEY(emp_code) REFERENCES employe(emp_code),
   FOREIGN KEY(pst_code) REFERENCES poste(pst_code),
   FOREIGN KEY(stg_code) REFERENCES stage(stg_code)
);

CREATE TABLE doc_stage(
   tdoc_code INTEGER,
   stg_code INTEGER,
   doc_stg_code SERIAL NOT NULL,
   doc_stg_date DATE,
   PRIMARY KEY(tdoc_code, stg_code),
   UNIQUE(doc_stg_code),
   FOREIGN KEY(tdoc_code) REFERENCES type_document(tdoc_code),
   FOREIGN KEY(stg_code) REFERENCES stage(stg_code)
);

-- =====================================================
-- TABLE UTILISATEURS
-- =====================================================

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nom VARCHAR(150),
    prenom VARCHAR(150),
    role VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- DONNÉES INITIALES
-- =====================================================

-- Insertion des positions par défaut
INSERT INTO position_(pos_type) VALUES 
    ('En service'),
    ('En cessation'),
    ('Sortie')
ON CONFLICT DO NOTHING;

-- Insertion des types de sortie
INSERT INTO sortie_type (s_type_code, s_type_motif) VALUES 
    ('RETRAITE', 'Retraite'),
    ('RENVOI', 'Renvoi'),
    ('ABROGATION', 'Abrogation')
ON CONFLICT (s_type_code) DO NOTHING;

-- Initialisation de occupation_poste pour tous les postes existants
INSERT INTO occupation_poste (pst_code, quota, nb_occupe, nb_vacant, nb_encessation)
SELECT 
    p.pst_code,
    1 as quota,
    COALESCE((
        SELECT COUNT(*)
        FROM affectation a
        WHERE a.pst_code = p.pst_code
          AND a.affec_date_fin IS NULL
    ), 0) as nb_occupe,
    GREATEST(0, 1 - COALESCE((
        SELECT COUNT(*)
        FROM affectation a
        WHERE a.pst_code = p.pst_code
          AND a.affec_date_fin IS NULL
    ), 0)) as nb_vacant,
    0 as nb_encessation
FROM poste p
WHERE NOT EXISTS (
    SELECT 1 FROM occupation_poste op WHERE op.pst_code = p.pst_code
)
ON CONFLICT (pst_code) DO NOTHING;

-- Migration optionnelle : Migrer les données existantes de employe vers sortie
-- (Si des employés ont déjà date_sortie et s_type_code)
INSERT INTO sortie (emp_code, s_type_code, date_sortie, commentaire)
SELECT emp_code, s_type_code, date_sortie, NULL
FROM employe
WHERE date_sortie IS NOT NULL 
  AND s_type_code IS NOT NULL
  AND NOT EXISTS (
      SELECT 1 FROM sortie s 
      WHERE s.emp_code = employe.emp_code 
        AND s.s_type_code = employe.s_type_code 
        AND s.date_sortie = employe.date_sortie
  );

-- =====================================================
-- FIN DU SCHÉMA
-- =====================================================

