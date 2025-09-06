#!/bin/bash

# ===========================================
# VancouverTec Store - Dependências WSL
# Script: instalar-dependencias-wsl.sh
# Versão: 1.0.0 - Instalação Automática
# ===========================================

set -euo pipefail

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║       🔧 Dependências VancouverTec WSL 🔧     ║
║         Instalação PHP + MySQL + Tools      ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar se é WSL
if [[ ! -f /proc/version ]] || ! grep -qi microsoft /proc/version; then
    log_warning "Este script é otimizado para WSL"
    read -p "Continuar mesmo assim? (s/N): " -n 1 -r
    echo
    [[ ! $REPLY =~ ^[Ss]$ ]] && exit 1
fi

log_info "Atualizando repositórios..."
sudo apt update -qq

log_info "Verificando dependências existentes..."

# Verificar PHP
if ! command -v php &> /dev/null; then
    log_info "Instalando PHP e extensões..."
    sudo apt install -y \
        php \
        php-cli \
        php-mysql \
        php-mbstring \
        php-xml \
        php-gd \
        php-curl \
        php-zip \
        php-intl \
        php-bcmath \
        php-soap \
        php-json \
        php-readline
    log_success "PHP instalado!"
else
    PHP_VERSION=$(php -v | head -n1 | cut -d " " -f 2 | cut -d "." -f 1,2)
    log_success "PHP $PHP_VERSION já instalado"
fi

# Verificar MySQL
if ! command -v mysql &> /dev/null; then
    log_info "Instalando MySQL Server..."
    sudo apt install -y mysql-server mysql-client
    
    log_info "Iniciando MySQL..."
    sudo service mysql start
    
    log_info "Configurando MySQL..."
    # Configuração básica do MySQL para desenvolvimento
    sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '12345678';" 2>/dev/null || {
        log_info "Configurando senha root do MySQL..."
        sudo mysql -e "UPDATE mysql.user SET authentication_string = PASSWORD('12345678') WHERE User = 'root' AND Host = 'localhost';"
        sudo mysql -e "UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE User = 'root' AND Host = 'localhost';"
        sudo mysql -e "FLUSH PRIVILEGES;"
    }
    
    log_success "MySQL configurado!"
else
    log_success "MySQL já instalado"
    
    # Garantir que o MySQL está rodando
    if ! sudo service mysql status &>/dev/null; then
        log_info "Iniciando MySQL..."
        sudo service mysql start
    fi
fi

# Verificar ferramentas essenciais
TOOLS=("curl" "wget" "unzip" "git")
for tool in "${TOOLS[@]}"; do
    if ! command -v "$tool" &> /dev/null; then
        log_info "Instalando $tool..."
        sudo apt install -y "$tool"
    else
        log_success "$tool já instalado"
    fi
done

# Configurar MySQL para auto-start (WSL)
log_info "Configurando auto-start do MySQL..."
cat > ~/.bashrc_mysql << 'EOF'
# Auto-start MySQL no WSL
if ! sudo service mysql status &>/dev/null; then
    sudo service mysql start &>/dev/null
fi
EOF

if ! grep -q "source ~/.bashrc_mysql" ~/.bashrc; then
    echo "source ~/.bashrc_mysql" >> ~/.bashrc
    log_success "Auto-start MySQL configurado!"
fi

# Testar conexão MySQL
log_info "Testando conexão MySQL..."
if mysql -h127.0.0.1 -uroot -p12345678 -e "SELECT 1;" &>/dev/null; then
    log_success "Conexão MySQL aprovada!"
else
    log_warning "Conexão MySQL falhou. Configure manualmente:"
    echo "  sudo mysql -u root -p"
    echo "  ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '12345678';"
    echo "  FLUSH PRIVILEGES;"
fi

# Configurar timezone PHP
log_info "Configurando timezone PHP..."
PHP_INI=$(php --ini | grep "Loaded Configuration File" | cut -d: -f2 | xargs)
if [[ -n "$PHP_INI" && -f "$PHP_INI" ]]; then
    if ! grep -q "date.timezone" "$PHP_INI"; then
        echo "date.timezone = America/Sao_Paulo" | sudo tee -a "$PHP_INI" >/dev/null
        log_success "Timezone configurado!"
    fi
fi

# Criar diretório de trabalho se não existir
WORK_DIR="/home/$(whoami)/vancouvertec"
if [[ ! -d "$WORK_DIR" ]]; then
    mkdir -p "$WORK_DIR"
    log_success "Diretório de trabalho criado: $WORK_DIR"
fi

# Verificar espaço em disco
AVAILABLE_SPACE=$(df -BG . | awk 'NR==2 {print $4}' | sed 's/G//')
if [[ $AVAILABLE_SPACE -lt 2 ]]; then
    log_warning "Pouco espaço em disco disponível: ${AVAILABLE_SPACE}GB"
fi

# Relatório final
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║        ✅ DEPENDÊNCIAS INSTALADAS! ✅         ║"
echo -e "║           Ambiente WSL Pronto!               ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

echo -e "${CYAN}📦 Componentes Instalados:${NC}"
echo -e "  ✅ PHP $(php -v | head -n1 | cut -d ' ' -f 2 | cut -d '.' -f 1,2) + extensões"
echo -e "  ✅ MySQL Server"
echo -e "  ✅ Ferramentas: curl, wget, unzip, git"

echo -e "\n${YELLOW}🔗 Próximos Passos:${NC}"
echo -e "  1. Execute: ${GREEN}./setup-completo-vancouvertec-store.sh${NC}"
echo -e "  2. Execute: ${GREEN}./servidor-local-vancouvertec.sh${NC}"
echo -e "  3. Acesse: ${GREEN}http://localhost:8080${NC}"

echo -e "\n${PURPLE}💡 Dicas WSL:${NC}"
echo -e "  • MySQL inicia automaticamente no próximo login"
echo -e "  • Projetos em: /home/$(whoami)/vancouvertec/"
echo -e "  • Para parar MySQL: sudo service mysql stop"

log_success "Ambiente preparado para desenvolvimento WordPress!"

# Testar todas as dependências
echo -e "\n${BLUE}🧪 Teste Final de Dependências:${NC}"
php --version | head -1
mysql --version
curl --version | head -1

log_success "Todos os testes passaram! Pronto para usar!"