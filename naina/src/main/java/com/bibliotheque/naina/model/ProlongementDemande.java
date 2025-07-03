package com.bibliotheque.naina.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "prolongement_demande")
@Data
public class ProlongementDemande {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "pret_id", nullable = false)
    private Pret pret;

    @Column(name = "nombre_jour", nullable = false)
    private Integer nombreJour;
}