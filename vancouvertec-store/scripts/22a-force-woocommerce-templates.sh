#!/bin/bash

# ===========================================
# VancouverTec Store - Force WooCommerce Templates
# Script: 22a-force-woocommerce-templates.sh
# Versão: 1.0.0 - Forçar uso dos nossos templates
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
║    🔧 FORCE WOOCOMMERCE TEMPLATES 🔧        ║
║       Forçar uso dos nossos templates        ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Forçando WordPress a usar nossos templates..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# 1. ADICIONAR HOOKS NO FUNCTIONS.PHP PARA FORÇAR TEMPLATES
log_info "Adicionando hooks para forçar templates..."
cat >> "$THEME_PATH/functions.php" << 'EOF'

// ===== FORÇAR TEMPLATES WOOCOMMERCE =====

// Forçar template para página Cart
function vt_force_cart_template($template) {
    if (is_cart()) {
        $cart_template = locate_template('woocommerce/cart/cart.php');
        if ($cart_template) {
            return $cart_template;
        }
    }
    return $template;
}
add_filter('template_include', 'vt_force_cart_template', 99);

// Forçar template para página Checkout
function vt_force_checkout_template($template) {
    if (is_checkout()) {
        $checkout_template = locate_template('woocommerce/checkout/form-checkout.php');
        if ($checkout_template) {
            return $checkout_template;
        }
    }
    return $template;
}
add_filter('template_include', 'vt_force_checkout_template', 99);

// Forçar template para My Account
function vt_force_account_template($template) {
    if (is_account_page()) {
        $account_template = locate_template('woocommerce/myaccount/my-account.php');
        if ($account_template) {
            return $account_template;
        }
    }
    return $template;
}
add_filter('template_include', 'vt_force_account_template', 99);

// Desabilitar Elementor para páginas WooCommerce
function vt_disable_elementor_woocommerce($post_id) {
    if (is_cart() || is_checkout() || is_account_page() || is_shop()) {
        return false;
    }
    return $post_id;
}
add_filter('elementor/frontend/builder_content_display', 'vt_disable_elementor_woocommerce');

// Remover conteúdo de página para WooCommerce
function vt_remove_woocommerce_page_content() {
    if (is_cart() || is_checkout() || is_account_page()) {
        remove_filter('the_content', 'wpautop');
        add_filter('the_content', function($content) {
            if (is_cart() || is_checkout() || is_account_page()) {
                return '';
            }
            return $content;
        }, 999);
    }
}
add_action('wp', 'vt_remove_woocommerce_page_content');

// Debug: Verificar qual template está sendo usado
function vt_debug_template() {
    if (current_user_can('manage_options') && isset($_GET['debug_template'])) {
        global $template;
        echo '<div style="background: red; color: white; padding: 10px; position: fixed; top: 0; left: 0; z-index: 9999;">Template: ' . $template . '</div>';
    }
}
add_action('wp_footer', 'vt_debug_template');
EOF

# 2. CRIAR PAGE TEMPLATES ESPECÍFICOS
log_info "Criando page templates específicos..."

# Page template para Cart
cat > "$THEME_PATH/page-cart.php" << 'EOF'
<?php
/**
 * Template Name: Cart VancouverTec
 */

get_header(); ?>

<div class="vt-cart-page">
    <div class="container">
        <h1 class="vt-page-title">Carrinho de Compras</h1>
        
        <?php if (function_exists('woocommerce_cart_totals')) : ?>
            <?php echo do_shortcode('[woocommerce_cart]'); ?>
        <?php else : ?>
            <p>WooCommerce não está ativo.</p>
        <?php endif; ?>
    </div>
</div>

<?php get_footer(); ?>
EOF

# Page template para Checkout
cat > "$THEME_PATH/page-checkout.php" << 'EOF'
<?php
/**
 * Template Name: Checkout VancouverTec
 */

get_header(); ?>

<div class="vt-checkout-page">
    <div class="container">
        <h1 class="vt-page-title">Finalizar Compra</h1>
        
        <div class="vt-checkout-steps">
            <div class="vt-step active">
                <span class="vt-step-number">1</span>
                <span class="vt-step-label">Informações</span>
            </div>
            <div class="vt-step">
                <span class="vt-step-number">2</span>
                <span class="vt-step-label">Pagamento</span>
            </div>
            <div class="vt-step">
                <span class="vt-step-number">3</span>
                <span class="vt-step-label">Confirmação</span>
            </div>
        </div>
        
        <?php if (function_exists('woocommerce_checkout')) : ?>
            <?php echo do_shortcode('[woocommerce_checkout]'); ?>
        <?php else : ?>
            <p>WooCommerce não está ativo.</p>
        <?php endif; ?>
    </div>
</div>

<?php get_footer(); ?>
EOF

