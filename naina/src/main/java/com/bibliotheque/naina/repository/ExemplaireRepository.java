package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.Exemplaire;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ExemplaireRepository extends JpaRepository<Exemplaire, Long> {
    @Query("SELECT COALESCE(SUM(e.nombreDispo), 0) FROM Exemplaire e WHERE e.livre.id = :livreId")
    int getNombreDispoByLivreId(@Param("livreId") Long livreId);
}