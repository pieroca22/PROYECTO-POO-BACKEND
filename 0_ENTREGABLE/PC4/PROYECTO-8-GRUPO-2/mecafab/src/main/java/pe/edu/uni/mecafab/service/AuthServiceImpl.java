package pe.edu.uni.mecafab.service;

import lombok.RequiredArgsConstructor;
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
import pe.edu.uni.mecafab.model.Usuario;
import pe.edu.uni.mecafab.repository.AuthRepository;
import pe.edu.uni.mecafab.repository.PedidoRepository;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class AuthServiceImpl implements AuthService {

    private final AuthRepository authRepository;


    @Override
    public Usuario validarUsuarioContrasena(String usuario, String contrasena) {
        return authRepository.validarUsuarioContrasena(usuario, contrasena);
    }
}
