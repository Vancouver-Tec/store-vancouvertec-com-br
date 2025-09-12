#!/bin/bash

# ===========================================
# VancouverTec Store - Variáveis CSS Fix
# Script: 31l-variaveis-css-fix.sh
# Versão: 1.0.0 - Corrigir variáveis CSS que estão faltando
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
THEME_PATH="wp-content/themes/vancouvertec-store"

# Funções de log
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║        🔧 VARIÁVEIS CSS FIX 🔧               ║
║    Problema identificado: Variáveis CSS     ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar base
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Projeto não encontrado: $PROJECT_PATH"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Corrigindo variáveis CSS em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost:8080" > /dev/null; then
    log_warning "Parando servidor..."
    pkill -f "php -S localhost:8080" || true
    sleep 2
fi

# PROBLEMA IDENTIFICADO: FALTAM AS VARIÁVEIS CSS!
log_warning "PROBLEMA IDENTIFICADO: Os CSS usam variáveis que não existem!"
log_info "Todos os arquivos CSS usam var(--vt-blue-600) mas as variáveis não estão definidas"

# 1. ADICIONAR VARIÁVEIS CSS NO STYLE.CSS
log_info "Adicionando variáveis CSS no style.css..."

# Fazer backup do style.css atual
cp "${THEME_PATH}/style.css" "${THEME_PATH}/style.css.backup"

# Criar style.css com variáveis completas
cat > "${THEME_PATH}/style.css" << 'EOF'
/*
Theme Name: VancouverTec Store
Description: Tema premium para loja de produtos digitais da VancouverTec. Performance 99+, SEO avançado e design azul institucional moderno.
Author: VancouverTec
Version: 1.0.0
Requires at least: 6.4
Tested up to: 6.5
Requires PHP: 8.0
License: Proprietary
Text Domain: vancouvertec
Domain Path: /languages
Tags: woocommerce, e-commerce, digital-products, responsive, performance, vancouvertec
*/

/* ========================================
   VARIÁVEIS CSS VANCOUVERTEC - COMPLETAS
   ======================================== */
:root {
  /* Cores Principais VancouverTec */
  --vt-blue-600: #0066CC;
  --vt-blue-700: #0052A3;
  --vt-blue-500: #1E88E5;
  --vt-blue-50: #E3F2FD;
  --vt-indigo-500: #6366F1;
  --vt-indigo-600: #4F46E5;
  
  /* Cores de Sucesso e Estados */
  --vt-success-500: #10B981;
  --vt-success-600: #059669;
  --vt-success-700: #047857;
  --vt-warning-500: #F59E0B;
  --vt-error-500: #EF4444;
  
  /* Neutros */
  --vt-neutral-50: #F9FAFB;
  --vt-neutral-100: #F3F4F6;
  --vt-neutral-200: #E5E7EB;
  --vt-neutral-300: #D1D5DB;
  --vt-neutral-400: #9CA3AF;
  --vt-neutral-500: #6B7280;
  --vt-neutral-600: #4B5563;
  --vt-neutral-700: #374151;
  --vt-neutral-800: #1F2937;
  --vt-neutral-900: #111827;
  
  /* Typography */
  --vt-font-primary: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  --vt-font-secondary: 'Poppins', sans-serif;
  
  /* Spacing */
  --vt-space-xs: 0.5rem;
  --vt-space-sm: 1rem;
  --vt-space-md: 1.5rem;
  --vt-space-lg: 2rem;
  --vt-space-xl: 3rem;
  --vt-space-2xl: 4rem;
  
  /* Border Radius */
  --vt-radius-sm: 0.375rem;
  --vt-radius-md: 0.5rem;
  --vt-radius-lg: 0.75rem;
  --vt-radius-xl: 1rem;
  
  /* Shadows */
  --vt-shadow-xs: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  --vt-shadow-sm: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
  --vt-shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  --vt-shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
  --vt-shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
  
  /* Transitions */
  --vt-transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  --vt-transition-fast: all 0.15s ease;
}

/* ========================================
   RESET E BASE
   ======================================== */
*, *::before, *::after {
  box-sizing: border-box;
}

