package pe.edu.uni.mecafab.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class CambioEstadoDTO {

    @NotNull
    private Integer pedidoId;

    @NotNull
    private Integer nuevoEstadoId;

    @NotNull
    private Integer usuarioResponsableId;
}
