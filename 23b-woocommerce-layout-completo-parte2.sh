#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce Layout Completo PARTE 2
# Script: 23b-woocommerce-layout-completo-parte2.sh
# Versão: 1.0.0 - Checkout + My Account + Formulários
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
║  🎨 WOOCOMMERCE LAYOUT COMPLETO - PARTE 2 🎨 ║
║       Checkout + My Account + Formulários    ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Aplicando layout VancouverTec COMPLETO - Parte 2..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# 1. ADICIONAR CSS CHECKOUT + MY ACCOUNT
log_info "Adicionando CSS para Checkout e My Account..."
cat >> "$THEME_PATH/assets/css/components/woocommerce-vancouvertec-complete.css" << 'EOF'

/* ===== CHECKOUT PAGE ===== */
body.woocommerce-checkout .woocommerce .woocommerce-checkout {
  display: grid !important;
  grid-template-columns: 1fr 1fr !important;
  gap: 3rem !important;
  margin-top: 2rem !important;
}

body.woocommerce-checkout .col2-set .col-1,
body.woocommerce-checkout .col2-set .col-2 {
  background: white !important;
  padding: 2.5rem !important;
  border-radius: 20px !important;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1) !important;
  border: 2px solid rgba(0, 102, 204, 0.1) !important;
  margin-bottom: 0 !important;
}

body.woocommerce-checkout #order_review_heading {
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500)) !important;
  color: white !important;
  padding: 1.5rem 2.5rem !important;
  margin: 0 0 2rem 0 !important;
  border-radius: 20px 20px 0 0 !important;
  font-weight: 800 !important;
  text-align: center !important;
}

body.woocommerce-checkout #order_review {
  background: white !important;
  padding: 2.5rem !important;
  border-radius: 0 0 20px 20px !important;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1) !important;
  border: 2px solid rgba(0, 102, 204, 0.1) !important;
  border-top: none !important;
  margin: 0 !important;
}

body.woocommerce-checkout .woocommerce-checkout h3 {
  color: var(--vt-neutral-800) !important;
  font-weight: 800 !important;
  margin-bottom: 2rem !important;
  padding-bottom: 1rem !important;
  border-bottom: 3px solid var(--vt-blue-600) !important;
  font-size: 1.375rem !important;
  position: relative !important;
}

body.woocommerce-checkout .woocommerce-checkout h3::before {
  content: "📋" !important;
  margin-right: 0.75rem !important;
  font-size: 1.125rem !important;
}

/* ===== MY ACCOUNT PAGE ===== */
body.woocommerce-account .woocommerce {
  display: grid !important;
  grid-template-columns: 300px 1fr !important;
  gap: 3rem !important;
  align-items: flex-start !important;
}

body.woocommerce-account .woocommerce-MyAccount-navigation {
  background: white !important;
  border-radius: 20px !important;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1) !important;
  border: 2px solid rgba(0, 102, 204, 0.1) !important;
  padding: 0 !important;
  margin-bottom: 0 !important;
  overflow: hidden !important;
  position: sticky !important;
  top: 2rem !important;
}

body.woocommerce-account .woocommerce-MyAccount-navigation::before {
  content: "👤 Minha Conta" !important;
  display: block !important;
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500)) !important;
  color: white !important;
  padding: 1.5rem 2rem !important;
  font-weight: 800 !important;
  text-align: center !important;
  margin-bottom: 0 !important;
  font-size: 1.125rem !important;
}

body.woocommerce-account .woocommerce-MyAccount-navigation ul {
  list-style: none !important;
  padding: 1.5rem 0 !important;
  margin: 0 !important;
}

body.woocommerce-account .woocommerce-MyAccount-navigation li {
  margin-bottom: 0 !important;
  border-bottom: 1px solid #E5E7EB !important;
}

body.woocommerce-account .woocommerce-MyAccount-navigation li:last-child {
  border-bottom: none !important;
}

body.woocommerce-account .woocommerce-MyAccount-navigation a {
  display: flex !important;
  align-items: center !important;
  gap: 1rem !important;
  padding: 1.25rem 2rem !important;
  color: #6B7280 !important;
  text-decoration: none !important;
  font-weight: 600 !important;
  transition: all 0.3s ease !important;
  border-left: 4px solid transparent !important;
}

body.woocommerce-account .woocommerce-MyAccount-navigation a::before {
  content: "📋" !important;
  font-size: 1.125rem !important;
  opacity: 0.7 !important;
}

body.woocommerce-account .woocommerce-MyAccount-navigation .woocommerce-MyAccount-navigation-link--dashboard a::before {
  content: "🏠" !important;
}

body.woocommerce-account .woocommerce-MyAccount-navigation .woocommerce-MyAccount-navigation-link--orders a::before {
  content: "📦" !important;
}

body.woocommerce-account .woocommerce-MyAccount-navigation .woocommerce-MyAccount-navigation-link--downloads a::before {
  content: "⬇️" !important;
}

body.woocommerce-account .woocommerce-MyAccount-navigation .woocommerce-MyAccount-navigation-link--edit-address a::before {
  content: "📍" !important;
}

