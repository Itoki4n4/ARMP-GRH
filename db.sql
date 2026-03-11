CREATE TABLE statut_armp(
   stt_armp_code SERIAL,
   stt_armp_statut VARCHAR(50) ,
   PRIMARY KEY(stt_armp_code)
);

CREATE TABLE service(
   srvc_code SERIAL,
   srvc_nom VARCHAR(50) ,
   dir_code INTEGER NOT NULL,
   PRIMARY KEY(srvc_code),
   FOREIGN KEY(dir_code) REFERENCES direction(dir_code)
);

CREATE TABLE direction(
   dir_code SERIAL,
   dir_nom VARCHAR(50) ,
   dir_abbreviation VARCHAR(50) ,
   PRIMARY KEY(dir_code)
);

CREATE TABLE tache_suppl(
   tsup_code SERIAL,
   tsup_tache VARCHAR(50) ,
   PRIMARY KEY(tsup_code)
);



CREATE TABLE rang_hierarchique(
   rhq_code SERIAL,
   rhq_rang VARCHAR(50) ,
   rhq_niveau VARCHAR(50) ,
   PRIMARY KEY(rhq_code)
);




CREATE TABLE stagiaire(
   stgr_code SERIAL,
   stgr_nom VARCHAR(50) ,
   stgr_prenom VARCHAR(50) ,
   stgr_nom_prenom VARCHAR(50) ,
   stgr_contact VARCHAR(50) ,
   stgr_filiere VARCHAR(50) ,
   stgr_niveau VARCHAR(50) ,
   PRIMARY KEY(stgr_code),
   UNIQUE(stgr_contact)
);

CREATE TABLE etablissement(
   etab_code SERIAL,
   etab_nom VARCHAR(50) ,
   etab_adresse VARCHAR(50) ,
   PRIMARY KEY(etab_code)
);

CREATE TABLE type_document(
   tdoc_code SERIAL,
   tdoc_nom VARCHAR(50) ,
   tdoc_matricule VARCHAR(50)  NOT NULL,
   PRIMARY KEY(tdoc_code),
   UNIQUE(tdoc_matricule)
);

CREATE TABLE competence(
   comp_code SERIAL,
   comp_intitule VARCHAR(50) ,
   comp_domaine VARCHAR(50) ,
   comp_description VARCHAR(50) ,
   PRIMARY KEY(comp_code)
);

CREATE TABLE assiduite(
   asdt_code SERIAL,
   asdt_remarque VARCHAR(50) ,
   asdt_nb_abscence INTEGER,
   asdt_nb_retard INTEGER,
   PRIMARY KEY(asdt_code)
);

CREATE TABLE motif_affectation(
   m_aff_code SERIAL,
   m_aff_motif VARCHAR(50) ,
   m_aff_type VARCHAR(50) ,
   PRIMARY KEY(m_aff_code)
);

CREATE TABLE type_entree(
   e_type_code VARCHAR(50) ,
   e_type_motif VARCHAR(50) ,
   PRIMARY KEY(e_type_code)
);

CREATE TABLE sortie_type(
   s_type_code VARCHAR(50) ,
   s_type_motif VARCHAR(50) ,
   PRIMARY KEY(s_type_code)
);

CREATE TABLE position_(
   pos_code SERIAL,
   pos_type VARCHAR(50) ,
   PRIMARY KEY(pos_code)
);

CREATE TABLE employe(
   emp_code SERIAL,
   emp_matricule VARCHAR(50) ,
   emp_nom VARCHAR(50) ,
   emp_prenom VARCHAR(50) ,
   emp_titre VARCHAR(50) ,
   emp_sexe BOOLEAN,
   emp_datenaissance DATE,
   emp_im_armp VARCHAR(50) ,
   emp_im_etat VARCHAR(50) ,
   date_entree DATE,
   date_sortie DATE,
   s_type_code VARCHAR(50) ,
   e_type_code VARCHAR(50)  NOT NULL,
   PRIMARY KEY(emp_code),
   UNIQUE(emp_im_armp),
   UNIQUE(emp_im_etat),
   FOREIGN KEY(s_type_code) REFERENCES sortie_type(s_type_code),
   FOREIGN KEY(e_type_code) REFERENCES type_entree(e_type_code)
);

