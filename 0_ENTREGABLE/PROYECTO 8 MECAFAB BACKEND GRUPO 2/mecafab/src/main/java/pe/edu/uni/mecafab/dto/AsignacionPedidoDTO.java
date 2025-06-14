package pe.edu.uni.mecafab.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class AsignacionPedidoDTO {

    @NotNull
    private Integer pedidoId;

    @NotNull
    private Integer operarioId;

    @NotNull
    private Integer nuevoEstadoId;
}
