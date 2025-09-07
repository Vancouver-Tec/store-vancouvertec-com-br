#!/bin/bash

# ===========================================
# VancouverTec Store - Tema Completo Premium
# Script: 03-tema-completo-vancouvertec.sh
# Versão: 1.0.0 - Tema Performance 99+ Completo
# ===========================================

set -euo pipefail

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Variáveis
THEME_PATH="wp-content/themes/vancouvertec-store"
PROJECT_PATH="/home/$(whoami)/vancouvertec/store-vancouvertec-com-br/vancouvertec-store"

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║    🎨 Tema VancouverTec Store COMPLETO 🎨     ║
║  Performance 99+ | WooCommerce | Elementor  ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar projeto
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Projeto não encontrado em: $PROJECT_PATH"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Criando tema completo em: $(pwd)"

# Parar servidor se rodando
if pgrep -f "php -S localhost" > /dev/null; then
    log_warning "Parando servidor para aplicar mudanças..."
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Limpar tema anterior
if [[ -d "$THEME_PATH" ]]; then
    log_warning "Removendo versão anterior do tema..."
    rm -rf "$THEME_PATH"
fi

# Criar estrutura completa
log_info "Criando estrutura completa do tema..."
mkdir -p "$THEME_PATH"/{inc,template-parts/{header,footer,content,product},woocommerce/{single-product,archive-product,cart,checkout,account},assets/{css,js,images,fonts,icons},languages}

# style.css COMPLETO
log_info "Criando style.css premium..."
cat > "$THEME_PATH/style.css" << 'EOF'
/*
Theme Name: VancouverTec Store
Description: Tema premium para loja de produtos digitais da VancouverTec. Performance 99+, SEO avançado, WooCommerce + Elementor, design azul institucional moderno.
Author: VancouverTec
Version: 1.0.0
Requires at least: 6.4
Tested up to: 6.5
Requires PHP: 8.0
License: Proprietary
License URI: https://vancouvertec.com.br/license
Text Domain: vancouvertec
Domain Path: /languages
Tags: woocommerce, e-commerce, digital-products, responsive, performance, seo, elementor
*/

:root {
  /* VancouverTec Color Palette */
  --vt-blue-600: #0066CC;
  --vt-blue-700: #0052A3;
  --vt-blue-800: #004080;
  --vt-indigo-500: #6366F1;
  --vt-indigo-600: #4F46E5;
  --vt-success-500: #10B981;
  --vt-success-600: #059669;
  --vt-warning-500: #F59E0B;
  --vt-error-500: #EF4444;
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
  --vt-font-primary: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  --vt-font-secondary: 'Poppins', sans-serif;
  --vt-font-display: 'Inter', sans-serif;
  
  /* Spacing */
  --vt-space-xs: 0.5rem;
  --vt-space-sm: 1rem;
  --vt-space-md: 1.5rem;
  --vt-space-lg: 2rem;
  --vt-space-xl: 3rem;
  --vt-space-2xl: 4rem;
  --vt-space-3xl: 6rem;
  
  /* Border Radius */
  --vt-radius-sm: 0.375rem;
  --vt-radius-md: 0.5rem;
  --vt-radius-lg: 0.75rem;
  --vt-radius-xl: 1rem;
  --vt-radius-full: 9999px;
  
  /* Shadows */
  --vt-shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  --vt-shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  --vt-shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
  --vt-shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
  
  /* Transitions */
  --vt-transition-fast: 0.15s ease;
  --vt-transition-normal: 0.3s ease;
  --vt-transition-slow: 0.5s ease;
}

/* Reset e Base */
*, *::before, *::after { box-sizing: border-box; }

body {
  font-family: var(--vt-font-primary);
  line-height: 1.6;
  color: var(--vt-neutral-800);
  background: #ffffff;
  margin: 0;
  padding: 0;
  font-size: 16px;
  font-weight: 400;
  scroll-behavior: smooth;
}

/* Container System */
.container { 
  max-width: 1200px; 
  margin: 0 auto; 
  padding: 0 var(--vt-space-sm); 
  width: 100%;
}

.container-fluid { 
  max-width: 100%; 
  padding: 0 var(--vt-space-sm); 
}

/* Header */
.site-header {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid var(--vt-neutral-200);
  position: sticky;
  top: 0;
  z-index: 1000;
  transition: var(--vt-transition-fast);
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--vt-space-sm) 0;
  min-height: 70px;
}

.site-branding .site-title {
  margin: 0;
  font-size: 1.75rem;
  font-weight: 700;
  font-family: var(--vt-font-display);
}

.site-title a {
  color: var(--vt-blue-600);
  text-decoration: none;
  transition: var(--vt-transition-fast);
}

.site-title a:hover {
  color: var(--vt-blue-700);
}

/* Navigation */
.main-navigation ul {
  display: flex;
  list-style: none;
  margin: 0;
  padding: 0;
  gap: var(--vt-space-lg);
  align-items: center;
}

.main-navigation a {
  color: var(--vt-neutral-700);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  padding: var(--vt-space-xs) var(--vt-space-sm);
  border-radius: var(--vt-radius-md);
  transition: var(--vt-transition-fast);
  position: relative;
}

.main-navigation a:hover,
.main-navigation a:focus {
  color: var(--vt-blue-600);
  background: var(--vt-neutral-50);
}

