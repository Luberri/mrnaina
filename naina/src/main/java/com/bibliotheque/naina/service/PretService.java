package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.Pret;
import com.bibliotheque.naina.repository.PretRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class PretService {

    @Autowired
    private PretRepository pretRepository;

    @Autowired
    private AdherentService adherentService;
    @Autowired
    private AbonnementService abonnementService;
    @Autowired
    private PretRoleService pretRoleService;
    @Autowired
    private PretJourService pretJourService;

    public List<Pret> findAll() {
        return pretRepository.findAll()
            .stream()
            .sorted((p1, p2) -> {
                // Si tu as un champ datePret, utilise-le, sinon adapte avec dateRetour ou autre
                if (p1.getDateRetour() == null) return 1;
                if (p2.getDateRetour() == null) return -1;
                return p2.getDateRetour().compareTo(p1.getDateRetour());
            })
            .toList();
    }

    public Optional<Pret> findById(Long id) {
        return pretRepository.findById(id);
    }

    public Pret save(Pret pret) {
        return pretRepository.save(pret);
    }

    public void deleteById(Long id) {
        pretRepository.deleteById(id);
    }

    public String verifierPret(Long adherentId) {
        // Vérifier que l'adhérent existe
        var adherentOpt = adherentService.findById(adherentId);
        if (adherentOpt.isEmpty()) {
            return "Adhérent inexistant.";
        }
        // Vérifier l'abonnement mensuel
        if (!abonnementService.estAbonneCeMois(adherentId)) {
            return "L'adhérent n'est pas abonné pour ce mois.";
        }
        // Récupérer le nombre max de livres pour ce rôle
        var adherent = adherentOpt.get();
        var pretRoleOpt = pretRoleService.findByRoleId(adherent.getRole().getId());
        if (pretRoleOpt.isEmpty()) {
            return "Aucune règle de prêt définie pour ce rôle.";
        }
        int nbMax = pretRoleOpt.get().getNombreLivreMax();
        // Compter le nombre de prêts en cours (non rendus)
        int nbEnCours = (int) findAll().stream()
            .filter(p -> p.getAdherent().getId().equals(adherentId) && !Boolean.TRUE.equals(p.getRendu()))
            .count();
        if (nbEnCours >= nbMax) {
            return "Nombre maximum de prêts atteint pour cet adhérent.";
        }
        return null; // OK
    }

    public Integer getNombreJourPourRole(Long roleId) {
        return pretJourService.findAll().stream()
                .filter(pj -> pj.getRole().getId().equals(roleId))
                .map(pj -> pj.getNombreJour())
                .findFirst()
                .orElse(null);
    }
}