package pe.edu.uni.mecafab.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import pe.edu.uni.mecafab.dto.AsignacionPedidoDTO;
import pe.edu.uni.mecafab.dto.CambioEstadoDTO;
import pe.edu.uni.mecafab.dto.ConfirmacionEntregaDTO;
import pe.edu.uni.mecafab.dto.PedidoRequestDTO;
import pe.edu.uni.mecafab.model.Pedido;
import pe.edu.uni.mecafab.util.TransCodeUtil;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class PedidoRepository {

    private final JdbcTemplate jdbcTemplate;

    public void insertarPedido(PedidoRequestDTO dto) {
        // 1. SQL sin el código
        String sql = """
        INSERT INTO Pedido (
            descripcion_producto, tipo_trabajo, fecha_solicitud,
            fecha_entrega_comprometida, estado_id, cliente_id,
            operario_asignado_id, usuario_creador_id, fecha_registro, es_entregado
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), 0)
    """;

        KeyHolder keyHolder = new GeneratedKeyHolder();

        // 2. Ejecuta el INSERT y captura el ID generado
        jdbcTemplate.update((Connection con) -> {
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, dto.getDescripcionProducto());
            ps.setString(2, dto.getTipoTrabajo());
            ps.setObject(3, dto.getFechaSolicitud());
            ps.setObject(4, dto.getFechaEntregaComprometida());
            ps.setInt(5, dto.getEstadoId());
            ps.setInt(6, dto.getClienteId());
            if(dto.getOperarioAsignadoId()!=null)
                ps.setInt(7, dto.getOperarioAsignadoId());
            else
                ps.setNull(7, Types.INTEGER);
            ps.setInt(8, dto.getUsuarioCreadorId());
            return ps;
        }, keyHolder);










        // 3. Recupera el ID
        Integer nuevoId = keyHolder.getKey().intValue();

        // 4. Genera el código con tu utilitario
        String codigo = TransCodeUtil.transCodePedido(nuevoId);

        // 5. Actualiza sólo la columna 'codigo'
        String updateSql = "UPDATE Pedido SET codigo = ? WHERE id = ?";
        jdbcTemplate.update(updateSql, codigo, nuevoId);
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

    // SOLUCIONA Asignacion
    public boolean existePedidoPorId(Integer id) {
        String sql = "SELECT COUNT(1) FROM Pedido WHERE id = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, id);
        return count != null && count > 0;
    }

    // SOLUCIONA Comprobante y entrega
    public Pedido obtenerPorId(Integer id) {
        String sql = "SELECT * FROM Pedido WHERE id = ?";
        return jdbcTemplate.queryForObject(
                sql,
                BeanPropertyRowMapper.newInstance(Pedido.class),
                id
        );
    }


}
