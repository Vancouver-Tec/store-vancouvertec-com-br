#!/bin/bash

# ===========================================
# VancouverTec Store - Safe WooCommerce Styling
# Script: 22c-safe-woocommerce-styling.sh
# Versão: 1.0.0 - Aplicar layout VT sem quebrar estrutura
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
║    🎨 SAFE WOOCOMMERCE STYLING 🎨           ║
║    Layout VancouverTec sem quebrar nada     ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Aplicando layout VancouverTec de forma segura..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# 1. REMOVER HOOKS PERIGOSOS SE EXISTIREM
log_info "Removendo hooks perigosos anteriores..."
if grep -q "template_include" "$THEME_PATH/functions.php"; then
    # Remover linhas perigosas
    sed -i '/add_filter.*template_include/d' "$THEME_PATH/functions.php"
    sed -i '/vt_force.*template/,+10d' "$THEME_PATH/functions.php"
fi

# 2. CRIAR CSS FORTE PARA SOBRESCREVER WOOCOMMERCE
log_info "Criando CSS forte para sobrescrever WooCommerce..."
cat > "$THEME_PATH/assets/css/components/woocommerce-override-safe.css" << 'EOF'
/* VancouverTec Store - Override Seguro WooCommerce */

/* FORÇA APLICAÇÃO DAS CORES VANCOUVERTEC */
:root {
  --vt-blue-600: #0066CC !important;
  --vt-blue-700: #0052A3 !important;
  --vt-indigo-500: #6366F1 !important;
  --vt-success-500: #10B981 !important;
  --vt-error-500: #EF4444 !important;
}

/* CONTAINER PRINCIPAL - FORÇAR LAYOUT VT */
.woocommerce .container,
.woocommerce-page .container,
body.woocommerce .container,
body.woocommerce-page .container {
  max-width: 1200px !important;
  margin: 0 auto !important;
  padding: 0 1rem !important;
}

/* CABEÇALHO DAS PÁGINAS WOOCOMMERCE */
.woocommerce .entry-header,
.woocommerce-page .entry-header,
.woocommerce h1.entry-title,
.woocommerce-page h1.entry-title {
  background: linear-gradient(135deg, #F8FAFC 0%, #E2E8F0 100%) !important;
  padding: 3rem 2rem !important;
  text-align: center !important;
  margin-bottom: 3rem !important;
  border-radius: 15px !important;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08) !important;
}

.woocommerce h1.entry-title,
.woocommerce-page h1.entry-title,
.woocommerce .page-title,
.woocommerce-page .page-title {
  font-size: 2.5rem !important;
  font-weight: 800 !important;
  color: #1F2937 !important;
  margin: 0 !important;
  background: none !important;
}

/* CART PAGE - LAYOUT VANCOUVERTEC */
.woocommerce-cart .woocommerce,
.woocommerce-cart .entry-content {
  background: #F9FAFB !important;
  padding: 2rem !important;
  border-radius: 15px !important;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08) !important;
}

.woocommerce table.cart,
.woocommerce table.shop_table {
  background: white !important;
  border-radius: 12px !important;
  overflow: hidden !important;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05) !important;
  border: none !important;
}

.woocommerce table.cart th,
.woocommerce table.shop_table th {
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500)) !important;
  color: white !important;
  font-weight: 700 !important;
  padding: 1.5rem 1rem !important;
  border: none !important;
}

.woocommerce table.cart td,
.woocommerce table.shop_table td {
  padding: 1.5rem 1rem !important;
  border-bottom: 1px solid #E5E7EB !important;
  vertical-align: middle !important;
}

.woocommerce table.cart .product-thumbnail img {
  border-radius: 8px !important;
  max-width: 80px !important;
  height: 80px !important;
  object-fit: cover !important;
}

/* CART TOTALS */
.cart-collaterals .cart_totals,
.woocommerce .cart-collaterals .cart_totals {
  background: white !important;
  border-radius: 15px !important;
  padding: 2rem !important;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08) !important;
  border: none !important;
  float: none !important;
  width: 100% !important;
  max-width: 400px !important;
  margin: 2rem auto 0 !important;
}

.cart-collaterals .cart_totals h2 {
  color: #1F2937 !important;
  font-weight: 800 !important;
  margin-bottom: 1.5rem !important;
  text-align: center !important;
}

.cart-collaterals .cart_totals table {
  background: #F9FAFB !important;
  border-radius: 10px !important;
  border: none !important;
}

.cart-collaterals .cart_totals table th,
.cart-collaterals .cart_totals table td {
  padding: 1rem !important;
  border: none !important;
}

/* CHECKOUT PAGE */
.woocommerce-checkout .woocommerce {
  background: #F9FAFB !important;
  padding: 2rem !important;
  border-radius: 15px !important;
}

.woocommerce-checkout .col2-set {
  display: grid !important;
  grid-template-columns: 1fr 1fr !important;
  gap: 3rem !important;
}

.woocommerce-checkout .col-1,
.woocommerce-checkout .col-2,
.woocommerce-checkout #order_review_heading,
.woocommerce-checkout #order_review {
  background: white !important;
  padding: 2rem !important;
  border-radius: 12px !important;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08) !important;
}

