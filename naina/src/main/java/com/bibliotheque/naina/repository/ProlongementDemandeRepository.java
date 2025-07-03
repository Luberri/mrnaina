package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.ProlongementDemande;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProlongementDemandeRepository extends JpaRepository<ProlongementDemande, Long> {
    List<ProlongementDemande> findByPretId(Long pretId);
}