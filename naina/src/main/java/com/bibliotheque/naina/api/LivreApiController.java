package com.bibliotheque.naina.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.bibliotheque.naina.model.Livre;
import com.bibliotheque.naina.model.Exemplaire;
import com.bibliotheque.naina.service.LivreService;
import com.bibliotheque.naina.service.ExemplaireService;
import java.util.*;

@RestController
@RequestMapping("/api/livres")
public class LivreApiController {
    @Autowired
    private LivreService livreService;
    @Autowired
    private ExemplaireService exemplaireService;

    @GetMapping("/{id}")
    public Map<String, Object> getLivreWithExemplaires(@PathVariable Long id) {
        Optional<Livre> optLivre = livreService.findById(id);
        if (optLivre.isEmpty()) {
            throw new org.springframework.web.server.ResponseStatusException(
                org.springframework.http.HttpStatus.NOT_FOUND, "Livre non trouvé");
        }
        Livre livre = optLivre.get();
        List<Exemplaire> exemplaires = exemplaireService.findAll();
        List<Exemplaire> exemplairesLivre = exemplaires.stream()
            .filter(ex -> ex.getLivre() != null && Objects.equals(ex.getLivre().getId(), id))
            .toList();
        Map<String, Object> result = new HashMap<>();
        result.put("livre", livre);
        result.put("exemplaires", exemplairesLivre);
        return result;
    }
}
