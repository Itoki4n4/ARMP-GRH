-- =====================================================
-- SYSTÈME D'INFORMATION RH – ARMP
-- Gestion administrative, carrières, compétences et stages
-- Version PostgreSQL complète
-- ORDRE CORRIGÉ POUR ÉVITER LES ERREURS DE DÉPENDANCE
-- =====================================================

-- =========================
-- TABLES DE RÉFÉRENCE (sans dépendances)
-- =========================

CREATE TABLE direction (
    dir_code SERIAL PRIMARY KEY,
    dir_abbreviation VARCHAR(50),
    dir_nom VARCHAR(100)
);

CREATE TABLE service_ (
    srvc_code SERIAL PRIMARY KEY,
    srvc_nom VARCHAR(100),
    dir_code INTEGER REFERENCES direction(dir_code)
);

CREATE TABLE rang_hierarchique (
    rhq_code SERIAL PRIMARY KEY,
    rhq_rang VARCHAR(50),
    rhq_niveau VARCHAR(10)
);

CREATE TABLE tache_suppl (
    tsup_code SERIAL PRIMARY KEY,
    tsup_tache VARCHAR(100)
);

CREATE TABLE type_contrat (
    tcontrat_code SERIAL PRIMARY KEY,
    tcontrat_nom VARCHAR(50)
);

CREATE TABLE type_entree (
    e_type_code VARCHAR(50) PRIMARY KEY,
    e_type_motif VARCHAR(50)
);

CREATE TABLE sortie_type (
    s_type_code VARCHAR(50) PRIMARY KEY,
    s_type_motif VARCHAR(50)
);

CREATE TABLE statut_armp (
    stt_armp_code SERIAL PRIMARY KEY,
    stt_armp_statut VARCHAR(50)
);

CREATE TABLE type_document (
    tdoc_code SERIAL PRIMARY KEY,
    tdoc_nom VARCHAR(50)
);

-- =========================
-- POSTES & STRUCTURE
-- =========================

CREATE TABLE poste (
    pst_code SERIAL PRIMARY KEY,
    tsup_code INTEGER REFERENCES tache_suppl(tsup_code),
    rhq_code INTEGER REFERENCES rang_hierarchique(rhq_code),
    pst_fonction VARCHAR(255),
    pst_mission VARCHAR(255),
    srvc_code INTEGER REFERENCES service_(srvc_code),
    dir_code INTEGER REFERENCES direction(dir_code)
);

CREATE TABLE occupation_poste (
    occpst_code SERIAL PRIMARY KEY,
    pst_code INTEGER UNIQUE REFERENCES poste(pst_code),
    quota INTEGER,
    nb_occupe INTEGER,
    nb_vacant INTEGER,
    nb_encessation INTEGER
);

-- =========================
-- POSITION ADMINISTRATIVE
-- =========================

CREATE TABLE position_ (
    pos_code SERIAL PRIMARY KEY,
    pos_type VARCHAR(50)
);

-- =========================
-- EMPLOYÉS
-- =========================

CREATE TABLE employe (
    emp_code SERIAL PRIMARY KEY,
    emp_matricule VARCHAR(50),
    emp_nom VARCHAR(50),
    emp_prenom VARCHAR(50),
    emp_titre VARCHAR(50),
    emp_sexe BOOLEAN,
    emp_datenaissance DATE,
    emp_im_armp VARCHAR(50) UNIQUE,
    emp_im_etat VARCHAR(50) UNIQUE,
    date_entree DATE,
    date_sortie DATE,
    s_type_code VARCHAR(50) REFERENCES sortie_type(s_type_code),
    e_type_code VARCHAR(50) NOT NULL REFERENCES type_entree(e_type_code),
    emp_mail VARCHAR(100) UNIQUE,
    emp_cin VARCHAR(100)
);

CREATE TABLE pos_emp (
    emp_code INTEGER REFERENCES employe(emp_code),
    pos_code INTEGER REFERENCES position_(pos_code),
    date_ DATE,
    PRIMARY KEY (emp_code, pos_code)
);

CREATE TABLE contact (
    id_contact SERIAL PRIMARY KEY,
    numero VARCHAR(50) UNIQUE,
    emp_code INTEGER NOT NULL REFERENCES employe(emp_code)
);

CREATE TABLE statut_emp (
    emp_code INTEGER REFERENCES employe(emp_code),
    stt_armp_code INTEGER REFERENCES statut_armp(stt_armp_code),
    date_ DATE,
    PRIMARY KEY (emp_code, stt_armp_code)
);

-- =========================
-- AFFECTATIONS & CARRIÈRES
-- =========================

CREATE TABLE motif_affectation (
    m_aff_code SERIAL PRIMARY KEY,
    m_aff_motif VARCHAR(50),
    m_aff_type VARCHAR(50)
);

