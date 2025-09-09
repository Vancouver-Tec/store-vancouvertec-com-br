#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce Layout Completo PARTE 1
# Script: 23a-woocommerce-layout-completo-parte1.sh
# Versão: 1.0.0 - CSS Ultra-Específico + Estrutura Base
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
THEME_PATH="wp-content/themes/vancouvertec-store"
PROJECT_PATH="/home/$(whoami)/vancouvertec/store-vancouvertec-com-br/vancouvertec-store"

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║  🎨 WOOCOMMERCE LAYOUT COMPLETO - PARTE 1 🎨 ║
║         CSS Ultra-Específico + Base          ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Aplicando layout VancouverTec COMPLETO - Parte 1..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# 1. REMOVER CSS ANTERIOR CONFLITANTE
log_info "Removendo CSS anterior para evitar conflitos..."
if [[ -f "$THEME_PATH/assets/css/components/woocommerce-override-safe.css" ]]; then
    rm -f "$THEME_PATH/assets/css/components/woocommerce-override-safe.css"
fi

# 2. CRIAR CSS ULTRA-ESPECÍFICO BASE
log_info "Criando CSS ultra-específico base..."
cat > "$THEME_PATH/assets/css/components/woocommerce-vancouvertec-complete.css" << 'EOF'
/* VancouverTec Store - WooCommerce Layout COMPLETO */

/* ===== VARIÁVEIS FORÇADAS ===== */
:root {
  --vt-blue-600: #0066CC !important;
  --vt-blue-700: #0052A3 !important;
  --vt-indigo-500: #6366F1 !important;
  --vt-success-500: #10B981 !important;
  --vt-error-500: #EF4444 !important;
  --vt-neutral-50: #F9FAFB !important;
  --vt-neutral-100: #F3F4F6 !important;
  --vt-neutral-800: #1F2937 !important;
  --vt-neutral-900: #111827 !important;
}

/* ===== BODY E ESTRUTURA GERAL ===== */
body.woocommerce,
body.woocommerce-page,
body.woocommerce-cart,
body.woocommerce-checkout,
body.woocommerce-account {
  background: var(--vt-neutral-100) !important;
  font-family: "Inter", -apple-system, BlinkMacSystemFont, sans-serif !important;
  line-height: 1.6 !important;
  color: var(--vt-neutral-800) !important;
}

/* ===== CONTAINER PRINCIPAL ===== */
body.woocommerce .site-main,
body.woocommerce-page .site-main,
body.woocommerce .entry-content,
body.woocommerce-page .entry-content {
  max-width: 1200px !important;
  margin: 0 auto !important;
  padding: 2rem 1rem !important;
  background: transparent !important;
}

/* ===== TÍTULOS DAS PÁGINAS ===== */
body.woocommerce .entry-header,
body.woocommerce-page .entry-header {
  background: linear-gradient(135deg, white 0%, var(--vt-neutral-50) 100%) !important;
  padding: 3rem 2rem !important;
  text-align: center !important;
  margin: 0 0 3rem 0 !important;
  border-radius: 20px !important;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1) !important;
  border: 2px solid rgba(0, 102, 204, 0.1) !important;
}

body.woocommerce .entry-title,
body.woocommerce-page .entry-title,
body.woocommerce h1.page-title,
body.woocommerce-page h1.page-title {
  font-size: 2.5rem !important;
  font-weight: 800 !important;
  color: var(--vt-neutral-800) !important;
  margin: 0 !important;
  padding: 0 !important;
  background: none !important;
  text-transform: none !important;
  letter-spacing: -0.025em !important;
}

/* ===== WRAPPER GERAL WOOCOMMERCE ===== */
body.woocommerce .woocommerce,
body.woocommerce-page .woocommerce {
  background: white !important;
  border-radius: 20px !important;
  padding: 3rem !important;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1) !important;
  border: 2px solid rgba(0, 102, 204, 0.1) !important;
  margin-bottom: 2rem !important;
}

