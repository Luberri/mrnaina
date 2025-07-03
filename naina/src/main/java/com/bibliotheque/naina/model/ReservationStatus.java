package com.bibliotheque.naina.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "reservation_status")
@Data
public class ReservationStatus {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Lien vers Reservation
    @ManyToOne
    @JoinColumn(name = "reservation_id", nullable = false)
    private Reservation reservation;

    @Column(name = "etat", nullable = false)
    private String etat; // 'en attente', 'confirmée', 'annulée', etc.

    @Column(name = "date", nullable = false)
    private LocalDate date = LocalDate.now();
}