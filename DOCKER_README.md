# Laravel con Docker Compose

Este proyecto incluye una configuración completa de Docker Compose con:
- **Nginx**: Servidor web
- **PostgreSQL**: Base de datos
- **PHP-FPM**: Servidor de aplicaciones PHP para Laravel
- **pgAdmin**: Interfaz web para administrar PostgreSQL

## Requisitos

- Docker
- Docker Compose

## Configuración inicial

1. **Copiar el archivo de configuración**:
   ```bash
   cp env.example .env
   ```

2. **Construir y levantar los contenedores**:
   ```bash
   docker-compose up -d --build
   ```

3. **Instalar dependencias de Composer** (si no se instalaron automáticamente):
   ```bash
   docker-compose exec app composer install
   ```

4. **Generar clave de aplicación**:
   ```bash
   docker-compose exec app php artisan key:generate
   ```

5. **Ejecutar migraciones**:
   ```bash
   docker-compose exec app php artisan migrate
   ```

## Acceso a los servicios

- **Aplicación Laravel**: http://localhost
- **pgAdmin (Administrador de PostgreSQL)**: http://localhost:5050
  - Email: `admin@admin.com`
  - Contraseña: `admin`
- **Base de datos PostgreSQL**: localhost:5432
  - Base de datos: `laravel_db`
  - Usuario: `laravel_user`
  - Contraseña: `laravel_password`

## Comandos útiles

### Ver logs
```bash
# Todos los servicios
docker-compose logs

# Servicio específico
docker-compose logs nginx
docker-compose logs app
docker-compose logs postgres
docker-compose logs pgadmin
```

### Ejecutar comandos en el contenedor de la aplicación
```bash
docker-compose exec app php artisan [comando]
docker-compose exec app composer [comando]
```

### Parar los servicios
```bash
docker-compose down
```

### Parar y eliminar volúmenes (incluye datos de la base de datos)
```bash
docker-compose down -v
```

## Estructura de archivos

```
├── docker-compose.yml          # Configuración principal de Docker Compose
├── Dockerfile                  # Imagen personalizada de PHP-FPM
├── docker/
│   ├── nginx/
│   │   └── conf.d/
│   │       └── app.conf        # Configuración de Nginx
│   └── php/
│       └── local.ini          # Configuración personalizada de PHP
└── env.example                # Archivo de configuración de ejemplo
```

## Notas importantes

- Los datos de PostgreSQL se almacenan en un volumen persistente
- El código de la aplicación se monta como volumen para desarrollo
- Nginx está configurado para servir archivos estáticos y procesar PHP
- La aplicación Laravel debe estar configurada para usar PostgreSQL en el archivo `.env`
- pgAdmin se ejecuta en el puerto 5050 y mantiene su configuración en un volumen persistente

## Configuración de pgAdmin

Después de acceder a pgAdmin en http://localhost:5050:

1. Inicia sesión con las credenciales por defecto:
   - Email: `admin@admin.com`
   - Contraseña: `admin`

2. Para conectar con la base de datos PostgreSQL:
   - Click derecho en "Servers" → "Register" → "Server"
   - En la pestaña "General":
     - Name: `Laravel PostgreSQL`
   - En la pestaña "Connection":
     - Host name/address: `postgres`
     - Port: `5432`
     - Maintenance database: `laravel_db`
     - Username: `laravel_user`
     - Password: `laravel_password` 