#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce Cart + Checkout Templates
# Script: 31a1-woo-cart-checkout.sh
# Versão: 1.0.0 - Cart e Checkout Templates
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
WC_TEMPLATES_PATH="${THEME_PATH}/woocommerce"

# Funções de log
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║  🛒 Templates Override - PARTE 1A (Cart)    ║
║           Cart + Checkout Templates          ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar base
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Execute antes: 31a-woo-templates-override.sh"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Criando templates cart/checkout em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost:8080" > /dev/null; then
    log_warning "Parando servidor..."
    pkill -f "php -S localhost:8080" || true
    sleep 2
fi

# Criar estrutura cart/checkout
log_info "Criando estrutura cart e checkout..."
mkdir -p "${WC_TEMPLATES_PATH}"/{cart,checkout}

# 1. Template cart.php
log_info "Criando cart/cart.php..."
cat > "${WC_TEMPLATES_PATH}/cart/cart.php" << 'EOF'
<?php
/**
 * VancouverTec Store - Shopping Cart
 */

if (!defined('ABSPATH')) exit;

do_action('woocommerce_before_cart'); ?>

<div class="vt-cart-page">
    <div class="container">
        
        <div class="vt-cart-header">
            <h1><?php esc_html_e('Seu Carrinho', 'vancouvertec'); ?></h1>
            <p class="vt-cart-subtitle">
                <?php esc_html_e('Revise seus produtos antes de finalizar', 'vancouvertec'); ?>
            </p>
        </div>

        <form class="woocommerce-cart-form" action="<?php echo esc_url(wc_get_cart_url()); ?>" method="post">
            
            <?php do_action('woocommerce_before_cart_table'); ?>
            
            <div class="vt-cart-content">
                <div class="vt-cart-items">
                    <table class="shop_table cart woocommerce-cart-form__contents" cellspacing="0">
                        <thead>
                            <tr>
                                <th class="product-thumbnail"><?php esc_html_e('Produto', 'vancouvertec'); ?></th>
                                <th class="product-name">&nbsp;</th>
                                <th class="product-price"><?php esc_html_e('Preço', 'vancouvertec'); ?></th>
                                <th class="product-quantity"><?php esc_html_e('Quantidade', 'vancouvertec'); ?></th>
                                <th class="product-subtotal"><?php esc_html_e('Subtotal', 'vancouvertec'); ?></th>
                                <th class="product-remove">&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php do_action('woocommerce_before_cart_contents'); ?>

                            <?php foreach (WC()->cart->get_cart() as $cart_item_key => $cart_item):
                                $_product = apply_filters('woocommerce_cart_item_product', $cart_item['data'], $cart_item, $cart_item_key);
                                $product_id = apply_filters('woocommerce_cart_item_product_id', $cart_item['product_id'], $cart_item, $cart_item_key);

                                if ($_product && $_product->exists() && $cart_item['quantity'] > 0):
                                    $product_permalink = $_product->is_visible() ? $_product->get_permalink($cart_item) : '';
                            ?>
                                <tr class="woocommerce-cart-form__cart-item cart_item">

                                    <td class="product-thumbnail">
                                        <?php
                                        $thumbnail = $_product->get_image();
                                        if (!$product_permalink) {
                                            echo $thumbnail;
                                        } else {
                                            printf('<a href="%s">%s</a>', esc_url($product_permalink), $thumbnail);
                                        }
                                        ?>
                                    </td>

                                    <td class="product-name" data-title="<?php esc_attr_e('Produto', 'vancouvertec'); ?>">
                                        <?php
                                        if (!$product_permalink) {
                                            echo wp_kses_post($_product->get_name());
                                        } else {
                                            echo wp_kses_post(sprintf('<a href="%s">%s</a>', esc_url($product_permalink), $_product->get_name()));
                                        }

                                        do_action('woocommerce_after_cart_item_name', $cart_item, $cart_item_key);
                                        echo wc_get_formatted_cart_item_data($cart_item);

                                        if ($_product->backorders_require_notification() && $_product->is_on_backorder($cart_item['quantity'])) {
                                            echo wp_kses_post('<p class="backorder_notification">' . esc_html__('Disponível em pré-venda', 'vancouvertec') . '</p>');
                                        }
                                        ?>
                                    </td>

                                    <td class="product-price" data-title="<?php esc_attr_e('Preço', 'vancouvertec'); ?>">
                                        <?php echo WC()->cart->get_product_price($_product); ?>
                                    </td>

                                    <td class="product-quantity" data-title="<?php esc_attr_e('Quantidade', 'vancouvertec'); ?>">
                                        <?php
                                        $product_quantity = woocommerce_quantity_input([
                                            'input_name'   => "cart[{$cart_item_key}][qty]",
                                            'input_value'  => $cart_item['quantity'],
                                            'max_value'    => $_product->get_max_purchase_quantity(),
                                            'min_value'    => '0',
                                            'product_name' => $_product->get_name(),
                                        ], $_product, false);

                                        echo $product_quantity;
                                        ?>
                                    </td>

                                    <td class="product-subtotal" data-title="<?php esc_attr_e('Subtotal', 'vancouvertec'); ?>">
                                        <?php echo WC()->cart->get_product_subtotal($_product, $cart_item['quantity']); ?>
                                    </td>

                                    <td class="product-remove">
                                        <?php
                                        echo sprintf(
                                            '<a href="%s" class="remove" aria-label="%s" data-product_id="%s" data-product_sku="%s">&times;</a>',
                                            esc_url(wc_get_cart_remove_url($cart_item_key)),
                                            esc_attr__('Remover este item', 'vancouvertec'),
                                            esc_attr($product_id),
                                            esc_attr($_product->get_sku())
                                        );
                                        ?>
                                    </td>
                                </tr>
                            <?php endif; ?>
                            <?php endforeach; ?>

                            <tr>
                                <td colspan="6" class="actions">
                                    <div class="vt-cart-actions">
                                        <?php if (wc_coupons_enabled()): ?>
                                            <div class="coupon">
                                                <input type="text" name="coupon_code" class="input-text" value="" placeholder="<?php esc_attr_e('Código do cupom', 'vancouvertec'); ?>" />
                                                <button type="submit" class="button" name="apply_coupon" value="<?php esc_attr_e('Aplicar cupom', 'vancouvertec'); ?>">
                                                    <?php esc_html_e('Aplicar cupom', 'vancouvertec'); ?>
                                                </button>
                                            </div>
                                        <?php endif; ?>

                                        <button type="submit" class="button" name="update_cart" value="<?php esc_attr_e('Atualizar carrinho', 'vancouvertec'); ?>">
                                            <?php esc_html_e('Atualizar carrinho', 'vancouvertec'); ?>
                                        </button>

                                        <?php wp_nonce_field('woocommerce-cart', 'woocommerce-cart-nonce'); ?>
                                    </div>
                                </td>
                            </tr>

                            <?php do_action('woocommerce_after_cart_contents'); ?>
                        </tbody>
                    </table>
                </div>
                
                <div class="vt-cart-collaterals">
                    <?php do_action('woocommerce_cart_collaterals'); ?>
                </div>
            </div>

            <?php do_action('woocommerce_after_cart_table'); ?>
        </form>

    </div>
