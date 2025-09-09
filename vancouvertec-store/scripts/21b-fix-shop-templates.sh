#!/bin/bash

# ===========================================
# VancouverTec Store - Fix Shop + Templates WooCommerce
# Script: 21b-fix-shop-templates.sh
# Versão: 1.0.0 - Archive Product + Cart + Checkout + Account
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
║    🔧 FIX SHOP + TEMPLATES WOOCOMMERCE 🔧    ║
║     Archive + Cart + Checkout + Account      ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Corrigindo templates WooCommerce..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# 1. ARCHIVE-PRODUCT.PHP (Shop com layout VancouverTec)
log_info "Criando archive-product.php para Shop..."
cat > "$THEME_PATH/woocommerce/archive-product.php" << 'EOF'
<?php get_header(); ?>

<div class="vt-shop-page">
    <div class="container">
        <div class="vt-shop-header">
            <h1 class="vt-shop-title"><?php woocommerce_page_title(); ?></h1>
            <div class="vt-shop-controls">
                <?php woocommerce_catalog_ordering(); ?>
                <?php woocommerce_result_count(); ?>
            </div>
        </div>
        
        <div class="vt-shop-content">
            <aside class="vt-shop-sidebar">
                <div class="vt-widget">
                    <h3>Categorias</h3>
                    <?php the_widget('WC_Widget_Product_Categories'); ?>
                </div>
                <div class="vt-widget">
                    <h3>Filtrar por Preço</h3>
                    <?php the_widget('WC_Widget_Price_Filter'); ?>
                </div>
            </aside>
            
            <main class="vt-shop-main">
                <?php if (woocommerce_product_loop()) : ?>
                    <div class="vt-products-grid">
                        <?php woocommerce_product_loop_start(); ?>
                        <?php while (have_posts()) : the_post(); ?>
                            <?php wc_get_template_part('content', 'product'); ?>
                        <?php endwhile; ?>
                        <?php woocommerce_product_loop_end(); ?>
                    </div>
                    <?php woocommerce_pagination(); ?>
                <?php else : ?>
                    <p>Nenhum produto encontrado.</p>
                <?php endif; ?>
            </main>
        </div>
    </div>
</div>

<?php get_footer(); ?>
EOF

# 2. CART.PHP
log_info "Criando cart.php..."
cat > "$THEME_PATH/woocommerce/cart/cart.php" << 'EOF'
<?php
defined('ABSPATH') || exit;
do_action('woocommerce_before_cart'); ?>

