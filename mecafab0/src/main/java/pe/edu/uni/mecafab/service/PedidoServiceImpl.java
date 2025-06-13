package pe.edu.uni.mecafab.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pe.edu.uni.mecafab.dto.AsignacionPedidoDTO;
import pe.edu.uni.mecafab.dto.CambioEstadoDTO;
import pe.edu.uni.mecafab.dto.ConfirmacionEntregaDTO;
import pe.edu.uni.mecafab.dto.PedidoRequestDTO;
import pe.edu.uni.mecafab.exception.EntregaYaConfirmadaException;
import pe.edu.uni.mecafab.exception.EstadoYaAsignadoException;
import pe.edu.uni.mecafab.exception.PedidoNoEncontradoException;
import pe.edu.uni.mecafab.model.Pedido;
import pe.edu.uni.mecafab.repository.PedidoRepository;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class PedidoServiceImpl implements PedidoService {

    private final PedidoRepository pedidoRepository;

    @Override
    public void registrarPedido(PedidoRequestDTO dto) {
        pedidoRepository.insertarPedido(dto);
    }

    @Override
    public void asignarPedido(AsignacionPedidoDTO dto) {
        validarExistenciaPedido(dto.getPedidoId());
        pedidoRepository.actualizarAsignacion(dto);
    }

    @Override
    public void cambiarEstado(CambioEstadoDTO dto) {
        validarExistenciaPedido(dto.getPedidoId());
        boolean cambiado = pedidoRepository.actualizarEstadoSiEsDiferente(dto);
        if (!cambiado) {
            throw new EstadoYaAsignadoException();
        }
    }

    @Override
    public void confirmarEntrega(ConfirmacionEntregaDTO dto) {
        Pedido pedido = obtenerPedido(dto.getPedidoId());
        if (pedido.isEsEntregado()) {
            throw new EntregaYaConfirmadaException(dto.getPedidoId());
        }
        pedidoRepository.actualizarEntrega(dto);
        pedidoRepository.insertarComprobante(dto);
    }

    @Override
    public List<Pedido> listarPedidos(Integer estadoId, Integer operarioId, Integer clienteId) {
        return pedidoRepository.buscarPedidos(estadoId, operarioId, clienteId);
    }

    @Override
    public List<Pedido> obtenerEntregasPorRango(LocalDate desde, LocalDate hasta) {
        return pedidoRepository.buscarEntregasPorRango(desde, hasta);
    }

    @Override
    public List<Pedido> obtenerPedidosPorVencer(int dias) {
        return pedidoRepository.buscarPedidosPorVencer(dias);
    }

    private Pedido obtenerPedido(Integer id) {
        return pedidoRepository.buscarPedidos(id, null, null).stream()
                .findFirst()
                .orElseThrow(() -> new PedidoNoEncontradoException(id));
    }

    private void validarExistenciaPedido(Integer id) {
        if (pedidoRepository.buscarPedidos(id, null, null).isEmpty()) {
            throw new PedidoNoEncontradoException(id);
        }
    }
}
