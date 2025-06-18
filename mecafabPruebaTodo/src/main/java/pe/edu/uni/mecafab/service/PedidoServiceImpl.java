package pe.edu.uni.mecafab.service;

import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import pe.edu.uni.mecafab.dto.AsignacionPedidoDTO;
import pe.edu.uni.mecafab.dto.CambioEstadoDTO;
import pe.edu.uni.mecafab.dto.ConfirmacionEntregaDTO;
import pe.edu.uni.mecafab.dto.PedidoRequestDTO;
import pe.edu.uni.mecafab.exception.EntregaYaConfirmadaException;
import pe.edu.uni.mecafab.exception.EstadoYaAsignadoException;
import pe.edu.uni.mecafab.exception.PedidoNoEncontradoException;
import pe.edu.uni.mecafab.exception.PedidoYaEntregadoException;
import pe.edu.uni.mecafab.model.Pedido;
import pe.edu.uni.mecafab.repository.PedidoRepository;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class PedidoServiceImpl implements PedidoService {

    private final PedidoRepository pedidoRepository;

    @Override
    public void registrarPedido(PedidoRequestDTO dto) {
        pedidoRepository.insertarPedido(dto);
    }

    @Override
    public void asignarPedido(AsignacionPedidoDTO dto) {
        validarExistenciaPedido(dto.getPedidoId());
        validarPedidoYaEntregado(dto.getPedidoId());
        pedidoRepository.actualizarAsignacion(dto);
    }

    @Override
    @Transactional
    @PreAuthorize(
            "hasRole('Jefe') or (hasRole('Operario') and @estadoService.isIntermediate(#dto.nuevoEstadoId))"
    )
    public void cambiarEstado(CambioEstadoDTO dto) {
        validarExistenciaPedido(dto.getPedidoId());
        validarPedidoYaEntregado(dto.getPedidoId());
        boolean cambiado = pedidoRepository.actualizarEstadoSiEsDiferente(dto);
        if (!cambiado) {
            throw new EstadoYaAsignadoException();
        }
    }

    // SOLUCIONA Comprobante y entrega
    @Override
    public void confirmarEntrega(ConfirmacionEntregaDTO dto) {
        // 1) Valida existencia
        validarExistenciaPedido(dto.getPedidoId());

        // 2) (Opcional) evita confirmarlo dos veces
        Pedido pedido = pedidoRepository.obtenerPorId(dto.getPedidoId());
        if (pedido.isEsEntregado()) {
            throw new EntregaYaConfirmadaException(dto.getPedidoId());
        }

        // 3) Actualiza los campos de entrega
        pedidoRepository.actualizarEntrega(dto);

        // 4) Registra el comprobante
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

    //=================================================================
    //======================= VALIDACIONES ============================
    //=================================================================
    // SOLUCIONA Asignacion
    private void validarExistenciaPedido(Integer id) {
        if (!pedidoRepository.existePedidoPorId(id)) {
            throw new PedidoNoEncontradoException(id);
        }
    }

    // Para cuando se intenta cambiar el estado de un pedido que ya esta entregado
    private void validarPedidoYaEntregado(Integer id) {
        if(pedidoRepository.pedidoYaEntregado(id)) {
            throw new PedidoYaEntregadoException(id);
        }
    }

}