body.woocommerce-account .woocommerce-MyAccount-navigation .woocommerce-MyAccount-navigation-link--edit-account a::before {
  content: "👤" !important;
}

body.woocommerce-account .woocommerce-MyAccount-navigation .woocommerce-MyAccount-navigation-link--customer-logout a::before {
  content: "🚪" !important;
}

body.woocommerce-account .woocommerce-MyAccount-navigation a:hover,
body.woocommerce-account .woocommerce-MyAccount-navigation .is-active a {
  background: linear-gradient(135deg, #F0F9FF, #E0F2FE) !important;
  color: var(--vt-blue-600) !important;
  border-left-color: var(--vt-blue-600) !important;
  transform: translateX(4px) !important;
}

body.woocommerce-account .woocommerce-MyAccount-navigation a:hover::before,
body.woocommerce-account .woocommerce-MyAccount-navigation .is-active a::before {
  opacity: 1 !important;
  transform: scale(1.1) !important;
}

body.woocommerce-account .woocommerce-MyAccount-content {
  background: white !important;
  border-radius: 20px !important;
  padding: 3rem !important;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1) !important;
  border: 2px solid rgba(0, 102, 204, 0.1) !important;
}

body.woocommerce-account .woocommerce-MyAccount-content::before {
  content: "📊 Painel do Cliente" !important;
  display: block !important;
  background: linear-gradient(135deg, var(--vt-neutral-50), white) !important;
  color: var(--vt-neutral-800) !important;
  padding: 1.5rem 2rem !important;
  margin: -3rem -3rem 2rem -3rem !important;
  border-radius: 20px 20px 0 0 !important;
  border-bottom: 3px solid var(--vt-blue-600) !important;
  font-weight: 800 !important;
  text-align: center !important;
  font-size: 1.25rem !important;
}

/* ===== FORMULÁRIOS ===== */
body.woocommerce .form-row,
body.woocommerce-page .form-row {
  margin-bottom: 1.5rem !important;
}

body.woocommerce .form-row label,
body.woocommerce-page .form-row label {
  font-weight: 700 !important;
  color: var(--vt-neutral-800) !important;
  margin-bottom: 0.75rem !important;
  display: block !important;
  font-size: 0.9rem !important;
  text-transform: uppercase !important;
  letter-spacing: 0.05em !important;
}

body.woocommerce .form-row label .required,
body.woocommerce-page .form-row label .required {
  color: var(--vt-error-500) !important;
  font-weight: 800 !important;
}

body.woocommerce .form-row input.input-text,
body.woocommerce .form-row select,
body.woocommerce .form-row textarea,
body.woocommerce-page .form-row input.input-text,
body.woocommerce-page .form-row select,
body.woocommerce-page .form-row textarea {
  width: 100% !important;
  border: 2px solid #E5E7EB !important;
  border-radius: 12px !important;
  padding: 1rem 1.25rem !important;
  font-size: 1rem !important;
  font-weight: 500 !important;
  transition: all 0.3s ease !important;
  background: white !important;
  color: var(--vt-neutral-800) !important;
  line-height: 1.5 !important;
}

body.woocommerce .form-row input.input-text:focus,
body.woocommerce .form-row select:focus,
body.woocommerce .form-row textarea:focus,
body.woocommerce-page .form-row input.input-text:focus,
body.woocommerce-page .form-row select:focus,
body.woocommerce-page .form-row textarea:focus {
  border-color: var(--vt-blue-600) !important;
  box-shadow: 0 0 0 4px rgba(0, 102, 204, 0.1) !important;
  outline: none !important;
  transform: translateY(-1px) !important;
}

/* ===== BOTÕES VANCOUVERTEC ===== */
body.woocommerce a.button,
body.woocommerce button.button,
body.woocommerce input.button,
body.woocommerce input[type="submit"],
body.woocommerce .button,
body.woocommerce-page a.button,
body.woocommerce-page button.button,
body.woocommerce-page input.button,
body.woocommerce-page input[type="submit"],
body.woocommerce-page .button {
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500)) !important;
  color: white !important;
  border: 2px solid var(--vt-blue-600) !important;
  border-radius: 12px !important;
  padding: 1rem 2rem !important;
  font-weight: 800 !important;
  font-size: 1rem !important;
  text-transform: none !important;
  transition: all 0.3s ease !important;
  text-decoration: none !important;
  display: inline-block !important;
  cursor: pointer !important;
  box-shadow: 0 4px 15px rgba(0, 102, 204, 0.3) !important;
  letter-spacing: 0.025em !important;
}

