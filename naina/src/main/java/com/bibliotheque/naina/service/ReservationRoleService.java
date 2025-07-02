package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.ReservationRole;
import com.bibliotheque.naina.repository.ReservationRoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ReservationRoleService {

    @Autowired
    private ReservationRoleRepository reservationRoleRepository;

    public List<ReservationRole> findAll() {
        return reservationRoleRepository.findAll();
    }

    public Optional<ReservationRole> findById(Long id) {
        return reservationRoleRepository.findById(id);
    }

    public ReservationRole save(ReservationRole reservationRole) {
        return reservationRoleRepository.save(reservationRole);
    }

    public void deleteById(Long id) {
        reservationRoleRepository.deleteById(id);
    }
}