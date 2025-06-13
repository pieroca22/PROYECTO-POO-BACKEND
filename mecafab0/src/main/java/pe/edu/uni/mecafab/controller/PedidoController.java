package pe.edu.uni.mecafab.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.edu.uni.mecafab.dto.AsignacionPedidoDTO;
import pe.edu.uni.mecafab.dto.CambioEstadoDTO;
import pe.edu.uni.mecafab.dto.ConfirmacionEntregaDTO;
import pe.edu.uni.mecafab.dto.PedidoRequestDTO;
import pe.edu.uni.mecafab.model.Pedido;
import pe.edu.uni.mecafab.service.PedidoService;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/pedidos")
@RequiredArgsConstructor
public class PedidoController {

    private final PedidoService pedidoService;

    @PostMapping
    public ResponseEntity<?> registrarPedido(@Valid @RequestBody PedidoRequestDTO dto) {
        pedidoService.registrarPedido(dto);
        return ResponseEntity.ok("Pedido registrado correctamente.");
    }

    @PutMapping("/asignar")
    public ResponseEntity<?> asignarPedido(@Valid @RequestBody AsignacionPedidoDTO dto) {
        pedidoService.asignarPedido(dto);
        return ResponseEntity.ok("Pedido asignado y estado actualizado.");
    }

    @PutMapping("/cambiar-estado")
    public ResponseEntity<?> cambiarEstado(@Valid @RequestBody CambioEstadoDTO dto) {
        pedidoService.cambiarEstado(dto);
        return ResponseEntity.ok("Estado actualizado y registrado en historial.");
    }

    @PutMapping("/entregar")
    public ResponseEntity<?> confirmarEntrega(@Valid @RequestBody ConfirmacionEntregaDTO dto) {
        pedidoService.confirmarEntrega(dto);
        return ResponseEntity.ok("Entrega registrada y comprobante generado.");
    }

    @GetMapping
    public List<Pedido> listarPedidos(
            @RequestParam(required = false) Integer estadoId,
            @RequestParam(required = false) Integer operarioId,
            @RequestParam(required = false) Integer clienteId
    ) {
        return pedidoService.listarPedidos(estadoId, operarioId, clienteId);
    }

    @GetMapping("/entregas")
    public List<Pedido> entregasPorRango(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate desde,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate hasta
    ) {
        return pedidoService.obtenerEntregasPorRango(desde, hasta);
    }

    @GetMapping("/vencimientos")
    public List<Pedido> pedidosProximosAVencer(
            @RequestParam(defaultValue = "2") int dias
    ) {
        return pedidoService.obtenerPedidosPorVencer(dias);
    }
}