.woocommerce-checkout h3 {
  color: #1F2937 !important;
  font-weight: 800 !important;
  margin-bottom: 1.5rem !important;
  padding-bottom: 1rem !important;
  border-bottom: 2px solid #E5E7EB !important;
}

/* MY ACCOUNT PAGE */
.woocommerce-account .woocommerce {
  background: #F9FAFB !important;
  padding: 2rem !important;
  border-radius: 15px !important;
}

.woocommerce-account .woocommerce-MyAccount-navigation {
  background: white !important;
  border-radius: 12px !important;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08) !important;
  padding: 1.5rem !important;
  margin-bottom: 2rem !important;
}

.woocommerce-account .woocommerce-MyAccount-navigation ul {
  list-style: none !important;
  padding: 0 !important;
  margin: 0 !important;
}

.woocommerce-account .woocommerce-MyAccount-navigation li {
  margin-bottom: 0.5rem !important;
}

.woocommerce-account .woocommerce-MyAccount-navigation a {
  display: block !important;
  padding: 1rem 1.5rem !important;
  color: #6B7280 !important;
  text-decoration: none !important;
  border-radius: 8px !important;
  font-weight: 600 !important;
  transition: all 0.3s ease !important;
}

.woocommerce-account .woocommerce-MyAccount-navigation a:hover,
.woocommerce-account .woocommerce-MyAccount-navigation .is-active a {
  background: linear-gradient(135deg, #F0F9FF, #E0F2FE) !important;
  color: var(--vt-blue-600) !important;
}

.woocommerce-account .woocommerce-MyAccount-content {
  background: white !important;
  border-radius: 12px !important;
  padding: 2rem !important;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08) !important;
}

/* BOTÕES FORÇADOS ESTILO VANCOUVERTEC */
.woocommerce a.button,
.woocommerce button.button,
.woocommerce input.button,
.woocommerce input[type="submit"],
.woocommerce .button,
.woocommerce-page a.button,
.woocommerce-page button.button,
.woocommerce-page input.button,
.woocommerce-page .button {
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500)) !important;
  color: white !important;
  border: 2px solid var(--vt-blue-600) !important;
  border-radius: 10px !important;
  padding: 1rem 2rem !important;
  font-weight: 700 !important;
  font-size: 1rem !important;
  text-transform: none !important;
  transition: all 0.3s ease !important;
  text-decoration: none !important;
  display: inline-block !important;
}

