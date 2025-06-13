package pe.edu.uni.mecafab.exception;

public class PedidoNoEncontradoException extends EntidadNoEncontradaException {
    public PedidoNoEncontradoException(Integer id) {
        super("No se encontró el pedido con ID: " + id);
    }
}