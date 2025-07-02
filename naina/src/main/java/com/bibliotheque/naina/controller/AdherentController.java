package com.bibliotheque.naina.controller;

import com.bibliotheque.naina.model.Adherent;
import com.bibliotheque.naina.service.AdherentService;
import com.bibliotheque.naina.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.stream.Collectors;

@Controller
public class AdherentController {

    @Autowired
    private AdherentService adherentService;

    @Autowired
    private RoleService roleService;

    @GetMapping("/adherents")
    public String listeAdherents(Model model) {
        model.addAttribute("adherents", adherentService.findAll());
        return "adherents";
    }

    @GetMapping("/adherents/nouveau")
    public String showAjoutAdherentForm(Model model) {
        // Filtrer les rôles pour exclure l'id 5 (anonyme)
        var rolesSansAnonyme = roleService.findAll()
            .stream()
            .filter(role -> role.getId() != 5L)
            .collect(Collectors.toList());
        model.addAttribute("roles", rolesSansAnonyme);
        return "adherent_nouveau";
    }

    @PostMapping("/adherents/nouveau")
    public String ajoutAdherent(
            @RequestParam String nom,
            @RequestParam Long roleId,
            @RequestParam String dateNaissance,
            Model model
    ) {
        Adherent adherent = new Adherent();
        adherent.setNom(nom);
        adherent.setRole(roleService.findById(roleId).orElse(null));
        adherent.setDateNaissance(java.time.LocalDate.parse(dateNaissance));
        adherentService.save(adherent);
        model.addAttribute("message", "Adhérent ajouté avec succès !");
        model.addAttribute("adherents", adherentService.findAll());
        return "adherents";
    }
}