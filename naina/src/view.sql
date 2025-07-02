CREATE OR REPLACE FUNCTION verifier_abonnement_mensuel()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM abonnement
        WHERE adherent_id = NEW.adherent_id
          AND date_trunc('month', date) = date_trunc('month', NEW.date)
    ) THEN
        RAISE EXCEPTION 'Cet adhérent a déjà payé pour ce mois.';
    END IF;

    RETURN NEW;
END;
CREATE TRIGGER trigger_verifier_abonnement
BEFORE INSERT ON abonnement
FOR EACH ROW
EXECUTE FUNCTION verifier_abonnement_mensuel();

-- Fonction pour vérifier les règles de prêt
CREATE OR REPLACE FUNCTION verifier_pret()
RETURNS TRIGGER AS $$
DECLARE
    nb_max INT;
    nb_en_cours INT;
    est_abonne BOOLEAN;
BEGIN
    -- Vérifier que l'adhérent existe
    IF NOT EXISTS (SELECT 1 FROM adherent WHERE id = NEW.adherent_id) THEN
        RAISE EXCEPTION 'Adhérent inexistant.';
    END IF;

    -- Vérifier l'abonnement mensuel (utilise la même logique que verifier_abonnement_mensuel)
    SELECT COUNT(*) > 0 INTO est_abonne
    FROM abonnement
    WHERE adherent_id = NEW.adherent_id
      AND date_trunc('month', date) = date_trunc('month', CURRENT_DATE);
    IF NOT est_abonne THEN
        RAISE EXCEPTION 'L''adhérent n''est pas abonné pour ce mois.';
    END IF;

    -- Récupérer le nombre max de livres pour ce rôle
    SELECT pr.nombre_livre_max INTO nb_max
    FROM adherent a
    JOIN pret_role pr ON pr.role_id = a.role_id
    WHERE a.id = NEW.adherent_id;
    IF nb_max IS NULL THEN
        RAISE EXCEPTION 'Aucune règle de prêt définie pour ce rôle.';
    END IF;

    -- Compter le nombre de prêts en cours (non rendus)
    SELECT COUNT(*) INTO nb_en_cours
    FROM pret
    WHERE adherent_id = NEW.adherent_id AND rendu = FALSE;

    IF nb_en_cours >= nb_max THEN
        RAISE EXCEPTION 'Nombre maximum de prêts atteint pour cet adhérent.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger sur la table pret
DROP TRIGGER IF EXISTS trigger_verifier_pret ON pret;
CREATE TRIGGER trigger_verifier_pret
BEFORE INSERT ON pret
FOR EACH ROW
EXECUTE FUNCTION verifier_pret();