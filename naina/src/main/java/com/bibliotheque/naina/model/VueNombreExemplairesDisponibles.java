package com.bibliotheque.naina.model;

import jakarta.persistence.*;

@Entity
@Table(name = "nombre_exemplaires_disponibles")
public class VueNombreExemplairesDisponibles {
    @Id
    @Column(name = "livre_id")
    private Long livreId;

    private String titre;

    @Column(name = "nombre_exemplaires_disponibles")
    private Integer nombreExemplairesDisponibles;

    // Getters et setters
    public Long getLivreId() { return livreId; }
    public void setLivreId(Long livreId) { this.livreId = livreId; }
    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }
    public Integer getNombreExemplairesDisponibles() { return nombreExemplairesDisponibles; }
    public void setNombreExemplairesDisponibles(Integer n) { this.nombreExemplairesDisponibles = n; }
}