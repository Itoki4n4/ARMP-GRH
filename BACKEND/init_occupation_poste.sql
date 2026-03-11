-- Script SQL pour initialiser les données d'occupation_poste
-- Exécuter ce script après avoir créé la table occupation_poste

-- 0. Ajouter une contrainte UNIQUE sur pst_code si elle n'existe pas
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'occupation_poste_pst_code_unique'
    ) THEN
        ALTER TABLE occupation_poste 
        ADD CONSTRAINT occupation_poste_pst_code_unique UNIQUE (pst_code);
    END IF;
END $$;

-- 1. Initialiser occupation_poste pour tous les postes existants
INSERT INTO occupation_poste (pst_code, quota, nb_occupe, nb_vacant, nb_encessation)
SELECT 
    p.pst_code,
    0 as quota,  -- À définir manuellement selon vos besoins
    COALESCE(COUNT(CASE WHEN a.affec_date_fin IS NULL THEN 1 END), 0) as nb_occupe,
    0 as nb_vacant,  -- À calculer selon quota - nb_occupe - nb_encessation
    0 as nb_encessation  -- À définir selon vos règles
FROM poste p
LEFT JOIN affectation a ON a.pst_code = p.pst_code
WHERE NOT EXISTS (
    SELECT 1 FROM occupation_poste op WHERE op.pst_code = p.pst_code
)
GROUP BY p.pst_code;

-- 2. Mettre à jour nb_occupe avec le nombre réel d'affectations actives
UPDATE occupation_poste op
SET nb_occupe = (
    SELECT COUNT(*)
    FROM affectation a
    WHERE a.pst_code = op.pst_code
      AND a.affec_date_fin IS NULL
);

-- 3. Vérification : Afficher les postes avec leurs occupations
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

