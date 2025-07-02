package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.Livre;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LivreRepository extends JpaRepository<Livre, Long> {
}