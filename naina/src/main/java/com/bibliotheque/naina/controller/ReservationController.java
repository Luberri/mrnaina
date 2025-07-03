package com.bibliotheque.naina.controller;

import com.bibliotheque.naina.model.Reservation;
import com.bibliotheque.naina.model.Adherent;
import com.bibliotheque.naina.model.Livre;
import com.bibliotheque.naina.service.ReservationService;
import com.bibliotheque.naina.service.AdherentService;
import com.bibliotheque.naina.service.LivreService;
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

    @GetMapping("/reservations")
    public String listeReservations(Model model) {
        model.addAttribute("reservations", reservationService.findAll());
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
            Model model
    ) {
        Adherent adherent = adherentService.findById(adherentId).orElse(null);
        Livre livre = livreService.findById(livreId).orElse(null);

        if (adherent == null || livre == null) {
            model.addAttribute("error", "Paramètres invalides.");
        } else {
            Reservation reservation = new Reservation();
            reservation.setAdherent(adherent);
            reservation.setLivre(livre);
            reservationService.save(reservation);
            model.addAttribute("message", "Réservation enregistrée !");
        }
        model.addAttribute("adherents", adherentService.findAll());
        model.addAttribute("livres", livreService.findAll());
        model.addAttribute("body", "reservation_form.jsp");
        return "layout";
    }
}