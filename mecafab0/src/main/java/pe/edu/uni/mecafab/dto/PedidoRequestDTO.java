package pe.edu.uni.mecafab.dto;

import jakarta.validation.constraints.*;
import lombok.Data;

import java.time.LocalDate;

@Data
public class PedidoRequestDTO {

    @NotBlank
    private String descripcionProducto;

    @NotBlank
    private String tipoTrabajo;

    @NotNull
    @PastOrPresent //cambiaso (soluciona el fecha solicitud y generar pedidos sin operario asignado)
    private LocalDate fechaSolicitud;

    @NotNull
    @Future
    private LocalDate fechaEntregaComprometida;

    @NotNull
    private Integer estadoId;

    @NotNull
    private Integer clienteId;

    @NotNull
    private Integer usuarioCreadorId;

    private Integer operarioAsignadoId;
}
