#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce Cart/Checkout PARTE 3
# Script: 10c-woocommerce-cart-checkout-parte3.sh
# Versão: 1.0.0 - Cart + Checkout + My Account
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
║   🛒 WOOCOMMERCE CART/CHECKOUT - PARTE 3 🛒  ║
║      Cart + Checkout + My Account            ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Criando templates Cart, Checkout e Account..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# 1. CART.PHP
log_info "Criando cart.php..."
cat > "$THEME_PATH/woocommerce/cart/cart.php" << 'EOF'
<?php
/**
 * Cart Page Template - VancouverTec Store
 */

defined('ABSPATH') || exit;

do_action('woocommerce_before_cart'); ?>

<div class="cart-page">
    <div class="container">
        <div class="cart-header">
            <h1 class="cart-title">Carrinho de Compras</h1>
            <div class="cart-breadcrumb">
                <?php woocommerce_breadcrumb(); ?>
            </div>
        </div>

        <form class="woocommerce-cart-form" action="<?php echo esc_url(wc_get_cart_url()); ?>" method="post">
            <?php do_action('woocommerce_before_cart_table'); ?>

            <div class="cart-content">
                <div class="cart-items">
                    <table class="shop_table shop_table_responsive cart woocommerce-cart-form__contents">
                        <thead>
                            <tr>
                                <th class="product-thumbnail">Produto</th>
                                <th class="product-name"></th>
                                <th class="product-price">Preço</th>
                                <th class="product-quantity">Quantidade</th>
                                <th class="product-subtotal">Subtotal</th>
                                <th class="product-remove"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php do_action('woocommerce_before_cart_contents'); ?>

                            <?php
                            foreach (WC()->cart->get_cart() as $cart_item_key => $cart_item) {
                                $_product   = apply_filters('woocommerce_cart_item_product', $cart_item['data'], $cart_item, $cart_item_key);
                                $product_id = apply_filters('woocommerce_cart_item_product_id', $cart_item['product_id'], $cart_item, $cart_item_key);

                                if ($_product && $_product->exists() && $cart_item['quantity'] > 0 && apply_filters('woocommerce_cart_item_visible', true, $cart_item, $cart_item_key)) {
                                    $product_permalink = apply_filters('woocommerce_cart_item_permalink', $_product->is_visible() ? $_product->get_permalink($cart_item) : '', $cart_item, $cart_item_key);
                                    ?>
                                    <tr class="woocommerce-cart-form__cart-item <?php echo esc_attr(apply_filters('woocommerce_cart_item_class', 'cart_item', $cart_item, $cart_item_key)); ?>">

                                        <td class="product-thumbnail">
                                            <?php
                                            $thumbnail = apply_filters('woocommerce_cart_item_thumbnail', $_product->get_image(), $cart_item, $cart_item_key);

                                            if (!$product_permalink) {
                                                echo $thumbnail;
                                            } else {
                                                printf('<a href="%s">%s</a>', esc_url($product_permalink), $thumbnail);
                                            }
                                            ?>
                                        </td>

                                        <td class="product-name" data-title="Produto">
                                            <?php
                                            if (!$product_permalink) {
                                                echo wp_kses_post(apply_filters('woocommerce_cart_item_name', $_product->get_name(), $cart_item, $cart_item_key) . '&nbsp;');
                                            } else {
                                                echo wp_kses_post(apply_filters('woocommerce_cart_item_name', sprintf('<a href="%s">%s</a>', esc_url($product_permalink), $_product->get_name()), $cart_item, $cart_item_key));
                                            }

                                            do_action('woocommerce_after_cart_item_name', $cart_item, $cart_item_key);

                                            echo wc_get_formatted_cart_item_data($cart_item);

                                            if ($_product->backorders_require_notification() && $_product->is_on_backorder($cart_item['quantity'])) {
                                                echo wp_kses_post(apply_filters('woocommerce_cart_item_backorder_notification', '<p class="backorder_notification">' . esc_html__('Disponível em pré-venda', 'vancouvertec') . '</p>', $product_id));
                                            }
                                            ?>
                                        </td>

                                        <td class="product-price" data-title="Preço">
                                            <?php
                                                echo apply_filters('woocommerce_cart_item_price', WC()->cart->get_product_price($_product), $cart_item, $cart_item_key);
                                            ?>
                                        </td>

                                        <td class="product-quantity" data-title="Quantidade">
                                            <?php
                                            if ($_product->is_sold_individually()) {
                                                $min_quantity = 1;
                                                $max_quantity = 1;
                                            } else {
                                                $min_quantity = 0;
                                                $max_quantity = $_product->get_max_purchase_quantity();
                                            }

                                            $product_quantity = woocommerce_quantity_input(
                                                array(
                                                    'input_name'   => "cart[{$cart_item_key}][qty]",
                                                    'input_value'  => $cart_item['quantity'],
                                                    'max_value'    => $max_quantity,
                                                    'min_value'    => $min_quantity,
                                                    'product_name' => $_product->get_name(),
                                                ),
                                                $_product,
                                                false
                                            );

                                            echo apply_filters('woocommerce_cart_item_quantity', $product_quantity, $cart_item_key, $cart_item);
                                            ?>
                                        </td>

                                        <td class="product-subtotal" data-title="Subtotal">
                                            <?php
                                                echo apply_filters('woocommerce_cart_item_subtotal', WC()->cart->get_product_subtotal($_product, $cart_item['quantity']), $cart_item, $cart_item_key);
                                            ?>
                                        </td>

                                        <td class="product-remove">
                                            <?php
                                                echo apply_filters(
                                                    'woocommerce_cart_item_remove_link',
                                                    sprintf(
                                                        '<a href="%s" class="remove" aria-label="%s" data-product_id="%s" data-product_sku="%s">×</a>',
                                                        esc_url(wc_get_cart_remove_url($cart_item_key)),
                                                        esc_html__('Remover item', 'vancouvertec'),
                                                        esc_attr($product_id),
                                                        esc_attr($_product->get_sku())
                                                    ),
                                                    $cart_item_key
                                                );
                                            ?>
                                        </td>
                                    </tr>
                                    <?php
                                }
                            }
                            ?>

                            <?php do_action('woocommerce_cart_contents'); ?>

                            <tr>
                                <td colspan="6" class="actions">
                                    <div class="cart-actions">
                                        <button type="submit" class="button update-cart" name="update_cart" value="Atualizar carrinho" formnovalidate>
                                            Atualizar carrinho
                                        </button>
                                        
                                        <a href="<?php echo esc_url(apply_filters('woocommerce_return_to_shop_redirect', wc_get_page_permalink('shop'))); ?>" class="continue-shopping">
                                            ← Continuar Comprando
                                        </a>
                                    </div>

                                    <?php do_action('woocommerce_cart_actions'); ?>
                                    <?php wp_nonce_field('woocommerce-cart', 'woocommerce-cart-nonce'); ?>
                                </td>
                            </tr>

                            <?php do_action('woocommerce_after_cart_contents'); ?>
                        </tbody>
                    </table>
                </div>

                <div class="cart-totals">
                    <?php do_action('woocommerce_before_cart_collaterals'); ?>
                    <div class="cart-collaterals">
                        <?php
                            do_action('woocommerce_cart_collaterals');
                        ?>
                    </div>
                </div>
            </div>

            <?php do_action('woocommerce_after_cart_table'); ?>
        </form>

        <?php do_action('woocommerce_before_cart_collaterals'); ?>
    </div>
