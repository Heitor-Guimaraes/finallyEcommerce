package com.senai.ecomerce.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UsuarioRequestDto {

    @NotBlank
    private String nome;

    @NotBlank
    @Email
    private String email;

    private String telefone;

    @NotBlank
    private String senha;

    private String fotoUrl;

}
