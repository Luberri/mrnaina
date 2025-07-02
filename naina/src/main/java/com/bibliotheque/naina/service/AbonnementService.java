package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.Abonnement;
import com.bibliotheque.naina.repository.AbonnementRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
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

    // Nouvelle méthode pour vérifier l'abonnement du mois courant
    public boolean estAbonneCeMois(Long adherentId) {
        LocalDate now = LocalDate.now();
        return abonnementRepository.findAll().stream()
            .anyMatch(a -> a.getAdherent().getId().equals(adherentId)
                && a.getDate().getYear() == now.getYear()
                && a.getDate().getMonthValue() == now.getMonthValue());
    }
}