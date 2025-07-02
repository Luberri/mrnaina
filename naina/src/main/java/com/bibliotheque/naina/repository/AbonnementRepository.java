package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.Abonnement;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AbonnementRepository extends JpaRepository<Abonnement, Long> {
}