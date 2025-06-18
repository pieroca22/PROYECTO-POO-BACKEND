package pe.edu.uni.mecafab.exception;

public class PedidoYaEntregadoException extends ReglaNegocioException {
    public PedidoYaEntregadoException(Integer id) {
        super("El pedido ya está entregado.");
    }
}