package com.bibliotheque.naina.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "pret")
@Data
public class Pret {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "exemplaire_id", nullable = false)
    private Exemplaire exemplaire;

    @ManyToOne
    @JoinColumn(name = "adherent_id", nullable = false)
    private Adherent adherent;

    @ManyToOne
    @JoinColumn(name = "mode_id", nullable = false)
    private Mode mode;

    @Column(name = "date_pret", nullable = false)
    private LocalDate datePret;

    @Column(name = "date_retour", nullable = false)
    private LocalDate dateRetour;

    @Column(name = "date_retour_reel")
    private LocalDate dateRetourReel;

    
    @Column(name = "prolongement_jour")
    private Integer prolongementJour = 0;
    
    @Column(name = "rendu", nullable = false)
    private Boolean rendu = false;
}