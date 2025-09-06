#!/bin/bash

# ===========================================
# VancouverTec Store - Servidor Local WSL
# Script: servidor-local-vancouvertec.sh
# Versão: 1.0.0 - Configuração Servidor Local
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
WP_CLI_URL="https://raw.githubusercontent.com/wp-cli/wp-cli/v2.8.1/utils/wp-completion.bash"
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
    log_info "Instale com: sudo apt update && sudo apt install php php-mysql php-mbstring php-xml php-gd php-curl"
    exit 1
fi

PHP_VERSION=$(php -v | head -n1 | cut -d " " -f 2 | cut -d "." -f 1,2)
log_success "PHP $PHP_VERSION encontrado"

# Instalar WP-CLI se necessário
log_info "Verificando WP-CLI..."
if ! command -v wp &> /dev/null || [[ $(wp --version 2>/dev/null | head -c3) == "404" ]]; then
    log_warning "WP-CLI não instalado ou corrompido. Instalando..."
    
    # Remover WP-CLI corrompido
    sudo rm -f /usr/local/bin/wp 2>/dev/null || true
    
    # Baixar WP-CLI
    curl -O "$WP_CLI_PHAR" -L --silent --show-error
    chmod +x wp-cli-2.8.1.phar
    sudo mv wp-cli-2.8.1.phar /usr/local/bin/wp
    
    # Testar instalação
    if wp --info &>/dev/null; then
        log_success "WP-CLI instalado com sucesso!"
    else
        log_error "Falha na instalação do WP-CLI"
        exit 1
    fi
else
    log_success "WP-CLI já instalado"
fi

# Verificar MySQL
log_info "Verificando conexão MySQL..."
if ! mysqladmin ping -h127.0.0.1 -uroot -p12345678 &> /dev/null; then
    log_error "MySQL não conecta! Verifique se o serviço está rodando:"
    log_info "sudo service mysql start"
    exit 1
fi
log_success "MySQL conectado"

# Navegar para o projeto
cd "$PROJECT_PATH"
log_info "Entrando no diretório: $(pwd)"

# Verificar se WordPress já está configurado
if wp core is-installed &>/dev/null; then
    log_warning "WordPress já configurado!"
    
    read -p "Deseja reconfigurar? (s/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Ss]$ ]]; then
        log_info "Resetando configuração..."
        wp db reset --yes
    else
        log_info "Pulando configuração inicial..."
        SKIP_INSTALL=true
    fi
fi

# Configurar WordPress se necessário
if [[ "${SKIP_INSTALL:-false}" != "true" ]]; then
    log_info "Configurando WordPress..."
    
    # Configuração básica
    wp core install \
        --url="http://localhost:$SERVER_PORT" \
        --title="VancouverTec Store - Soluções Digitais para o seu Negócio" \
        --admin_user="admin" \
        --admin_password="admin123" \
        --admin_email="admin@vancouvertec.com.br" \
        --skip-email \
        --allow-root 2>/dev/null || {
            log_warning "Configuração manual necessária. Continuando..."
        }
    
    # Ativar tema e plugin
    wp theme activate vancouvertec-store --allow-root 2>/dev/null || log_warning "Tema não ativado automaticamente"
    wp plugin activate vancouvertec-digital-manager --allow-root 2>/dev/null || log_warning "Plugin não ativado automaticamente"
    
    # Configurações extras do WordPress
    wp option update blogname "VancouverTec Store" --allow-root 2>/dev/null
    wp option update blogdescription "Soluções Digitais para o seu Negócio" --allow-root 2>/dev/null
    wp option update permalink_structure "/%postname%/" --allow-root 2>/dev/null
    wp rewrite flush --allow-root 2>/dev/null
    
    log_success "WordPress configurado!"
fi

# Função para parar o servidor
cleanup_server() {
    log_info "Parando servidor..."
    kill $SERVER_PID 2>/dev/null || true
    exit 0
}
trap cleanup_server INT TERM

# Iniciar servidor PHP embutido
log_info "Iniciando servidor local na porta $SERVER_PORT..."

# Verificar se a porta está livre
if lsof -Pi :$SERVER_PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
    log_warning "Porta $SERVER_PORT já em uso!"
    read -p "Usar porta alternativa 8081? (S/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        SERVER_PORT="8081"
    else
        log_error "Escolha uma porta livre e tente novamente"
        exit 1
    fi
fi

# Criar arquivo .htaccess para desenvolvimento se não existir
if [[ ! -f ".htaccess" ]]; then
    cat > .htaccess << 'EOF'
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>
EOF
fi

# Iniciar servidor
php -S localhost:$SERVER_PORT -t . > /dev/null 2>&1 &
SERVER_PID=$!

# Aguardar servidor inicializar
sleep 2

# Testar se o servidor está rodando
if curl -s "http://localhost:$SERVER_PORT" > /dev/null; then
    log_success "Servidor rodando!"
else
    log_error "Falha ao iniciar servidor"
    exit 1
fi

# Exibir informações finais
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║      🎉 SERVIDOR LOCAL CONFIGURADO! 🎉       ║"
echo -e "║            Acesse seu projeto!               ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

echo -e "${CYAN}🌐 URLs de Acesso:${NC}"
echo -e "   Frontend: ${GREEN}http://localhost:$SERVER_PORT${NC}"
echo -e "   Admin:    ${GREEN}http://localhost:$SERVER_PORT/wp-admin${NC}"

echo -e "\n${YELLOW}👤 Credenciais Admin:${NC}"
echo -e "   Usuário: ${GREEN}admin${NC}"
echo -e "   Senha:   ${GREEN}admin123${NC}"

echo -e "\n${PURPLE}💾 Banco de Dados:${NC}"
echo -e "   Host: 127.0.0.1"
echo -e "   Banco: vt_store_db"
echo -e "   Usuário: root"

echo -e "\n${BLUE}📁 Projeto:${NC} $PROJECT_PATH"

echo -e "\n${YELLOW}⚡ Para parar o servidor: Ctrl+C${NC}"
echo -e "${CYAN}🔄 Para reiniciar: execute este script novamente${NC}\n"

log_info "Servidor rodando... Pressione Ctrl+C para parar"

# Loop para manter o servidor ativo
while kill -0 $SERVER_PID 2>/dev/null; do
    sleep 1
done

log_info "Servidor parado."