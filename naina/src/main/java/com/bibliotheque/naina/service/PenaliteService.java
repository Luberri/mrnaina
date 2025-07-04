package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.Penalite;
import com.bibliotheque.naina.repository.PenaliteRepository;
import com.bibliotheque.naina.model.Pret;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PenaliteService {

    @Autowired
    private PenaliteRepository penaliteRepository;

    public List<Penalite> findAll() {
        return penaliteRepository.findAll();
    }

    public Optional<Penalite> findById(Long id) {
        return penaliteRepository.findById(id);
    }

    public List<Penalite> findByAdherentId(Long adherentId) {
        return penaliteRepository.findByAdherentId(adherentId);
    }

    public List<Penalite> findByPretId(Long pretId) {
        return penaliteRepository.findByPretId(pretId);
    }

    public Penalite save(Penalite penalite) {
        return penaliteRepository.save(penalite);
    }

    public void deleteById(Long id) {
        penaliteRepository.deleteById(id);
    }

    public boolean estEncorePenalise(Long adherentId) {
        List<Penalite> penalites = penaliteRepository.findByAdherentId(adherentId);
        java.time.LocalDate today = java.time.LocalDate.now();
        for (Penalite p : penalites) {
            Pret pret = p.getPret();
            if (pret.getDateRetourReel() != null) {
                java.time.LocalDate finPenalite = pret.getDateRetourReel().plusDays(p.getDuree());
                if (today.isBefore(finPenalite)) {
                    return true;
                }
            }
        }
        return false;
    }
}