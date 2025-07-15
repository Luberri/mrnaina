package com.bibliotheque.naina.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.bibliotheque.naina.model.Adherent;
import com.bibliotheque.naina.service.AdherentService;
import java.util.Optional;

@RestController
@RequestMapping("/api/adherants")
public class AdherantApiController {
    @Autowired
    private AdherentService adherentService;

    @GetMapping("/{id}")
    public Adherent getAdherantInfo(@PathVariable Long id) {
        Optional<Adherent> optAdh = adherentService.findById(id);
        if (optAdh.isEmpty()) {
            throw new org.springframework.web.server.ResponseStatusException(
                org.springframework.http.HttpStatus.NOT_FOUND, "Adhérent non trouvé");
        }
        return optAdh.get();
    }
}
