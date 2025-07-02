package com.bibliotheque.naina.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "pret_jour")
@Data
public class PretJour {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "role_id", nullable = false)
    private Role role;

    @Column(name = "nombre_jour", nullable = false)
    private Integer nombreJour;
}