/* Buttons */
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: var(--vt-space-sm) var(--vt-space-lg);
  font-family: var(--vt-font-primary);
  font-size: 0.95rem;
  font-weight: 600;
  line-height: 1;
  text-decoration: none;
  text-align: center;
  border: none;
  border-radius: var(--vt-radius-md);
  cursor: pointer;
  transition: var(--vt-transition-fast);
  white-space: nowrap;
  user-select: none;
  min-height: 44px;
}

.btn-primary {
  background: var(--vt-blue-600);
  color: white;
  box-shadow: var(--vt-shadow-sm);
}

.btn-primary:hover,
.btn-primary:focus {
  background: var(--vt-blue-700);
  transform: translateY(-1px);
  box-shadow: var(--vt-shadow-md);
  color: white;
  text-decoration: none;
}

.btn-secondary {
  background: var(--vt-neutral-100);
  color: var(--vt-neutral-700);
  border: 1px solid var(--vt-neutral-300);
}

.btn-secondary:hover {
  background: var(--vt-neutral-200);
  border-color: var(--vt-neutral-400);
}

.btn-success {
  background: var(--vt-success-500);
  color: white;
}

.btn-success:hover {
  background: var(--vt-success-600);
  color: white;
}

/* Footer */
.site-footer {
  background: var(--vt-neutral-900);
  color: var(--vt-neutral-300);
  margin-top: var(--vt-space-3xl);
  padding: var(--vt-space-2xl) 0 var(--vt-space-lg);
}

.footer-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: var(--vt-space-lg);
}

.footer-info p {
  margin: 0;
  color: var(--vt-neutral-400);
}

.footer-navigation ul {
  display: flex;
  list-style: none;
  margin: 0;
  padding: 0;
  gap: var(--vt-space-lg);
}

.footer-navigation a {
  color: var(--vt-neutral-400);
  text-decoration: none;
  transition: var(--vt-transition-fast);
}

.footer-navigation a:hover {
  color: var(--vt-neutral-200);
}

/* Responsive Design */
@media (max-width: 768px) {
  .header-content {
    flex-direction: column;
    gap: var(--vt-space-sm);
    padding: var(--vt-space-sm) 0;
  }
  
  .main-navigation ul {
    flex-wrap: wrap;
    justify-content: center;
    gap: var(--vt-space-sm);
  }
  
  .footer-content {
    flex-direction: column;
    text-align: center;
  }
  
  .btn {
    width: 100%;
    max-width: 300px;
  }
  
  .container {
    padding: 0 var(--vt-space-sm);
  }
}

/* Utility Classes */
.text-center { text-align: center; }
.text-left { text-align: left; }
.text-right { text-align: right; }

.mt-0 { margin-top: 0; }
.mt-1 { margin-top: var(--vt-space-xs); }
.mt-2 { margin-top: var(--vt-space-sm); }
.mt-3 { margin-top: var(--vt-space-md); }
.mt-4 { margin-top: var(--vt-space-lg); }

.mb-0 { margin-bottom: 0; }
.mb-1 { margin-bottom: var(--vt-space-xs); }
.mb-2 { margin-bottom: var(--vt-space-sm); }
.mb-3 { margin-bottom: var(--vt-space-md); }
.mb-4 { margin-bottom: var(--vt-space-lg); }

.d-none { display: none; }
.d-block { display: block; }
.d-flex { display: flex; }
.d-grid { display: grid; }

.flex-center { 
  display: flex; 
  align-items: center; 
  justify-content: center; 
}

.flex-between { 
  display: flex; 
  align-items: center; 
  justify-content: space-between; 
}

/* Performance Loading States */
.vt-loading {
  opacity: 0;
  transition: opacity var(--vt-transition-normal);
}

.vt-loaded {
  opacity: 1;
}

/* Accessibility */
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}

/* Focus styles for accessibility */
*:focus {
  outline: 2px solid var(--vt-blue-600);
  outline-offset: 2px;
}

.btn:focus {
  outline: 2px solid var(--vt-blue-600);
  outline-offset: 2px;
}
EOF

log_success "style.css premium criado!"

echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║       ✅ TEMA BASE CRIADO COM SUCESSO! ✅     ║"
echo -e "║     Estrutura completa + CSS avançado        ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "Estrutura do tema criada!"
log_success "CSS premium com design system completo!"

echo -e "\n${CYAN}📁 Estrutura Criada:${NC}"
echo -e "• ${GREEN}$THEME_PATH/${NC}"
echo -e "  ├── inc/ (funcionalidades)"
echo -e "  ├── template-parts/ (componentes)"
echo -e "  ├── woocommerce/ (templates)"
echo -e "  ├── assets/ (CSS, JS, imagens)"
echo -e "  └── languages/ (traduções)"

echo -e "\n${YELLOW}🎨 CSS System Criado:${NC}"
echo -e "• ✅ Paleta de cores VancouverTec"
echo -e "• ✅ Sistema de espaçamento"
echo -e "• ✅ Typography system"
echo -e "• ✅ Components base (botões, containers)"
echo -e "• ✅ Responsive design"
echo -e "• ✅ Accessibility features"

echo -e "\n${PURPLE}📋 Próximo Passo:${NC}"
log_warning "Execute: chmod +x 03a-tema-functions-completo.sh && ./03a-tema-functions-completo.sh"
log_info "Isso criará functions.php + templates + WooCommerce integration"

exit 0