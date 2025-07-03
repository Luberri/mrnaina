package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.ReservationStatus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservationStatusRepository extends JpaRepository<ReservationStatus, Long> {
}