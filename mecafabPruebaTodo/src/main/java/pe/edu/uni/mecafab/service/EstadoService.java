package pe.edu.uni.mecafab.service;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service("estadoService") // Referenciable en expresiones SpEL
@RequiredArgsConstructor
public class EstadoService {
    private final JdbcTemplate jdbcTemplate;

    /**
     * Retorna true si el estado dado no es final (es_final = 0 en DB).
     */
    public boolean isIntermediate(Integer estadoId) {
        Boolean esFinal = jdbcTemplate.queryForObject(
                "SELECT es_final FROM EstadoPedido WHERE id = ?",
                Boolean.class,
                estadoId
        );
        return Boolean.FALSE.equals(esFinal);
    }
}