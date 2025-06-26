package pe.edu.uni.mecafab.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(EntidadNoEncontradaException.class)
    public ResponseEntity<?> manejarEntidadNoEncontrada(EntidadNoEncontradaException ex) {
        return crearRespuesta(ex.getMessage(), "NOT_FOUND", HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(ReglaNegocioException.class)
    public ResponseEntity<?> manejarReglaNegocio(ReglaNegocioException ex) {
        return crearRespuesta(ex.getMessage(), "BUSINESS_ERROR", HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<?> manejarValidaciones(MethodArgumentNotValidException ex) {
        String errores = ex.getBindingResult().getFieldErrors().stream()
                .map(error -> error.getField() + ": " + error.getDefaultMessage())
                .collect(Collectors.joining("; "));
        return crearRespuesta(errores, "VALIDATION_ERROR", HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<?> manejarErroresGenerales(Exception ex) {
        return crearRespuesta("Error interno del servidor", "INTERNAL_ERROR", HttpStatus.INTERNAL_SERVER_ERROR);
    }

    private ResponseEntity<Map<String, Object>> crearRespuesta(String mensaje, String codigo, HttpStatus status) {
        Map<String, Object> body = new HashMap<>();
        body.put("timestamp", LocalDateTime.now());
        body.put("mensaje", mensaje);
        body.put("codigo", codigo);
        return new ResponseEntity<>(body, status);
    }
}