CREATE TABLE affectation (
    affec_code SERIAL PRIMARY KEY,
    affec_date_debut DATE,
    affec_date_fin DATE,
    affec_commentaire VARCHAR(50),
    m_aff_code INTEGER REFERENCES motif_affectation(m_aff_code),
    emp_code INTEGER NOT NULL REFERENCES employe(emp_code),
    pst_code INTEGER NOT NULL REFERENCES poste(pst_code),
    affec_etat VARCHAR(255),
    tcontrat_code INTEGER REFERENCES type_contrat(tcontrat_code)
);

CREATE TABLE sortie (
    emp_code INTEGER REFERENCES employe(emp_code),
    s_type_code VARCHAR(50) REFERENCES sortie_type(s_type_code),
    commentaire VARCHAR(255),
    date_sortie DATE,
    PRIMARY KEY (emp_code, s_type_code, date_sortie)
);

-- =========================
-- COMPÉTENCES
-- =========================

CREATE TABLE competence (
    comp_code SERIAL PRIMARY KEY,
    comp_intitule VARCHAR(50),
    comp_domaine VARCHAR(50),
    comp_description VARCHAR(50)
);

CREATE TABLE comp_employe (
    emp_code INTEGER REFERENCES employe(emp_code),
    comp_code INTEGER REFERENCES competence(comp_code),
    niveau_acquis INTEGER,
    PRIMARY KEY (emp_code, comp_code)
);

CREATE TABLE comp_poste (
    pst_code INTEGER REFERENCES poste(pst_code),
    comp_code INTEGER REFERENCES competence(comp_code),
    niveau_requis INTEGER,
    PRIMARY KEY (pst_code, comp_code)
);

-- =========================
-- DOCUMENTS EMPLOYÉS
-- =========================

CREATE TABLE doc_emp (
    tdoc_code INTEGER REFERENCES type_document(tdoc_code),
    affec_code INTEGER REFERENCES affectation(affec_code),
    doc_emp_code SERIAL UNIQUE,
    doc_emp_date DATE,
    doc_emp_statut VARCHAR(50),
    tdoc_matricule VARCHAR(50) UNIQUE,
    usage VARCHAR(100),
    commentaire VARCHAR(255),
    PRIMARY KEY (tdoc_code, affec_code)
);

-- =========================
-- STAGES
-- =========================

CREATE TABLE etablissement (
    etab_code SERIAL PRIMARY KEY,
    etab_nom VARCHAR(50),
    etab_adresse VARCHAR(50)
);

CREATE TABLE stagiaire (
    stgr_code SERIAL PRIMARY KEY,
    stgr_nom VARCHAR(50),
    stgr_prenom VARCHAR(50),
    stgr_nom_prenom VARCHAR(50),
    stgr_contact VARCHAR(50) UNIQUE,
    stgr_filiere VARCHAR(50),
    stgr_niveau VARCHAR(50),
    stgr_sexe BOOLEAN,
    stgr_adresse VARCHAR(255)
);

CREATE TABLE assiduite (
    asdt_code SERIAL PRIMARY KEY,
    asdt_remarque VARCHAR(50),
    asdt_nb_abscence INTEGER,
    asdt_nb_retard INTEGER
);

CREATE TABLE eval_stage (
    evstg_code SERIAL PRIMARY KEY,
    evstg_lieu VARCHAR(50),
    evstg_note INTEGER,
    evstg_aptitude VARCHAR(50),
    evstg_date_eval VARCHAR(50),
    asdt_code INTEGER REFERENCES assiduite(asdt_code)
);

CREATE TABLE stage (
    stg_code SERIAL PRIMARY KEY,
    stg_duree INTEGER,
    stg_date_debut DATE,
    stg_date_fin DATE,
    stg_theme VARCHAR(50),
    evstg_code INTEGER REFERENCES eval_stage(evstg_code),
    stgr_code INTEGER REFERENCES stagiaire(stgr_code),
    etab_code INTEGER REFERENCES etablissement(etab_code)
);

CREATE TABLE doc_stage (
    tdoc_code INTEGER REFERENCES type_document(tdoc_code),
    stg_code INTEGER REFERENCES stage(stg_code),
    doc_stg_code SERIAL UNIQUE,
    doc_stg_date DATE,
    tdoc_matricule VARCHAR(50),
    doc_stage_statut VARCHAR(50) DEFAULT 'en attente',
    PRIMARY KEY (tdoc_code, stg_code)
);

CREATE TABLE stage_carriere (
    emp_code INTEGER REFERENCES employe(emp_code),
    pst_code INTEGER REFERENCES poste(pst_code),
    stg_code INTEGER REFERENCES stage(stg_code),
    stg_carriere_code SERIAL UNIQUE,
    PRIMARY KEY (emp_code, pst_code, stg_code)
);

-- =========================
-- UTILISATEURS
-- =========================

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    nom VARCHAR(150),
    prenom VARCHAR(150),
    role VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================================
-- INDEX POUR PERFORMANCE
-- ==============================================



-- ==============================================
-- FIN DU SCHÉMA
-- ==============================================