package com.bibliotheque.naina.controller;

import com.bibliotheque.naina.model.Pret;
import com.bibliotheque.naina.model.Adherent;
import com.bibliotheque.naina.model.Exemplaire;
import com.bibliotheque.naina.model.Mode;
import com.bibliotheque.naina.service.PretService;
import com.bibliotheque.naina.service.AdherentService;
import com.bibliotheque.naina.service.ExemplaireService;
import com.bibliotheque.naina.service.ModeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Controller
public class PretController {

    @Autowired
    private PretService pretService;
    @Autowired
    private AdherentService adherentService;
    @Autowired
    private ExemplaireService exemplaireService;
    @Autowired
    private ModeService modeService;

    @GetMapping("/prets")
    public String listePrets(Model model) {
        model.addAttribute("prets", pretService.findAll());
        model.addAttribute("body", "pret_list.jsp");
        return "layout";
    }

    @GetMapping("/prets/nouveau")
    public String showPretForm(Model model) {
        var exemplaires = exemplaireService.findAll();
        model.addAttribute("adherents", adherentService.findAll());
        model.addAttribute("exemplaires", exemplaires);
        model.addAttribute("modes", modeService.findAll());

        // Map des disponibilités réelles
        java.util.Map<Long, Integer> disponibilites = new java.util.HashMap<>();
        for (var ex : exemplaires) {
            disponibilites.put(ex.getId(), exemplaireService.getNombreDisponible(ex.getId()));
        }
        model.addAttribute("disponibilites", disponibilites);

        model.addAttribute("body", "pret_form.jsp");
        return "layout";
    }

    @PostMapping("/prets/nouveau")
    public String creerPret(
            @RequestParam Long adherentId,
            @RequestParam Long exemplaireId,
            @RequestParam Long modeId,
            Model model
    ) {
        Adherent adherent = adherentService.findById(adherentId).orElse(null);
        Mode mode = modeService.findById(modeId).orElse(null);

        // Vérification de la disponibilité de l'exemplaire
        int dispo = exemplaireService.getNombreDisponible(exemplaireId);
        if (dispo <= 0) {
            model.addAttribute("error", "Aucun exemplaire disponible pour ce livre.");
            model.addAttribute("adherents", adherentService.findAll());
            model.addAttribute("exemplaires", exemplaireService.findAll());
            model.addAttribute("modes", modeService.findAll());
            model.addAttribute("body", "pret_form.jsp");
            return "layout";
        }

        // Règle : anonyme (role_id=5) ne peut pas faire de prêt à domicile (mode_id=1)
        if (adherent != null && mode != null && adherent.getRole().getId() == 5L && mode.getId() == 1L) {
            model.addAttribute("error", "Un adhérent anonyme ne peut pas emprunter à domicile.");
        } else {
            String erreur = pretService.verifierPret(adherentId);
            if (erreur != null) {
                model.addAttribute("error", erreur);
            } else {
                try {
                    Pret pret = new Pret();
                    pret.setAdherent(adherent);
                    pret.setExemplaire(exemplaireService.findById(exemplaireId).orElse(null));
                    pret.setMode(mode);

                    String message;
                    if (mode.getId() == 2L) { // sur place
                        pret.setDateRetour(LocalDate.now().plusDays(1));
                        message = "ok, À rendre avant la fermeture du bibliothèque.";
                    } else {
                        Integer nombreJour = pretService.getNombreJourPourRole(adherent.getRole().getId());
                        if (nombreJour == null) {
                            model.addAttribute("error", "Aucune durée de prêt définie pour ce rôle.");
                            model.addAttribute("adherents", adherentService.findAll());
                            model.addAttribute("exemplaires", exemplaireService.findAll());
                            model.addAttribute("modes", modeService.findAll());
                            model.addAttribute("body", "pret_form.jsp");
                            return "layout";
                        }
                        pret.setDateRetour(LocalDate.now().plusDays(nombreJour));
                        message = "ok, À rendre avant le " + pret.getDateRetour();
                    }
                    pret.setRendu(false);
                    pretService.save(pret);
                    model.addAttribute("message", message);
                } catch (Exception e) {
                    model.addAttribute("error", "Erreur lors de l'enregistrement du prêt.");
                }
            }
        }
        model.addAttribute("adherents", adherentService.findAll());
        model.addAttribute("exemplaires", exemplaireService.findAll());
        model.addAttribute("modes", modeService.findAll());
        model.addAttribute("body", "pret_form.jsp");
        return "layout";
    }
}