body {
  font-family: var(--vt-font-primary);
  line-height: 1.6;
  color: var(--vt-neutral-800);
  background-color: #ffffff;
  margin: 0;
  padding: 0;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

/* ========================================
   LAYOUT PRINCIPAL
   ======================================== */
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 var(--vt-space-sm);
}

.vt-main-content {
  padding: var(--vt-space-xl) 0;
  min-height: 70vh;
}

/* ========================================
   BOTÕES VANCOUVERTEC
   ======================================== */
.button, .btn, 
input[type="submit"], 
input[type="button"],
button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: var(--vt-space-xs) var(--vt-space-md);
  border: 2px solid transparent;
  border-radius: var(--vt-radius-md);
  font-family: var(--vt-font-primary);
  font-weight: 600;
  font-size: 0.875rem;
  text-decoration: none;
  transition: var(--vt-transition);
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.btn-primary, .button.btn-primary {
  background: linear-gradient(135deg, var(--vt-blue-600) 0%, var(--vt-blue-700) 100%);
  color: white;
  border-color: var(--vt-blue-600);
  box-shadow: var(--vt-shadow-sm);
}

.btn-primary:hover {
  background: linear-gradient(135deg, var(--vt-blue-700) 0%, var(--vt-blue-600) 100%);
  transform: translateY(-1px);
  box-shadow: var(--vt-shadow-lg);
  color: white;
}

.btn-success {
  background: linear-gradient(135deg, var(--vt-success-500) 0%, var(--vt-success-600) 100%);
  color: white;
  border-color: var(--vt-success-500);
}

.btn-success:hover {
  background: var(--vt-success-600);
  transform: translateY(-1px);
  box-shadow: var(--vt-shadow-lg);
}

/* ========================================
   CARDS E COMPONENTES
   ======================================== */
.vt-card {
  background: white;
  border-radius: var(--vt-radius-lg);
  box-shadow: var(--vt-shadow-sm);
  border: 1px solid var(--vt-neutral-100);
  transition: var(--vt-transition);
  overflow: hidden;
}

.vt-card:hover {
  transform: translateY(-2px);
  box-shadow: var(--vt-shadow-lg);
}

/* ========================================
   BADGES E INDICADORES
   ======================================== */
.vt-badge {
  display: inline-flex;
  align-items: center;
  padding: 0.25rem 0.75rem;
  border-radius: 9999px;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.025em;
}

.vt-sale-badge {
  background: var(--vt-error-500);
  color: white;
}

.vt-featured-badge {
  background: var(--vt-indigo-500);
  color: white;
}

.vt-success-badge {
  background: var(--vt-success-500);
  color: white;
}

/* ========================================
   TIPOGRAFIA
   ======================================== */
h1, h2, h3, h4, h5, h6 {
  font-family: var(--vt-font-secondary);
  font-weight: 700;
  line-height: 1.2;
  color: var(--vt-neutral-900);
  margin: 0 0 var(--vt-space-md) 0;
}

h1 { font-size: 2.5rem; }
h2 { font-size: 2rem; }
h3 { font-size: 1.5rem; }
h4 { font-size: 1.25rem; }

.vt-page-title {
  font-size: 3rem;
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  margin-bottom: var(--vt-space-lg);
}

/* ========================================
   LOADING E ESTADOS
   ======================================== */
.vt-loading {
  opacity: 0.6;
  pointer-events: none;
  position: relative;
}

.vt-loading::after {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  width: 20px;
  height: 20px;
  margin: -10px 0 0 -10px;
  border: 2px solid var(--vt-blue-600);
  border-radius: 50%;
  border-top-color: transparent;
  animation: vt-spin 1s linear infinite;
}

@keyframes vt-spin {
  to { transform: rotate(360deg); }
}

/* ========================================
   UTILITÁRIOS
   ======================================== */
.vt-text-center { text-align: center; }
.vt-text-left { text-align: left; }
.vt-text-right { text-align: right; }

.vt-mb-0 { margin-bottom: 0; }
.vt-mb-sm { margin-bottom: var(--vt-space-sm); }
.vt-mb-md { margin-bottom: var(--vt-space-md); }
.vt-mb-lg { margin-bottom: var(--vt-space-lg); }

