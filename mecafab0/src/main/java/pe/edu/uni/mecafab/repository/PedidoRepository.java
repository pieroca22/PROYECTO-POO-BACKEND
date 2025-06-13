package pe.edu.uni.mecafab.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import pe.edu.uni.mecafab.dto.AsignacionPedidoDTO;
import pe.edu.uni.mecafab.dto.CambioEstadoDTO;
import pe.edu.uni.mecafab.dto.ConfirmacionEntregaDTO;
import pe.edu.uni.mecafab.dto.PedidoRequestDTO;
import pe.edu.uni.mecafab.model.Pedido;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class PedidoRepository {

    private final JdbcTemplate jdbcTemplate;

    public void insertarPedido(PedidoRequestDTO dto) {
        String sql = """
            INSERT INTO Pedido (
                codigo, descripcion_producto, tipo_trabajo, fecha_solicitud, 
                fecha_entrega_comprometida, estado_id, cliente_id, 
                operario_asignado_id, usuario_creador_id, fecha_registro, es_entregado
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), 0)
        """;
        String codigo = "PED-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        jdbcTemplate.update(sql,
                codigo,
                dto.getDescripcionProducto(),
                dto.getTipoTrabajo(),
                dto.getFechaSolicitud(),
                dto.getFechaEntregaComprometida(),
                dto.getEstadoId(),
                dto.getClienteId(),
                dto.getOperarioAsignadoId(),
                dto.getUsuarioCreadorId()
        );
    }

    public void actualizarAsignacion(AsignacionPedidoDTO dto) {
        String sql = """
            UPDATE Pedido
            SET estado_id = ?, operario_asignado_id = ?, fecha_modificacion = GETDATE()
            WHERE id = ?
        """;
        jdbcTemplate.update(sql,
                dto.getNuevoEstadoId(),
                dto.getOperarioId(),
                dto.getPedidoId()
        );
    }

    public boolean actualizarEstadoSiEsDiferente(CambioEstadoDTO dto) {
        String getEstadoSql = "SELECT estado_id FROM Pedido WHERE id = ?";
        Integer estadoActual = jdbcTemplate.queryForObject(getEstadoSql, Integer.class, dto.getPedidoId());

        if (estadoActual != null && estadoActual.equals(dto.getNuevoEstadoId())) {
            return false;
        }

        String updateSql = """
        UPDATE Pedido
        SET estado_id = ?, fecha_modificacion = GETDATE()
        WHERE id = ?
    """;
        jdbcTemplate.update(updateSql,
                dto.getNuevoEstadoId(),
                dto.getPedidoId()
        );

        insertarHistorialEstadoCompleto(dto, estadoActual);
        return true;
    }

    public void insertarHistorialEstadoCompleto(CambioEstadoDTO dto, Integer estadoAnteriorId) {
        String sql = """
            INSERT INTO HistorialEstadoPedido (pedido_id, estado_anterior_id, estado_nuevo_id, usuario_id, fecha_cambio)
            VALUES (?, ?, ?, ?, GETDATE())
        """;
        jdbcTemplate.update(sql,
                dto.getPedidoId(),
                estadoAnteriorId,
                dto.getNuevoEstadoId(),
                dto.getUsuarioResponsableId()
        );
    }

    public void actualizarEntrega(ConfirmacionEntregaDTO dto) {
        String sql = """
            UPDATE Pedido
            SET estado_id = (SELECT id FROM EstadoPedido WHERE nombre = 'Entregado'),
                es_entregado = 1,
                fecha_entrega_confirmada = ?,
                fecha_entrega_real = GETDATE(),
                fecha_modificacion = GETDATE()
            WHERE id = ?
        """;
        jdbcTemplate.update(sql,
                dto.getFechaEntregaConfirmada() != null ? Date.valueOf(dto.getFechaEntregaConfirmada()) : null,
                dto.getPedidoId()
        );
    }

    public void insertarComprobante(ConfirmacionEntregaDTO dto) {
        String sql = """
            INSERT INTO ComprobanteEntrega (pedido_id, fecha_generacion, contenido, tipo, usuario_id)
            VALUES (?, GETDATE(), ?, ?, ?)
        """;
        jdbcTemplate.update(sql,
                dto.getPedidoId(),
                dto.getContenido(),
                dto.getTipoComprobante(),
                dto.getUsuarioResponsableId()
        );
    }

    public List<Pedido> buscarPedidos(Integer estadoId, Integer operarioId, Integer clienteId) {
        StringBuilder sql = new StringBuilder("SELECT * FROM Pedido WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (estadoId != null) {
            sql.append(" AND estado_id = ?");
            params.add(estadoId);
        }

        if (operarioId != null) {
            sql.append(" AND operario_asignado_id = ?");
            params.add(operarioId);
        }

        if (clienteId != null) {
            sql.append(" AND cliente_id = ?");
            params.add(clienteId);
        }

        return jdbcTemplate.query(sql.toString(), BeanPropertyRowMapper.newInstance(Pedido.class), params.toArray());
    }

    public List<Pedido> buscarEntregasPorRango(LocalDate desde, LocalDate hasta) {
        String sql = "SELECT * FROM Pedido WHERE fecha_entrega_real BETWEEN ? AND ?";
        return jdbcTemplate.query(sql,
                BeanPropertyRowMapper.newInstance(Pedido.class),
                desde, hasta
        );
    }

    public List<Pedido> buscarPedidosPorVencer(int dias) {
        String sql = "SELECT * FROM Pedido " +
                "WHERE es_entregado = 0 " +
                "AND fecha_entrega_comprometida BETWEEN GETDATE() AND DATEADD(DAY, ?, GETDATE())";
        return jdbcTemplate.query(sql,
                BeanPropertyRowMapper.newInstance(Pedido.class),
                dias
        );
    }
}
