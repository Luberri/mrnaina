package com.bibliotheque.naina.model;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Entity
@Table(name = "livre")
@Data
public class Livre {
    public String getTitre() { return titre; }
    public String getAuteur() { return auteur; }
    public String getEditeur() { return editeur; }
    public Integer getAnneePublication() { return anneePublication; }
    public Long getId() {
        return id;
    }
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

    @OneToMany(mappedBy = "livre")
    private List<LivreCategorie> livreCategories;

    // Retourne la liste des catégories associées à ce livre
    public List<Categorie> getCategories() {
        if (livreCategories == null) return java.util.Collections.emptyList();
        return livreCategories.stream()
                .map(LivreCategorie::getCategorie)
                .toList();
    }
}