package com.bibliotheque.naina.controller;

import com.bibliotheque.naina.model.Abonnement;
import com.bibliotheque.naina.model.Adherent;
import com.bibliotheque.naina.service.AbonnementService;
import com.bibliotheque.naina.service.AdherentService;
import com.bibliotheque.naina.service.AbonnementTarifService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AbonnementController {

    @Autowired
    private AbonnementService abonnementService;

    @Autowired
    private AdherentService adherentService;

    @Autowired
    private AbonnementTarifService abonnementTarifService;

    @GetMapping("/abonnement/nouveau")
    public String showAbonnementForm(Model model) {
        model.addAttribute("adherents", adherentService.findAll());
        model.addAttribute("abonnementTarifs", abonnementTarifService.findAll());
        return "abonnement_nouveau";
    }

    @PostMapping("/abonnement/nouveau")
    public String createAbonnement(@RequestParam Long adherentId, Model model) {
        Adherent adherent = adherentService.findById(adherentId).orElse(null);
        if (adherent == null) {
            model.addAttribute("error", "Adhérent introuvable.");
        } else {
            try {
                // Utilisation de la méthode de service
                if (abonnementService.estAbonneCeMois(adherentId)) {
                    model.addAttribute("error", "Cet adhérent a déjà payé pour ce mois.");
                } else {
                    Abonnement abonnement = new Abonnement();
                    abonnement.setAdherent(adherent);
                    abonnementService.save(abonnement);
                    model.addAttribute("message", "Abonnement créé avec succès !");
                }
            } catch (Exception e) {
                model.addAttribute("error", e.getMessage());
            }
        }
        model.addAttribute("adherents", adherentService.findAll());
        model.addAttribute("abonnementTarifs", abonnementTarifService.findAll());
        return "abonnement_nouveau";
    }
}