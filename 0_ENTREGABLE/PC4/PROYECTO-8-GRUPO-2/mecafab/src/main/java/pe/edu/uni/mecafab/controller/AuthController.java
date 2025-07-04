package pe.edu.uni.mecafab.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.edu.uni.mecafab.dto.LoginRequestDTO;
import pe.edu.uni.mecafab.dto.LoginResponseDTO;
import pe.edu.uni.mecafab.model.Usuario;
import pe.edu.uni.mecafab.service.AuthService;
import pe.edu.uni.mecafab.util.JwtUtil;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final JwtUtil jwtUtil;
    private final AuthService authService;

    @PostMapping("/login")
    public ResponseEntity<LoginResponseDTO> login(@RequestBody LoginRequestDTO request) {
        String username = request.getUsername();
        String password = request.getPassword();

        Usuario usuario = authService.validarUsuarioContrasena(username, password);

        if (usuario != null) {
            String token = jwtUtil.generateToken(username);
            LoginResponseDTO loginResponseDTO =
                    new LoginResponseDTO(usuario.getId(), token,
                            usuario.getNombre(), usuario.getCorreo(), usuario.getRolId());

            return ResponseEntity.ok(loginResponseDTO);
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
    }
}
