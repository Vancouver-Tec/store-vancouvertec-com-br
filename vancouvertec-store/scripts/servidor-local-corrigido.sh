#!/bin/bash

# ===========================================
# VancouverTec Store - Servidor Local CORRIGIDO
# Script: servidor-local-corrigido.sh
# Versão: 1.1.0 - Bugs Corrigidos
# ===========================================

set -euo pipefail

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Variáveis
PROJECT_PATH="/home/$(whoami)/vancouvertec/store-vancouvertec-com-br/vancouvertec-store"
SERVER_PORT="8080"
WP_CLI_PHAR="https://github.com/wp-cli/wp-cli/releases/download/v2.8.1/wp-cli-2.8.1.phar"

# Função para log colorido
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║       🌐 Servidor Local VancouverTec 🌐       ║
║         Configuração WSL + WordPress         ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar se o projeto existe
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Projeto não encontrado em: $PROJECT_PATH"
    log_info "Execute primeiro: ./setup-completo-vancouvertec-store.sh"
    exit 1
fi

log_success "Projeto encontrado!"

# Verificar PHP
log_info "Verificando PHP..."
if ! command -v php &> /dev/null; then
    log_error "PHP não encontrado!"
    log_info "Execute: ./instalar-dependencias-wsl.sh"
    exit 1
fi

PHP_VERSION=$(php -v | head -n1 | cut -d " " -f 2 | cut -d "." -f 1,2)
log_success "PHP $PHP_VERSION encontrado"

# Verificar MySQL
log_info "Verificando conexão MySQL..."
if ! mysqladmin ping -h127.0.0.1 -uroot -p12345678 &> /dev/null; then
    log_warning "MySQL não conecta. Tentando iniciar..."
    sudo service mysql start &>/dev/null || true
    sleep 2
    
    if ! mysqladmin ping -h127.0.0.1 -uroot -p12345678 &> /dev/null; then
        log_error "MySQL não conecta! Execute: sudo service mysql start"
        exit 1
    fi
fi
log_success "MySQL conectado"

# Navegar para o projeto
cd "$PROJECT_PATH"
log_info "Entrando no diretório: $(pwd)"

# Verificar estrutura WordPress
if [[ ! -f "wp-config.php" ]]; then
    log_error "wp-config.php não encontrado!"
    log_info "Execute primeiro: ./setup-completo-vancouvertec-store.sh"
    exit 1
fi

# Corrigir WP-CLI se necessário
log_info "Verificando WP-CLI..."
if ! wp --info &>/dev/null; then
    log_warning "WP-CLI com problemas. Reinstalando..."
    
    sudo rm -f /usr/local/bin/wp 2>/dev/null || true
    curl -O "$WP_CLI_PHAR" -L --silent --show-error
    chmod +x wp-cli-2.8.1.phar
    sudo mv wp-cli-2.8.1.phar /usr/local/bin/wp
    
    if ! wp --info &>/dev/null; then
        log_warning "WP-CLI não funcional. Continuando sem ele..."
        WP_CLI_BROKEN=true
    else
        log_success "WP-CLI corrigido!"
    fi
else
    log_success "WP-CLI funcionando"
fi

# Configurar WordPress (manual se WP-CLI quebrado)
if [[ "${WP_CLI_BROKEN:-false}" != "true" ]]; then
    log_info "Verificando instalação WordPress..."
    
    if ! wp core is-installed --allow-root &>/dev/null; then
        log_info "Instalando WordPress..."
        
        wp core install \
            --url="http://localhost:$SERVER_PORT" \
            --title="VancouverTec Store - Soluções Digitais" \
            --admin_user="admin" \
            --admin_password="admin123" \
            --admin_email="admin@vancouvertec.com.br" \
            --skip-email \
            --allow-root &>/dev/null || {
                log_warning "Instalação automática falhou. Configure manualmente."
            }
        
        # Tentar ativar tema e plugin
        wp theme activate vancouvertec-store --allow-root &>/dev/null || log_warning "Ative o tema manualmente"
        wp plugin activate vancouvertec-digital-manager --allow-root &>/dev/null || log_warning "Ative o plugin manualmente"
        
        log_success "WordPress configurado!"
    else
        log_success "WordPress já instalado"
    fi
else
    log_warning "Configure WordPress manualmente em: http://localhost:$SERVER_PORT"
fi

# Verificar se a porta está livre
log_info "Verificando porta $SERVER_PORT..."
if lsof -Pi :$SERVER_PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
    log_warning "Porta $SERVER_PORT ocupada!"
    
    # Tentar matar processo anterior
    PIDS=$(lsof -Pi :$SERVER_PORT -sTCP:LISTEN -t 2>/dev/null || true)
    if [[ -n "$PIDS" ]]; then
        log_info "Matando processos anteriores..."
        kill $PIDS &>/dev/null || true
        sleep 2
    fi
    
    # Se ainda estiver ocupada, usar porta alternativa
    if lsof -Pi :$SERVER_PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
        SERVER_PORT="8081"
        log_warning "Usando porta alternativa: $SERVER_PORT"
    fi
fi

