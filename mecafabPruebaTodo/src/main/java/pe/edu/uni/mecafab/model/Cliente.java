package pe.edu.uni.mecafab.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cliente {
    private Integer id;
    private String nombreRazonSocial;
    private String documento;
    private String telefono;
    private String correo;
    private String direccion;
}
