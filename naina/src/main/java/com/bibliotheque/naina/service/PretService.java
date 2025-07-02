package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.Pret;
import com.bibliotheque.naina.repository.PretRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PretService {

    @Autowired
    private PretRepository pretRepository;

    public List<Pret> findAll() {
        return pretRepository.findAll();
    }

    public Optional<Pret> findById(Long id) {
        return pretRepository.findById(id);
    }

    public Pret save(Pret pret) {
        return pretRepository.save(pret);
    }

    public void deleteById(Long id) {
        pretRepository.deleteById(id);
    }
}