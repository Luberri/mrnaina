package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.PretRole;
import com.bibliotheque.naina.repository.PretRoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PretRoleService {

    @Autowired
    private PretRoleRepository pretRoleRepository;

    public List<PretRole> findAll() {
        return pretRoleRepository.findAll();
    }

    public Optional<PretRole> findById(Long id) {
        return pretRoleRepository.findById(id);
    }

    public Optional<PretRole> findByRoleId(Long roleId) {
        return pretRoleRepository.findByRoleId(roleId);
    }

    public PretRole save(PretRole pretRole) {
        return pretRoleRepository.save(pretRole);
    }

    public void deleteById(Long id) {
        pretRoleRepository.deleteById(id);
    }
}