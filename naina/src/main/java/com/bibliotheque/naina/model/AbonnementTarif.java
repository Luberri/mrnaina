package com.bibliotheque.naina.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "abonnement_tarif")
@Data
public class AbonnementTarif {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "role_id", nullable = false)
    private Role role;

    @Column(name = "prix", nullable = false)
    private Double prix;
}