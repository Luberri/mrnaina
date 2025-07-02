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
        return "pret_list";
    }

    @GetMapping("/prets/nouveau")
    public String showPretForm(Model model) {
        model.addAttribute("adherents", adherentService.findAll());
        model.addAttribute("exemplaires", exemplaireService.findAll());
        model.addAttribute("modes", modeService.findAll());
        return "pret_form";
    }

    @PostMapping("/prets/nouveau")
    public String creerPret(
            @RequestParam Long adherentId,
            @RequestParam Long exemplaireId,
            @RequestParam Long modeId,
            @RequestParam String dateRetour,
            Model model
    ) {
        String erreur = pretService.verifierPret(adherentId);
        if (erreur != null) {
            model.addAttribute("error", erreur);
        } else {
            try {
                Pret pret = new Pret();
                pret.setAdherent(adherentService.findById(adherentId).orElse(null));
                pret.setExemplaire(exemplaireService.findById(exemplaireId).orElse(null));
                pret.setMode(modeService.findById(modeId).orElse(null));
                pret.setDateRetour(LocalDate.parse(dateRetour));
                pret.setRendu(false);
                pretService.save(pret);
                model.addAttribute("message", "Prêt enregistré !");
            } catch (Exception e) {
                model.addAttribute("error", "Erreur lors de l'enregistrement du prêt.");
            }
        }
        model.addAttribute("adherents", adherentService.findAll());
        model.addAttribute("exemplaires", exemplaireService.findAll());
        model.addAttribute("modes", modeService.findAll());
        return "pret_form";
    }
}