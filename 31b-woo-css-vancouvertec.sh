#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce CSS Completo VancouverTec
# Script: 31b-woo-css-vancouvertec.sh
# Versão: 1.0.0 - CSS Design VancouverTec Azul Institucional
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
CSS_PATH="${THEME_PATH}/assets/css/woocommerce"

# Funções de log
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║     🎨 CSS VancouverTec Completo 🎨          ║
║      Design Azul Institucional Moderno      ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar base
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Execute antes: 31a2-woo-shop-account.sh"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Criando CSS VancouverTec em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost:8080" > /dev/null; then
    log_warning "Parando servidor..."
    pkill -f "php -S localhost:8080" || true
    sleep 2
fi

# 1. ATUALIZAR CSS PRINCIPAL DO TEMA
log_info "Atualizando style.css principal..."
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
   VARIÁVEIS CSS VANCOUVERTEC
   ======================================== */
:root {
  /* Cores Principais VancouverTec */
  --vt-blue-600: #0066CC;
  --vt-blue-700: #0052A3;
  --vt-blue-500: #1E88E5;
  --vt-indigo-500: #6366F1;
  --vt-indigo-600: #4F46E5;
  
  /* Cores de Sucesso e Estados */
  --vt-success-500: #10B981;
  --vt-success-600: #059669;
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
EOF

# 2. CSS WOOCOMMERCE ESPECÍFICO
log_info "Criando CSS WooCommerce específico..."
cat > "${CSS_PATH}/woocommerce.css" << 'EOF'
/**
 * VancouverTec Store - WooCommerce CSS Completo
 * Design Azul Institucional VancouverTec
 */

/* ========================================
   WOOCOMMERCE BASE
   ======================================== */

/* Remove estilos padrão WooCommerce */
.woocommerce-page .entry-header,
.woocommerce-page .entry-title {
  display: none;
}

/* Container principal WooCommerce */
.woocommerce,
.woocommerce-page {
  font-family: var(--vt-font-primary);
}

/* ========================================
   BOTÕES WOOCOMMERCE
   ======================================== */
.woocommerce .button,
.woocommerce button,
.woocommerce input[type="submit"],
.woocommerce-page .button,
.woocommerce-page button,
.woocommerce-page input[type="submit"] {
  background: var(--vt-blue-600);
  color: white;
  border: none;
  padding: var(--vt-space-xs) var(--vt-space-md);
  border-radius: var(--vt-radius-md);
  font-weight: 600;
  font-size: 0.875rem;
  transition: var(--vt-transition);
  cursor: pointer;
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  box-shadow: var(--vt-shadow-sm);
}

.woocommerce .button:hover,
.woocommerce button:hover,
.woocommerce input[type="submit"]:hover {
  background: var(--vt-blue-700);
  color: white;
  transform: translateY(-1px);
  box-shadow: var(--vt-shadow-md);
}

/* Botão adicionar ao carrinho */
.woocommerce .single_add_to_cart_button {
  background: linear-gradient(135deg, var(--vt-success-500) 0%, var(--vt-success-600) 100%);
  font-size: 1rem;
  padding: var(--vt-space-md) var(--vt-space-xl);
  min-width: 200px;
}

.woocommerce .single_add_to_cart_button:hover {
  background: var(--vt-success-600);
}

/* ========================================
   PRODUTOS - GRID E CARDS
   ======================================== */
.woocommerce ul.products {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: var(--vt-space-lg);
  margin: 0;
  padding: 0;
  list-style: none;
}

.woocommerce ul.products li.product {
  background: white;
  border-radius: var(--vt-radius-lg);
  box-shadow: var(--vt-shadow-sm);
  border: 1px solid var(--vt-neutral-100);
  padding: 0;
  transition: var(--vt-transition);
  overflow: hidden;
  position: relative;
  margin: 0;
}

.woocommerce ul.products li.product:hover {
  transform: translateY(-4px);
  box-shadow: var(--vt-shadow-lg);
}

/* Imagem do produto */
.woocommerce ul.products li.product .woocommerce-LoopProduct-link {
  display: block;
  text-decoration: none;
}

.woocommerce ul.products li.product img {
  width: 100%;
  height: 250px;
  object-fit: cover;
  border-radius: var(--vt-radius-md) var(--vt-radius-md) 0 0;
}

/* Conteúdo do produto */
.woocommerce ul.products li.product .woocommerce-loop-product__title {
  font-size: 1.125rem;
  font-weight: 600;
  color: var(--vt-neutral-800);
  margin: var(--vt-space-sm) var(--vt-space-md) var(--vt-space-xs);
  line-height: 1.4;
}

.woocommerce ul.products li.product .price {
  color: var(--vt-blue-600);
  font-weight: bold;
  font-size: 1.25rem;
  margin: 0 var(--vt-space-md) var(--vt-space-md);
}

.woocommerce ul.products li.product .price del {
  color: var(--vt-neutral-400);
  font-size: 1rem;
}

/* Botão do produto no loop */
.woocommerce ul.products li.product .button {
  margin: var(--vt-space-md);
  width: calc(100% - 2rem);
}

/* ========================================
   SINGLE PRODUCT - PÁGINA DO PRODUTO
   ======================================== */
.woocommerce div.product {
  margin-bottom: var(--vt-space-xl);
}

.vt-single-product {
  background: white;
  border-radius: var(--vt-radius-xl);
  box-shadow: var(--vt-shadow-sm);
  padding: var(--vt-space-xl);
  margin-bottom: var(--vt-space-xl);
}

.vt-product-container {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--vt-space-xl);
  margin-bottom: var(--vt-space-xl);
}

