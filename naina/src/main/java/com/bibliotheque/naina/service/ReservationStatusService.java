package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.ReservationStatus;
import com.bibliotheque.naina.repository.ReservationStatusRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ReservationStatusService {

    @Autowired
    private ReservationStatusRepository reservationStatusRepository;

    public List<ReservationStatus> findAll() {
        return reservationStatusRepository.findAll();
    }

    public Optional<ReservationStatus> findById(Long id) {
        return reservationStatusRepository.findById(id);
    }

    public ReservationStatus save(ReservationStatus status) {
        return reservationStatusRepository.save(status);
    }

    public void deleteById(Long id) {
        reservationStatusRepository.deleteById(id);
    }
}