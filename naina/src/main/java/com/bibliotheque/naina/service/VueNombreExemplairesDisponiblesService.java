package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.VueNombreExemplairesDisponibles;
import com.bibliotheque.naina.repository.VueNombreExemplairesDisponiblesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VueNombreExemplairesDisponiblesService {

    @Autowired
    private VueNombreExemplairesDisponiblesRepository repository;

    public List<VueNombreExemplairesDisponibles> findAll() {
        return repository.findAll();
    }
}