<div class="vt-cart-page">
    <div class="container">
        <h1 class="vt-page-title">Carrinho de Compras</h1>
        
        <form class="woocommerce-cart-form" action="<?php echo esc_url(wc_get_cart_url()); ?>" method="post">
            <div class="vt-cart-content">
                <div class="vt-cart-items">
                    <table class="shop_table vt-cart-table">
                        <thead>
                            <tr>
                                <th>Produto</th>
                                <th>Preço</th>
                                <th>Quantidade</th>
                                <th>Subtotal</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php do_action('woocommerce_before_cart_contents'); ?>

                            <?php foreach (WC()->cart->get_cart() as $cart_item_key => $cart_item) {
                                $_product = apply_filters('woocommerce_cart_item_product', $cart_item['data'], $cart_item, $cart_item_key);
                                $product_id = apply_filters('woocommerce_cart_item_product_id', $cart_item['product_id'], $cart_item, $cart_item_key);

                                if ($_product && $_product->exists() && $cart_item['quantity'] > 0 && apply_filters('woocommerce_cart_item_visible', true, $cart_item, $cart_item_key)) {
                                    $product_permalink = apply_filters('woocommerce_cart_item_permalink', $_product->is_visible() ? $_product->get_permalink($cart_item) : '', $cart_item, $cart_item_key);
                                    ?>
                                    <tr class="woocommerce-cart-form__cart-item">
                                        <td class="product-info">
                                            <?php echo apply_filters('woocommerce_cart_item_thumbnail', $_product->get_image(), $cart_item, $cart_item_key); ?>
                                            <div class="product-details">
                                                <h4><?php echo $_product->get_name(); ?></h4>
                                            </div>
                                        </td>
                                        <td class="product-price">
                                            <?php echo apply_filters('woocommerce_cart_item_price', WC()->cart->get_product_price($_product), $cart_item, $cart_item_key); ?>
                                        </td>
                                        <td class="product-quantity">
                                            <?php
                                            if ($_product->is_sold_individually()) {
                                                $product_quantity = sprintf('1 <input type="hidden" name="cart[%s][qty]" value="1" />', $cart_item_key);
                                            } else {
                                                $product_quantity = woocommerce_quantity_input(array(
                                                    'input_name'   => "cart[{$cart_item_key}][qty]",
                                                    'input_value'  => $cart_item['quantity'],
                                                    'max_value'    => $_product->get_max_purchase_quantity(),
                                                    'min_value'    => '0',
                                                    'product_name' => $_product->get_name(),
                                                ), $_product, false);
                                            }
                                            echo apply_filters('woocommerce_cart_item_quantity', $product_quantity, $cart_item_key, $cart_item);
                                            ?>
                                        </td>
                                        <td class="product-subtotal">
                                            <?php echo apply_filters('woocommerce_cart_item_subtotal', WC()->cart->get_product_subtotal($_product, $cart_item['quantity']), $cart_item, $cart_item_key); ?>
                                        </td>
                                        <td class="product-remove">
                                            <?php
                                                echo apply_filters('woocommerce_cart_item_remove_link', sprintf(
                                                    '<a href="%s" class="remove" aria-label="Remover item">×</a>',
                                                    esc_url(wc_get_cart_remove_url($cart_item_key))
                                                ), $cart_item_key);
                                            ?>
                                        </td>
                                    </tr>
                                    <?php
                                }
                            } ?>

                            <tr>
                                <td colspan="5" class="actions">
                                    <div class="vt-cart-actions">
                                        <button type="submit" class="button update-cart" name="update_cart" value="Atualizar carrinho">
                                            Atualizar carrinho
                                        </button>
                                        <a href="<?php echo esc_url(apply_filters('woocommerce_return_to_shop_redirect', wc_get_page_permalink('shop'))); ?>" class="continue-shopping">
                                            ← Continuar Comprando
                                        </a>
                                    </div>
                                    <?php wp_nonce_field('woocommerce-cart', 'woocommerce-cart-nonce'); ?>
                                </td>
                            </tr>

                            <?php do_action('woocommerce_after_cart_contents'); ?>
                        </tbody>
                    </table>
                </div>

                <div class="vt-cart-totals">
                    <?php do_action('woocommerce_cart_collaterals'); ?>
                </div>
            </div>
        </form>
    </div>
</div>

<?php do_action('woocommerce_after_cart'); ?>
EOF

# 3. CHECKOUT FORM
log_info "Criando form-checkout.php..."
cat > "$THEME_PATH/woocommerce/checkout/form-checkout.php" << 'EOF'
<?php
if (!defined('ABSPATH')) exit;

do_action('woocommerce_before_checkout_form', $checkout);

if (!$checkout->is_registration_enabled() && $checkout->is_registration_required() && !is_user_logged_in()) {
    echo esc_html(apply_filters('woocommerce_checkout_must_be_logged_in_message', __('Você deve estar logado para finalizar a compra.', 'vancouvertec')));
    return;
}
?>

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

        <form name="checkout" method="post" class="checkout woocommerce-checkout" action="<?php echo esc_url(wc_get_checkout_url()); ?>" enctype="multipart/form-data">

            <div class="vt-checkout-content">
                <div class="vt-checkout-form">
                    <?php if ($checkout->get_checkout_fields()) : ?>
                        <?php do_action('woocommerce_checkout_before_customer_details'); ?>

                        <div class="vt-customer-details">
                            <div class="vt-billing-fields">
                                <h3>Informações de Cobrança</h3>
                                <?php do_action('woocommerce_checkout_billing'); ?>
                            </div>

                            <?php if (WC()->cart->needs_shipping_address()) : ?>
                                <div class="vt-shipping-fields">
                                    <h3>Informações de Entrega</h3>
                                    <?php do_action('woocommerce_checkout_shipping'); ?>
                                </div>
                            <?php endif; ?>
                        </div>

                        <?php do_action('woocommerce_checkout_after_customer_details'); ?>
                    <?php endif; ?>
                </div>

                <div class="vt-order-review">
                    <h3>Seu Pedido</h3>
                    <?php do_action('woocommerce_checkout_before_order_review_heading'); ?>
                    <?php do_action('woocommerce_checkout_before_order_review'); ?>

                    <div id="order_review" class="woocommerce-checkout-review-order">
                        <?php do_action('woocommerce_checkout_order_review'); ?>
                    </div>

                    <?php do_action('woocommerce_checkout_after_order_review'); ?>
                </div>
            </div>
        </form>
    </div>
