package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.Pret;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PretRepository extends JpaRepository<Pret, Long> {
    long countByExemplaireIdAndRenduFalse(Long exemplaireId);
}