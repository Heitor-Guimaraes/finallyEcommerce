package com.senai.ecomerce.controller;

import com.senai.ecomerce.dto.UsuarioRequestDto;
import com.senai.ecomerce.dto.UsuarioResponseDto;
import com.senai.ecomerce.service.UsuarioService;
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
@RequestMapping("usuario")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/user")
    public List<UsuarioResponseDto> findAll() {
        return usuarioService.findAll();
    }

    @GetMapping("/user/{id}")
    public UsuarioResponseDto findById(@PathVariable UUID id) {
        return usuarioService.findById(id);
    }

    @PostMapping("/user")
    @ResponseStatus(HttpStatus.CREATED)
    public UsuarioResponseDto create(@Valid @RequestBody UsuarioRequestDto dto){
        return usuarioService.create(dto);
    }

    @PutMapping("/user/{id}")
    public UsuarioResponseDto update(@PathVariable UUID id, @Valid @RequestBody UsuarioRequestDto dto) {
        return usuarioService.update(id, dto);
    }

    @DeleteMapping("/user/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable UUID id) {
        usuarioService.delete(id);
    }

    @PostMapping("/user/{id}/imagem")
    public ResponseEntity<?> adicionarImagem(@PathVariable UUID id, @RequestParam MultipartFile foto) throws IOException {
        UsuarioResponseDto usuarioAtualizado = usuarioService.adicionarImagem(id, foto);
        return ResponseEntity.ok(usuarioAtualizado);
    }

    @GetMapping("/admin")
    public String admin(){
        return "Acesso ADMIN";
    }

}
