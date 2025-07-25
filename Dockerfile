FROM php:8.2-fpm

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql mbstring exif pcntl bcmath gd zip

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Crear usuario para la aplicación
RUN useradd -G www-data,root -u 1000 -d /home/laravel laravel
RUN mkdir -p /home/laravel/.composer && \
    chown -R laravel:laravel /home/laravel

# Establecer directorio de trabajo
WORKDIR /var/www/html

# Copiar archivos del proyecto
COPY . /var/www/html

# Cambiar propietario de los archivos
RUN chown -R laravel:laravel /var/www/html

# Instalar dependencias de Composer
RUN composer install --no-dev --optimize-autoloader

# Generar clave de aplicación
RUN php artisan key:generate

# Cambiar al usuario laravel
USER laravel

# Exponer puerto 9000 para PHP-FPM
EXPOSE 9000

# Comando por defecto
CMD ["php-fpm"] 