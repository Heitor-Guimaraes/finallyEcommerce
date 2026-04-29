package com.senai.ecomerce.controller;

import com.senai.ecomerce.dto.LoginRequestDto;
import com.senai.ecomerce.dto.LoginResponseDto;
import com.senai.ecomerce.dto.UsuarioResponseDto;
import com.senai.ecomerce.entity.Usuario;
import com.senai.ecomerce.repositories.UsuarioRepository;
import com.senai.ecomerce.security.JwtTokenProvider;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.util.Optional;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private JwtTokenProvider jwtTokenProvider;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping("/login")
    public ResponseEntity<LoginResponseDto> login(@Valid @RequestBody LoginRequestDto loginRequest) {
        Optional<Usuario> usuarioOpt = usuarioRepository.findByEmail(loginRequest.getEmail());

        if (usuarioOpt.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Email ou senha inválidos");
        }

        Usuario usuario = usuarioOpt.get();

        if (!passwordEncoder.matches(loginRequest.getSenha(), usuario.getSenha())) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Email ou senha inválidos");
        }

        String token = jwtTokenProvider.generateTokenByEmail(usuario.getEmail());
        UsuarioResponseDto usuarioResponseDto = new UsuarioResponseDto(usuario);

        LoginResponseDto response = new LoginResponseDto(
                token,
                "Bearer",
                86400000L,
                usuarioResponseDto
        );

        return ResponseEntity.ok(response);
    }
}

