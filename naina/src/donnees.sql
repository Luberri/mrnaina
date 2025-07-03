-- Roles
INSERT INTO role (nom) VALUES ('bibliotheque');
INSERT INTO role (nom) VALUES ('etudiant');
INSERT INTO role (nom) VALUES ('professeur');
INSERT INTO role (nom) VALUES ('professionnel');
INSERT INTO role (nom) VALUES ('anonyme');

-- Categories
INSERT INTO categorie (nom) VALUES ('Roman');
INSERT INTO categorie (nom) VALUES ('Science');
INSERT INTO categorie (nom) VALUES ('Histoire');

-- Livres
INSERT INTO livre (titre, auteur, editeur, annee_publication) 
VALUES 
    ('Le Petit Prince', 'Antoine de Saint-Exupery', 'Gallimard', 1943),
    ('Introduction à la Physique', 'Marie Curie', 'Dunod', 1923),
    ('Les Miserables', 'Victor Hugo', 'A. Lacroix', 1862);

-- Adherents (pas d'anonyme)
-- On suppose ici que les rôles ont été insérés dans le même ordre
-- bibliotheque = 1, etudiant = 2, professeur = 3, professionnel = 4
INSERT INTO adherent (nom, role_id, date_naissance) 
VALUES 
    ('Alice Dupont', 2, '2000-05-10'),
    ('Bob Martin', 3, '1980-11-22'),
    ('Claire Durand', 4, '1990-03-15'),
    ('administrator', 1, '1990-03-15');

-- Exemplaires (en se basant sur l'ordre d'insertion des livres)
INSERT INTO exemplaire (livre_id, nombre_dispo) 
VALUES 
    (1, 3),
    (1, 1),
    (2, 6),
    (3, 2);

-- LivreCategorie
INSERT INTO livre_categorie (livre_id, categorie_id) 
VALUES 
    (1, 1),
    (2, 2),
    (3, 1),
    (3, 3);

-- Abonnement tarif (prix par rôle)
INSERT INTO abonnement_tarif (role_id, prix) 
VALUES 
    (1, 0.00),   -- bibliotheque
    (2, 15.00),  -- etudiant
    (3, 25.00),  -- professeur
    (4, 30.00),  -- essionnel
    (5, 0.00);   -- anonyme
INSERT INTO pret_role (role_id, nombre_livre_max) VALUES (1, 0); -- Par exemple, rôle 1 : 3 livres max
INSERT INTO pret_role (role_id, nombre_livre_max) VALUES (2, 5); -- Par exemple, rôle 2 : 5 livres max
INSERT INTO pret_role (role_id, nombre_livre_max) VALUES (3, 8); -- Par exemple, rôle 3 : 1 livre max
INSERT INTO pret_role (role_id, nombre_livre_max) VALUES (4, 12); -- Par exemple, rôle 3 : 1 livre max
INSERT INTO pret_role (role_id, nombre_livre_max) VALUES (5, 15); -- Par exemple, rôle 3 : 1 livre max

-- Données de test pour pret_jour
INSERT INTO pret_jour (role_id, nombre_jour) VALUES (2, 10); 
INSERT INTO pret_jour (role_id, nombre_jour) VALUES (3, 15); 
INSERT INTO pret_jour (role_id, nombre_jour) VALUES (4, 22);   
INSERT INTO adherent (nom, role_id, date_naissance) VALUES (
    'Anonymous', 5, '1990-06-20'
);

INSERT INTO reservation_role (role_id, nombre_livre_max) VALUES (1, 0); -- Par exemple, rôle 1 : 3 livres max
INSERT INTO reservation_role (role_id, nombre_livre_max) VALUES (2, 2); -- Par exemple, rôle 2 : 5 livres max
INSERT INTO reservation_role (role_id, nombre_livre_max) VALUES (3, 5); -- Par exemple, rôle 3 : 5 livres max
INSERT INTO reservation_role (role_id, nombre_livre_max) VALUES (4, 8); -- Par exemple, rôle 4 : 8 livres max
INSERT INTO reservation_role (role_id, nombre_livre_max) VALUES (5, 10); -- Par exemple, rôle 5 : 10 livres max

INSERT INTO adherent (nom, role_id, date_naissance) 
VALUES 
    ('luberri', 2, '2000-05-10');
UPDATE adherent SET nom = 'Alice' WHERE id = 1;
UPDATE adherent SET nom = 'Bob' WHERE id = 2;
UPDATE adherent SET nom = 'Claire' WHERE id = 3;
UPDATE adherent SET nom = 'administrator' WHERE id = 4;

INSERT INTO prolongement_role (role_id, nombre_jour) VALUES (1, 0); -- Par exemple, rôle 1 : 0 jours max
INSERT INTO prolongement_role (role_id, nombre_jour) VALUES (2, 7);
INSERT INTO prolongement_role (role_id, nombre_jour) VALUES (3, 10);
INSERT INTO prolongement_role (role_id, nombre_jour) VALUES (4, 15);
INSERT INTO prolongement_role (role_id, nombre_jour) VALUES (5, 20);