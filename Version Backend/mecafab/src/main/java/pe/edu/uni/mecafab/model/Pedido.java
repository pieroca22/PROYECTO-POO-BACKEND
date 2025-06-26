
package pe.edu.uni.mecafab.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
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

    /**
     * Fecha en que el sistema registra la entrega física del pedido.
     * Se asigna automáticamente con GETDATE() al confirmar la entrega.
     */
    @JsonIgnore // Evitarla es mejor (por ahora)
    private LocalDate fechaEntregaReal;

    /**
     * Fecha que el encargado (jefe de taller) anota como día en que el cliente recibió el pedido.
     * Puede coincidir con fechaEntregaReal o diferir según el registro manual.
     */
    private LocalDate fechaEntregaConfirmada;

    private Integer estadoId;
    private Integer clienteId;
    private Integer operarioAsignadoId;
    private Integer usuarioCreadorId;
    private boolean esEntregado;
}