.vt-mt-0 { margin-top: 0; }
.vt-mt-sm { margin-top: var(--vt-space-sm); }
.vt-mt-md { margin-top: var(--vt-space-md); }
.vt-mt-lg { margin-top: var(--vt-space-lg); }

/* ========================================
   RESPONSIVO BASE
   ======================================== */
@media (max-width: 768px) {
  .container {
    padding: 0 var(--vt-space-sm);
  }
  
  .vt-main-content {
    padding: var(--vt-space-lg) 0;
  }
  
  .vt-page-title {
    font-size: 2rem;
  }
  
  h1 { font-size: 2rem; }
  h2 { font-size: 1.5rem; }
  h3 { font-size: 1.25rem; }
}

@media (max-width: 480px) {
  :root {
    --vt-space-sm: 0.75rem;
    --vt-space-md: 1rem;
    --vt-space-lg: 1.5rem;
  }
  
  .vt-page-title {
    font-size: 1.75rem;
  }
}

/* ========================================
   COMPATIBILITY FIXES
   ======================================== */

/* Garantir que as variáveis funcionem em todos os browsers */
body.vt-body {
  --vt-blue-600: #0066CC;
  --vt-blue-700: #0052A3;
  --vt-success-500: #10B981;
  --vt-neutral-800: #1F2937;
  --vt-neutral-900: #111827;
}

/* Fallbacks para browsers antigos */
.btn-primary {
  background: #0066CC;
  background: linear-gradient(135deg, #0066CC 0%, #0052A3 100%);
}

.vt-card {
  box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
}
EOF

# 2. VERIFICAR SE O PROBLEMA FOI RESOLVIDO
log_info "Verificando se as variáveis foram aplicadas..."

# Iniciar servidor
log_info "Iniciando servidor com variáveis CSS..."
nohup php -S localhost:8080 router.php > server.log 2>&1 &
echo $! > .server_pid
sleep 3

# Teste rápido
if curl -s "http://localhost:8080" > /dev/null; then
    log_success "✅ Servidor funcionando"
else
    log_error "❌ Servidor com problemas"
fi

# Verificar arquivo criado
if [[ -f "${THEME_PATH}/style.css" ]]; then
    log_success "✅ style.css com variáveis criado"
    
    # Verificar se tem as variáveis
    if grep -q "vt-blue-600" "${THEME_PATH}/style.css"; then
        log_success "✅ Variáveis CSS encontradas no arquivo"
    else
        log_error "❌ Variáveis não foram inseridas"
    fi
else
    log_error "❌ style.css não foi criado"
fi

# Relatório
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║      ✅ VARIÁVEIS CSS CORRIGIDAS! ✅          ║"
echo -e "║                                              ║"
echo -e "║  🎯 PROBLEMA IDENTIFICADO E RESOLVIDO:       ║"
echo -e "║                                              ║"
echo -e "║  ❌ Antes: CSS usava var(--vt-blue-600)      ║"
echo -e "║      mas as variáveis não existiam           ║"
echo -e "║                                              ║"
echo -e "║  ✅ Agora: Todas as variáveis definidas      ║"
echo -e "║      no style.css principal                  ║"
echo -e "║                                              ║"
echo -e "║  Variáveis CSS VancouverTec:                 ║"
echo -e "║  • --vt-blue-600: #0066CC                    ║"
echo -e "║  • --vt-blue-700: #0052A3                    ║"
echo -e "║  • --vt-success-500: #10B981                 ║"
echo -e "║  • --vt-neutral-800: #1F2937                 ║"
echo -e "║  • --vt-space-xl: 3rem                       ║"
echo -e "║  • E mais 30+ variáveis completas            ║"
echo -e "║                                              ║"
echo -e "║  🌐 Acesse: http://localhost:8080            ║"
echo -e "║     🎯 AGORA O LAYOUT DEVE FUNCIONAR! 🎯     ║"
echo -e "║                                              ║"
echo -e "║  📋 Header azul + Footer + CSS aplicado      ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "🔧 Problema das variáveis CSS corrigido!"
log_info "🚀 Recarregue a página para ver o layout VancouverTec funcionando!"
log_warning "📝 Backup salvo como: style.css.backup"