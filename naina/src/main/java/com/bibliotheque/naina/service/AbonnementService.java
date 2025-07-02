package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.Abonnement;
import com.bibliotheque.naina.repository.AbonnementRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AbonnementService {

    @Autowired
    private AbonnementRepository abonnementRepository;

    public List<Abonnement> findAll() {
        return abonnementRepository.findAll();
    }

    public Optional<Abonnement> findById(Long id) {
        return abonnementRepository.findById(id);
    }

    public Abonnement save(Abonnement abonnement) {
        return abonnementRepository.save(abonnement);
    }

    public void deleteById(Long id) {
        abonnementRepository.deleteById(id);
    }
}