</div>

<?php do_action('woocommerce_after_cart'); ?>
EOF

# 2. Template checkout form-checkout.php
log_info "Criando checkout/form-checkout.php..."
cat > "${WC_TEMPLATES_PATH}/checkout/form-checkout.php" << 'EOF'
<?php
/**
 * VancouverTec Store - Checkout Form
 */

if (!defined('ABSPATH')) exit;

do_action('woocommerce_before_checkout_form', $checkout);

if (!$checkout->is_registration_enabled() && $checkout->is_registration_required() && !is_user_logged_in()) {
    echo esc_html__('Você deve estar logado para finalizar a compra.', 'vancouvertec');
    return;
}
?>

<div class="vt-checkout-page">
    <div class="container">
        
        <div class="vt-checkout-header">
            <h1><?php esc_html_e('Finalizar Compra', 'vancouvertec'); ?></h1>
            <div class="vt-checkout-steps">
                <div class="vt-step active">
                    <span class="step-number">1</span>
                    <span class="step-label"><?php esc_html_e('Informações', 'vancouvertec'); ?></span>
                </div>
                <div class="vt-step-separator"></div>
                <div class="vt-step">
                    <span class="step-number">2</span>
                    <span class="step-label"><?php esc_html_e('Pagamento', 'vancouvertec'); ?></span>
                </div>
                <div class="vt-step-separator"></div>
                <div class="vt-step">
                    <span class="step-number">3</span>
                    <span class="step-label"><?php esc_html_e('Confirmação', 'vancouvertec'); ?></span>
                </div>
            </div>
        </div>

        <form name="checkout" method="post" class="checkout woocommerce-checkout" action="<?php echo esc_url(wc_get_checkout_url()); ?>" enctype="multipart/form-data">

            <div class="vt-checkout-content">
                
                <?php if ($checkout->get_checkout_fields()): ?>
                    <div class="vt-checkout-billing">
                        
                        <?php do_action('woocommerce_checkout_before_customer_details'); ?>

                        <div class="col2-set" id="customer_details">
                            <div class="col-1">
                                <?php do_action('woocommerce_checkout_billing'); ?>
                            </div>

                            <div class="col-2">
                                <?php do_action('woocommerce_checkout_shipping'); ?>
                            </div>
                        </div>

                        <?php do_action('woocommerce_checkout_after_customer_details'); ?>

                    </div>
                <?php endif; ?>
                
                <div class="vt-checkout-review">
                    
                    <?php do_action('woocommerce_checkout_before_order_review_heading'); ?>
                    
                    <h3 id="order_review_heading" class="vt-section-title">
                        <?php esc_html_e('Seu Pedido', 'vancouvertec'); ?>
                    </h3>
                    
                    <?php do_action('woocommerce_checkout_before_order_review'); ?>

                    <div id="order_review" class="woocommerce-checkout-review-order">
                        <?php do_action('woocommerce_checkout_order_review'); ?>
                    </div>

                    <?php do_action('woocommerce_checkout_after_order_review'); ?>
                    
                </div>
                
            </div>

        </form>

        <div class="vt-checkout-security">
            <div class="vt-security-badges">
                <div class="vt-security-item">
                    <span class="vt-icon">🔒</span>
                    <span><?php esc_html_e('SSL 256-bits', 'vancouvertec'); ?></span>
                </div>
                <div class="vt-security-item">
                    <span class="vt-icon">💳</span>
                    <span><?php esc_html_e('Pagamento Seguro', 'vancouvertec'); ?></span>
                </div>
                <div class="vt-security-item">
                    <span class="vt-icon">📞</span>
                    <span><?php esc_html_e('Suporte 24h', 'vancouvertec'); ?></span>
                </div>
            </div>
        </div>

    </div>
