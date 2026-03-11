-- Ajouter la colonne commentaire à la table sortie_type
ALTER TABLE sortie_type ADD COLUMN IF NOT EXISTS commentaire VARCHAR(255);