# Criar .htaccess otimizado para desenvolvimento
log_info "Criando .htaccess para desenvolvimento..."
cat > .htaccess << 'EOF'
# VancouverTec Store - Development .htaccess
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>

# Security Headers (when available)
<IfModule mod_headers.c>
    Header always set X-Content-Type-Options "nosniff"
    Header always set X-Frame-Options "SAMEORIGIN"
</IfModule>

# Performance (when available)
<IfModule mod_expires.c>
ExpiresActive On
ExpiresByType text/css "access plus 1 day"
ExpiresByType application/javascript "access plus 1 day"
ExpiresByType image/png "access plus 1 week"
ExpiresByType image/jpg "access plus 1 week"
ExpiresByType image/jpeg "access plus 1 week"
ExpiresByType image/gif "access plus 1 week"
</IfModule>
EOF

# Função para parar o servidor
cleanup_server() {
    if [[ -n "${SERVER_PID:-}" ]] && kill -0 $SERVER_PID 2>/dev/null; then
        log_info "Parando servidor (PID: $SERVER_PID)..."
        kill $SERVER_PID &>/dev/null || true
    fi
    exit 0
}
trap cleanup_server INT TERM

# Iniciar servidor PHP
log_info "Iniciando servidor PHP em localhost:$SERVER_PORT..."

# Criar arquivo de log do servidor
SERVER_LOG="/tmp/vt-server-$SERVER_PORT.log"
echo "VancouverTec Server Log - $(date)" > "$SERVER_LOG"

# Iniciar servidor em background
php -S localhost:$SERVER_PORT -t . >> "$SERVER_LOG" 2>&1 &
SERVER_PID=$!

log_info "Servidor iniciado (PID: $SERVER_PID)"

# Aguardar servidor inicializar
log_info "Aguardando servidor inicializar..."
for i in {1..10}; do
    if curl -s "http://localhost:$SERVER_PORT" > /dev/null 2>&1; then
        break
    fi
    sleep 1
    if [[ $i -eq 10 ]]; then
        log_error "Servidor não responde após 10 segundos"
        log_info "Log do servidor:"
        tail -5 "$SERVER_LOG" 2>/dev/null || echo "Log não disponível"
        cleanup_server
    fi
done

# Verificar se o servidor está realmente rodando
if ! kill -0 $SERVER_PID 2>/dev/null; then
    log_error "Servidor parou inesperadamente!"
    log_info "Últimas linhas do log:"
    tail -10 "$SERVER_LOG" 2>/dev/null || echo "Log não disponível"
    exit 1
fi

# Testar conexão final
log_info "Testando conexão..."
if curl -s -I "http://localhost:$SERVER_PORT" | head -1 | grep -q "200\|302"; then
    log_success "Servidor respondendo!"
else
    log_warning "Servidor pode ter problemas de configuração"
fi

# Exibir informações finais
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║      🎉 SERVIDOR LOCAL FUNCIONANDO! 🎉       ║"
echo -e "║            Acesse seu projeto!               ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

echo -e "${CYAN}🌐 URLs de Acesso:${NC}"
echo -e "   Frontend: ${GREEN}http://localhost:$SERVER_PORT${NC}"
echo -e "   Admin:    ${GREEN}http://localhost:$SERVER_PORT/wp-admin${NC}"
echo -e "   PhpInfo:  ${GREEN}http://localhost:$SERVER_PORT/wp-admin/admin.php?page=health-check${NC}"

echo -e "\n${YELLOW}👤 Credenciais Admin:${NC}"
echo -e "   Usuário: ${GREEN}admin${NC}"
echo -e "   Senha:   ${GREEN}admin123${NC}"

echo -e "\n${PURPLE}💾 Informações Técnicas:${NC}"
echo -e "   PHP: $(php -v | head -1 | cut -d ' ' -f 2 | cut -d '.' -f 1,2)"
echo -e "   MySQL: 127.0.0.1/vt_store_db"
echo -e "   PID: $SERVER_PID"

echo -e "\n${BLUE}📁 Estrutura:${NC}"
echo -e "   Projeto: $PROJECT_PATH"
echo -e "   Tema: wp-content/themes/vancouvertec-store/"
echo -e "   Plugin: wp-content/plugins/vancouvertec-digital-manager/"

echo -e "\n${YELLOW}⚡ Controles:${NC}"
echo -e "   Para parar: ${RED}Ctrl+C${NC}"
echo -e "   Log do servidor: tail -f $SERVER_LOG"
echo -e "   Reiniciar: execute este script novamente"

echo -e "\n${CYAN}🔧 Troubleshooting:${NC}"
echo -e "   • Se não carregar: verifique PHP errors no log"
echo -e "   • Se 404: verifique .htaccess e permissões"
echo -e "   • Se lento: normal em PHP built-in server"

log_success "Servidor rodando! Pressione Ctrl+C para parar..."

# Loop principal para manter o servidor ativo
while true; do
    # Verificar se o servidor ainda está rodando
    if ! kill -0 $SERVER_PID 2>/dev/null; then
        log_error "Servidor parou inesperadamente!"
        log_info "Últimas linhas do log:"
        tail -5 "$SERVER_LOG" 2>/dev/null || echo "Log não disponível"
        break
    fi
    
    sleep 2
done

cleanup_server