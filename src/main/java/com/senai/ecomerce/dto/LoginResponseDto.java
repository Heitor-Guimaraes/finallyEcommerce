package com.senai.ecomerce.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class LoginResponseDto {

    private String token;
    private String type = "Bearer";
    private Long expiresIn;
    private UsuarioResponseDto usuario;
}

