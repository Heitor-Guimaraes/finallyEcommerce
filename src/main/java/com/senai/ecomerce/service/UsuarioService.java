package com.senai.ecomerce.service;

import com.senai.ecomerce.dto.AdminInfoResponseDto;
import com.senai.ecomerce.dto.UsuarioRequestDto;
import com.senai.ecomerce.dto.UsuarioResponseDto;
import com.senai.ecomerce.entity.Usuario;
import com.senai.ecomerce.enums.Roles;
import com.senai.ecomerce.repositories.UsuarioRepository;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private ImageStorageService imageStorageService;

    private final PasswordEncoder passwordEncoder;

    public UsuarioService(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    public List<UsuarioResponseDto> findAll() {
        return usuarioRepository.findAll().stream().map(UsuarioResponseDto::new).toList();
    }

    public AdminInfoResponseDto adminInfo(String adminEmail) {
        Usuario admin = usuarioRepository.findByEmail(adminEmail)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Usuário admin não encontrado"));

        if (admin.getRoles() != Roles.ADMIN) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Acesso permitido apenas para ADMIN");
        }

        List<UsuarioResponseDto> usuarios = findAll();

        AdminInfoResponseDto response = new AdminInfoResponseDto();
        response.setMessage("Acesso ADMIN");
        response.setAdminEmail(admin.getEmail());
        response.setTotalUsers(usuarios.size());
        response.setUsers(usuarios);

        return response;
    }

    public UsuarioResponseDto findById(UUID id) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Usuário não encontrado"));
        return new UsuarioResponseDto(usuario);
    }

    public UsuarioResponseDto create(UsuarioRequestDto dto){
        if (usuarioRepository.existsByEmail(dto.getEmail())) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Email já cadastrado");
        }

        Usuario usuario = new Usuario();
        usuario.setEmail(dto.getEmail());
        usuario.setSenha(passwordEncoder.encode(dto.getSenha()));
        usuario.setNome(dto.getNome());
        usuario.setTelefone(dto.getTelefone());
        usuario.setFotoUrl(dto.getFotoUrl());
        usuario.setRoles(Roles.USER);

        usuarioRepository.save(usuario);
        return new UsuarioResponseDto(usuario);
    }

    public UsuarioResponseDto update(UUID id, UsuarioRequestDto dto) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Usuário não encontrado"));

        String emailNovo = dto.getEmail();
        if (!usuario.getEmail().equals(emailNovo) && usuarioRepository.existsByEmail(emailNovo)) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Email já cadastrado");
        }

        usuario.setNome(dto.getNome());
        usuario.setEmail(emailNovo);
        usuario.setTelefone(dto.getTelefone());
        usuario.setSenha(passwordEncoder.encode(dto.getSenha()));
        usuario.setFotoUrl(dto.getFotoUrl());

        usuarioRepository.save(usuario);
        return new UsuarioResponseDto(usuario);
    }

    public UsuarioResponseDto adicionarImagem(UUID id, MultipartFile foto) throws IOException {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Usuário não encontrado"));

        String caminhoFoto = imageStorageService.savePhoto(foto);
        usuario.setFotoUrl(caminhoFoto);

        usuarioRepository.save(usuario);
        return new UsuarioResponseDto(usuario);
    }

    public void delete(UUID id) {
        if (!usuarioRepository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Usuário não encontrado");
        }
        try {
            usuarioRepository.deleteById(id);
        } catch (DataIntegrityViolationException ex) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Usuário está em uso e não pode ser removido", ex);
        }
    }

    public UsuarioResponseDto promoteToAdmin(UUID id) {
        Usuario usuario = usuarioRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Usuário não encontrado"));

        if (usuario.getRoles() == Roles.ADMIN) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Usuário já é ADMIN");
        }

        usuario.setRoles(Roles.ADMIN);
        usuarioRepository.save(usuario);
        return new UsuarioResponseDto(usuario);
    }

    public UsuarioResponseDto createAdmin(UsuarioRequestDto dto) {
        if (usuarioRepository.existsByEmail(dto.getEmail())) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Email já cadastrado");
        }

        Usuario admin = new Usuario();
        admin.setEmail(dto.getEmail());
        admin.setSenha(passwordEncoder.encode(dto.getSenha()));
        admin.setNome(dto.getNome());
        admin.setTelefone(dto.getTelefone());
        admin.setFotoUrl(dto.getFotoUrl());
        admin.setRoles(Roles.ADMIN);

        usuarioRepository.save(admin);
        return new UsuarioResponseDto(admin);
    }
}
