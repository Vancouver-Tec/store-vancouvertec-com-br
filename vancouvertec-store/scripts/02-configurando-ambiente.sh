#!/bin/bash

# ===========================================
# VancouverTec Store - Configuração Ambiente
# Script: 02-configurando-ambiente.sh
# Versão: 1.0.1 (CORRIGIDO)
# ===========================================

set -euo pipefail

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variáveis do projeto
PROJECT_DIR="vancouvertec-store"
DB_LOCAL_NAME="vt_store_db"
DB_LOCAL_USER="root"
DB_LOCAL_PASS="12345678"
DB_LOCAL_HOST="127.0.0.1"
WORDPRESS_URL="https://wordpress.org/latest.zip"

# Função para log colorido
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Função de cleanup em caso de erro
cleanup() {
    if [[ -f "latest.zip" ]]; then
        rm -f latest.zip
    fi
    if [[ -d "wordpress" ]]; then
        rm -rf wordpress
    fi
}

# Trap para cleanup
trap cleanup ERR EXIT

# Banner do projeto
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║          VancouverTec Store Builder          ║
║     🔧 Configurando Ambiente Local 🔧       ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar se estamos no diretório correto
if [[ ! -d "$PROJECT_DIR" ]]; then
    log_error "Diretório '$PROJECT_DIR' não encontrado!"
    log_error "Execute primeiro: ./01-criando-estrutura-projeto.sh"
    exit 1
fi

log_info "Iniciando configuração do ambiente de desenvolvimento..."

# Verificar dependências
log_info "Verificando dependências do sistema..."

# Verificar MySQL
if ! command -v mysql &> /dev/null; then
    log_error "MySQL não encontrado! Instale MySQL/MariaDB primeiro."
    exit 1
fi

# Verificar se MySQL está rodando
if ! mysqladmin ping -h"$DB_LOCAL_HOST" -u"$DB_LOCAL_USER" -p"$DB_LOCAL_PASS" &> /dev/null; then
    log_error "MySQL não está rodando ou credenciais incorretas!"
    log_error "Verifique se o MySQL está ativo e as credenciais estão corretas:"
    log_error "Host: $DB_LOCAL_HOST | User: $DB_LOCAL_USER | Pass: $DB_LOCAL_PASS"
    exit 1
fi

# Verificar wget ou curl
if ! command -v wget &> /dev/null && ! command -v curl &> /dev/null; then
    log_error "wget ou curl não encontrados!"
    exit 1
fi

# Verificar unzip
if ! command -v unzip &> /dev/null; then
    log_error "unzip não encontrado!"
    exit 1
fi

log_success "Todas as dependências verificadas!"

# Entrar no diretório do projeto
cd "$PROJECT_DIR"

# Backup do wp-content existente
log_info "Fazendo backup do wp-content existente..."
BACKUP_NAME="wp-content-backup-$(date +%Y%m%d-%H%M%S)"
if [[ -d "wp-content" ]]; then
    cp -r wp-content "$BACKUP_NAME"
    log_success "Backup do wp-content criado: $BACKUP_NAME"
fi

# Download do WordPress
log_info "Baixando WordPress core..."
if command -v wget &> /dev/null; then
    wget -q --show-progress "$WORDPRESS_URL" -O latest.zip
else
    curl -L "$WORDPRESS_URL" -o latest.zip
fi

log_success "WordPress baixado com sucesso!"

# Extrair WordPress
log_info "Extraindo WordPress..."
unzip -q latest.zip

# Mover arquivos do WordPress preservando wp-content
log_info "Configurando estrutura do WordPress..."

# Primeiro, mover arquivos do core do WordPress (exceto wp-content)
log_info "Copiando arquivos do WordPress core..."
find wordpress -maxdepth 1 -not -name wp-content -not -name wordpress -exec cp -r {} . \; 2>/dev/null || true

# Remover pasta wordpress temporária
rm -rf wordpress

# Remover wp-content padrão que veio do WordPress
if [[ -d "wp-content" ]] && [[ ! -f "wp-content/.vt-custom" ]]; then
    log_info "Removendo wp-content padrão do WordPress..."
    rm -rf wp-content
fi

# Restaurar nosso wp-content customizado
if [[ -d "$BACKUP_NAME" ]]; then
    log_info "Restaurando wp-content customizado..."
    mv "$BACKUP_NAME" wp-content
    # Marcar como customizado para próximas execuções
    touch wp-content/.vt-custom
    log_success "wp-content customizado restaurado!"
elif [[ ! -d "wp-content" ]]; then
    log_error "wp-content não encontrado! Execute primeiro: ./01-criando-estrutura-projeto.sh"
    exit 1
fi

log_success "Estrutura WordPress configurada!"

# Configurar banco de dados local
log_info "Configurando banco de dados local..."

# Criar banco se não existir
mysql -h"$DB_LOCAL_HOST" -u"$DB_LOCAL_USER" -p"$DB_LOCAL_PASS" -e "CREATE DATABASE IF NOT EXISTS \`$DB_LOCAL_NAME\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" 2>/dev/null

