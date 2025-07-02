package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.LivreCategorie;
import com.bibliotheque.naina.repository.LivreCategorieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class LivreCategorieService {

    @Autowired
    private LivreCategorieRepository livreCategorieRepository;

    public List<LivreCategorie> findAll() {
        return livreCategorieRepository.findAll();
    }

    public Optional<LivreCategorie> findById(LivreCategorie.LivreCategorieId id) {
        return livreCategorieRepository.findById(id);
    }

    public LivreCategorie save(LivreCategorie livreCategorie) {
        return livreCategorieRepository.save(livreCategorie);
    }

    public void deleteById(LivreCategorie.LivreCategorieId id) {
        livreCategorieRepository.deleteById(id);
    }
}