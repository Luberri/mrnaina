package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.AbonnementTarif;
import com.bibliotheque.naina.repository.AbonnementTarifRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AbonnementTarifService {

    @Autowired
    private AbonnementTarifRepository abonnementTarifRepository;

    public List<AbonnementTarif> findAll() {
        return abonnementTarifRepository.findAll();
    }

    public Optional<AbonnementTarif> findById(Long id) {
        return abonnementTarifRepository.findById(id);
    }

    public AbonnementTarif save(AbonnementTarif abonnementTarif) {
        return abonnementTarifRepository.save(abonnementTarif);
    }

    public void deleteById(Long id) {
        abonnementTarifRepository.deleteById(id);
    }
}