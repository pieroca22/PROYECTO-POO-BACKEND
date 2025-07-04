package pe.edu.uni.mecafab.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import pe.edu.uni.mecafab.model.Cliente;

import java.util.List;

@RestController
@RequestMapping("/api/clientes")
@RequiredArgsConstructor
public class ClienteController {

    private final JdbcTemplate jdbcTemplate;

    @GetMapping
    public ResponseEntity<List<Cliente>> listarClientes() {
        String sql = "SELECT * FROM Cliente";
        List<Cliente> clientes = jdbcTemplate.query(
                sql,
                BeanPropertyRowMapper.newInstance(Cliente.class)
        );
        return ResponseEntity.ok(clientes);
    }
}