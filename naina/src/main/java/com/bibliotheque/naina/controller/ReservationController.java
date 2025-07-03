package com.bibliotheque.naina.controller;

import com.bibliotheque.naina.model.Reservation;
import com.bibliotheque.naina.model.Adherent;
import com.bibliotheque.naina.model.Livre;
import com.bibliotheque.naina.model.ReservationStatus;
import com.bibliotheque.naina.service.ReservationService;
import com.bibliotheque.naina.service.AdherentService;
import com.bibliotheque.naina.service.LivreService;
import com.bibliotheque.naina.service.ReservationStatusService;
import com.bibliotheque.naina.service.AbonnementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
public class ReservationController {

    @Autowired
    private ReservationService reservationService;
    @Autowired
    private AdherentService adherentService;
    @Autowired
    private LivreService livreService;
    @Autowired
    private ReservationStatusService reservationStatusService;
    @Autowired
    private AbonnementService abonnementService;
    @Autowired
    private com.bibliotheque.naina.service.ReservationRoleService reservationRoleService;

    @GetMapping("/reservations")
    public String listeReservations(Model model) {
        model.addAttribute("reservations", reservationService.findAll());
        model.addAttribute("reservationStatusService", reservationStatusService);
        model.addAttribute("body", "reservation_list.jsp");
        return "layout";
    }

    @GetMapping("/reservations/nouveau")
    public String showReservationForm(Model model) {
        model.addAttribute("adherents", adherentService.findAll());
        model.addAttribute("livres", livreService.findAll());
        model.addAttribute("body", "reservation_form.jsp");
        return "layout";
    }

    @PostMapping("/reservations/nouveau")
    public String creerReservation(
            @RequestParam Long adherentId,
            @RequestParam Long livreId,
            @RequestParam String dateReservation,
            Model model
    ) {
        Adherent adherent = adherentService.findById(adherentId).orElse(null);
        Livre livre = livreService.findById(livreId).orElse(null);
        java.time.LocalDate date = java.time.LocalDate.parse(dateReservation);

        // Règle 1 : L'adhérent doit être abonné ce mois
        if (adherent == null || livre == null) {
            model.addAttribute("error", "Paramètres invalides.");
        } else if (!abonnementService.estAbonneCeMois(adherentId)) {
            model.addAttribute("error", "Vous devez être abonné ce mois pour réserver.");
        } else {
            // Règle 2 : Vérifier si le livre est déjà réservé (statut 'confirmée') pour cette date
            boolean dejaReserve = reservationService.findAll().stream()
                .filter(r -> r.getLivre().getId().equals(livreId) && r.getDateReservation().equals(date))
                .anyMatch(r -> reservationStatusService.findByReservationId(r.getId()).stream()
                    .anyMatch(status -> "confirmee".equalsIgnoreCase(status.getEtat()))
                );
            if (dejaReserve) {
                model.addAttribute("error", "Ce livre est déjà réservé et confirmé pour cette date.");
            } else {
                Reservation reservation = new Reservation();
                reservation.setAdherent(adherent);
                reservation.setLivre(livre);
                reservation.setDateReservation(date);
                reservation = reservationService.save(reservation);

                // Insertion du statut initial "en attente"
                ReservationStatus status = new ReservationStatus();
                status.setReservation(reservation);
                status.setEtat("en attente");
                status.setDate(java.time.LocalDate.now());
                reservationStatusService.save(status);

                model.addAttribute("message", "Réservation en attente");
            }
        }
        model.addAttribute("adherents", adherentService.findAll());
        model.addAttribute("livres", livreService.findAll());
        model.addAttribute("body", "reservation_form.jsp");
        return "layout";
    }

    @GetMapping("/reservations/{id}")
    public String voirReservation(@PathVariable Long id, Model model) {
        var reservationOpt = reservationService.findById(id);
        if (reservationOpt.isEmpty()) {
            model.addAttribute("error", "Réservation introuvable.");
            model.addAttribute("body", "reservation_list.jsp");
            return "layout";
        }
        var reservation = reservationOpt.get();
        var statuts = reservationStatusService.findByReservationId(id);
        model.addAttribute("reservation", reservation);
        model.addAttribute("statuts", statuts);
        model.addAttribute("body", "reservation_voir.jsp");
        return "layout";
    }

    @PostMapping("/reservations/{id}/statut")
    public String changerStatutReservation(
            @PathVariable Long id,
            @RequestParam String action,
            Model model
    ) {
        var reservationOpt = reservationService.findById(id);
        if (reservationOpt.isEmpty()) {
            model.addAttribute("error", "Réservation introuvable.");
            model.addAttribute("body", "reservation_list.jsp");
            return "layout";
        }
        Reservation reservation = reservationOpt.get();

        // Règle : Empêcher de confirmer si le max est atteint
        if ("accepter".equals(action)) {
            // Récupère le nombre max pour le rôle
            var adherent = reservation.getAdherent();
            var roleId = adherent.getRole().getId();
            var optRole = reservationRoleService.findAll().stream()
                .filter(rr -> rr.getRole().getId().equals(roleId))
                .findFirst();
            int maxConfirme = optRole.map(rr -> rr.getNombreLivreMax()).orElse(0);

            // Compte les réservations confirmées de cet adhérent
            long nbConfirme = reservationService.findAll().stream()
                .filter(r -> r.getAdherent().getId().equals(adherent.getId()))
                .filter(r -> reservationStatusService.findByReservationId(r.getId()).stream()
                    .anyMatch(st -> "confirmee".equalsIgnoreCase(st.getEtat())))
                .count();

            if (nbConfirme >= maxConfirme) {
                model.addAttribute("error", "Nombre maximum de réservations confirmées atteint pour cet adhérent.");
                model.addAttribute("reservation", reservation);
                model.addAttribute("statuts", reservationStatusService.findByReservationId(id));
                model.addAttribute("body", "reservation_voir.jsp");
                return "layout";
            }
        }

        ReservationStatus status = new ReservationStatus();
        status.setReservation(reservation);
        if ("accepter".equals(action)) {
            status.setEtat("confirmee");
        } else if ("refuser".equals(action)) {
            status.setEtat("annulee");
        } else {
            model.addAttribute("error", "Action inconnue.");
            model.addAttribute("body", "reservation_voir.jsp");
            return "layout";
        }
        status.setDate(java.time.LocalDate.now());
        reservationStatusService.save(status);

        model.addAttribute("message", "Statut mis à jour !");
        var statuts = reservationStatusService.findByReservationId(id);
        model.addAttribute("reservation", reservation);
        model.addAttribute("statuts", statuts);
        model.addAttribute("body", "reservation_voir.jsp");
        return "layout";
    }

    @GetMapping("/mes-reservations")
public String mesReservations(
        @RequestParam(required = false) String dateDebut,
        @RequestParam(required = false) String dateFin,
        Model model
) {
    model.addAttribute("reservations", reservationService.findAll());
    model.addAttribute("reservationStatusService", reservationStatusService);
    model.addAttribute("reservationRoles", reservationRoleService.findAll());
    model.addAttribute("dateDebut", dateDebut);
    model.addAttribute("dateFin", dateFin);
    model.addAttribute("body", "mes_reservations.jsp");
    return "layout";
}
}