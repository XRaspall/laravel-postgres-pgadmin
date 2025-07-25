# Laravel with Docker Compose

This project includes a complete Docker Compose configuration with:
- **Nginx**: Web server
- **PostgreSQL**: Database
- **PHP-FPM**: PHP application server for Laravel
- **pgAdmin**: Web interface to manage PostgreSQL

## Requirements

- Docker
- Docker Compose

## Initial setup

1. **Copy the configuration file**:
   ```bash
   cp env.example .env
   ```

2. **Build and start the containers**:
   ```bash
   docker-compose up -d --build
   ```

3. **Install Composer dependencies** (if not installed automatically):
   ```bash
   docker-compose exec app composer install
   ```

4. **Generate application key**:
   ```bash
   docker-compose exec app php artisan key:generate
   ```

5. **Run migrations**:
   ```bash
   docker-compose exec app php artisan migrate
   ```

## Service access

- **Laravel Application**: http://localhost
- **pgAdmin (PostgreSQL Manager)**: http://localhost:5050
  - Email: `admin@admin.com`
  - Password: `admin`
- **PostgreSQL Database**: localhost:5432
  - Database: `laravel_db`
  - Username: `laravel_user`
  - Password: `laravel_password`

## Useful commands

### View logs
```bash
# All services
docker-compose logs

# Specific service
docker-compose logs nginx
docker-compose logs app
docker-compose logs postgres
docker-compose logs pgadmin
```

### Run commands in the application container
```bash
docker-compose exec app php artisan [command]
docker-compose exec app composer [command]
```

### Stop services
```bash
docker-compose down
```

### Stop and remove volumes (includes database data)
```bash
docker-compose down -v
```

## File structure

```
├── docker-compose.yml          # Main Docker Compose configuration
├── Dockerfile                  # Custom PHP-FPM image
├── docker/
│   ├── nginx/
│   │   └── conf.d/
│   │       └── app.conf        # Nginx configuration
│   └── php/
│       └── local.ini          # Custom PHP configuration
└── env.example                # Configuration example file
```

## Important notes

- PostgreSQL data is stored in a persistent volume
- Application code is mounted as a volume for development
- Nginx is configured to serve static files and process PHP
- The Laravel application must be configured to use PostgreSQL in the `.env` file
- pgAdmin runs on port 5050 and maintains its configuration in a persistent volume

## pgAdmin Configuration

After accessing pgAdmin at http://localhost:5050:

1. Log in with default credentials:
   - Email: `admin@admin.com`
   - Password: `admin`

2. To connect to the PostgreSQL database:
   - Right-click on "Servers" → "Register" → "Server"
   - In the "General" tab:
     - Name: `Laravel PostgreSQL`
   - In the "Connection" tab:
     - Host name/address: `postgres`
     - Port: `5432`
     - Maintenance database: `laravel_db`
     - Username: `laravel_user`
     - Password: `laravel_password` 