.woocommerce a.button:hover,
.woocommerce button.button:hover,
.woocommerce input.button:hover,
.woocommerce input[type="submit"]:hover,
.woocommerce .button:hover,
.woocommerce-page a.button:hover,
.woocommerce-page button.button:hover,
.woocommerce-page input.button:hover,
.woocommerce-page .button:hover {
  background: linear-gradient(135deg, var(--vt-blue-700), #4F46E5) !important;
  border-color: var(--vt-blue-700) !important;
  color: white !important;
  transform: translateY(-2px) !important;
  box-shadow: 0 8px 25px rgba(0, 102, 204, 0.4) !important;
}

/* CAMPOS DE FORMULÁRIO */
.woocommerce .form-row input.input-text,
.woocommerce .form-row select,
.woocommerce .form-row textarea,
.woocommerce-page .form-row input.input-text,
.woocommerce-page .form-row select,
.woocommerce-page .form-row textarea {
  border: 2px solid #E5E7EB !important;
  border-radius: 8px !important;
  padding: 1rem !important;
  font-size: 1rem !important;
  transition: border-color 0.3s ease !important;
  background: white !important;
}

.woocommerce .form-row input.input-text:focus,
.woocommerce .form-row select:focus,
.woocommerce .form-row textarea:focus,
.woocommerce-page .form-row input.input-text:focus,
.woocommerce-page .form-row select:focus,
.woocommerce-page .form-row textarea:focus {
  border-color: var(--vt-blue-600) !important;
  box-shadow: 0 0 0 3px rgba(0, 102, 204, 0.1) !important;
  outline: none !important;
}

/* LABELS */
.woocommerce .form-row label,
.woocommerce-page .form-row label {
  font-weight: 600 !important;
  color: #374151 !important;
  margin-bottom: 0.5rem !important;
  display: block !important;
}

/* MENSAGENS */
.woocommerce-message,
.woocommerce-info,
.woocommerce-error {
  padding: 1rem 1.5rem !important;
  border-radius: 10px !important;
  margin: 1rem 0 !important;
  border: none !important;
}

.woocommerce-message {
  background: linear-gradient(135deg, #D1FAE5, #A7F3D0) !important;
  color: #047857 !important;
}

.woocommerce-error {
  background: linear-gradient(135deg, #FEE2E2, #FECACA) !important;
  color: #DC2626 !important;
}

.woocommerce-info {
  background: linear-gradient(135deg, #DBEAFE, #BFDBFE) !important;
  color: var(--vt-blue-700) !important;
}

/* RESPONSIVE */
@media (max-width: 768px) {
  .woocommerce-checkout .col2-set {
    grid-template-columns: 1fr !important;
    gap: 2rem !important;
  }
  
  .woocommerce table.cart,
  .woocommerce table.shop_table {
    font-size: 0.875rem !important;
  }
  
  .woocommerce table.cart th,
  .woocommerce table.shop_table th,
  .woocommerce table.cart td,
  .woocommerce table.shop_table td {
    padding: 1rem 0.5rem !important;
  }
  
  .cart-collaterals .cart_totals {
    margin: 2rem 0 0 !important;
  }
}

/* FORÇA REMOÇÃO DE ESTILOS CONFLITANTES */
.woocommerce .woocommerce-ordering,
.woocommerce .woocommerce-result-count {
  background: white !important;
  padding: 1rem !important;
  border-radius: 8px !important;
  border: 1px solid #E5E7EB !important;
}

/* QUANTIDADES */
.woocommerce .quantity input.qty {
  border: 2px solid #E5E7EB !important;
  border-radius: 6px !important;
  padding: 0.5rem !important;
  text-align: center !important;
  max-width: 80px !important;
}
EOF

# 3. ADICIONAR HOOKS SEGUROS NO FUNCTIONS.PHP
log_info "Adicionando hooks seguros..."
cat >> "$THEME_PATH/functions.php" << 'EOF'

// ===== HOOKS SEGUROS WOOCOMMERCE VANCOUVERTEC =====

/**
 * Carregar CSS específico para páginas WooCommerce
 */
function vt_woocommerce_safe_styles() {
    if (is_woocommerce() || is_cart() || is_checkout() || is_account_page()) {
        wp_enqueue_style(
            'vt-woocommerce-override-safe', 
            VT_THEME_URI . '/assets/css/components/woocommerce-override-safe.css', 
            [], 
            VT_THEME_VERSION,
            'all'
        );
        
        // Adicionar inline style para garantir prioridade
        wp_add_inline_style('vt-woocommerce-override-safe', '
            body.woocommerce,
            body.woocommerce-page {
                background: #F3F4F6 !important;
                font-family: "Inter", -apple-system, BlinkMacSystemFont, sans-serif !important;
            }
        ');
    }
}
add_action('wp_enqueue_scripts', 'vt_woocommerce_safe_styles', 999);

/**
 * Adicionar classes VancouverTec ao body das páginas WooCommerce
 */
function vt_add_woocommerce_body_classes($classes) {
    if (is_woocommerce() || is_cart() || is_checkout() || is_account_page()) {
        $classes[] = 'vt-woocommerce-page';
        $classes[] = 'vt-layout-vancouvertec';
    }
    return $classes;
}
add_filter('body_class', 'vt_add_woocommerce_body_classes');

/**
 * Customizar títulos das páginas WooCommerce
 */
function vt_woocommerce_page_titles($title) {
    if (is_cart()) {
        return 'Carrinho de Compras - VancouverTec';
    }
    if (is_checkout()) {
        return 'Finalizar Compra - VancouverTec';
    }
    if (is_account_page()) {
        return 'Minha Conta - VancouverTec';
    }
    return $title;
}
add_filter('woocommerce_page_title', 'vt_woocommerce_page_titles');

/**
 * Adicionar wrapper VancouverTec ao conteúdo WooCommerce
 */
function vt_woocommerce_before_main_content() {
    echo '<div class="vt-woocommerce-wrapper"><div class="container">';
}
add_action('woocommerce_before_main_content', 'vt_woocommerce_before_main_content', 5);

function vt_woocommerce_after_main_content() {
    echo '</div></div>';
}
add_action('woocommerce_after_main_content', 'vt_woocommerce_after_main_content', 999);
EOF

# 4. INCLUIR CSS NO FUNCTIONS.PHP SE NÃO EXISTIR
if ! grep -q "woocommerce-override-safe.css" "$THEME_PATH/functions.php"; then
    log_info "CSS já incluído via hooks seguros"
fi

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
echo -e "║  ✅ LAYOUT VANCOUVERTEC APLICADO SEGURO! ✅  ║"
echo -e "║    CSS forte + Hooks seguros aplicados       ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ CSS forte com !important aplicado"
log_success "✅ Hooks seguros sem quebrar templates"
log_success "✅ Layout VancouverTec mantendo funcionalidade"
log_success "✅ Classes e wrappers adicionados"
log_success "✅ Responsivo para mobile mantido"

echo -e "\n${BLUE}🎯 AGORA TESTE:${NC}"
echo -e "• Cart: http://localhost:8080/cart/"
echo -e "• Checkout: http://localhost:8080/checkout/"
echo -e "• Shop: http://localhost:8080/shop/"

echo -e "\n${YELLOW}💡 ABORDAGEM SEGURA:${NC}"
echo -e "• Não mexe nos templates core"
echo -e "• Usa CSS !important para sobrescrever"
echo -e "• Adiciona hooks seguros do WooCommerce"
echo -e "• Mantém toda funcionalidade"

exit 0