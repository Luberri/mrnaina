package com.bibliotheque.naina.controller;

import com.bibliotheque.naina.model.Pret;
import com.bibliotheque.naina.model.Adherent;
import com.bibliotheque.naina.model.Exemplaire;
import com.bibliotheque.naina.model.Mode;
import com.bibliotheque.naina.service.PretService;
import com.bibliotheque.naina.service.AdherentService;
import com.bibliotheque.naina.service.ExemplaireService;
import com.bibliotheque.naina.service.ModeService;
import com.bibliotheque.naina.service.ProlongementRoleService;
import com.bibliotheque.naina.service.ProlongementDemandeService;
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
    @Autowired
    private ProlongementRoleService prolongementRoleService;
    @Autowired
    private ProlongementDemandeService prolongementDemandeService;

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
                    if (mode.getId() == 2L) {
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

    @GetMapping("/mes-prets")
    public String mesPrets(Model model) {
        model.addAttribute("prets", pretService.findAll());
        model.addAttribute("body", "mes_prets.jsp");
        return "layout";
    }

    @PostMapping("/prets/{id}/rendre")
    public String rendrePret(@PathVariable Long id, Model model) {
        var pretOpt = pretService.findById(id);
        if (pretOpt.isPresent()) {
            Pret pret = pretOpt.get();
            pret.setRendu(true);
            pretService.save(pret);
            model.addAttribute("message", "Le prêt a été marqué comme rendu.");
        } else {
            model.addAttribute("error", "Prêt introuvable.");
        }
        model.addAttribute("prets", pretService.findAll());
        model.addAttribute("body", "mes_prets.jsp");
        return "layout";
    }

    @PostMapping("/prets/{id}/prolonger")
    public String prolongerPret(
            @PathVariable Long id,
            @RequestParam int jours,
            Model model
    ) {
        var pretOpt = pretService.findById(id);
        if (pretOpt.isPresent()) {
            Pret pret = pretOpt.get();
            // Vérifie que le mode est "sur place"
            if (pret.getMode().getId() != 1L) {
                model.addAttribute("error", "Seuls les prêts à domicile peuvent être prolongés.");
            } else {
                // Récupère la limite de prolongement pour le rôle
                int maxProlongement = prolongementRoleService.findAll().stream()
                    .filter(pr -> pr.getRole().getId().equals(pret.getAdherent().getRole().getId()))
                    .map(pr -> pr.getNombreJour())
                    .findFirst()
                    .orElse(0);

                // Calcule le total demandé (somme des demandes existantes + nouvelle)
                int totalDemande = prolongementDemandeService.findByPretId(pret.getId()).stream()
                    .mapToInt(pd -> pd.getNombreJour())
                    .sum();
                int nouveauTotal = totalDemande + jours;

                if (nouveauTotal > maxProlongement) {
                    model.addAttribute("error", "Vous ne pouvez pas prolonger de plus de " + maxProlongement + " jours.");
                } else {
                    // Insertion de la demande
                    com.bibliotheque.naina.model.ProlongementDemande demande = new com.bibliotheque.naina.model.ProlongementDemande();
                    demande.setPret(pret);
                    demande.setNombreJour(jours);
                    prolongementDemandeService.save(demande);
                    model.addAttribute("message", "Demande de prolongement +" + jours + " jours enregistrée !");
                }
            }
        } else {
            model.addAttribute("error", "Prêt introuvable.");
        }
        model.addAttribute("prets", pretService.findAll());
        model.addAttribute("body", "mes_prets.jsp");
        return "layout";
    }

    @GetMapping("/prolongements")
    public String listeProlongements(Model model) {
        model.addAttribute("prolongements", prolongementDemandeService.findAll());
        model.addAttribute("body", "prolongement_list.jsp");
        return "layout";
    }

    @PostMapping("/prolongements/{id}/valider")
    public String validerProlongement(@PathVariable Long id, Model model) {
        var demandeOpt = prolongementDemandeService.findById(id);
        if (demandeOpt.isPresent()) {
            var demande = demandeOpt.get();
            Pret pret = demande.getPret();
            Adherent adherent = pret.getAdherent();

            // Vérification de l'abonnement pour le mois courant
            if (!abonnementService.estAbonneCeMois(adherent.getId())) {
                model.addAttribute("error", "L'adhérent n'est pas abonné pour ce mois. Prolongement refusé.");
            } else {
                int jours = demande.getNombreJour();
                pret.setProlongementJour((pret.getProlongementJour() == null ? 0 : pret.getProlongementJour()) + jours);
                pret.setDateRetour(pret.getDateRetour().plusDays(jours));
                pretService.save(pret);
                prolongementDemandeService.deleteById(id);
                model.addAttribute("message", "Prolongement validé !");
            }
        }
        model.addAttribute("prolongements", prolongementDemandeService.findAll());
        model.addAttribute("body", "prolongement_list.jsp");
        return "layout";
    }

    @PostMapping("/prolongements/{id}/refuser")
    public String refuserProlongement(@PathVariable Long id, Model model) {
        prolongementDemandeService.deleteById(id);
        model.addAttribute("message", "Demande supprimée.");
        model.addAttribute("prolongements", prolongementDemandeService.findAll());
        model.addAttribute("body", "prolongement_list.jsp");
        return "layout";
    }
}