CREATE TABLE poste(
   pst_code SERIAL,
   pst_fonction VARCHAR(50) ,
   pst_mission VARCHAR(50) ,
   tsup_code INTEGER,
   tsup_code INTEGER,
   rhq_code INTEGER NOT NULL,
   srvc_code INTEGER,
   dir_code INTEGER,
   PRIMARY KEY(pst_code),
   FOREIGN KEY(tsup_code) REFERENCES tache_suppl(tsup_code),
   FOREIGN KEY(rhq_code) REFERENCES rang_hierarchique(rhq_code),
   FOREIGN KEY(srvc_code) REFERENCES service(srvc_code),
   FOREIGN KEY(dir_code) REFERENCES direction(dir_code)
);

CREATE TABLE contact(
   Id_contact SERIAL,
   numero VARCHAR(50) ,
   emp_code INTEGER NOT NULL,
   PRIMARY KEY(Id_contact),
   UNIQUE(numero),
   FOREIGN KEY(emp_code) REFERENCES employe(emp_code)
);

CREATE TABLE eval_stage(
   evstg_code SERIAL,
   evstg_lieu VARCHAR(50) ,
   evstg_note INTEGER,
   evstg_aptitude VARCHAR(50) ,
   evstg_date_eval VARCHAR(50) ,
   asdt_code INTEGER NOT NULL,
   PRIMARY KEY(evstg_code),
   FOREIGN KEY(asdt_code) REFERENCES assiduite(asdt_code)
);

CREATE TABLE affectation(
   affec_code SERIAL,
   affec_date_debut DATE,
   affec_date_fin DATE,
   affec_commentaire VARCHAR(50) ,
   affec_type_contrat VARCHAR(50) ,
   m_aff_code INTEGER NOT NULL,
   emp_code INTEGER NOT NULL,
   pst_code INTEGER NOT NULL,
   PRIMARY KEY(affec_code),
   FOREIGN KEY(m_aff_code) REFERENCES motif_affectation(m_aff_code),
   FOREIGN KEY(emp_code) REFERENCES employe(emp_code),
   FOREIGN KEY(pst_code) REFERENCES poste(pst_code)
);

CREATE TABLE stage(
   stg_code SERIAL,
   stg_duree INTEGER,
   stg_date_debut DATE,
   stg_date_fin DATE,
   stg_theme VARCHAR(50) ,
   evstg_code INTEGER NULL,
   stgr_code INTEGER NOT NULL,
   etab_code INTEGER NOT NULL,
   PRIMARY KEY(stg_code),
   FOREIGN KEY(evstg_code) REFERENCES eval_stage(evstg_code),
   FOREIGN KEY(stgr_code) REFERENCES stagiaire(stgr_code),
   FOREIGN KEY(etab_code) REFERENCES etablissement(etab_code)
);

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

