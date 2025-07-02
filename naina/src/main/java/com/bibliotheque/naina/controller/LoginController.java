package com.bibliotheque.naina.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
import org.springframework.beans.factory.annotation.Autowired;
import com.bibliotheque.naina.service.LivreService;
import com.bibliotheque.naina.service.AdherentService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private LivreService livreService;

    @Autowired
    private AdherentService adherentService;

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String doLogin(@RequestParam String nom, HttpSession session, Model model) {
        var adherent = adherentService.findByNom(nom);
        if (adherent == null) {
            model.addAttribute("error", "Nom inconnu. Veuillez réessayer.");
            return "login";
        }
        session.setAttribute("nom", nom);
        session.setAttribute("adherentId", adherent.getId());
        return "redirect:/livres";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }

    @GetMapping("/login-admin")
    public String showAdminLoginForm() {
        return "login_admin";
    }

    @PostMapping("/login-admin")
    public String doAdminLogin(@RequestParam String nom, @RequestParam String mdp, HttpSession session, Model model) {
        var adherent = adherentService.findByNom(nom);
        // Vérifie que l'adhérent existe et a le rôle id=1
        if (adherent == null || adherent.getRole() == null || adherent.getRole().getId() != 1L || !"1234".equals(mdp)) {
            model.addAttribute("error", "Nom ou mot de passe incorrect ou accès non autorisé.");
            return "login_admin";
        }
        session.setAttribute("admin", true);
        session.setAttribute("adminNom", nom);
        return "redirect:/admin";
    }

    @GetMapping("/admin")
    public String adminPage(HttpSession session) {
        // Optionnel : vérifier que l'utilisateur est bien admin
        if (session.getAttribute("admin") == null) {
            return "redirect:/login-admin";
        }
        return "admin";
    }
}