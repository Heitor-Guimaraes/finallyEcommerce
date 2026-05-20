package com.senai.ecomerce.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AdminInfoResponseDto {

    private String message;
    private String adminEmail;
    private Integer totalUsers;
    private List<UsuarioResponseDto> users;
}

