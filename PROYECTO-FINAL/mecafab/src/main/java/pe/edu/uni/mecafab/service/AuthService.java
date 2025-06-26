package pe.edu.uni.mecafab.service;

import pe.edu.uni.mecafab.dto.AsignacionPedidoDTO;
import pe.edu.uni.mecafab.dto.CambioEstadoDTO;
import pe.edu.uni.mecafab.dto.ConfirmacionEntregaDTO;
import pe.edu.uni.mecafab.dto.PedidoRequestDTO;
import pe.edu.uni.mecafab.model.Pedido;
import pe.edu.uni.mecafab.model.Usuario;

import java.time.LocalDate;
import java.util.List;

public interface AuthService {
    Usuario validarUsuarioContrasena(String usuario, String contrasena);
}