/* Galeria de imagens */
.vt-product-gallery {
  position: relative;
}

.vt-main-image img {
  width: 100%;
  height: auto;
  border-radius: var(--vt-radius-lg);
  box-shadow: var(--vt-shadow-md);
}

.vt-gallery-thumbs {
  display: flex;
  gap: var(--vt-space-sm);
  margin-top: var(--vt-space-md);
}

.vt-thumb {
  width: 80px;
  height: 80px;
  border-radius: var(--vt-radius-md);
  overflow: hidden;
  cursor: pointer;
  border: 2px solid transparent;
  transition: var(--vt-transition);
}

.vt-thumb:hover {
  border-color: var(--vt-blue-600);
}

.vt-thumb img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* Summary do produto */
.vt-product-summary {
  padding: var(--vt-space-md);
}

.vt-product-header {
  margin-bottom: var(--vt-space-lg);
}

.woocommerce div.product .product_title {
  font-size: 2rem;
  font-weight: 700;
  color: var(--vt-neutral-900);
  margin-bottom: var(--vt-space-md);
}

.vt-product-badges {
  display: flex;
  gap: var(--vt-space-xs);
  margin-bottom: var(--vt-space-md);
}

/* Preço */
.vt-price-section {
  background: var(--vt-neutral-50);
  padding: var(--vt-space-md);
  border-radius: var(--vt-radius-lg);
  margin-bottom: var(--vt-space-lg);
}

.woocommerce div.product p.price {
  font-size: 2rem;
  font-weight: bold;
  color: var(--vt-blue-600);
  margin-bottom: var(--vt-space-sm);
}

.vt-installments {
  color: var(--vt-neutral-600);
  font-size: 0.875rem;
}

