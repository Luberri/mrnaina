package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.ProlongementDemande;
import com.bibliotheque.naina.repository.ProlongementDemandeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProlongementDemandeService {

    @Autowired
    private ProlongementDemandeRepository prolongementDemandeRepository;

    public List<ProlongementDemande> findAll() {
        return prolongementDemandeRepository.findAll();
    }

    public Optional<ProlongementDemande> findById(Long id) {
        return prolongementDemandeRepository.findById(id);
    }

    public List<ProlongementDemande> findByPretId(Long pretId) {
        return prolongementDemandeRepository.findByPretId(pretId);
    }

    public ProlongementDemande save(ProlongementDemande demande) {
        return prolongementDemandeRepository.save(demande);
    }

    public void deleteById(Long id) {
        prolongementDemandeRepository.deleteById(id);
    }
}