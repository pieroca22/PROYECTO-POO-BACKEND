package pe.edu.uni.mecafab.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;

@Data
public class ConfirmacionEntregaDTO {

    @NotNull
    private Integer pedidoId;

    @NotNull
    private Integer usuarioResponsableId;

    private LocalDate fechaEntregaConfirmada;

    private String tipoComprobante;

    private String contenido;
}
