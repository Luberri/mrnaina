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
