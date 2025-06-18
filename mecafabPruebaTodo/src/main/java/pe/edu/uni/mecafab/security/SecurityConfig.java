package pe.edu.uni.mecafab.security;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableMethodSecurity  // Habilita @PreAuthorize en servicios
public class SecurityConfig {

    /**
     * Para demo rápido con texto plano.
     * En producción, cambia a BCryptPasswordEncoder y guarda hashes.
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return NoOpPasswordEncoder.getInstance();
    }

    /**
     * JDBC-based userDetails: lee correo, clave y estado de Usuario
     * y roles (CONCAT('ROLE_', nombre)) de la tabla Rol.
     */
    @Bean
    public UserDetailsService users(DataSource dataSource) {
        JdbcUserDetailsManager manager = new JdbcUserDetailsManager(dataSource);
        manager.setUsersByUsernameQuery(
                "SELECT correo, clave, estado FROM Usuario WHERE correo = ?"
        );
        manager.setAuthoritiesByUsernameQuery(
                "SELECT u.correo, CONCAT('ROLE_', r.nombre) " +
                        "FROM Usuario u JOIN Rol r ON u.rol_id = r.id " +
                        "WHERE u.correo = ?"
        );
        return manager;
    }

    /**
     * Configuración de acceso:
     * 1) Recursos estáticos y página index.html → público
     * 2) GET /api/pedidos/** → Jefe u Operario
     * 3) PUT /api/pedidos/cambiar-estado → sólo Operario
     * 4) Cualquier otro /api/** → sólo Jefe
     * 5) Resto de rutas → autenticado
     */
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(auth -> auth
                        // 1) frontend
                        .requestMatchers(
                                "/",
                                "/index.html",
                                "/css/**",
                                "/js/**",
                                "/favicon.ico"
                        ).permitAll()

                        // 2) listar pedidos
                        .requestMatchers(HttpMethod.GET, "/api/pedidos/**")
                        .hasAnyRole("Jefe", "Operario")

                        // 3) cambiar estado (operario)
                        .requestMatchers(HttpMethod.PUT, "/api/pedidos/cambiar-estado")
                        .hasRole("Operario")

                        // 4) resto de API → sólo jefe
                        .requestMatchers("/api/**")
                        .hasRole("Jefe")

                        // 5) cualquier otra ruta → autenticado
                        .anyRequest().authenticated()
                )
                .httpBasic(Customizer.withDefaults());

        return http.build();
    }
}