</div>

<?php do_action('woocommerce_after_checkout_form', $checkout); ?>
EOF

# 4. MY ACCOUNT
log_info "Criando my-account.php..."
cat > "$THEME_PATH/woocommerce/myaccount/my-account.php" << 'EOF'
<?php
if (!defined('ABSPATH')) exit;

do_action('woocommerce_before_account_navigation');
?>

<div class="vt-account-page">
    <div class="container">
        <h1 class="vt-page-title">Minha Conta</h1>
        <p class="vt-account-welcome">Olá, <?php echo esc_html($current_user->display_name); ?>!</p>

        <div class="vt-account-content">
            <nav class="woocommerce-MyAccount-navigation">
                <ul>
                    <?php foreach (wc_get_account_menu_items() as $endpoint => $label) : ?>
                        <li class="<?php echo wc_get_account_menu_item_classes($endpoint); ?>">
                            <a href="<?php echo esc_url(wc_get_account_endpoint_url($endpoint)); ?>" class="vt-account-nav-link">
                                <?php 
                                $icons = array(
                                    'dashboard' => '🏠',
                                    'orders' => '📦',
                                    'downloads' => '⬇️',
                                    'edit-address' => '📍',
                                    'edit-account' => '👤',
                                    'customer-logout' => '🚪'
                                );
                                echo isset($icons[$endpoint]) ? $icons[$endpoint] . ' ' : '';
                                echo esc_html($label); 
                                ?>
                            </a>
                        </li>
                    <?php endforeach; ?>
                </ul>
            </nav>

            <div class="woocommerce-MyAccount-content">
                <?php do_action('woocommerce_account_content'); ?>
            </div>
        </div>
    </div>
</div>
EOF

# 5. CSS PARA TODOS OS TEMPLATES
log_info "Criando CSS para shop e templates..."
cat > "$THEME_PATH/assets/css/components/woocommerce-shop-templates.css" << 'EOF'
/* VancouverTec - Shop + Templates CSS */

/* SHOP PAGE */
.vt-shop-page {
  padding: 2rem 0 4rem;
}

.vt-shop-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 3rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #E5E7EB;
}

.vt-shop-title {
  font-size: 2.5rem;
  font-weight: 800;
  color: #1F2937;
}

.vt-shop-controls {
  display: flex;
  gap: 1rem;
  align-items: center;
}

.vt-shop-content {
  display: grid;
  grid-template-columns: 280px 1fr;
  gap: 3rem;
}

.vt-shop-sidebar {
  background: #F9FAFB;
  padding: 2rem;
  border-radius: 15px;
  height: fit-content;
  position: sticky;
  top: 2rem;
}

.vt-widget {
  margin-bottom: 2rem;
}

.vt-widget h3 {
  font-size: 1.125rem;
  font-weight: 700;
  color: #1F2937;
  margin-bottom: 1rem;
}

.vt-products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 2rem;
}

/* CART PAGE */
.vt-cart-page {
  padding: 2rem 0 4rem;
}

.vt-page-title {
  font-size: 2.5rem;
  font-weight: 800;
  color: #1F2937;
  margin-bottom: 2rem;
  text-align: center;
}

.vt-cart-content {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 3rem;
}

.vt-cart-items {
  background: white;
  border-radius: 15px;
  padding: 2rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.vt-cart-table {
  width: 100%;
  border-collapse: collapse;
}

.vt-cart-table th {
  padding: 1rem;
  background: #F9FAFB;
  font-weight: 700;
  color: #374151;
  border-bottom: 2px solid #E5E7EB;
}

.vt-cart-table td {
  padding: 1.5rem 1rem;
  border-bottom: 1px solid #E5E7EB;
  vertical-align: middle;
}

.product-info {
  display: flex;
  gap: 1rem;
  align-items: center;
}

.product-info img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 10px;
}

.vt-cart-totals {
  background: white;
  border-radius: 15px;
  padding: 2rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  height: fit-content;
  position: sticky;
  top: 2rem;
}

