package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.Penalite;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PenaliteRepository extends JpaRepository<Penalite, Long> {
    List<Penalite> findByAdherentId(Long adherentId);
    List<Penalite> findByPretId(Long pretId);
}