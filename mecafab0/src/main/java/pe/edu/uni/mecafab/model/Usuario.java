package pe.edu.uni.mecafab.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Usuario {
    private Integer id;
    private String nombre;
    private String correo;
    private String clave;
    private Integer rolId;
    private boolean estado;
}
