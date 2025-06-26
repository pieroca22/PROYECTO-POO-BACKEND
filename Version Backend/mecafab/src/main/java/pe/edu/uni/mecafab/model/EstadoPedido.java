package pe.edu.uni.mecafab.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EstadoPedido {
    private Integer id;
    private String nombre;
    private Integer ordenLogico;
    private boolean esFinal;
}
