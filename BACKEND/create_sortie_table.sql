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
-- Utiliser une requête qui ignore les doublons
INSERT INTO sortie_type (s_type_code, s_type_motif) 
SELECT * FROM (VALUES 
    ('RETRAITE', 'Retraite'),
    ('RENVOI', 'Renvoi'),
    ('ABROGATION', 'Abrogation')
) AS v(s_type_code, s_type_motif)
WHERE NOT EXISTS (
    SELECT 1 FROM sortie_type st WHERE st.s_type_code = v.s_type_code
);

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

