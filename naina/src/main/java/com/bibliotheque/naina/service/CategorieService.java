package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.Categorie;
import com.bibliotheque.naina.repository.CategorieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CategorieService {

    @Autowired
    private CategorieRepository categorieRepository;

    public List<Categorie> findAll() {
        return categorieRepository.findAll();
    }

    public Optional<Categorie> findById(Long id) {
        return categorieRepository.findById(id);
    }

    public Categorie save(Categorie categorie) {
        return categorieRepository.save(categorie);
    }

    public void deleteById(Long id) {
        categorieRepository.deleteById(id);
    }
}