# Testar conexão
if mysql -h"$DB_LOCAL_HOST" -u"$DB_LOCAL_USER" -p"$DB_LOCAL_PASS" "$DB_LOCAL_NAME" -e "SELECT 1;" &> /dev/null; then
    log_success "Banco de dados '$DB_LOCAL_NAME' configurado e conectado!"
else
    log_error "Falha na conexão com o banco de dados!"
    exit 1
fi

# Gerar salts de segurança
log_info "Gerando chaves de segurança..."
SALTS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)

# Criar wp-config.php
log_info "Criando wp-config.php otimizado..."
cat > wp-config.php << EOF
<?php
/**
 * VancouverTec Store - WordPress Configuration
 * Environment: Local/Production Auto-Switch
 * Generated: $(date)
 */

// Environment Configuration
define('VT_ENV', 'local'); // Alterado automaticamente no deploy

// Database Configuration
if (VT_ENV === 'local') {
    define('DB_NAME', '$DB_LOCAL_NAME');
    define('DB_USER', '$DB_LOCAL_USER');
    define('DB_PASSWORD', '$DB_LOCAL_PASS');
    define('DB_HOST', '$DB_LOCAL_HOST');
    define('WP_DEBUG', true);
    define('WP_DEBUG_LOG', true);
    define('WP_DEBUG_DISPLAY', false);
    define('SCRIPT_DEBUG', true);
} else {
    define('DB_NAME', 'vancouvertec-store');
    define('DB_USER', 'vancouvertec-store');
    define('DB_PASSWORD', 'VeNWJAL1JCOQr2h2ohw5');
    define('DB_HOST', '127.0.0.1:3306');
    define('WP_DEBUG', false);
    define('WP_DEBUG_LOG', false);
    define('WP_DEBUG_DISPLAY', false);
    define('SCRIPT_DEBUG', false);
}

define('DB_CHARSET', 'utf8mb4');
define('DB_COLLATE', '');

// Security Keys
$SALTS

// WordPress Table Prefix
\$table_prefix = 'vt_';

// VancouverTec Specific Constants
define('VT_STORE_VERSION', '1.0.0');
define('VT_STORE_URL', VT_ENV === 'local' ? 'http://localhost/vancouvertec-store' : 'https://store.vancouvertec.com.br');
define('VT_API_ENDPOINT', '/wp-json/vt/v1');

// Performance & Security
define('AUTOMATIC_UPDATER_DISABLED', true);
define('WP_AUTO_UPDATE_CORE', false);
define('DISALLOW_FILE_EDIT', true);
define('WP_POST_REVISIONS', 3);
define('AUTOSAVE_INTERVAL', 300);
define('WP_CACHE', true);
define('COMPRESS_CSS', true);
define('COMPRESS_SCRIPTS', true);
define('ENFORCE_GZIP', true);

// Memory & Upload Limits
define('WP_MEMORY_LIMIT', '512M');
define('WP_MAX_MEMORY_LIMIT', '512M');

// Security
define('DISALLOW_UNFILTERED_HTML', true);
define('ALLOW_UNFILTERED_UPLOADS', false);

// WordPress URLs
if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

require_once ABSPATH . 'wp-settings.php';
EOF

log_success "wp-config.php criado com configurações otimizadas!"

# Criar .htaccess otimizado
log_info "Criando .htaccess otimizado..."
cat > .htaccess << 'EOF'
# VancouverTec Store - .htaccess Optimized
# Performance & Security Configuration

# Security Headers
<IfModule mod_headers.c>
    Header always set X-Content-Type-Options "nosniff"
    Header always set X-Frame-Options "SAMEORIGIN"  
    Header always set X-XSS-Protection "1; mode=block"
    Header always set Referrer-Policy "strict-origin-when-cross-origin"
    Header always set Permissions-Policy "geolocation=(), microphone=(), camera=()"
</IfModule>

# WordPress Permalinks
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>

# Performance - Cache Static Files
<IfModule mod_expires.c>
ExpiresActive On
ExpiresByType text/css "access plus 1 year"
ExpiresByType application/javascript "access plus 1 year"
ExpiresByType application/x-javascript "access plus 1 year"
ExpiresByType text/javascript "access plus 1 year"
ExpiresByType image/png "access plus 1 year"
ExpiresByType image/jpg "access plus 1 year"
ExpiresByType image/jpeg "access plus 1 year"
ExpiresByType image/gif "access plus 1 year"
ExpiresByType image/svg+xml "access plus 1 year"
ExpiresByType application/pdf "access plus 1 month"
ExpiresByType text/html "access plus 1 hour"
</IfModule>

# Compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/css
    AddOutputFilterByType DEFLATE application/javascript
    AddOutputFilterByType DEFLATE application/x-javascript
    AddOutputFilterByType DEFLATE text/javascript
    AddOutputFilterByType DEFLATE text/html
    AddOutputFilterByType DEFLATE application/json
    AddOutputFilterByType DEFLATE application/xml
    AddOutputFilterByType DEFLATE text/xml
