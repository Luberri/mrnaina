package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.Exemplaire;
import com.bibliotheque.naina.repository.ExemplaireRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ExemplaireService {

    @Autowired
    private ExemplaireRepository exemplaireRepository;
    @Autowired
    private com.bibliotheque.naina.repository.PretRepository pretRepository;

    public List<Exemplaire> findAll() {
        return exemplaireRepository.findAll();
    }

    public Optional<Exemplaire> findById(Long id) {
        return exemplaireRepository.findById(id);
    }

    public Exemplaire save(Exemplaire exemplaire) {
        return exemplaireRepository.save(exemplaire);
    }

    public void deleteById(Long id) {
        exemplaireRepository.deleteById(id);
    }

    /**
     * Retourne le nombre d'exemplaires disponibles pour un exemplaire donné.
     * @param exemplaireId l'id de l'exemplaire
     * @return le nombre d'exemplaires disponibles (>=0)
     */
    public int getNombreDisponible(Long exemplaireId) {
        Optional<Exemplaire> optEx = exemplaireRepository.findById(exemplaireId);
        if (optEx.isEmpty()) return 0;
        Exemplaire ex = optEx.get();
        int total = ex.getNombreDispo() != null ? ex.getNombreDispo() : 0;
        // Compte les prêts non rendus pour cet exemplaire via la table pret
        long pretsNonRendus = pretRepository.countByExemplaireIdAndRenduFalse(exemplaireId);
        int dispo = total - (int) pretsNonRendus;
        return Math.max(dispo, 0);
    }
}