package pe.edu.uni.mecafab.exception;

public abstract class EntidadNoEncontradaException extends RuntimeException {
    public EntidadNoEncontradaException(String mensaje) {
        super(mensaje);
    }
}