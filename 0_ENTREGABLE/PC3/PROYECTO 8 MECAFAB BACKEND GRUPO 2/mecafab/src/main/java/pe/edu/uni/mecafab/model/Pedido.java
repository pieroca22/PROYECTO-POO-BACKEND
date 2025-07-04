
package pe.edu.uni.mecafab.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Pedido {
    private Integer id;
    private String codigo;
    private String descripcionProducto;
    private String tipoTrabajo;
    private LocalDate fechaSolicitud;
    private LocalDate fechaEntregaComprometida;
    private LocalDate fechaEntregaReal;
    private Integer estadoId;
    private Integer clienteId;
    private Integer operarioAsignadoId;
    private Integer usuarioCreadorId;
    private LocalDate fechaEntregaConfirmada;
    private boolean esEntregado;
}

