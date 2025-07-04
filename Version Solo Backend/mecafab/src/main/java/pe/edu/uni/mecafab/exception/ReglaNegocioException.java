package pe.edu.uni.mecafab.exception;

public abstract class ReglaNegocioException extends RuntimeException {
    public ReglaNegocioException(String mensaje) {
        super(mensaje);
    }
}