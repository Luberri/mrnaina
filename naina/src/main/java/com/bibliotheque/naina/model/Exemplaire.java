package com.bibliotheque.naina.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
public class Exemplaire {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "livre_id")
    private Livre livre;

    private String etat;

    @OneToMany(mappedBy = "exemplaire")
    private List<Pret> prets;

    @Column(name = "nombre_dispo")
    private Integer nombreDispo;

    // Constructors
    public Exemplaire() {
    }

    public Exemplaire(Livre livre, String etat) {
        this.livre = livre;
        this.etat = etat;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Livre getLivre() {
        return livre;
    }

    public void setLivre(Livre livre) {
        this.livre = livre;
    }

    public String getEtat() {
        return etat;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }

    public List<Pret> getPrets() {
        return prets;
    }

    public void setPrets(List<Pret> prets) {
        this.prets = prets;
    }

    public Integer getNombreDispo() {
        return nombreDispo;
    }

    public void setNombreDispo(Integer nombreDispo) {
        this.nombreDispo = nombreDispo;
    }
}