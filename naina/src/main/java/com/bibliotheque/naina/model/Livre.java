package com.bibliotheque.naina.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "livre")
@Data
public class Livre {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "titre", nullable = false)
    private String titre;

    @Column(name = "auteur")
    private String auteur;

    @Column(name = "editeur")
    private String editeur;

    @Column(name = "annee_publication")
    private Integer anneePublication;
}