</div>

<?php do_action('woocommerce_after_checkout_form', $checkout); ?>
EOF

# 3. Template cart-empty.php
log_info "Criando cart/cart-empty.php..."
cat > "${WC_TEMPLATES_PATH}/cart/cart-empty.php" << 'EOF'
<?php
/**
 * VancouverTec Store - Empty Cart
 */

if (!defined('ABSPATH')) exit;

wc_print_notices();

do_action('woocommerce_cart_is_empty');

if (wc_get_page_id('shop') > 0): ?>
    <div class="vt-empty-cart">
        <div class="container">
            <div class="vt-empty-content">
                <div class="vt-empty-icon">🛒</div>
                <h2><?php esc_html_e('Seu carrinho está vazio', 'vancouvertec'); ?></h2>
                <p><?php esc_html_e('Adicione produtos incríveis ao seu carrinho e finalize sua compra.', 'vancouvertec'); ?></p>
                
                <div class="vt-empty-actions">
                    <a class="button wc-backward btn-primary" href="<?php echo esc_url(apply_filters('woocommerce_return_to_shop_redirect', wc_get_page_permalink('shop'))); ?>">
                        <?php esc_html_e('Continuar Comprando', 'vancouvertec'); ?>
                    </a>
                </div>
                
                <div class="vt-why-choose">
                    <h3><?php esc_html_e('Por que escolher a VancouverTec?', 'vancouvertec'); ?></h3>
                    <div class="vt-benefits">
                        <div class="vt-benefit">
                            <span class="vt-icon">⚡</span>
                            <span><?php esc_html_e('Download Imediato', 'vancouvertec'); ?></span>
                        </div>
                        <div class="vt-benefit">
                            <span class="vt-icon">🎯</span>
                            <span><?php esc_html_e('Suporte Especializado', 'vancouvertec'); ?></span>
                        </div>
                        <div class="vt-benefit">
                            <span class="vt-icon">🔒</span>
                            <span><?php esc_html_e('Pagamento 100% Seguro', 'vancouvertec'); ?></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<?php endif; ?>
EOF

# Iniciar servidor
log_info "Iniciando servidor..."
nohup php -S localhost:8080 router.php > server.log 2>&1 &
echo $! > .server_pid
sleep 3

# Verificar arquivos criados
created_files=(
    "${WC_TEMPLATES_PATH}/cart/cart.php"
    "${WC_TEMPLATES_PATH}/checkout/form-checkout.php"
    "${WC_TEMPLATES_PATH}/cart/cart-empty.php"
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
echo -e "║      ✅ TEMPLATES CART/CHECKOUT CRIADOS! ✅  ║"
echo -e "║                                              ║"
echo -e "║  🛒 cart/cart.php                           ║"
echo -e "║  💳 checkout/form-checkout.php              ║"  
echo -e "║  📭 cart/cart-empty.php                     ║"
echo -e "║                                              ║"
echo -e "║  Features:                                   ║"
echo -e "║  • Steps de checkout                         ║"
echo -e "║  • Security badges                           ║"
echo -e "║  • Empty cart com call-to-action             ║"
echo -e "║                                              ║"
echo -e "║  🌐 Servidor: http://localhost:8080          ║"
echo -e "║                                              ║"
echo -e "║  ➡️  Próximo: 31a2-woo-shop-account.sh       ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_info "Execute para continuar:"
echo -e "${BLUE}chmod +x 31a2-woo-shop-account.sh && ./31a2-woo-shop-account.sh${NC}"