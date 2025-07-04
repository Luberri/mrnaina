package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.JourFerier;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDate;
import java.util.Optional;

public interface JourFerierRepository extends JpaRepository<JourFerier, Integer> {
    Optional<JourFerier> findByDate(LocalDate date);
}
