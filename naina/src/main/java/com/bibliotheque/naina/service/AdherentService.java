package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.Adherent;
import com.bibliotheque.naina.repository.AdherentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AdherentService {

    @Autowired
    private AdherentRepository adherentRepository;

    public List<Adherent> findAll() {
        return adherentRepository.findAll();
    }

    public Optional<Adherent> findById(Long id) {
        return adherentRepository.findById(id);
    }

    public Adherent save(Adherent adherent) {
        return adherentRepository.save(adherent);
    }

    public void deleteById(Long id) {
        adherentRepository.deleteById(id);
    }

    public Adherent findByNom(String nom) {
        return adherentRepository.findByNom(nom);
    }
}