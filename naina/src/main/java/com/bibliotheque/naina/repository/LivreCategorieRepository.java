package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.LivreCategorie;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LivreCategorieRepository extends JpaRepository<LivreCategorie, LivreCategorie.LivreCategorieId> {
}