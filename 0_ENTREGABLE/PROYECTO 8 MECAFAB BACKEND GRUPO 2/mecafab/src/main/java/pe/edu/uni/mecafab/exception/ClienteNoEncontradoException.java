package pe.edu.uni.mecafab.exception;

public class ClienteNoEncontradoException extends EntidadNoEncontradaException {
    public ClienteNoEncontradoException(Integer id) {
        super("No se encontró el cliente con ID: " + id);
    }
}