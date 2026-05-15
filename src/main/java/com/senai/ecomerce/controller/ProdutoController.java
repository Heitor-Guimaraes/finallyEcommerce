package com.senai.ecomerce.controller;

import com.senai.ecomerce.dto.ProdutoRequestDto;
import com.senai.ecomerce.dto.ProdutoResponseDto;
import com.senai.ecomerce.service.ProdutoService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("produto")
public class ProdutoController {

    @Autowired
    private ProdutoService produtoService;

    @GetMapping("/user/")
    public List<ProdutoResponseDto> findAll() {
        return produtoService.findAll();
    }

    @GetMapping("/user/{id}")
    public ProdutoResponseDto findById(@PathVariable UUID id) {
        return produtoService.findById(id);
    }

    @PostMapping("/user/")
    @ResponseStatus(HttpStatus.CREATED)
    public ProdutoResponseDto create(@Valid @RequestBody ProdutoRequestDto dto) {
        return produtoService.create(dto);
    }

    @PutMapping("/user/{id}")
    public ProdutoResponseDto update(@PathVariable UUID id, @Valid @RequestBody ProdutoRequestDto dto) {
        return produtoService.update(id, dto);
    }

    @DeleteMapping("/user/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable UUID id) {
        produtoService.delete(id);
    }

    @PostMapping("/user/{id}/imagem")
    public ResponseEntity<?> adicionarImagem(@PathVariable UUID id, @RequestParam MultipartFile foto) throws IOException {
        ProdutoResponseDto produtoAtualizado = produtoService.adicionarImagem(id, foto);
        return ResponseEntity.ok(produtoAtualizado);
    }

}