/* ===== SHOP PAGE ===== */
body.woocommerce.archive .woocommerce-ordering,
body.woocommerce.archive .woocommerce-result-count {
  background: var(--vt-neutral-50) !important;
  padding: 1rem 1.5rem !important;
  border-radius: 12px !important;
  border: 2px solid #E5E7EB !important;
  margin-bottom: 1rem !important;
  font-weight: 600 !important;
  color: var(--vt-neutral-800) !important;
}

body.woocommerce.archive .woocommerce-ordering select {
  background: white !important;
  border: 2px solid #E5E7EB !important;
  border-radius: 8px !important;
  padding: 0.75rem 1rem !important;
  font-weight: 600 !important;
  color: var(--vt-neutral-800) !important;
}

/* ===== CART PAGE ESPECÍFICO ===== */
body.woocommerce-cart .woocommerce .cart-empty {
  text-align: center !important;
  padding: 4rem 2rem !important;
  background: linear-gradient(135deg, var(--vt-neutral-50), white) !important;
  border-radius: 20px !important;
  border: 2px solid rgba(0, 102, 204, 0.1) !important;
}

body.woocommerce-cart .woocommerce .cart-empty::before {
  content: "🛒" !important;
  font-size: 4rem !important;
  display: block !important;
  margin-bottom: 1rem !important;
  opacity: 0.7 !important;
}

body.woocommerce-cart .woocommerce .return-to-shop {
  margin-top: 2rem !important;
}

/* ===== TABELAS WOOCOMMERCE ===== */
body.woocommerce table.cart,
body.woocommerce table.shop_table,
body.woocommerce-page table.shop_table {
  background: white !important;
  border-radius: 15px !important;
  overflow: hidden !important;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08) !important;
  border: 2px solid rgba(0, 102, 204, 0.1) !important;
  width: 100% !important;
  border-collapse: separate !important;
  border-spacing: 0 !important;
}

body.woocommerce table.cart thead th,
body.woocommerce table.shop_table thead th,
body.woocommerce-page table.shop_table thead th {
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500)) !important;
  color: white !important;
  font-weight: 800 !important;
  padding: 1.5rem 1rem !important;
  border: none !important;
  font-size: 0.9rem !important;
  text-transform: uppercase !important;
  letter-spacing: 0.05em !important;
}

body.woocommerce table.cart tbody td,
body.woocommerce table.shop_table tbody td,
body.woocommerce-page table.shop_table tbody td {
  padding: 1.5rem 1rem !important;
  border-bottom: 1px solid #E5E7EB !important;
  vertical-align: middle !important;
  border-left: none !important;
  border-right: none !important;
  background: white !important;
}

body.woocommerce table.cart .product-thumbnail img {
  border-radius: 10px !important;
  max-width: 80px !important;
  height: 80px !important;
  object-fit: cover !important;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1) !important;
}

/* ===== CART TOTALS ===== */
body.woocommerce .cart-collaterals,
body.woocommerce-page .cart-collaterals {
  margin-top: 3rem !important;
  display: flex !important;
  justify-content: center !important;
}

body.woocommerce .cart-collaterals .cart_totals,
body.woocommerce-page .cart-collaterals .cart_totals {
  background: white !important;
  border-radius: 20px !important;
  padding: 2.5rem !important;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1) !important;
  border: 2px solid rgba(0, 102, 204, 0.1) !important;
  float: none !important;
  width: 100% !important;
  max-width: 450px !important;
  margin: 0 !important;
}

body.woocommerce .cart_totals h2,
body.woocommerce-page .cart_totals h2 {
  color: var(--vt-neutral-800) !important;
  font-weight: 800 !important;
  margin-bottom: 1.5rem !important;
  text-align: center !important;
  font-size: 1.5rem !important;
  padding-bottom: 1rem !important;
  border-bottom: 2px solid #E5E7EB !important;
}

