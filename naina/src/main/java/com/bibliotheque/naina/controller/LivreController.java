package com.bibliotheque.naina.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.beans.factory.annotation.Autowired;
import com.bibliotheque.naina.service.LivreService;
import com.bibliotheque.naina.service.ExemplaireService;
import com.bibliotheque.naina.service.LivreCategorieService;
import com.bibliotheque.naina.model.Livre;
import com.bibliotheque.naina.model.LivreCategorie;
import com.bibliotheque.naina.service.VueNombreExemplairesDisponiblesService;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class LivreController {

    @Autowired
    private LivreService livreService;

    @Autowired
    private ExemplaireService exemplaireService;
    @Autowired
    private LivreCategorieService livreCategorieService;

    @Autowired
    private VueNombreExemplairesDisponiblesService vueExemplairesService;

    @GetMapping("/livres")
    public String listeLivres(
            @RequestParam(required = false) String categorie,
            @RequestParam(required = false) String titre,
            @RequestParam(required = false) String auteur,
            Model model
    ) {
        List<Livre> livres = livreService.findAll();
        List<LivreCategorie> relations = livreCategorieService.findAll();

        // Map livreId -> liste de catégories
        Map<Long, List<String>> livreCategories = relations.stream()
            .collect(Collectors.groupingBy(
                lc -> lc.getLivre().getId(),
                Collectors.mapping(lc -> lc.getCategorie().getNom(), Collectors.toList())
            ));

        // Filtrage
        if (categorie != null && !categorie.isEmpty()) {
            livres = livres.stream()
                .filter(l -> livreCategories.getOrDefault(l.getId(), List.of()).contains(categorie))
                .toList();
        }
        if (titre != null && !titre.isEmpty()) {
            livres = livres.stream()
                .filter(l -> l.getTitre() != null && l.getTitre().toLowerCase().contains(titre.toLowerCase()))
                .toList();
        }
        if (auteur != null && !auteur.isEmpty()) {
            livres = livres.stream()
                .filter(l -> l.getAuteur() != null && l.getAuteur().toLowerCase().contains(auteur.toLowerCase()))
                .toList();
        }

        // Map livreId -> nombre total d'exemplaires disponibles
        Map<Long, Integer> exemplairesDisponibles = new HashMap<>();
        for (Livre livre : livres) {
            int totalDispo = 0;
            List<com.bibliotheque.naina.model.Exemplaire> exs = exemplaireService.findAll().stream()
                .filter(ex -> ex.getLivre().getId().equals(livre.getId()))
                .toList();
            for (var ex : exs) {
                totalDispo += exemplaireService.getNombreDisponible(ex.getId());
            }
            exemplairesDisponibles.put(livre.getId(), totalDispo);
        }

        // Liste des catégories pour le filtre
        Set<String> allCategories = relations.stream()
            .map(lc -> lc.getCategorie().getNom())
            .collect(Collectors.toSet());

        model.addAttribute("livres", livres);
        model.addAttribute("livreCategories", livreCategories);
        model.addAttribute("exemplairesDisponibles", exemplairesDisponibles);
        model.addAttribute("allCategories", allCategories);
        model.addAttribute("selectedCategorie", categorie);
        model.addAttribute("searchTitre", titre);
        model.addAttribute("searchAuteur", auteur);
        model.addAttribute("body", "livres.jsp");
        return "layout";
    }
}