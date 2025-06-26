package pe.edu.uni.mecafab.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import pe.edu.uni.mecafab.model.Usuario;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class AuthRepository {

    private final JdbcTemplate jdbcTemplate;

    public Usuario validarUsuarioContrasena(String usuario, String contrasena) {
        String sql = "SELECT TOP 1 * FROM Usuario WHERE correo=? AND clave=? AND estado=1";
        return jdbcTemplate.query(sql,
                BeanPropertyRowMapper.newInstance(Usuario.class),
                usuario, contrasena
        ).stream().findFirst().orElse(null);
    }
}
