package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.ProlongementRole;
import com.bibliotheque.naina.repository.ProlongementRoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProlongementRoleService {

    @Autowired
    private ProlongementRoleRepository prolongementRoleRepository;

    public List<ProlongementRole> findAll() {
        return prolongementRoleRepository.findAll();
    }

    public Optional<ProlongementRole> findById(Long id) {
        return prolongementRoleRepository.findById(id);
    }

    public ProlongementRole save(ProlongementRole prolongementRole) {
        return prolongementRoleRepository.save(prolongementRole);
    }

    public void deleteById(Long id) {
        prolongementRoleRepository.deleteById(id);
    }
}