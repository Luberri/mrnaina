package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.JourFerier;
import com.bibliotheque.naina.repository.JourFerierRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class JourFerierService {
    @Autowired
    private JourFerierRepository jourFerierRepository;

    public List<JourFerier> findAll() {
        return jourFerierRepository.findAll();
    }

    public Optional<JourFerier> findById(Integer id) {
        return jourFerierRepository.findById(id);
    }

    public Optional<JourFerier> findByDate(LocalDate date) {
        return jourFerierRepository.findByDate(date);
    }

    public JourFerier save(JourFerier jourFerier) {
        return jourFerierRepository.save(jourFerier);
    }

    public void deleteById(Integer id) {
        jourFerierRepository.deleteById(id);
    }
}
