INSERT INTO statut_poste (stpst_code, stpst_statut) VALUES
(1, 'Occupé'),
(2, 'Vacant'),
(3, 'Gelé'),
(4, 'Supprimé');
INSERT INTO rang_hierarchique (rhq_code, rhq_rang) VALUES
(1, 'Rang 1'),
(2, 'Rang 2'),
(3, 'Rang 3'),
(4, 'Rang 4');
INSERT INTO niveau_hierarchique (nivhq_code, nivhq_niveau) VALUES
(1, 'Cadre'),
(2, 'Cadre supérieur'),
(3, 'Chef de service'),
(4, 'Directeur');
INSERT INTO tache_suppl (tsup_code, tsup_tache) VALUES
(1, 'Supervision des équipes'),
(2, 'Gestion de projets'),
(3, 'Rédaction de rapports'),
(4, 'Audit interne');

INSERT INTO service (srvc_code, srvc_nom) VALUES
(1, 'Direction Générale'),
(2, 'Administration et Finances'),
(3, 'Ressources Humaines'),
(4, 'Systèmes d Information'),
(5, 'Passation des Marchés');

INSERT INTO direction (dir_code, dir_nom, dir_abbreviation, srvc_code) VALUES
(1, 'Direction Générale', 'DG', 1),
(2, 'Direction Administrative et Financière', 'DAF', 2),
(3, 'Direction des Ressources Humaines', 'DRH', 3),
(4, 'Direction des Systèmes d Information', 'DSI', 4),
(5, 'Direction de la Passation des Appels d Offres', 'DPA', 5);

INSERT INTO categ_poste_recrutement (ctgr_code, ctgr_statut) VALUES
(1, 'Fonctionnaire'),
(2, 'Contractuel'),
(3, 'Prestataire');
INSERT INTO indice_recrutement (idrec_code, idrec_nom) VALUES
(1, 'IR-1'),
(2, 'IR-2'),
(3, 'IR-3'),
(4, 'IR-4');

INSERT INTO poste 
(pst_code, pst_fonction, pst_mission, tsup_code, nivhq_code, rhq_code, ctgr_code, idrec_code, stpst_code, srvc_code)
VALUES
(1, 'Directeur Général', 'Superviser l ensemble des directions.', NULL, 1, 1, 1, 1, 1, 1),
(2, 'Directeur Administratif et Financier', 'Gérer les finances et l administration.', NULL, 1, 1, 1, 1, 1, 2),
(3, 'Directeur des Ressources Humaines', 'Superviser la gestion RH.', NULL, 1, 1, 1, 1, 1, 3),
(4, 'Directeur des Systèmes d Information', 'Piloter les systèmes d information.', NULL, 1, 1, 1, 1, 1, 4),
(5, 'Directeur Passation des Appels d Offres', 'Superviser la passation des marchés.', NULL, 1, 1, 1, 1, 1, 5),

(6, 'Chef de Service RH', 'Gérer les services RH.', NULL, 2, 2, 1, 2, 1, 3),
(7, 'Chef de Service Informatique', 'Superviser l infrastructure SI.', NULL, 2, 2, 1, 2, 1, 4),
(8, 'Chef de Service Passation', 'Superviser les dossiers de passation.', NULL, 2, 2, 1, 2, 1, 5),

(9, 'Assistant Administratif', 'Assister les services administratifs.', NULL, 3, 3, 2, 3, 1, 2),
(10, 'Technicien Réseau', 'Gérer les réseaux et équipements.', NULL, 3, 3, 2, 3, 1, 4);

INSERT INTO fonction_direc (dir_code, pst_code) VALUES
-- Directions générales
(1,1),

-- DAF
(2,2),
(2,9),

-- DRH
(3,3),
(3,6),

-- DSI
(4,4),
(4,7),
(4,10),

-- DPA
(5,5),
(5,8);

CREATE EXTENSION IF NOT EXISTS pgcrypto;


INSERT INTO users (username, password, nom, prenom, role)
VALUES (
  'admin',
  crypt('admin123', gen_salt('bf')),-- hash pour 'admin123'
  'Super',
  'Administrateur',
  0
);


INSERT INTO type_entree (e_type_code, e_type_motif) VALUES
(1, 'Recrutement'),
(2, 'Nomination'),
(3, 'Transfert'),
(4, 'Promotion');

INSERT INTO motif_affectation (m_aff_code, m_aff_motif, m_aff_type) VALUES
(1, 'Affectation Initiale', 'Permanente'),
(2, 'Mutation', 'Permanente'),
(3, 'Promotion', 'Permanente'),
(4, 'Intérim', 'Temporaire'),
(5, 'Détachement', 'Temporaire');
(5, 'Mise à disposition');
INSERT INTO motif_affectation (m_aff_motif, m_aff_type) VALUES 
('Affectation Initiale', 'Permanente'), 
('Mutation', 'Permanente'), ...