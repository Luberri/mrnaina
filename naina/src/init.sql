\c postgres;
DROP DATABASE IF EXISTS bibliotheque_naina;
CREATE DATABASE bibliotheque_naina;
\c bibliotheque_naina;

-- Table des rôles
CREATE TABLE role (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE
);

-- Adhérents
CREATE TABLE adherent (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    role_id INT NOT NULL REFERENCES role(id),
    date_naissance DATE NOT NULL
);

-- Catégories
CREATE TABLE categorie (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL UNIQUE
);

-- Livres (logique) - Suppression de categorie_id
CREATE TABLE livre (
    id SERIAL PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    auteur VARCHAR(100),
    editeur VARCHAR(100),
    annee_publication INT
);

-- Table d'association Many-to-Many entre Livre et Categorie
CREATE TABLE livre_categorie (
    livre_id INTEGER NOT NULL,
    categorie_id INTEGER NOT NULL,
    PRIMARY KEY (livre_id, categorie_id),
    FOREIGN KEY (livre_id) REFERENCES livre(id),
    FOREIGN KEY (categorie_id) REFERENCES categorie(id)
);

-- Exemplaires disponibles (inventaire)
CREATE TABLE exemplaire (
    id SERIAL PRIMARY KEY,
    livre_id INT NOT NULL REFERENCES livre(id),
    nombre_dispo INT DEFAULT 0 CHECK (nombre_dispo >= 0)
);

-- Mode de prêt (à domicile / sur place)
CREATE TABLE mode (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO mode (nom) VALUES ('a domicile');
INSERT INTO mode (nom) VALUES ('sur place');

-- Prêt d’un exemplaire à un adhérent
CREATE TABLE pret (
    id SERIAL PRIMARY KEY,
    exemplaire_id INT NOT NULL REFERENCES exemplaire(id),
    adherent_id INT NOT NULL REFERENCES adherent(id),
    mode_id INT NOT NULL REFERENCES mode(id),
    date_retour DATE NOT NULL,
    date_retour_reel DATE,
    rendu BOOLEAN DEFAULT FALSE
);

-- Durée max de prêt selon rôle
CREATE TABLE pret_jour (
    id SERIAL PRIMARY KEY,
    role_id INT NOT NULL REFERENCES role(id),
    nombre_jour INT NOT NULL CHECK (nombre_jour > 0)
);

-- Abonnement annuel des adhérents
CREATE TABLE abonnement (
    id SERIAL PRIMARY KEY,
    adherent_id INT NOT NULL REFERENCES adherent(id),
    date DATE DEFAULT CURRENT_DATE
);

-- Tarif d'abonnement par rôle
CREATE TABLE abonnement_tarif (
    id SERIAL PRIMARY KEY,
    role_id INT NOT NULL REFERENCES role(id),
    prix DECIMAL(10,2) NOT NULL CHECK (prix >= 0)
);

-- Réservation d’un livre par un adhérent
CREATE TABLE reservation (
    id SERIAL PRIMARY KEY,
    adherent_id INT NOT NULL REFERENCES adherent(id),
    livre_id INT NOT NULL REFERENCES livre(id),
    date_reservation DATE DEFAULT CURRENT_DATE
);

-- Limite de réservations autorisées selon le rôle
CREATE TABLE reservation_role (
    id SERIAL PRIMARY KEY,
    role_id INT NOT NULL REFERENCES role(id),
    nombre_livre_max INT NOT NULL CHECK (nombre_livre_max >= 0)
);
CREATE TABLE pret_role (
    id SERIAL PRIMARY KEY,
    role_id INT NOT NULL REFERENCES role(id),
    nombre_livre_max INT NOT NULL CHECK (nombre_livre_max >= 0)
);

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