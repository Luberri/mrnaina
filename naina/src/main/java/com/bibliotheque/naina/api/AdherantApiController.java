package com.bibliotheque.naina.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.bibliotheque.naina.model.Adherent;
import com.bibliotheque.naina.service.AdherentService;
import java.util.Optional;
import java.util.Map;
import java.util.HashMap;

@RestController
@RequestMapping("/api/adherants")
public class AdherantApiController {

    @Autowired
    private com.bibliotheque.naina.service.AbonnementService abonnementService;
    @Autowired
    private com.bibliotheque.naina.service.PenaliteService penaliteService;
    @Autowired
    private com.bibliotheque.naina.service.PretRoleService pretRoleService;
    @Autowired
    private com.bibliotheque.naina.service.PretService pretService;

    @GetMapping("/{id}/infos")
    public Map<String, Object> getAdherantInfos(@PathVariable Long id) {
        Optional<Adherent> optAdh = adherentService.findById(id);
        if (optAdh.isEmpty()) {
            throw new org.springframework.web.server.ResponseStatusException(
                org.springframework.http.HttpStatus.NOT_FOUND, "Adhérent non trouvé");
        }
        Adherent adh = optAdh.get();
        Map<String, Object> infos = new HashMap<>();
        // Abonnement ce mois
        boolean abonneCeMois = abonnementService.estAbonneCeMois(id);
        infos.put("abonneCeMois", abonneCeMois);
        // Quota prêt restant
        // Récupère le rôle (fallback si pas de getRole)
        Long roleId = null;
        try {
            roleId = (Long) Adherent.class.getMethod("getRole").invoke(adh).getClass().getMethod("getId").invoke(adh.getRole());
        } catch (Exception e) {
            // fallback: tente d'accéder à la propriété directement
            try {
                java.lang.reflect.Field f = Adherent.class.getDeclaredField("role");
                f.setAccessible(true);
                Object role = f.get(adh);
                if (role != null) {
                    java.lang.reflect.Field fid = role.getClass().getDeclaredField("id");
                    fid.setAccessible(true);
                    roleId = (Long) fid.get(role);
                }
            } catch (Exception ignore) {}
        }
        int quotaMax = 0;
        if (roleId != null) {
            Integer q = pretRoleService.findByRoleId(roleId).map(pr -> pr.getNombreLivreMax()).orElse(null);
            quotaMax = (q != null) ? q : 0;
        }
        // Compte les prêts en cours (statut rendu = false)
        long nbPretsEnCours = pretService.findAll().stream()
            .filter(p -> {
                try {
                    java.lang.reflect.Field f = p.getClass().getDeclaredField("adherent");
                    f.setAccessible(true);
                    Object adhObj = f.get(p);
                    java.lang.reflect.Field idf = Adherent.class.getDeclaredField("id");
                    idf.setAccessible(true);
                    return adhObj != null && idf.get(adhObj).equals(id);
                } catch (Exception e) { return false; }
            })
            .filter(p -> {
                try {
                    java.lang.reflect.Field f = p.getClass().getDeclaredField("rendu");
                    f.setAccessible(true);
                    Object rendu = f.get(p);
                    return rendu != null && rendu.equals(Boolean.FALSE);
                } catch (Exception e) { return false; }
            })
            .count();
        int quotaPretRestant = Math.max(0, quotaMax - (int)nbPretsEnCours);
        infos.put("quotaPretMax", quotaMax);
        infos.put("quotaPretRestant", quotaPretRestant);
        // Pénalité
        boolean penalise = penaliteService.estEncorePenalise(id);
        int joursRestant = 0;
        if (penalise) {
            // Cherche la pénalité active
            var pen = penaliteService.findAll().stream()
                .filter(p -> {
                    try {
                        java.lang.reflect.Field f = p.getClass().getDeclaredField("adherent");
                        f.setAccessible(true);
                        Object adhObj = f.get(p);
                        java.lang.reflect.Field idf = Adherent.class.getDeclaredField("id");
                        idf.setAccessible(true);
                        return adhObj != null && idf.get(adhObj).equals(id);
                    } catch (Exception e) { return false; }
                })
                .findFirst();
            if (pen.isPresent()) {
                try {
                    java.lang.reflect.Field dureeF = pen.get().getClass().getDeclaredField("duree");
                    dureeF.setAccessible(true);
                    Object duree = dureeF.get(pen.get());
                    joursRestant = (duree != null) ? ((Number)duree).intValue() : 0;
                } catch (Exception ignore) {}
            }
        }
        infos.put("penalise", penalise);
        infos.put("joursPenaliteRestant", joursRestant);

        // Structure claire pour le front :
        Map<String, Object> resume = new HashMap<>();
        resume.put("abonneCeMois", abonneCeMois);
        resume.put("quotaPretMax", quotaMax);
        resume.put("quotaPretRestant", quotaPretRestant);
        resume.put("penalise", penalise);
        resume.put("joursPenaliteRestant", joursRestant);
        infos.put("infosResume", resume);
        return infos;
    }
    @Autowired
    private AdherentService adherentService;

    @GetMapping("/{id}")
    public Map<String, Object> getAdherantInfo(@PathVariable Long id) {
        return getAdherantInfos(id);
    }
}