</IfModule>

# Security - Block Access to Sensitive Files
<FilesMatch "(wp-config\.php|\.htaccess|\.htpasswd)">
    Order deny,allow
    Deny from all
</FilesMatch>

# Block xmlrpc.php
<Files xmlrpc.php>
    Order deny,allow
    Deny from all
</Files>

# Disable Directory Browsing
Options -Indexes

# Protect wp-content
<IfModule mod_rewrite.c>
RewriteCond %{REQUEST_URI} !^/wp-content/plugins/file/to/exclude\.php
RewriteCond %{REQUEST_URI} !^/wp-content/themes/file/to/exclude\.php
RewriteRule wp-content/plugins/(.*\.php)$ - [R=404,L]
RewriteRule wp-content/themes/(.*\.php)$ - [R=404,L]
</IfModule>
EOF

log_success ".htaccess otimizado criado!"

# Testar instalação WordPress
log_info "Testando instalação WordPress..."

# Verificar se conseguimos conectar ao banco
php -r "
try {
    \$mysqli = new mysqli('$DB_LOCAL_HOST', '$DB_LOCAL_USER', '$DB_LOCAL_PASS', '$DB_LOCAL_NAME');
    if (\$mysqli->connect_error) {
        throw new Exception('Connection failed: ' . \$mysqli->connect_error);
    }
    echo 'Database connection successful!';
    \$mysqli->close();
} catch (Exception \$e) {
    echo 'Database connection failed: ' . \$e->getMessage();
    exit(1);
}
" >/dev/null

log_success "Teste de conexão com banco bem-sucedido!"

# Criar script de configuração rápida do WordPress
log_info "Criando script de setup WordPress..."
cat > ../setup-wordpress.sh << 'EOF'
#!/bin/bash
# VancouverTec Store - WordPress Quick Setup

echo "🚀 Configurando WordPress VancouverTec Store..."

# Navegar para o diretório
cd vancouvertec-store

# Instalar WordPress via WP-CLI (se disponível)
if command -v wp &> /dev/null; then
    echo "📦 Instalando WordPress via WP-CLI..."
    wp core install \
        --url="http://localhost/vancouvertec-store" \
        --title="VancouverTec Store" \
        --admin_user="admin" \
        --admin_password="admin123" \
        --admin_email="admin@vancouvertec.com.br" \
        --skip-email
    
    echo "🎨 Ativando tema VancouverTec Store..."
    wp theme activate vancouvertec-store
    
    echo "🔌 Ativando plugin VancouverTec Digital Manager..."
    wp plugin activate vancouvertec-digital-manager
    
    echo "✅ WordPress configurado com sucesso!"
    echo "🌐 URL: http://localhost/vancouvertec-store"
    echo "👤 Admin: admin / admin123"
else
    echo "⚠️  WP-CLI não encontrado. Configure manualmente:"
    echo "🌐 Acesse: http://localhost/vancouvertec-store"
    echo "🔐 Use as credenciais do banco configuradas"
fi
EOF

chmod +x ../setup-wordpress.sh
log_success "Script de setup WordPress criado!"

# Cleanup final
log_info "Limpando arquivos temporários..."
rm -f latest.zip
rm -f wp-config-sample.php

# Configurar permissões
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;
chmod 600 wp-config.php
chmod 644 .htaccess

log_success "Permissões configuradas!"

# Relatório final
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║            🎉 AMBIENTE CONFIGURADO! 🎉       ║"
echo -e "║         Pronto para desenvolvimento          ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "WordPress Core: Instalado e integrado"
log_success "Banco Local: $DB_LOCAL_NAME (configurado)"
log_success "wp-config.php: Criado com VT_ENV=local"
log_success "wp-content: Preservado e integrado"
log_success ".htaccess: Otimizado para performance"

echo -e "\n${CYAN}📋 Estrutura Final:${NC}"
echo "├── wp-admin/ (WordPress core)"
echo "├── wp-includes/ (WordPress core)"  
echo "├── wp-content/"
echo "│   ├── themes/vancouvertec-store/"
echo "│   └── plugins/vancouvertec-digital-manager/"
echo "├── wp-config.php (VT_ENV=local)"
echo "├── index.php"
echo "└── .htaccess"

echo -e "\n${YELLOW}🚀 Próximos Passos:${NC}"
echo "1. Configure seu servidor local (Apache/Nginx)"
echo "2. Execute: ../setup-wordpress.sh"
echo "3. Acesse: http://localhost/vancouvertec-store"
echo "4. Para deploy: chmod +x scripts/03-deploy-local-vps.sh"

echo -e "\n${PURPLE}💾 Credenciais do Banco:${NC}"
echo "Host: $DB_LOCAL_HOST"
echo "Database: $DB_LOCAL_NAME"  
echo "Username: $DB_LOCAL_USER"
echo "Password: [configurado]"

echo -e "\n${GREEN}✅ Ambiente local idêntico à produção VPS!${NC}"
log_success "Script 02 concluído com sucesso!"

exit 0