</div>

<?php do_action('woocommerce_after_cart'); ?>
EOF

# 2. CHECKOUT.PHP (simplificado)
log_info "Criando checkout templates..."
mkdir -p "$THEME_PATH/woocommerce/checkout"

cat > "$THEME_PATH/woocommerce/checkout/form-checkout.php" << 'EOF'
<?php
/**
 * Checkout Form Template - VancouverTec Store
 */

if (!defined('ABSPATH')) {
    exit;
}

do_action('woocommerce_before_checkout_form', $checkout);

if (!$checkout->is_registration_enabled() && $checkout->is_registration_required() && !is_user_logged_in()) {
    echo esc_html(apply_filters('woocommerce_checkout_must_be_logged_in_message', __('Você deve estar logado para finalizar a compra.', 'vancouvertec')));
    return;
}
?>

<div class="checkout-page">
    <div class="container">
        <div class="checkout-header">
            <h1 class="checkout-title">Finalizar Compra</h1>
            <div class="checkout-steps">
                <div class="step active">
                    <span class="step-number">1</span>
                    <span class="step-label">Informações</span>
                </div>
                <div class="step">
                    <span class="step-number">2</span>
                    <span class="step-label">Pagamento</span>
                </div>
                <div class="step">
                    <span class="step-number">3</span>
                    <span class="step-label">Confirmação</span>
                </div>
            </div>
        </div>

        <form name="checkout" method="post" class="checkout woocommerce-checkout" action="<?php echo esc_url(wc_get_checkout_url()); ?>" enctype="multipart/form-data">

            <div class="checkout-content">
                <div class="checkout-form">
                    <?php if ($checkout->get_checkout_fields()) : ?>
                        <?php do_action('woocommerce_checkout_before_customer_details'); ?>

                        <div class="customer-details">
                            <div class="billing-fields">
                                <h3>Informações de Cobrança</h3>
                                <?php do_action('woocommerce_checkout_billing'); ?>
                            </div>

                            <div class="shipping-fields">
                                <?php if (WC()->cart->needs_shipping_address()) : ?>
                                    <h3>Informações de Entrega</h3>
                                    <?php do_action('woocommerce_checkout_shipping'); ?>
                                <?php endif; ?>
                            </div>
                        </div>

                        <?php do_action('woocommerce_checkout_after_customer_details'); ?>
                    <?php endif; ?>
                </div>

                <div class="order-review">
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

