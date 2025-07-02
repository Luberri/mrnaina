package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.Adherent;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AdherentRepository extends JpaRepository<Adherent, Long> {
    Adherent findByNom(String nom);
}