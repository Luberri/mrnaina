package com.bibliotheque.naina.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "prolongement_role")
@Data
public class ProlongementRole {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "role_id", nullable = false)
    private Role role;

    @Column(name = "nombre_jour", nullable = false)
    private Integer nombreJour;
}
