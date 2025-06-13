package pe.edu.uni.mecafab.service;

import pe.edu.uni.mecafab.dto.AsignacionPedidoDTO;
import pe.edu.uni.mecafab.dto.CambioEstadoDTO;
import pe.edu.uni.mecafab.dto.ConfirmacionEntregaDTO;
import pe.edu.uni.mecafab.dto.PedidoRequestDTO;
import pe.edu.uni.mecafab.model.Pedido;

import java.time.LocalDate;
import java.util.List;

public interface PedidoService {
    void registrarPedido(PedidoRequestDTO dto);
    void asignarPedido(AsignacionPedidoDTO dto);
    void cambiarEstado(CambioEstadoDTO dto);
    void confirmarEntrega(ConfirmacionEntregaDTO dto);
    List<Pedido> listarPedidos(Integer estadoId, Integer operarioId, Integer clienteId);
    List<Pedido> obtenerEntregasPorRango(LocalDate desde, LocalDate hasta);
    List<Pedido> obtenerPedidosPorVencer(int dias);
}
