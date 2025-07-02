-- Roles
INSERT INTO role (id, nom) VALUES (1, 'bibliotheque');
INSERT INTO role (id, nom) VALUES (2, 'etudiant');
INSERT INTO role (id, nom) VALUES (3, 'professeur');
INSERT INTO role (id, nom) VALUES (4, 'professionnel');
INSERT INTO role (id, nom) VALUES (5, 'anonyme');

-- Categories
INSERT INTO categorie (id, nom) VALUES (1, 'Roman');
INSERT INTO categorie (id, nom) VALUES (2, 'Science');
INSERT INTO categorie (id, nom) VALUES (3, 'Histoire');

-- Livres
INSERT INTO livre (id, titre, auteur, editeur, annee_publication) VALUES (1, 'Le Petit Prince', 'Antoine de Saint-Exupéry', 'Gallimard', 1943);
INSERT INTO livre (id, titre, auteur, editeur, annee_publication) VALUES (2, 'Introduction à la Physique', 'Marie Curie', 'Dunod', 1923);
INSERT INTO livre (id, titre, auteur, editeur, annee_publication) VALUES (3, 'Les Misérables', 'Victor Hugo', 'A. Lacroix', 1862);

-- LivreCategorie (relations livre-categorie)
INSERT INTO livre_categorie (livre_id, categorie_id) VALUES (1, 1);
INSERT INTO livre_categorie (livre_id, categorie_id) VALUES (2, 2);
INSERT INTO livre_categorie (livre_id, categorie_id) VALUES (3, 1);
INSERT INTO livre_categorie (livre_id, categorie_id) VALUES (3, 3);

-- Adherents (pas d'anonyme)
INSERT INTO adherent (id, nom, role_id, date_naissance) VALUES (1, 'Alice Dupont', 2, '2000-05-10');
INSERT INTO adherent (id, nom, role_id, date_naissance) VALUES (2, 'Bob Martin', 3, '1980-11-22');
INSERT INTO adherent (id, nom, role_id, date_naissance) VALUES (3, 'Claire Durand', 4, '1990-03-15');
INSERT INTO adherent (id, nom, role_id, date_naissance) VALUES (4, 'administrator', 1, '1990-03-15');

-- Exemplaires
INSERT INTO exemplaire (id, livre_id,nombre_dispo) VALUES (1, 1, 3);
INSERT INTO exemplaire (id, livre_id,nombre_dispo) VALUES (2, 1, 1);
INSERT INTO exemplaire (id, livre_id,nombre_dispo) VALUES (3, 2, 6);
INSERT INTO exemplaire (id, livre_id,nombre_dispo) VALUES (4, 3, 2);

-- Abonnement tarif (prix par rôle)
INSERT INTO abonnement_tarif (id, role_id, prix) VALUES (1, 1, 0.00);      -- bibliotheque
INSERT INTO abonnement_tarif (id, role_id, prix) VALUES (2, 2, 15.00);     -- etudiant
INSERT INTO abonnement_tarif (id, role_id, prix) VALUES (3, 3, 25.00);     -- professeur
INSERT INTO abonnement_tarif (id, role_id, prix) VALUES (4, 4, 30.00);     -- professionnel
INSERT INTO abonnement_tarif (id, role_id, prix) VALUES (5, 5, 0.00);      -- anonyme