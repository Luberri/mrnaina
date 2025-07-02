package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.PretJour;
import com.bibliotheque.naina.repository.PretJourRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PretJourService {

    @Autowired
    private PretJourRepository pretJourRepository;

    public List<PretJour> findAll() {
        return pretJourRepository.findAll();
    }

    public Optional<PretJour> findById(Long id) {
        return pretJourRepository.findById(id);
    }

    public PretJour save(PretJour pretJour) {
        return pretJourRepository.save(pretJour);
    }

    public void deleteById(Long id) {
        pretJourRepository.deleteById(id);
    }
}