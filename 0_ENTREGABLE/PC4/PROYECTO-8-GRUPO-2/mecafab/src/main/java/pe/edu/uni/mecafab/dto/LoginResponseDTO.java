package pe.edu.uni.mecafab.dto;


import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class LoginResponseDTO {
    private int user;
    private String token;
    private String nombre;
    private String correo;
    private int rol;
}