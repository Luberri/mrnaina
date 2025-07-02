package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.VueNombreExemplairesDisponibles;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface VueNombreExemplairesDisponiblesRepository extends JpaRepository<VueNombreExemplairesDisponibles, Long> {
    Optional<VueNombreExemplairesDisponibles> findByLivreId(Long livreId);
}