CREATE TABLE doc_emp(
   tdoc_code INTEGER,
   affec_code INTEGER,
   doc_emp_statut VARCHAR(50),
   doc_emp_code SERIAL NOT NULL,
   doc_emp_date DATE,
   PRIMARY KEY(tdoc_code, affec_code),
   UNIQUE(doc_emp_code),
   FOREIGN KEY(tdoc_code) REFERENCES type_document(tdoc_code),
   FOREIGN KEY(affec_code) REFERENCES affectation(affec_code)
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

CREATE TABLE statut_emp(
   emp_code INTEGER,
   stt_armp_code INTEGER,
   date_ DATE,
   PRIMARY KEY(emp_code, stt_armp_code),
   FOREIGN KEY(emp_code) REFERENCES employe(emp_code),
   FOREIGN KEY(stt_armp_code) REFERENCES statut_armp(stt_armp_code)
);

CREATE TABLE pos_emp(
   emp_code INTEGER,
   pos_code INTEGER,
   date_ DATE,
   PRIMARY KEY(emp_code, pos_code),
   FOREIGN KEY(emp_code) REFERENCES employe(emp_code),
   FOREIGN KEY(pos_code) REFERENCES position_(pos_code)
);
insert into position_(pos_type) values ('sortie');
ALTER TABLE employe ADD COLUMN emp_mail VARCHAR(100);

ALTER TABLE employe ADD COLUMN emp_cin VARCHAR(100);
alter table type_document drop column tdoc_matricule;
alter table doc_emp add column tdoc_matricule VARCHAR(50) UNIQUE not null;
alter table doc_emp add column doc_emp_statut varchar(50);

create table occupation_poste(
   occpst_code INTEGER primary key,
   pst_code INTEGER,
   quota INTEGER ,
   nb_occupe INTEGER,
   nb_vacant INTEGER,
   nb_encessation INTEGER,
   FOREIGN KEY(pst_code) REFERENCES poste(pst_code)
);
ALTER TABLE sortie_type ADD COLUMN IF NOT EXISTS commentaire VARCHAR(255);
-- Script pour corriger et initialiser la table occupation_poste
-- Exécuter ce script pour résoudre le problème d'auto-incrémentation

-- 1. Supprimer la table si elle existe (ATTENTION: cela supprimera les données existantes)
DROP TABLE IF EXISTS occupation_poste CASCADE;

-- 2. Recréer la table avec SERIAL pour l'auto-incrémentation
CREATE TABLE occupation_poste(
   occpst_code SERIAL PRIMARY KEY,
   pst_code INTEGER,
   quota INTEGER,
   nb_occupe INTEGER,
   nb_vacant INTEGER,
   nb_encessation INTEGER,
   FOREIGN KEY(pst_code) REFERENCES poste(pst_code)
);

-- 3. Ajouter une contrainte UNIQUE sur pst_code pour garantir un seul enregistrement par poste
ALTER TABLE occupation_poste 
ADD CONSTRAINT occupation_poste_pst_code_unique UNIQUE (pst_code);

-- 4. Initialiser les données pour tous les postes existants
-- Avec 1 occupé, 0 vacant, 0 en cessation par défaut
INSERT INTO occupation_poste (pst_code, quota, nb_occupe, nb_vacant, nb_encessation)
SELECT 
    p.pst_code,
    1 as quota,  -- Quota par défaut
    1 as nb_occupe,  -- 1 occupé par défaut
    0 as nb_vacant,  -- 0 vacant
    0 as nb_encessation  -- 0 en cessation
FROM poste p
WHERE NOT EXISTS (
    SELECT 1 FROM occupation_poste op WHERE op.pst_code = p.pst_code
);

-- 5. Mettre à jour nb_occupe avec le nombre réel d'affectations actives
UPDATE occupation_poste op
SET nb_occupe = COALESCE((
    SELECT COUNT(*)
    FROM affectation a
    WHERE a.pst_code = op.pst_code
      AND a.affec_date_fin IS NULL
), 0);

-- 6. Mettre à jour nb_vacant en fonction du quota et du nombre réel d'occupés
UPDATE occupation_poste
SET nb_vacant = GREATEST(0, quota - nb_occupe - nb_encessation);

-- 7. Vérification : Afficher les résultats
SELECT 
    p.pst_code,
    p.pst_fonction,
    op.quota,
    op.nb_occupe,
    op.nb_vacant,
    op.nb_encessation,
    (SELECT COUNT(*) FROM affectation a WHERE a.pst_code = p.pst_code AND a.affec_date_fin IS NULL) as nb_actives_reelles
FROM poste p
LEFT JOIN occupation_poste op ON op.pst_code = p.pst_code
ORDER BY p.pst_code;

-- Script pour créer la table sortie et mettre à jour la structure

-- 1. Supprimer la colonne commentaire de sortie_type si elle existe
ALTER TABLE sortie_type DROP COLUMN IF EXISTS commentaire;

-- 2. Créer la table sortie
CREATE TABLE IF NOT EXISTS sortie(
   emp_code INTEGER NOT NULL,
   s_type_code VARCHAR(50) NOT NULL,
   commentaire VARCHAR(255),
   date_sortie DATE NOT NULL,
   PRIMARY KEY(emp_code, s_type_code, date_sortie),
   FOREIGN KEY(emp_code) REFERENCES employe(emp_code),
   FOREIGN KEY(s_type_code) REFERENCES sortie_type(s_type_code)
);

-- 3. Insérer les types de sortie (retraite, renvoi, abrogation)
INSERT INTO sortie_type (s_type_code, s_type_motif) 
VALUES 
    ('RETRAITE', 'Retraite'),
    ('RENVOI', 'Renvoi'),
    ('ABROGATION', 'Abrogation')
ON CONFLICT (s_type_code) DO NOTHING;

-- 4. Optionnel : Migrer les données existantes de employe vers sortie si nécessaire
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
create table type_contrat(
   tcontrat_code SERIAL,
   tcontrat_nom VARCHAR(50) ,
   PRIMARY KEY(tcontrat_code)
);
insert into type_contrat (tcontrat_nom) values ('Fonctionnaire');
insert into type_contrat (tcontrat_nom) values ('ELD');
insert into type_contrat (tcontrat_nom) values ('EFA');
-- PostgreSQL
-- Ajout des colonnes "usage" et "commentaire" à la table doc_emp

ALTER TABLE doc_emp
  ADD COLUMN IF NOT EXISTS usage VARCHAR(100);

ALTER TABLE doc_emp
  ADD COLUMN IF NOT EXISTS commentaire VARCHAR(255);

ALTER TABLE affectation
  ADD COLUMN IF NOT EXISTS affec_etat VARCHAR(255);
ALTER TABLE affectation
  drop COLUMN affec_type_contrat ;
ALTER TABLE affectation
  ADD COLUMN IF NOT EXISTS tcontrat_code INTEGER 
  REFERENCES type_contrat(tcontrat_code);
alter table stagiaire add column stgr_sexe boolean;
alter table stagiaire add column stgr_adresse varchar(255);
alter table doc_stage add column tdoc_matricule varchar(50) unique not null;
alter table doc_stage add column doc_stage_statut varchar(50) not null default 'en attente';
insert into type_document (tdoc_nom) values ('Attestation de stage'),('Convention de stage');
insert into statut_armp(stt_armp_statut) values ('CNM'),('Fonctionnaire/armp'),('EFA/armp'),('Nomination'),('Mis en emploi'); 

drop table fonction_direc;
alter table direction drop column srvc_code;
alter table service add column dir_code integer references direction(dir_code);
alter table poste add column srvc_code integer null references service(srvc_code);
alter table poste add column dir_code integer null references direction(dir_code);












-- ============================================
-- SCRIPT COMPLET DE RÉINITIALISATION
-- Supprime toutes les données et remet les séquences à 1
-- ============================================

-- 1. DÉSACTIVER TEMPORAIREMENT LES CONTRAINTES (optionnel, pour éviter les erreurs)
SET session_replication_role = 'replica';

-- 2. VIDER LES TABLES DANS L'ORDRE INVERSE DES DÉPENDANCES
DELETE FROM occupation_poste;
DELETE FROM fonction_direc;
DELETE FROM poste;
DELETE FROM direction;
DELETE FROM service;
DELETE FROM tache_suppl;
DELETE FROM indice_recrutement;
DELETE FROM categ_poste_recrutement;
DELETE FROM rang_hierarchique;
DELETE FROM niveau_hierarchique;

-- 3. RÉINITIALISER TOUTES LES SÉQUENCES À 1
ALTER SEQUENCE IF EXISTS service_srvc_code_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS direction_dir_code_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS poste_pst_code_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS niveau_hierarchique_nivhq_code_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS rang_hierarchique_rhq_code_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS categ_poste_recrutement_ctgr_code_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS indice_recrutement_idrec_code_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS tache_suppl_tsup_code_seq RESTART WITH 1;
ALTER SEQUENCE IF EXISTS occupation_poste_occpst_code_seq RESTART WITH 1;

-- 4. RÉACTIVER LES CONTRAINTES
SET session_replication_role = 'origin';

-- 5. VÉRIFICATION (optionnel)
SELECT 
    sequencename,
    last_value
FROM pg_sequences 
WHERE schemaname = 'public'
ORDER BY sequencename;



















-- ============================================
-- SCRIPT COMPLET D'INSERTION DES DONNÉES
-- ============================================

-- -----------------------------------------------------
-- 1. NIVEAU HIERARCHIQUE
-- -----------------------------------------------------

-- -----------------------------------------------------
-- 2. RANG HIERARCHIQUE
-- -----------------------------------------------------
INSERT INTO rang_hierarchique (rhq_rang,rhq_niveau) VALUES
('HEE','Niveau1'),
('Chef de Service','Niveau2'),
('Cadre','Niveau3'),
('Agent exécutant','Niveau4');

-- -----------------------------------------------------
-- 1. INSERT dans direction (à partir de la colonne Direction)
INSERT INTO direction (dir_nom) VALUES
('Direction Générale'),
('Comité de Recours et de Réglementation'),
('Comité de Règlement des Différends'),
('Direction de l''Audit Interne'),
('Direction des Affaires Administratives et Financières'),
('Direction de la Formation et de la Documentation'),
('Direction du Système d''Information');

-- Note : Conservez les dir_code générés pour les références suivantes

-- 2. INSERT dans service (à partir de la colonne Service)
-- Note : Certaines lignes ont un service vide, donc on n'insère que les services nommés
INSERT INTO service (srvc_nom, dir_code) VALUES
('Agence Comptable', (SELECT dir_code FROM direction WHERE dir_nom = 'Direction Générale')),
('Service Ressource Humaines', (SELECT dir_code FROM direction WHERE dir_nom = 'Direction des Affaires Administratives et Financières')),
('Service de Suivi Evaluation', (SELECT dir_code FROM direction WHERE dir_nom = 'Direction de l''Audit Interne')),
('Service Administratif et Financier', (SELECT dir_code FROM direction WHERE dir_nom = 'Direction des Affaires Administratives et Financières')),
('Service Coordination et Régulation', (SELECT dir_code FROM direction WHERE dir_nom = 'Direction de l''Audit Interne')),
('Service de la Documentation', (SELECT dir_code FROM direction WHERE dir_nom = 'Direction de la Formation et de la Documentation')),
('Service de la Formation', (SELECT dir_code FROM direction WHERE dir_nom = 'Direction de la Formation et de la Documentation')),
('Service de Coordination Général des Activités', (SELECT dir_code FROM direction WHERE dir_nom = 'Direction Générale')),
('Service d''Administration Système et Réseau', (SELECT dir_code FROM direction WHERE dir_nom = 'Direction du Système d''Information')),
('Service Section Recours', (SELECT dir_code FROM direction WHERE dir_nom = 'Comité de Recours et de Réglementation'));

-- 3. INSERT dans poste (toutes les lignes)
-- Note : Détermination approximative du rang hiérarchique (rhq_code) basée sur l'intitulé
-- 1=HEE, 2=Chef de Service, 3=Cadre, 4=Agent exécutant
INSERT INTO poste (pst_fonction, srvc_code, dir_code, rhq_code) VALUES
('Directeur Général', NULL, (SELECT dir_code FROM direction WHERE dir_nom = 'Direction Générale'), 1),
('Président du Comité de Recours et de Réglementation', NULL, (SELECT dir_code FROM direction WHERE dir_nom = 'Comité de Recours et de Réglementation'), 1),
('Présidente du Comité de Règlement des Différends', NULL, (SELECT dir_code FROM direction WHERE dir_nom = 'Comité de Règlement des Différends'), 1),
('Directeur de l''Audit Interne', NULL, (SELECT dir_code FROM direction WHERE dir_nom = 'Direction de l''Audit Interne'), 1),
('Directeur des Affaires Administratives et Financières', NULL, (SELECT dir_code FROM direction WHERE dir_nom = 'Direction des Affaires Administratives et Financières'), 1),
('Directeur de la Formation et de la documentation', NULL, (SELECT dir_code FROM direction WHERE dir_nom = 'Direction de la Formation et de la Documentation'), 1),
('Directeur du Système d''Information', NULL, (SELECT dir_code FROM direction WHERE dir_nom = 'Direction du Système d''Information'), 1),
('Agent Comptable', (SELECT srvc_code FROM service WHERE srvc_nom = 'Agence Comptable'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction Générale'), 2),
('Responsable des Ressources Humaines', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Ressource Humaines'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction des Affaires Administratives et Financières'), 2),
('Chef de service Suivi Evaluation', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service de Suivi Evaluation'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction de l''Audit Interne'), 2),
('Responsable Administratif et Financier', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Administratif et Financier'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction des Affaires Administratives et Financières'), 2),
('Chef de service Coordination et Régulation', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Coordination et Régulation'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction de l''Audit Interne'), 2),
('Chef de Service de la Documentation', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service de la Documentation'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction de la Formation et de la Documentation'), 2),
('Chef de Service de la FORMATION', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service de la Formation'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction de la Formation et de la Documentation'), 2),
('Coordonnateur Général des Activités', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service de Coordination Général des Activités'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction Générale'), 2),
('Chef de Service Administration Système et Réseau', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service d''Administration Système et Réseau'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction du Système d''Information'), 2),
('Agent Administratif', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Administratif et Financier'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction des Affaires Administratives et Financières'), 4),
('Personnel d''Appui Ressources Humaines', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Ressource Humaines'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction des Affaires Administratives et Financières'), 4),
('Personnel d''Appui Système Réseau', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service d''Administration Système et Réseau'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction du Système d''Information'), 4),
('Personnel d''Appui Web', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service d''Administration Système et Réseau'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction du Système d''Information'), 4),
('Personnel d''Appui de l''Agence Comptable', (SELECT srvc_code FROM service WHERE srvc_nom = 'Agence Comptable'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction Générale'), 4),
('Personnel d''Appui de la Documentation', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service de la Documentation'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction de la Formation et de la Documentation'), 4),
('Personnel d''Appui de la Formation', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service de la Formation'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction de la Formation et de la Documentation'), 4),
('Personnel d''Appui Administratif et Financier', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Administratif et Financier'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction des Affaires Administratives et Financières'), 4),
('Webmaster', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service d''Administration Système et Réseau'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction du Système d''Information'), 4),
('Secrétaire Particulière de la Direction Générale', NULL, (SELECT dir_code FROM direction WHERE dir_nom = 'Direction Générale'), 4),
('Personnel d''Appui Communication', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service de Coordination Général des Activités'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction Générale'), 4),
('Dépositaire Comptable', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Administratif et Financier'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction des Affaires Administratives et Financières'), 4),
('Standardiste / Réceptionniste', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Administratif et Financier'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction des Affaires Administratives et Financières'), 4),
('Aide Comptable', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Administratif et Financier'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction des Affaires Administratives et Financières'), 4),
('Agent Administratif', (SELECT srvc_code FROM service WHERE srvc_nom = 'Agence Comptable'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction Générale'), 4),
('Chauffeur', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Administratif et Financier'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction des Affaires Administratives et Financières'), 4),
('Coursier / Vaguemestre', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Administratif et Financier'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction des Affaires Administratives et Financières'), 4),
('Technicien de Surface', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Administratif et Financier'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction des Affaires Administratives et Financières'), 4),
('Agent de sécurité', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Administratif et Financier'), (SELECT dir_code FROM direction WHERE dir_nom = 'Direction des Affaires Administratives et Financières'), 4),
('Juriste', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Section Recours'), (SELECT dir_code FROM direction WHERE dir_nom = 'Comité de Recours et de Réglementation'), 3),
('Economiste', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Section Recours'), (SELECT dir_code FROM direction WHERE dir_nom = 'Comité de Recours et de Réglementation'), 3),
('Traducteur/Rédacteur', (SELECT srvc_code FROM service WHERE srvc_nom = 'Service Section Recours'), (SELECT dir_code FROM direction WHERE dir_nom = 'Comité de Recours et de Réglementation'), 3);

-- 4. INSERT dans occupation_poste (quota = nb_vacant, autres = 0)
-- Note : Les valeurs de quota sont dans la colonne C
INSERT INTO occupation_poste (pst_code, quota, nb_vacant, nb_occupe, nb_encessation)
SELECT 
    p.pst_code,
    CASE 
        WHEN p.pst_fonction = 'Agent Administratif' AND s.srvc_nom = 'Service Administratif et Financier' THEN 2
        WHEN p.pst_fonction = 'Personnel d''Appui Administratif et Financier' THEN 2
        WHEN p.pst_fonction = 'Agent Administratif' AND s.srvc_nom = 'Agence Comptable' THEN 2
        WHEN p.pst_fonction = 'Personnel d''Appui Ressources Humaines' THEN 2
        WHEN p.pst_fonction = 'Chauffeur' THEN 15
        WHEN p.pst_fonction = 'Coursier / Vaguemestre' THEN 2
        WHEN p.pst_fonction = 'Technicien de Surface' THEN 3
        WHEN p.pst_fonction = 'Agent de sécurité' THEN 6
        WHEN p.pst_fonction = 'Economiste' THEN 2
        ELSE 1
    END as quota,
    CASE 
        WHEN p.pst_fonction = 'Agent Administratif' AND s.srvc_nom = 'Service Administratif et Financier' THEN 2
        WHEN p.pst_fonction = 'Personnel d''Appui Administratif et Financier' THEN 2
        WHEN p.pst_fonction = 'Agent Administratif' AND s.srvc_nom = 'Agence Comptable' THEN 2
        WHEN p.pst_fonction = 'Personnel d''Appui Ressources Humaines' THEN 2
        WHEN p.pst_fonction = 'Chauffeur' THEN 15
        WHEN p.pst_fonction = 'Coursier / Vaguemestre' THEN 2
        WHEN p.pst_fonction = 'Technicien de Surface' THEN 3
        WHEN p.pst_fonction = 'Agent de sécurité' THEN 6
        WHEN p.pst_fonction = 'Economiste' THEN 2
        ELSE 1
    END as nb_vacant,
    0 as nb_occupe,
    0 as nb_encessation
FROM poste p
LEFT JOIN service s ON p.srvc_code = s.srvc_code
ORDER BY p.pst_code;