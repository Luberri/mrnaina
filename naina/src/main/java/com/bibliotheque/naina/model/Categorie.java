package com.bibliotheque.naina.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "categorie")
@Data
public class Categorie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nom", nullable = false, unique = true)
    private String nom;
}