# 3. MY-ACCOUNT.PHP
log_info "Criando my-account templates..."
mkdir -p "$THEME_PATH/woocommerce/myaccount"

cat > "$THEME_PATH/woocommerce/myaccount/my-account.php" << 'EOF'
<?php
/**
 * My Account Page - VancouverTec Store
 */

if (!defined('ABSPATH')) {
    exit;
}

do_action('woocommerce_before_account_navigation');
?>

<div class="my-account-page">
    <div class="container">
        <div class="account-header">
            <h1 class="account-title">Minha Conta</h1>
            <p class="account-welcome">Olá, <?php echo esc_html($current_user->display_name); ?>!</p>
        </div>

        <div class="account-content">
            <nav class="woocommerce-MyAccount-navigation">
                <ul>
                    <?php foreach (wc_get_account_menu_items() as $endpoint => $label) : ?>
                        <li class="<?php echo wc_get_account_menu_item_classes($endpoint); ?>">
                            <a href="<?php echo esc_url(wc_get_account_endpoint_url($endpoint)); ?>" class="account-nav-link">
                                <?php 
                                // Adicionar ícones aos links
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
                <?php
                    do_action('woocommerce_account_content');
                ?>
            </div>
        </div>
    </div>
</div>
EOF

# 4. CSS para Cart, Checkout e Account
log_info "Criando CSS para Cart, Checkout e Account..."
cat > "$THEME_PATH/assets/css/components/woocommerce-checkout.css" << 'EOF'
/* VancouverTec Store - Cart, Checkout & Account */

/* CART PAGE */
.cart-page {
  padding: 2rem 0 5rem;
  min-height: 70vh;
}

.cart-header {
  text-align: center;
  margin-bottom: 3rem;
}

.cart-title {
  font-size: 2.5rem;
  font-weight: 800;
  color: #1F2937;
  margin-bottom: 1rem;
}

.cart-content {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 3rem;
}

.cart-items {
  background: white;
  border-radius: 15px;
  padding: 2rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.shop_table {
  width: 100%;
  border-collapse: collapse;
}

.shop_table th {
  padding: 1rem;
  background: #F9FAFB;
  font-weight: 700;
  color: #374151;
  border-bottom: 2px solid #E5E7EB;
}

.shop_table td {
  padding: 1.5rem 1rem;
  border-bottom: 1px solid #E5E7EB;
  vertical-align: middle;
}

.product-thumbnail img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 10px;
}

.product-name a {
  color: #1F2937;
  text-decoration: none;
  font-weight: 600;
}

.product-name a:hover {
  color: #0066CC;
}

.product-price,
.product-subtotal {
  font-weight: 700;
  color: #0066CC;
  font-size: 1.125rem;
}

.product-quantity input {
  width: 80px;
  padding: 0.5rem;
  border: 1px solid #E5E7EB;
  border-radius: 8px;
  text-align: center;
}

.product-remove .remove {
  background: #EF4444;
  color: white;
  width: 30px;
  height: 30px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  text-decoration: none;
  font-weight: bold;
}

.cart-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 1rem;
  margin-top: 1rem;
}

.update-cart {
  background: #0066CC;
  color: white;
  padding: 0.75rem 1.5rem;
  border: none;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
}

.continue-shopping {
  color: #6B7280;
  text-decoration: none;
  font-weight: 600;
}

.continue-shopping:hover {
  color: #0066CC;
}

/* Cart Totals */
.cart-totals {
  background: white;
  border-radius: 15px;
  padding: 2rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  height: fit-content;
  position: sticky;
  top: 2rem;
}

.cart_totals h2 {
  font-size: 1.5rem;
  font-weight: 700;
  color: #1F2937;
  margin-bottom: 1.5rem;
}

.cart_totals table {
  width: 100%;
  margin-bottom: 1.5rem;
}

.cart_totals th,
.cart_totals td {
  padding: 0.75rem 0;
  border-bottom: 1px solid #E5E7EB;
}

.cart_totals th {
  text-align: left;
  font-weight: 600;
  color: #374151;
}

.cart_totals .order-total th,
.cart_totals .order-total td {
  font-size: 1.25rem;
  font-weight: 700;
  color: #1F2937;
  border-bottom: 2px solid #0066CC;
}

