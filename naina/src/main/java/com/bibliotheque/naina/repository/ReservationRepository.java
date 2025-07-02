package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {
}