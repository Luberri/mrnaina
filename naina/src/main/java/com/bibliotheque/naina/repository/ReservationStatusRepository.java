package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.ReservationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ReservationStatusRepository extends JpaRepository<ReservationStatus, Long> {
    List<ReservationStatus> findByReservationId(Long reservationId);
}