/* CHECKOUT PAGE */
.vt-checkout-page {
  padding: 2rem 0 4rem;
}

.vt-checkout-steps {
  display: flex;
  justify-content: center;
  gap: 3rem;
  margin-bottom: 3rem;
}

.vt-step {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
}

.vt-step-number {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: #E5E7EB;
  color: #6B7280;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
}

.vt-step.active .vt-step-number {
  background: var(--vt-blue-600);
  color: white;
}

.vt-step-label {
  font-size: 0.875rem;
  font-weight: 600;
  color: #6B7280;
}

.vt-step.active .vt-step-label {
  color: var(--vt-blue-600);
}

.vt-checkout-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
}

.vt-checkout-form {
  background: white;
  border-radius: 15px;
  padding: 2rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.vt-order-review {
  background: white;
  border-radius: 15px;
  padding: 2rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  height: fit-content;
  position: sticky;
  top: 2rem;
}

/* MY ACCOUNT */
.vt-account-page {
  padding: 2rem 0 4rem;
}

.vt-account-welcome {
  font-size: 1.125rem;
  color: #6B7280;
  text-align: center;
  margin-bottom: 3rem;
}

.vt-account-content {
  display: grid;
  grid-template-columns: 280px 1fr;
  gap: 3rem;
}

.woocommerce-MyAccount-navigation {
  background: white;
  border-radius: 15px;
  padding: 2rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  height: fit-content;
  position: sticky;
  top: 2rem;
}

.woocommerce-MyAccount-navigation ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.woocommerce-MyAccount-navigation li {
  margin-bottom: 0.5rem;
}

.vt-account-nav-link {
  display: block;
  padding: 1rem;
  color: #6B7280;
  text-decoration: none;
  border-radius: 8px;
  font-weight: 600;
  transition: all 0.3s ease;
}

.vt-account-nav-link:hover,
.is-active .vt-account-nav-link {
  background: #F0F9FF;
  color: var(--vt-blue-600);
}

.woocommerce-MyAccount-content {
  background: white;
  border-radius: 15px;
  padding: 2rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

/* BOTÕES WOOCOMMERCE */
.woocommerce .button,
.woocommerce button.button,
.woocommerce input.button {
  background: var(--vt-blue-600) !important;
  color: white !important;
  border: 1px solid var(--vt-blue-600) !important;
  border-radius: 8px !important;
  font-weight: 600 !important;
  transition: all 0.3s ease !important;
}

.woocommerce .button:hover,
.woocommerce button.button:hover,
.woocommerce input.button:hover {
  background: var(--vt-blue-700) !important;
  border-color: var(--vt-blue-700) !important;
  color: white !important;
  transform: translateY(-1px) !important;
}

/* RESPONSIVE */
@media (max-width: 1024px) {
  .vt-shop-content,
  .vt-cart-content,
  .vt-checkout-content,
  .vt-account-content {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .vt-shop-sidebar,
  .vt-cart-totals,
  .vt-order-review,
  .woocommerce-MyAccount-navigation {
    position: relative;
    top: 0;
  }
}

@media (max-width: 768px) {
  .vt-shop-header {
    flex-direction: column;
    gap: 1rem;
    align-items: flex-start;
  }
  
  .vt-checkout-steps {
    gap: 1rem;
  }
}
EOF

# Incluir CSS no functions.php
if ! grep -q "woocommerce-shop-templates.css" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_style.*vt-woocommerce-templates-vt/a\    wp_enqueue_style('"'"'vt-woocommerce-shop-templates'"'"', VT_THEME_URI . '"'"'/assets/css/components/woocommerce-shop-templates.css'"'"', ['"'"'vt-woocommerce-templates-vt'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"
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
echo -e "║   ✅ TODOS TEMPLATES WOOCOMMERCE CRIADOS! ✅  ║"
echo -e "║    Shop + Cart + Checkout + My Account       ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ archive-product.php (Shop com layout VT)"
log_success "✅ cart.php (Carrinho com design customizado)"
log_success "✅ form-checkout.php (Checkout com steps)"
log_success "✅ my-account.php (Painel do cliente)"
log_success "✅ CSS unificado para todos templates"

echo -e "\n${BLUE}🎯 Agora todos templates WooCommerce seguem o layout VancouverTec!${NC}"

exit 0