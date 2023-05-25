#!/bin/bash

log_file="script.log"
max_retries=10
retry_interval=3

# Function to log messages to a file
log_message() {
    message="$1"
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $message" >> "$log_file"
}

# Function to check if MySQL is up
check_mysql() {
    log_message "Checking MySQL connection..."
    attempt=0
    while [[ $attempt -lt $max_retries ]]; do
        if mysql -h"$MYSQL_HOST" -u"$MYSQL_ADMIN_USER" -p"$MYSQL_ADMIN_PASS" -e "SELECT 1;" &>/dev/null; then
            log_message "MySQL connection successful."
            return 0
        fi
        log_message "MySQL connection attempt $((attempt + 1)) failed. Retrying in $retry_interval seconds..."
        sleep "$retry_interval"
        ((attempt++))
    done
    log_message "Maximum retries reached. Failed to establish a connection to MySQL."
    return 1
}

# Run the script
log_message "Script execution started."

# Check MySQL connection
check_mysql || exit 1

# Continue with the remaining commands
log_message "Running wp commands..."
wp core download --allow-root
wp config create --dbname="$MYSQL_DB" --dbuser="$MYSQL_ADMIN_USER" --dbpass="$MYSQL_ADMIN_PASS" --dbhost="$MYSQL_HOST" --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PS" --admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root
wp user create "$WP_USER" "$WP_USER_EMAIL" --user_pass="$WP_USER_PS" --role=author --allow-root
wp theme install twentyseventeen --activate --allow-root
wp plugin update --all --allow-root

# Start the PHP-FPM service with the desired options
log_message "Starting PHP-FPM..."
php-fpm8.1 --nodaemonize

log_message "Script execution completed."
