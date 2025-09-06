#!/bin/bash

# ===========================================
# VancouverTec Store - Correção Admin WordPress
# Script: 02a-corrigir-admin-wordpress.sh
# Versão: 1.0.0 - Corrige URLs do painel admin
# ===========================================

set -euo pipefail

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Variáveis
PROJECT_PATH="/home/$(whoami)/vancouvertec/store-vancouvertec-com-br/vancouvertec-store"
ROUTER_FILE="router.php"

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║       🔧 Correção Admin WordPress 🔧         ║
║      Resolvendo URLs quebradas do admin      ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Projeto não encontrado em: $PROJECT_PATH"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Corrigindo em: $(pwd)"

# Parar servidor atual
log_info "Parando servidor atual..."
pkill -f "php -S localhost:8080" || true
sleep 2

# Criar router.php para corrigir URLs do admin
log_info "Criando router.php personalizado..."
cat > "$ROUTER_FILE" << 'EOF'
<?php
/**
 * VancouverTec Store - Custom PHP Router
 * Corrige URLs do WordPress admin para servidor built-in
 */

$request_uri = $_SERVER['REQUEST_URI'];
$parsed_url = parse_url($request_uri);
$path = $parsed_url['path'];

// Log para debug
error_log("Router VT: " . $request_uri);

// Redirecionar URLs do admin sem /wp-admin/
if (preg_match('/^\/([a-z-]+\.php)/', $path, $matches)) {
    $file = $matches[1];
    $admin_files = [
        'themes.php', 'plugins.php', 'options-general.php', 
        'users.php', 'tools.php', 'upload.php', 'edit.php',
        'post-new.php', 'edit-tags.php', 'nav-menus.php',
        'customize.php', 'widgets.php', 'options-writing.php',
        'options-reading.php', 'options-discussion.php',
        'options-media.php', 'options-permalink.php'
    ];
    
    if (in_array($file, $admin_files)) {
        $redirect_url = '/wp-admin/' . $file;
        if (!empty($parsed_url['query'])) {
            $redirect_url .= '?' . $parsed_url['query'];
        }
        
        header("Location: $redirect_url", true, 302);
        error_log("Router VT: Redirecionando $path para $redirect_url");
        exit;
    }
}

// Arquivos estáticos
if (preg_match('/\.(css|js|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$/', $path)) {
    $file_path = __DIR__ . $path;
    if (file_exists($file_path)) {
        $mime_types = [
            'css' => 'text/css',
            'js' => 'application/javascript',
            'png' => 'image/png',
            'jpg' => 'image/jpeg',
            'jpeg' => 'image/jpeg',
            'gif' => 'image/gif',
            'ico' => 'image/x-icon',
            'svg' => 'image/svg+xml',
            'woff' => 'font/woff',
            'woff2' => 'font/woff2',
            'ttf' => 'font/ttf',
            'eot' => 'application/vnd.ms-fontobject'
        ];
        
        $extension = pathinfo($file_path, PATHINFO_EXTENSION);
        if (isset($mime_types[$extension])) {
            header('Content-Type: ' . $mime_types[$extension]);
        }
        
        readfile($file_path);
        return false;
    }
}

// Verificar se é arquivo PHP válido
$file_path = __DIR__ . $path;
if ($path !== '/' && file_exists($file_path) && pathinfo($file_path, PATHINFO_EXTENSION) === 'php') {
    return false; // Deixar o PHP processar
}

// Tudo o mais vai para o WordPress
if (!file_exists(__DIR__ . '/index.php')) {
    http_response_code(404);
    echo '404 - WordPress index.php não encontrado';
    return false;
}

// Deixar WordPress processar
return false;
EOF

# Corrigir wp-config.php com URLs corretas
log_info "Corrigindo wp-config.php..."
if [[ -f "wp-config.php" ]]; then
    # Fazer backup
    cp wp-config.php wp-config-backup-$(date +%Y%m%d-%H%M%S).php
    
    # Adicionar configurações de URL se não existirem
    if ! grep -q "WP_HOME" wp-config.php; then
        log_info "Adicionando configurações de URL..."
        sed -i "/define.*WP_DEBUG/a\\
\\
/* URLs Configuration */\\
define('WP_HOME', 'http://localhost:8080');\\
define('WP_SITEURL', 'http://localhost:8080');\\
define('FORCE_SSL_ADMIN', false);\\
" wp-config.php
    fi
fi

