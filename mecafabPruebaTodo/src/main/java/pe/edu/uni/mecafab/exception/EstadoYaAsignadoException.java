package pe.edu.uni.mecafab.exception;

public class EstadoYaAsignadoException extends ReglaNegocioException {
    public EstadoYaAsignadoException() {
        super("El estado que se intenta asignar ya está aplicado al pedido.");
    }
}