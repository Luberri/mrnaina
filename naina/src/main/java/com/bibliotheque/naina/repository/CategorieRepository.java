package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.Categorie;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategorieRepository extends JpaRepository<Categorie, Long> {
}