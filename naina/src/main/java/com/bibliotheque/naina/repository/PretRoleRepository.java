package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.PretRole;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PretRoleRepository extends JpaRepository<PretRole, Long> {
    Optional<PretRole> findByRoleId(Long roleId);
}