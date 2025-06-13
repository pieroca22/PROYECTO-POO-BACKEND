package pe.edu.uni.mecafab.exception;

public class EntregaYaConfirmadaException extends ReglaNegocioException {
    public EntregaYaConfirmadaException(Integer id) {
        super("La entrega del pedido con ID " + id + " ya fue confirmada.");
    }
}