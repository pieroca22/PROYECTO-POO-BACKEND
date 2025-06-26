package pe.edu.uni.mecafab.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;

@Data
public class ConfirmacionEntregaDTO {

    @NotNull
    private Integer pedidoId;

    @NotNull
    private Integer usuarioResponsableId;

    @NotNull
    private LocalDate fechaEntregaConfirmada;

    @NotBlank
    private String tipoComprobante;

    @NotBlank
    private String contenido;
}