body.woocommerce .cart_totals table,
body.woocommerce-page .cart_totals table {
  background: var(--vt-neutral-50) !important;
  border-radius: 12px !important;
  border: none !important;
  overflow: hidden !important;
}

body.woocommerce .cart_totals table th,
body.woocommerce .cart_totals table td,
body.woocommerce-page .cart_totals table th,
body.woocommerce-page .cart_totals table td {
  padding: 1.25rem !important;
  border: none !important;
  font-weight: 600 !important;
}

body.woocommerce .cart_totals .order-total th,
body.woocommerce .cart_totals .order-total td,
body.woocommerce-page .cart_totals .order-total th,
body.woocommerce-page .cart_totals .order-total td {
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500)) !important;
  color: white !important;
  font-weight: 800 !important;
  font-size: 1.125rem !important;
}
EOF

# 3. ADICIONAR HOOKS BÁSICOS NO FUNCTIONS.PHP
log_info "Adicionando hooks básicos no functions.php..."

# Remover hooks anteriores se existirem
sed -i '/\/\/ ===== HOOKS SEGUROS WOOCOMMERCE VANCOUVERTEC =====/,/add_action.*vt_woocommerce_after_main_content/d' "$THEME_PATH/functions.php"

cat >> "$THEME_PATH/functions.php" << 'EOF'

// ===== WOOCOMMERCE VANCOUVERTEC COMPLETE - PARTE 1 =====

/**
 * Carregar CSS completo para páginas WooCommerce
 */
function vt_woocommerce_complete_styles() {
    if (is_woocommerce() || is_cart() || is_checkout() || is_account_page()) {
        wp_enqueue_style(
            'vt-woocommerce-complete', 
            VT_THEME_URI . '/assets/css/components/woocommerce-vancouvertec-complete.css', 
            [], 
            VT_THEME_VERSION . '-' . time(),
            'all'
        );
        
        // CSS inline crítico
        wp_add_inline_style('vt-woocommerce-complete', '
            body.woocommerce,
            body.woocommerce-page {
                background: #F3F4F6 !important;
                min-height: 100vh !important;
            }
            .site-content {
                padding-top: 2rem !important;
                padding-bottom: 2rem !important;
            }
        ');
    }
}
add_action('wp_enqueue_scripts', 'vt_woocommerce_complete_styles', 999);

/**
 * Adicionar classes específicas ao body
 */
function vt_woocommerce_body_classes($classes) {
    if (is_woocommerce() || is_cart() || is_checkout() || is_account_page()) {
        $classes[] = 'vt-woocommerce-complete';
        $classes[] = 'vt-layout-vancouvertec';
        
        if (is_cart()) {
            $classes[] = 'vt-cart-page';
        }
        if (is_checkout()) {
            $classes[] = 'vt-checkout-page';
        }
        if (is_account_page()) {
            $classes[] = 'vt-account-page';
        }
    }
    return $classes;
}
add_filter('body_class', 'vt_woocommerce_body_classes');
EOF

# Reiniciar servidor
log_info "Reiniciando servidor..."
cd "$PROJECT_PATH"
php -S localhost:8080 -t . > /tmp/vt-server-8080.log 2>&1 &
SERVER_PID=$!

sleep 3

if kill -0 $SERVER_PID 2>/dev/null; then
    log_success "Servidor reiniciado (PID: $SERVER_PID)"
else
    log_error "Falha ao reiniciar servidor!"
    exit 1
fi

echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║  ✅ PARTE 1 APLICADA COM SUCESSO! ✅         ║"
echo -e "║       CSS Ultra-Específico + Base            ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ CSS ultra-específico criado"
log_success "✅ Hooks básicos adicionados"
log_success "✅ Estrutura base aplicada"
log_success "✅ Títulos e containers estilizados"
log_success "✅ Cart page base melhorada"

echo -e "\n${BLUE}📄 Digite 'continuar' para PARTE 2: Checkout + My Account${NC}"

exit 0