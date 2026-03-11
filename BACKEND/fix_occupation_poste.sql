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