/* Trust badges */
.vt-trust-badges {
  display: grid;
  grid-template-columns: 1fr;
  gap: var(--vt-space-sm);
  margin: var(--vt-space-lg) 0;
  padding: var(--vt-space-md);
  background: var(--vt-success-50, #F0FDF4);
  border-radius: var(--vt-radius-lg);
  border: 1px solid var(--vt-success-200, #BBF7D0);
}

.vt-trust-item {
  display: flex;
  align-items: center;
  gap: var(--vt-space-sm);
  color: var(--vt-success-700, #15803D);
  font-size: 0.875rem;
  font-weight: 500;
}

.vt-trust-item .vt-icon {
  font-size: 1.25rem;
}

/* ========================================
   CARRINHO
   ======================================== */
.vt-cart-page {
  padding: var(--vt-space-xl) 0;
}

.vt-cart-header {
  text-align: center;
  margin-bottom: var(--vt-space-xl);
}

.vt-cart-header h1 {
  font-size: 2.5rem;
  color: var(--vt-blue-600);
  margin-bottom: var(--vt-space-sm);
}

.vt-cart-subtitle {
  color: var(--vt-neutral-600);
  font-size: 1.125rem;
}

.woocommerce table.cart {
  background: white;
  border-radius: var(--vt-radius-lg);
  box-shadow: var(--vt-shadow-sm);
  overflow: hidden;
}

.woocommerce table.cart th,
.woocommerce table.cart td {
  padding: var(--vt-space-md);
  border-bottom: 1px solid var(--vt-neutral-100);
}

.woocommerce table.cart th {
  background: var(--vt-neutral-50);
  font-weight: 600;
  color: var(--vt-neutral-800);
}

/* ========================================
   CHECKOUT
   ======================================== */
.vt-checkout-page {
  padding: var(--vt-space-xl) 0;
}

.vt-checkout-header {
  text-align: center;
  margin-bottom: var(--vt-space-xl);
}

.vt-checkout-steps {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: var(--vt-space-md);
  margin-top: var(--vt-space-lg);
}

.vt-step {
  display: flex;
  align-items: center;
  gap: var(--vt-space-xs);
  padding: var(--vt-space-sm) var(--vt-space-md);
  background: var(--vt-neutral-100);
  border-radius: var(--vt-radius-lg);
  color: var(--vt-neutral-600);
  font-size: 0.875rem;
  font-weight: 500;
}

.vt-step.active {
  background: var(--vt-blue-600);
  color: white;
}

.vt-step-number {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.2);
  font-size: 0.75rem;
  font-weight: 700;
}

.vt-step-separator {
  width: 20px;
  height: 2px;
  background: var(--vt-neutral-200);
}

/* Security badges */
.vt-security-badges {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: var(--vt-space-md);
  margin-top: var(--vt-space-xl);
}

.vt-security-item {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: var(--vt-space-xs);
  padding: var(--vt-space-md);
  background: var(--vt-neutral-50);
  border-radius: var(--vt-radius-lg);
  border: 1px solid var(--vt-neutral-200);
  font-size: 0.875rem;
  font-weight: 500;
  color: var(--vt-neutral-700);
}

/* ========================================
   RESPONSIVO WOOCOMMERCE
   ======================================== */
@media (max-width: 768px) {
  .woocommerce ul.products {
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: var(--vt-space-md);
  }
  
  .vt-product-container {
    grid-template-columns: 1fr;
    gap: var(--vt-space-lg);
  }
  
  .vt-checkout-steps {
    flex-direction: column;
    gap: var(--vt-space-sm);
  }
  
  .vt-step-separator {
    width: 2px;
    height: 20px;
  }
  
  .vt-security-badges {
    grid-template-columns: 1fr;
  }
  
  .vt-trust-badges {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 480px) {
  .woocommerce ul.products {
    grid-template-columns: 1fr;
  }
  
  .vt-single-product {
    padding: var(--vt-space-md);
  }
  
  .vt-cart-header h1 {
    font-size: 2rem;
  }
  
  .woocommerce div.product .product_title {
    font-size: 1.5rem;
  }
}
EOF

# Iniciar servidor
log_info "Iniciando servidor..."
nohup php -S localhost:8080 router.php > server.log 2>&1 &
echo $! > .server_pid
sleep 3

# Verificar arquivos criados
created_files=(
    "${THEME_PATH}/style.css"
    "${CSS_PATH}/woocommerce.css"
)

for file in "${created_files[@]}"; do
    if [[ -f "$file" ]]; then
        log_success "✅ $(basename "$file")"
    else
        log_error "❌ $(basename "$file")"
    fi
done

# Relatório
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║        ✅ CSS VANCOUVERTEC CRIADO! ✅         ║"
echo -e "║                                              ║"
echo -e "║  🎨 Design azul institucional completo       ║"
echo -e "║  📱 Grid responsivo produtos                 ║"
echo -e "║  🛒 Cards modernos com hover effects         ║"
echo -e "║  💳 Checkout com steps visuais               ║"
echo -e "║  🔒 Security badges integrados               ║"
echo -e "║  ⚡ Performance CSS otimizado                ║"
echo -e "║                                              ║"
echo -e "║  Features:                                   ║"
echo -e "║  • Variáveis CSS organizadas                 ║"
echo -e "║  • Gradientes VancouverTec                   ║"
echo -e "║  • Animations e transitions                  ║"
echo -e "║  • Mobile-first responsive                   ║"
echo -e "║                                              ║"
echo -e "║  🌐 Servidor: http://localhost:8080          ║"
echo -e "║                                              ║"
echo -e "║  ➡️  Próximo: 31c-woo-responsive-mobile.sh   ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_info "Execute para continuar:"
echo -e "${BLUE}chmod +x 31c-woo-responsive-mobile.sh && ./31c-woo-responsive-mobile.sh${NC}"