body.woocommerce a.button:hover,
body.woocommerce button.button:hover,
body.woocommerce input.button:hover,
body.woocommerce input[type="submit"]:hover,
body.woocommerce .button:hover,
body.woocommerce-page a.button:hover,
body.woocommerce-page button.button:hover,
body.woocommerce-page input.button:hover,
body.woocommerce-page input[type="submit"]:hover,
body.woocommerce-page .button:hover {
  background: linear-gradient(135deg, var(--vt-blue-700), #4F46E5) !important;
  border-color: var(--vt-blue-700) !important;
  color: white !important;
  transform: translateY(-3px) !important;
  box-shadow: 0 8px 25px rgba(0, 102, 204, 0.4) !important;
}

/* ===== MENSAGENS ===== */
body.woocommerce .woocommerce-message,
body.woocommerce .woocommerce-info,
body.woocommerce .woocommerce-error,
body.woocommerce-page .woocommerce-message,
body.woocommerce-page .woocommerce-info,
body.woocommerce-page .woocommerce-error {
  padding: 1.5rem 2rem !important;
  border-radius: 15px !important;
  margin: 1.5rem 0 !important;
  border: none !important;
  font-weight: 600 !important;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1) !important;
  border-left: 5px solid !important;
}

body.woocommerce .woocommerce-message,
body.woocommerce-page .woocommerce-message {
  background: linear-gradient(135deg, #D1FAE5, #A7F3D0) !important;
  color: #047857 !important;
  border-left-color: var(--vt-success-500) !important;
}

body.woocommerce .woocommerce-message::before,
body.woocommerce-page .woocommerce-message::before {
  content: "✅ " !important;
  font-weight: 800 !important;
}

body.woocommerce .woocommerce-error,
body.woocommerce-page .woocommerce-error {
  background: linear-gradient(135deg, #FEE2E2, #FECACA) !important;
  color: #DC2626 !important;
  border-left-color: var(--vt-error-500) !important;
}

body.woocommerce .woocommerce-error::before,
body.woocommerce-page .woocommerce-error::before {
  content: "❌ " !important;
  font-weight: 800 !important;
}

body.woocommerce .woocommerce-info,
body.woocommerce-page .woocommerce-info {
  background: linear-gradient(135deg, #DBEAFE, #BFDBFE) !important;
  color: var(--vt-blue-700) !important;
  border-left-color: var(--vt-blue-600) !important;
}

body.woocommerce .woocommerce-info::before,
body.woocommerce-page .woocommerce-info::before {
  content: "ℹ️ " !important;
  font-weight: 800 !important;
}
EOF

# 2. ADICIONAR HOOKS AVANÇADOS NO FUNCTIONS.PHP
log_info "Adicionando hooks avançados..."
cat >> "$THEME_PATH/functions.php" << 'EOF'

/**
 * Customizar mensagens WooCommerce
 */
function vt_woocommerce_custom_messages() {
    // Mensagem carrinho vazio
    add_filter('wc_empty_cart_message', function($message) {
        return '<div class="vt-empty-cart-message">🛒 <strong>Seu carrinho está vazio!</strong><br>Que tal adicionar alguns produtos incríveis?</div>';
    });
    
    // Mensagem produto adicionado
    add_filter('wc_add_to_cart_message_html', function($message, $products) {
        return '<div class="vt-cart-success">✅ <strong>Produto adicionado com sucesso!</strong> ' . $message . '</div>';
    }, 10, 2);
}
add_action('init', 'vt_woocommerce_custom_messages');

/**
 * Customizar títulos das páginas
 */
function vt_woocommerce_custom_page_titles($title) {
    if (is_cart()) {
        return '🛒 Carrinho de Compras - VancouverTec';
    }
    if (is_checkout()) {
        return '💳 Finalizar Compra - VancouverTec';
    }
    if (is_account_page()) {
        return '👤 Minha Conta - VancouverTec';
    }
    return $title;
}
add_filter('woocommerce_page_title', 'vt_woocommerce_custom_page_titles');

/**
 * Adicionar JavaScript para melhorias UX
 */
function vt_woocommerce_scripts() {
    if (is_woocommerce() || is_cart() || is_checkout() || is_account_page()) {
        wp_add_inline_script('jquery', '
            jQuery(document).ready(function($) {
                // Smooth focus nos campos
                $(".form-row input, .form-row select, .form-row textarea").on("focus", function() {
                    $(this).closest(".form-row").addClass("focused");
                }).on("blur", function() {
                    $(this).closest(".form-row").removeClass("focused");
                });
                
                // Loading nos botões
                $(".button").on("click", function() {
                    if (!$(this).hasClass("no-loading")) {
                        $(this).addClass("loading").append(" <span class=\'spinner\'>⏳</span>");
                    }
                });
            });
        ');
    }
}
add_action('wp_enqueue_scripts', 'vt_woocommerce_scripts');
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
echo -e "║  ✅ PARTE 2 APLICADA COM SUCESSO! ✅         ║"
echo -e "║    Checkout + My Account + Formulários       ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Checkout page com grid layout aplicado"
log_success "✅ My Account com sidebar moderna"
log_success "✅ Formulários estilizados VancouverTec"
log_success "✅ Botões com gradiente e hover effects"
log_success "✅ Mensagens com ícones e cores"
log_success "✅ JavaScript para UX melhorada"

echo -e "\n${BLUE}📄 Digite 'continuar' para PARTE 3: Responsive + Finalizações${NC}"

exit 0