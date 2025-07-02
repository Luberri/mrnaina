package com.bibliotheque.naina.repository;

import com.bibliotheque.naina.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role, Long> {
}