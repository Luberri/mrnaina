package com.bibliotheque.naina.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "livre_categorie")
@Data
public class LivreCategorie {
    @EmbeddedId
    private LivreCategorieId id = new LivreCategorieId();

    @ManyToOne
    @MapsId("livreId")
    @JoinColumn(name = "livre_id")
    @com.fasterxml.jackson.annotation.JsonIgnore
    private Livre livre;

    @ManyToOne
    @MapsId("categorieId")
    @JoinColumn(name = "categorie_id")
    private Categorie categorie;

    @Embeddable
    public static class LivreCategorieId {
        private Long livreId;
        private Long categorieId;
    }
}