# Page template para My Account
cat > "$THEME_PATH/page-my-account.php" << 'EOF'
<?php
/**
 * Template Name: My Account VancouverTec
 */

get_header(); ?>

<div class="vt-account-page">
    <div class="container">
        <h1 class="vt-page-title">Minha Conta</h1>
        
        <?php if (function_exists('woocommerce_account_content')) : ?>
            <?php echo do_shortcode('[woocommerce_my_account]'); ?>
        <?php else : ?>
            <p>WooCommerce não está ativo.</p>
        <?php endif; ?>
    </div>
</div>

<?php get_footer(); ?>
EOF

# 3. CRIAR SHORTCODE PERSONALIZADO PARA CART
log_info "Criando shortcode customizado para cart..."
cat >> "$THEME_PATH/functions.php" << 'EOF'

// ===== SHORTCODES CUSTOMIZADOS =====

// Shortcode Cart customizado
function vt_custom_cart_shortcode() {
    if (!function_exists('WC')) {
        return '<p>WooCommerce não está ativo.</p>';
    }
    
    ob_start();
    
    if (WC()->cart->is_empty()) {
        echo '<div class="vt-empty-cart">';
        echo '<h3>Seu carrinho está vazio</h3>';
        echo '<p>Adicione alguns produtos incríveis ao seu carrinho!</p>';
        echo '<a href="' . get_permalink(wc_get_page_id('shop')) . '" class="button">Ir às Compras</a>';
        echo '</div>';
    } else {
        // Incluir template do cart
        $template = locate_template('woocommerce/cart/cart.php');
        if ($template) {
            include $template;
        } else {
            wc_get_template('cart/cart.php');
        }
    }
    
    return ob_get_clean();
}
add_shortcode('vt_cart', 'vt_custom_cart_shortcode');

// Shortcode Checkout customizado
function vt_custom_checkout_shortcode() {
    if (!function_exists('WC')) {
        return '<p>WooCommerce não está ativo.</p>';
    }
    
    ob_start();
    
    // Incluir template do checkout
    $template = locate_template('woocommerce/checkout/form-checkout.php');
    if ($template) {
        global $woocommerce;
        $checkout = WC()->checkout();
        if (!$checkout) {
            return '<p>Erro no checkout.</p>';
        }
        include $template;
    } else {
        echo do_shortcode('[woocommerce_checkout]');
    }
    
    return ob_get_clean();
}
add_shortcode('vt_checkout', 'vt_custom_checkout_shortcode');
EOF

# 4. ATUALIZAR CSS PARA GARANTIR QUE FUNCIONE
log_info "Atualizando CSS para garantir compatibilidade..."
cat >> "$THEME_PATH/assets/css/components/woocommerce-shop-templates.css" << 'EOF'

/* FORÇA ESTILOS WOOCOMMERCE */
.vt-cart-page .woocommerce,
.vt-checkout-page .woocommerce,
.vt-account-page .woocommerce {
  background: transparent !important;
  padding: 0 !important;
  margin: 0 !important;
}

.vt-empty-cart {
  text-align: center;
  padding: 4rem 2rem;
  background: white;
  border-radius: 15px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.vt-empty-cart h3 {
  font-size: 2rem;
  color: #1F2937;
  margin-bottom: 1rem;
}

.vt-empty-cart p {
  color: #6B7280;
  margin-bottom: 2rem;
  font-size: 1.125rem;
}

.vt-empty-cart .button {
  background: var(--vt-blue-600) !important;
  color: white !important;
  padding: 1rem 2rem !important;
  border-radius: 10px !important;
  text-decoration: none !important;
  font-weight: 600 !important;
}

/* DEBUG TEMPLATE */
.template-debug {
  position: fixed;
  top: 0;
  right: 0;
  background: red;
  color: white;
  padding: 10px;
  z-index: 9999;
  font-size: 12px;
}
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
echo -e "║  ✅ TEMPLATES WOOCOMMERCE FORÇADOS! ✅       ║"
echo -e "║    Hooks + Page Templates + Shortcodes       ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Hooks adicionados para forçar templates"
log_success "✅ Page templates específicos criados"
log_success "✅ Elementor desabilitado para WooCommerce"
log_success "✅ Shortcodes customizados criados"
log_success "✅ CSS atualizado para compatibilidade"

echo -e "\n${BLUE}🔧 Para debug, acesse: http://localhost:8080/cart/?debug_template=1${NC}"
echo -e "${YELLOW}Se ainda não funcionar, vá no admin WordPress:${NC}"
echo -e "• Páginas > Cart > Template: Selecione 'Cart VancouverTec'"
echo -e "• Páginas > Checkout > Template: Selecione 'Checkout VancouverTec'"
echo -e "• Páginas > My Account > Template: Selecione 'My Account VancouverTec'"

exit 0