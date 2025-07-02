package com.bibliotheque.naina.service;

import com.bibliotheque.naina.model.Mode;
import com.bibliotheque.naina.repository.ModeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ModeService {

    @Autowired
    private ModeRepository modeRepository;

    public List<Mode> findAll() {
        return modeRepository.findAll();
    }

    public Optional<Mode> findById(Long id) {
        return modeRepository.findById(id);
    }

    public Mode save(Mode mode) {
        return modeRepository.save(mode);
    }

    public void deleteById(Long id) {
        modeRepository.deleteById(id);
    }
}