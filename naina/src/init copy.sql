-- Connexion
\c postgres;
DROP DATABASE  bibliotheque_naina1;
CREATE DATABASE bibliotheque_naina1;
\c bibliotheque_naina1;

-- Table des rôles
CREATE TABLE role (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE
);

-- Adhérents
CREATE TABLE adherent (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    role_id INT NOT NULL REFERENCES role(id) ON DELETE CASCADE,
    date_naissance DATE NOT NULL
);

-- Catégories
CREATE TABLE categorie (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL UNIQUE
);

-- Livres
CREATE TABLE livre (
    id SERIAL PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    auteur VARCHAR(100),
    editeur VARCHAR(100),
    annee_publication INT
);

-- Association Livre <-> Catégorie (Many-to-Many)
CREATE TABLE livre_categorie (
    livre_id INT NOT NULL,
    categorie_id INT NOT NULL,
    PRIMARY KEY (livre_id, categorie_id),
    FOREIGN KEY (livre_id) REFERENCES livre(id) ON DELETE CASCADE,
    FOREIGN KEY (categorie_id) REFERENCES categorie(id) ON DELETE CASCADE
);

-- Exemplaires
CREATE TABLE exemplaire (
    id SERIAL PRIMARY KEY,
    livre_id INT NOT NULL REFERENCES livre(id) ON DELETE CASCADE,
    nombre_dispo INT DEFAULT 0 CHECK (nombre_dispo >= 0)
);
ALTER TABLE exemplaire ADD COLUMN etat VARCHAR(50);
-- Modes de prêt
CREATE TABLE mode (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO mode (nom) VALUES ('a domicile'), ('sur place');

CREATE TABLE prolongement_role (
    id SERIAL PRIMARY KEY,
    role_id INT NOT NULL REFERENCES role(id) ON DELETE CASCADE,
    nombre_jour INT NOT NULL CHECK (nombre_jour > 0)
);

-- Prêts
CREATE TABLE pret (
    id SERIAL PRIMARY KEY,
    exemplaire_id INT NOT NULL REFERENCES exemplaire(id) ON DELETE CASCADE,
    adherent_id INT NOT NULL REFERENCES adherent(id) ON DELETE CASCADE,
    mode_id INT NOT NULL REFERENCES mode(id) ON DELETE SET NULL,
    date_pret DATE NOT NULL,
    date_retour DATE NOT NULL,
    date_retour_reel DATE,
    prolongement_jour INT DEFAULT 0 CHECK (prolongement_jour >= 0),
    rendu BOOLEAN DEFAULT FALSE
);
CREATE TABLE prolongement_demande (
    id SERIAL PRIMARY KEY,
    pret_id INT NOT NULL REFERENCES pret(id) ON DELETE CASCADE,
    nombre_jour INT NOT NULL CHECK (nombre_jour > 0)
);

-- Durée max de prêt par rôle
CREATE TABLE pret_jour (
    id SERIAL PRIMARY KEY,
    role_id INT NOT NULL REFERENCES role(id) ON DELETE CASCADE,
    nombre_jour INT NOT NULL CHECK (nombre_jour > 0)
);
CREATE TABLE jour_ferier (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL UNIQUE,
    description VARCHAR(255)
);
-- Abonnement des adhérents
CREATE TABLE abonnement (
    id SERIAL PRIMARY KEY,
    adherent_id INT NOT NULL REFERENCES adherent(id) ON DELETE CASCADE,
    date DATE DEFAULT CURRENT_DATE
);

-- Tarification abonnement par rôle
CREATE TABLE abonnement_tarif (
    id SERIAL PRIMARY KEY,
    role_id INT NOT NULL REFERENCES role(id) ON DELETE CASCADE,
    prix DECIMAL(10,2) NOT NULL CHECK (prix >= 0)
);

-- Réservation
CREATE TABLE reservation (
    id SERIAL PRIMARY KEY,
    adherent_id INT NOT NULL REFERENCES adherent(id) ON DELETE CASCADE,
    livre_id INT NOT NULL REFERENCES livre(id) ON DELETE CASCADE,
    date_reservation DATE DEFAULT CURRENT_DATE
);

-- Limites de réservation par rôle
CREATE TABLE reservation_role (
    id SERIAL PRIMARY KEY,
    role_id INT NOT NULL REFERENCES role(id) ON DELETE CASCADE,
    nombre_livre_max INT NOT NULL CHECK (nombre_livre_max >= 0)
);
CREATE TABLE penalite (
    id SERIAL PRIMARY KEY,
    adherent_id INT NOT NULL REFERENCES adherent(id) ON DELETE CASCADE,
    pret_id INT NOT NULL REFERENCES pret(id) ON DELETE CASCADE,
    duree INT NOT NULL CHECK (duree >= 0)
);
-- Limites de prêt par rôle
CREATE TABLE pret_role (
    id SERIAL PRIMARY KEY,
    role_id INT NOT NULL REFERENCES role(id) ON DELETE CASCADE,
    nombre_livre_max INT NOT NULL CHECK (nombre_livre_max >= 0)
);

-- Suivi des états de réservation
CREATE TABLE reservation_status(
    id SERIAL PRIMARY KEY,
    reservation_id INT NOT NULL REFERENCES reservation(id) ON DELETE CASCADE,
    etat VARCHAR(30) NOT NULL CHECK (etat IN ('en attente', 'confirmee', 'annulee')),
    date DATE DEFAULT CURRENT_DATE
);


-- Vue sur les exemplaires disponibles
CREATE OR REPLACE VIEW nombre_exemplaires_disponibles AS
SELECT
    l.id AS livre_id,
    l.titre,
    COALESCE(SUM(e.nombre_dispo), 0) AS nombre_exemplaires_disponibles
FROM
    livre l
LEFT JOIN
    exemplaire e ON l.id = e.livre_id
GROUP BY
    l.id, l.titre;
