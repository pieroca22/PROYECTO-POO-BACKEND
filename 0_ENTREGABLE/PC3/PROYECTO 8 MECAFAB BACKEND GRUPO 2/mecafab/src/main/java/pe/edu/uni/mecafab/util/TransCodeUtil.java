package pe.edu.uni.mecafab.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class TransCodeUtil {
    // Formato año+mes, e.g. "202506"
    private static final DateTimeFormatter YM = DateTimeFormatter.ofPattern("yyyyMM");

    /**
     * Genera un código tipo "PED-202506-001" a partir del ID numérico.
     * @param id el ID secuencial del cliente
     * @return el código formateado
     */
    public static String transCodePedido(int id) {
        String ym = LocalDate.now().format(YM);
        // %03d ⇒ 3 dígitos, ceros a la izquierda
        return String.format("PED-%s-%03d", ym, id);
    }

    // ... otros métodos si los necesitas
}
