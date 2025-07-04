package com.bibliotheque.naina.controller;

import com.bibliotheque.naina.model.JourFerier;
import com.bibliotheque.naina.service.JourFerierService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/jour-ferier")
public class JourFerierController {
    @Autowired
    private JourFerierService jourFerierService;

    @GetMapping
    public List<JourFerier> getAll() {
        return jourFerierService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<JourFerier> getById(@PathVariable Integer id) {
        Optional<JourFerier> jourFerier = jourFerierService.findById(id);
        return jourFerier.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping
    public JourFerier create(@RequestBody JourFerier jourFerier) {
        return jourFerierService.save(jourFerier);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Integer id) {
        if (jourFerierService.findById(id).isPresent()) {
            jourFerierService.deleteById(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
