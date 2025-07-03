package com.bibliotheque.naina.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.beans.factory.annotation.Autowired;
import com.bibliotheque.naina.service.LivreService;
import com.bibliotheque.naina.service.ExemplaireService;
import com.bibliotheque.naina.service.LivreCategorieService;
import com.bibliotheque.naina.model.Livre;
import com.bibliotheque.naina.model.LivreCategorie;
import com.bibliotheque.naina.model.VueNombreExemplairesDisponibles;
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
    public String listeLivres(Model model) {
        List<Livre> livres = livreService.findAll();
        List<LivreCategorie> relations = livreCategorieService.findAll();

        // Map livreId -> liste de catégories
        Map<Long, List<String>> livreCategories = relations.stream()
            .collect(Collectors.groupingBy(
                lc -> lc.getLivre().getId(),
                Collectors.mapping(lc -> lc.getCategorie().getNom(), Collectors.toList())
            ));

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

        model.addAttribute("livres", livres);
        model.addAttribute("livreCategories", livreCategories);
        model.addAttribute("exemplairesDisponibles", exemplairesDisponibles);
        model.addAttribute("body", "livres.jsp");
        return "layout";
    }
}