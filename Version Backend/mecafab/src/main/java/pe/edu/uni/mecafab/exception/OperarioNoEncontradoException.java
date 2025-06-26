package pe.edu.uni.mecafab.exception;

public class OperarioNoEncontradoException extends EntidadNoEncontradaException {
    public OperarioNoEncontradoException(Integer id) {
        super("No se encontró el operario con ID: " + id);
    }
}