# Corrigir .htaccess para desenvolvimento
log_info "Atualizando .htaccess..."
cat > .htaccess << 'EOF'
# VancouverTec Store - Development .htaccess
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /

# WordPress Admin URLs
RewriteRule ^(themes|plugins|options-|users|tools|upload|edit|post-new|edit-tags|nav-menus|customize|widgets)\.php$ wp-admin/$1.php [R=302,L]

# Standard WordPress rules
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>

# Performance headers
<IfModule mod_headers.c>
    Header always set X-Content-Type-Options "nosniff"
    Header always set X-Frame-Options "SAMEORIGIN"
</IfModule>

# Cache static files
<IfModule mod_expires.c>
ExpiresActive On
ExpiresByType text/css "access plus 1 day"
ExpiresByType application/javascript "access plus 1 day"
ExpiresByType image/png "access plus 1 week"
ExpiresByType image/jpg "access plus 1 week"
ExpiresByType image/jpeg "access plus 1 week"
ExpiresByType image/gif "access plus 1 week"
ExpiresByType image/svg+xml "access plus 1 week"
</IfModule>
EOF

# Verificar se o WordPress está configurado corretamente
log_info "Verificando configuração WordPress..."
if [[ ! -f "wp-config.php" ]]; then
    log_error "wp-config.php não encontrado!"
    exit 1
fi

if [[ ! -f "index.php" ]]; then
    log_error "index.php não encontrado!"
    exit 1
fi

if [[ ! -d "wp-admin" ]]; then
    log_error "Diretório wp-admin não encontrado!"
    exit 1
fi

# Iniciar servidor com router personalizado
log_info "Iniciando servidor com router personalizado..."
php -S localhost:8080 -t . "$ROUTER_FILE" > /tmp/vt-server-8080-fixed.log 2>&1 &
SERVER_PID=$!

# Aguardar inicialização
log_info "Aguardando servidor inicializar..."
sleep 3

# Verificar se está rodando
if kill -0 $SERVER_PID 2>/dev/null; then
    log_success "Servidor rodando com PID: $SERVER_PID"
else
    log_error "Falha ao iniciar servidor!"
    log_info "Log do servidor:"
    tail -5 /tmp/vt-server-8080-fixed.log 2>/dev/null || echo "Log não disponível"
    exit 1
fi

# Testar URLs administrativas
log_info "Testando correções..."
sleep 2

# Verificar se o admin carrega
if curl -s -I "http://localhost:8080/wp-admin/" | head -1 | grep -E "(200|302|301)" > /dev/null; then
    log_success "Admin WordPress acessível!"
else
    log_warning "Admin pode ter problemas. Verifique manualmente."
fi

# Relatório final
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║        ✅ ADMIN WORDPRESS CORRIGIDO! ✅       ║"
echo -e "║       URLs do painel agora funcionam!        ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

echo -e "${YELLOW}🔧 CORREÇÕES APLICADAS:${NC}"
echo -e "✅ Router PHP personalizado criado"
echo -e "✅ wp-config.php com URLs corretas" 
echo -e "✅ .htaccess otimizado para desenvolvimento"
echo -e "✅ Redirecionamentos automáticos para /wp-admin/"

echo -e "\n${BLUE}🌐 ACESSO AO PAINEL:${NC}"
echo -e "Admin: ${GREEN}http://localhost:8080/wp-admin/${NC}"
echo -e "Login: ${GREEN}admin${NC} / ${GREEN}admin123${NC}"

echo -e "\n${PURPLE}📋 PÁGINAS QUE FUNCIONAM AGORA:${NC}"
echo -e "• /themes.php → /wp-admin/themes.php"
echo -e "• /plugins.php → /wp-admin/plugins.php"  
echo -e "• /options-general.php → /wp-admin/options-general.php"
echo -e "• E todas as outras páginas do admin!"

echo -e "\n${CYAN}🔍 DEBUGGING:${NC}"
echo -e "Log servidor: ${YELLOW}tail -f /tmp/vt-server-8080-fixed.log${NC}"
echo -e "Log router: ${YELLOW}tail -f /tmp/vt-server-8080-fixed.log | grep 'Router VT'${NC}"

log_success "Teste agora: http://localhost:8080/wp-admin/themes.php"
log_info "Pressione Ctrl+C para parar o servidor quando terminar"

# Loop para manter servidor ativo
while true; do
    if ! kill -0 $SERVER_PID 2>/dev/null; then
        log_error "Servidor parou!"
        break
    fi
    sleep 5
done

exit 0