.checkout-button {
  width: 100%;
  background: linear-gradient(135deg, #0066CC, #6366F1);
  color: white;
  padding: 1rem 2rem;
  border: none;
  border-radius: 10px;
  font-size: 1.125rem;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s ease;
}

.checkout-button:hover {
  background: linear-gradient(135deg, #0052A3, #4F46E5);
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(0, 102, 204, 0.3);
}

/* CHECKOUT PAGE */
.checkout-page {
  padding: 2rem 0 5rem;
}

.checkout-header {
  text-align: center;
  margin-bottom: 3rem;
}

.checkout-title {
  font-size: 2.5rem;
  font-weight: 800;
  color: #1F2937;
  margin-bottom: 2rem;
}

.checkout-steps {
  display: flex;
  justify-content: center;
  gap: 3rem;
  margin-bottom: 2rem;
}

.step {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
}

.step-number {
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

.step.active .step-number {
  background: #0066CC;
  color: white;
}

.step-label {
  font-size: 0.875rem;
  font-weight: 600;
  color: #6B7280;
}

.step.active .step-label {
  color: #0066CC;
}

.checkout-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
}

.checkout-form {
  background: white;
  border-radius: 15px;
  padding: 2rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.billing-fields h3,
.shipping-fields h3 {
  font-size: 1.25rem;
  font-weight: 700;
  color: #1F2937;
  margin-bottom: 1.5rem;
}

.form-row {
  margin-bottom: 1.5rem;
}

.form-row label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: 600;
  color: #374151;
}

.form-row input,
.form-row select,
.form-row textarea {
  width: 100%;
  padding: 0.75rem;
  border: 1px solid #E5E7EB;
  border-radius: 8px;
  font-size: 1rem;
}

.form-row input:focus,
.form-row select:focus,
.form-row textarea:focus {
  outline: none;
  border-color: #0066CC;
  box-shadow: 0 0 0 3px rgba(0, 102, 204, 0.1);
}

/* Order Review */
.order-review {
  background: white;
  border-radius: 15px;
  padding: 2rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  height: fit-content;
  position: sticky;
  top: 2rem;
}

.order-review h3 {
  font-size: 1.5rem;
  font-weight: 700;
  color: #1F2937;
  margin-bottom: 1.5rem;
}

/* MY ACCOUNT */
.my-account-page {
  padding: 2rem 0 5rem;
}

.account-header {
  text-align: center;
  margin-bottom: 3rem;
}

.account-title {
  font-size: 2.5rem;
  font-weight: 800;
  color: #1F2937;
  margin-bottom: 0.5rem;
}

.account-welcome {
  font-size: 1.125rem;
  color: #6B7280;
}

.account-content {
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

.account-nav-link {
  display: block;
  padding: 1rem;
  color: #6B7280;
  text-decoration: none;
  border-radius: 8px;
  font-weight: 600;
  transition: all 0.3s ease;
}

.account-nav-link:hover,
.is-active .account-nav-link {
  background: #F0F9FF;
  color: #0066CC;
}

.woocommerce-MyAccount-content {
  background: white;
  border-radius: 15px;
  padding: 2rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

/* Responsive */
@media (max-width: 1024px) {
  .cart-content,
  .checkout-content,
  .account-content {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .cart-totals,
  .order-review,
  .woocommerce-MyAccount-navigation {
    position: relative;
    top: 0;
  }
}

@media (max-width: 768px) {
  .cart-page,
  .checkout-page,
  .my-account-page {
    padding: 1rem 0 3rem;
  }
  
  .checkout-steps {
    gap: 1rem;
  }
  
  .shop_table {
    font-size: 0.875rem;
  }
  
  .product-thumbnail img {
    width: 60px;
    height: 60px;
  }
  
  .cart-actions {
    flex-direction: column;
    align-items: stretch;
  }
}

@media (max-width: 480px) {
  .cart-items,
  .checkout-form,
  .order-review,
  .woocommerce-MyAccount-content {
    padding: 1rem;
  }
  
  .cart-title,
  .checkout-title,
  .account-title {
    font-size: 2rem;
  }
}
EOF

# Atualizar functions.php
log_info "Atualizando functions.php..."
if ! grep -q "woocommerce-checkout.css" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_style.*vt-woo-pages/a\    wp_enqueue_style('"'"'vt-woo-checkout'"'"', VT_THEME_URI . '"'"'/assets/css/components/woocommerce-checkout.css'"'"', ['"'"'vt-woo-pages'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"
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
echo -e "║ ✅ WOOCOMMERCE TEMPLATES COMPLETOS! ✅      ║"
echo -e "║    Cart + Checkout + My Account              ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Cart page com layout responsivo"
log_success "✅ Checkout com steps e order review"
log_success "✅ My Account com navegação lateral"
log_success "✅ CSS completo para todas as páginas"
log_success "✅ Layout VancouverTec em todo WooCommerce"

echo -e "\n${YELLOW}🎯 WooCommerce 100% integrado ao tema!${NC}"

exit 0