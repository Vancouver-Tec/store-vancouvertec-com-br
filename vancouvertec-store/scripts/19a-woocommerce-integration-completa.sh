#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce Integration Completa
# Script: 19a-woocommerce-integration-completa.sh
# Versão: 1.0.0 - Shop + Single + Cart + Checkout + Account
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
║  🛒 WOOCOMMERCE INTEGRATION COMPLETA 🛒     ║
║    Shop + Cart + Checkout + My Account       ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Integrando WooCommerce ao tema VancouverTec..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# 1. Adicionar suporte WooCommerce no functions.php
log_info "Adicionando suporte WooCommerce no functions.php..."
cat >> "$THEME_PATH/functions.php" << 'EOF'

// ===== WOOCOMMERCE INTEGRATION =====

// Suporte ao WooCommerce
add_theme_support('woocommerce');
add_theme_support('wc-product-gallery-zoom');
add_theme_support('wc-product-gallery-lightbox');
add_theme_support('wc-product-gallery-slider');

// Enqueue WooCommerce styles
function vt_woocommerce_styles() {
    if (class_exists('WooCommerce')) {
        wp_enqueue_style('vt-woocommerce', VT_THEME_URI . '/assets/css/components/woocommerce.css', ['vt-style'], VT_THEME_VERSION);
    }
}
add_action('wp_enqueue_scripts', 'vt_woocommerce_styles');

// Configurar produtos por página e colunas
function vt_woocommerce_loop_columns() { return 3; }
add_filter('loop_shop_columns', 'vt_woocommerce_loop_columns');

function vt_woocommerce_products_per_page() { return 12; }
add_filter('loop_shop_per_page', 'vt_woocommerce_products_per_page', 20);

// Remover breadcrumbs padrão WooCommerce (usar do tema)
remove_action('woocommerce_before_main_content', 'woocommerce_breadcrumb', 20);

// Configurar páginas WooCommerce automaticamente
function vt_setup_woocommerce_pages() {
    if (class_exists('WooCommerce')) {
        $pages = array(
            'woocommerce_shop_page_id' => 'Shop',
            'woocommerce_cart_page_id' => 'Carrinho',
            'woocommerce_checkout_page_id' => 'Checkout',
            'woocommerce_myaccount_page_id' => 'Minha Conta'
        );

        foreach ($pages as $option => $title) {
            $page_id = get_option($option);
            if (!$page_id || !get_post($page_id)) {
                $page_id = wp_insert_post(array(
                    'post_title' => $title,
                    'post_content' => '',
                    'post_status' => 'publish',
                    'post_type' => 'page',
                    'post_name' => sanitize_title($title)
                ));
                update_option($option, $page_id);
            }
        }
    }
}
add_action('init', 'vt_setup_woocommerce_pages');
EOF

# 2. Criar estrutura de pastas WooCommerce
log_info "Criando estrutura de pastas WooCommerce..."
mkdir -p "$THEME_PATH/woocommerce"
mkdir -p "$THEME_PATH/woocommerce/cart"
mkdir -p "$THEME_PATH/woocommerce/checkout"
mkdir -p "$THEME_PATH/woocommerce/myaccount"

# 3. Shop Page Template (archive-product.php)
log_info "Criando archive-product.php (Shop)..."
cat > "$THEME_PATH/woocommerce/archive-product.php" << 'EOF'
<?php get_header(); ?>

<div class="shop-page">
    <div class="container">
        <div class="shop-header">
            <h1 class="shop-title"><?php woocommerce_page_title(); ?></h1>
            <div class="shop-controls">
                <?php woocommerce_catalog_ordering(); ?>
                <?php woocommerce_result_count(); ?>
            </div>
        </div>
        
        <div class="shop-content">
            <aside class="shop-sidebar">
                <div class="widget">
                    <h3>Categorias</h3>
                    <?php the_widget('WC_Widget_Product_Categories'); ?>
                </div>
                <div class="widget">
                    <h3>Filtrar por Preço</h3>
                    <?php the_widget('WC_Widget_Price_Filter'); ?>
                </div>
            </aside>
            
            <main class="shop-main">
                <?php if (woocommerce_product_loop()) : ?>
                    <div class="products-grid">
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

# 4. Single Product Template
log_info "Criando single-product.php..."
cat > "$THEME_PATH/woocommerce/single-product.php" << 'EOF'
<?php get_header(); ?>

<div class="single-product">
    <div class="container">
        <?php while (have_posts()) : the_post(); ?>
            <div class="product-layout">
                <div class="product-images">
                    <?php woocommerce_show_product_images(); ?>
                </div>
                
                <div class="product-summary">
                    <h1 class="product-title"><?php the_title(); ?></h1>
                    <?php woocommerce_template_single_rating(); ?>
                    <?php woocommerce_template_single_price(); ?>
                    <?php woocommerce_template_single_excerpt(); ?>
                    <?php woocommerce_template_single_add_to_cart(); ?>
                    <?php woocommerce_template_single_meta(); ?>
                    
                    <div class="product-guarantees">
                        <div class="guarantee-item">
                            <span>🛡️ Garantia de 30 dias</span>
                        </div>
                        <div class="guarantee-item">
                            <span>🚀 Entrega em 7 dias</span>
                        </div>
                        <div class="guarantee-item">
                            <span>📞 Suporte 24/7</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="product-tabs">
                <?php woocommerce_output_product_data_tabs(); ?>
            </div>
            
            <div class="related-products">
                <?php woocommerce_output_related_products(); ?>
            </div>
        <?php endwhile; ?>
    </div>
</div>

<?php get_footer(); ?>
EOF

# 5. Cart Template
log_info "Criando cart.php..."
cat > "$THEME_PATH/woocommerce/cart/cart.php" << 'EOF'
<?php
defined('ABSPATH') || exit;
do_action('woocommerce_before_cart'); ?>

<div class="cart-page">
    <div class="container">
        <h1 class="cart-title">Carrinho de Compras</h1>
        
        <form class="woocommerce-cart-form" action="<?php echo esc_url(wc_get_cart_url()); ?>" method="post">
            <div class="cart-content">
                <div class="cart-items">
                    <table class="shop_table cart">
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
                            <?php foreach (WC()->cart->get_cart() as $cart_item_key => $cart_item) {
                                $_product = apply_filters('woocommerce_cart_item_product', $cart_item['data'], $cart_item, $cart_item_key);
                                if ($_product && $_product->exists() && $cart_item['quantity'] > 0) {
                                    $product_permalink = $_product->is_visible() ? $_product->get_permalink($cart_item) : '';
                            ?>
                            <tr class="cart_item">
                                <td class="product-info">
                                    <?php echo $_product->get_image(); ?>
                                    <div class="product-details">
                                        <h3><?php echo $_product->get_name(); ?></h3>
                                    </div>
                                </td>
                                <td class="product-price">
                                    <?php echo WC()->cart->get_product_price($_product); ?>
                                </td>
                                <td class="product-quantity">
                                    <?php echo woocommerce_quantity_input(array(
                                        'input_name' => "cart[{$cart_item_key}][qty]",
                                        'input_value' => $cart_item['quantity'],
                                        'product_name' => $_product->get_name(),
                                    ), $_product, false); ?>
                                </td>
                                <td class="product-subtotal">
                                    <?php echo WC()->cart->get_product_subtotal($_product, $cart_item['quantity']); ?>
                                </td>
                                <td class="product-remove">
                                    <a href="<?php echo esc_url(wc_get_cart_remove_url($cart_item_key)); ?>" class="remove">×</a>
                                </td>
                            </tr>
                            <?php } } ?>
                        </tbody>
                    </table>
                    
                    <div class="cart-actions">
                        <button type="submit" name="update_cart" class="button">Atualizar carrinho</button>
                        <a href="<?php echo esc_url(wc_get_page_permalink('shop')); ?>" class="continue-shopping">← Continuar comprando</a>
                    </div>
                </div>
                
                <div class="cart-totals">
                    <?php do_action('woocommerce_cart_collaterals'); ?>
                </div>
            </div>
        </form>
    </div>
</div>

<?php do_action('woocommerce_after_cart'); ?>
EOF

# 6. CSS WooCommerce seguindo padrão do tema
log_info "Criando CSS WooCommerce integrado..."
cat > "$THEME_PATH/assets/css/components/woocommerce.css" << 'EOF'
/* VancouverTec Store - WooCommerce Integration */

/* SHOP PAGE */
.shop-page {
  padding: 2rem 0 4rem;
}

.shop-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 2rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #E5E7EB;
}

.shop-title {
  font-size: 2rem;
  font-weight: 700;
  color: #1F2937;
}

.shop-controls {
  display: flex;
  gap: 1rem;
  align-items: center;
}

.shop-content {
  display: grid;
  grid-template-columns: 250px 1fr;
  gap: 2rem;
}

.shop-sidebar {
  background: #F9FAFB;
  padding: 1.5rem;
  border-radius: 10px;
  height: fit-content;
}

.shop-sidebar .widget {
  margin-bottom: 2rem;
}

.shop-sidebar h3 {
  font-size: 1.125rem;
  font-weight: 600;
  color: #374151;
  margin-bottom: 1rem;
}

.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 2rem;
}

/* SINGLE PRODUCT */
.single-product {
  padding: 2rem 0 4rem;
}

.product-layout {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
  margin-bottom: 3rem;
}

.product-title {
  font-size: 2rem;
  font-weight: 700;
  color: #1F2937;
  margin-bottom: 1rem;
}

.product-guarantees {
  margin-top: 2rem;
  padding: 1.5rem;
  background: #F0F9FF;
  border-radius: 10px;
}

.guarantee-item {
  display: flex;
  align-items: center;
  margin-bottom: 0.75rem;
  font-weight: 500;
  color: #374151;
}

/* CART PAGE */
.cart-page {
  padding: 2rem 0 4rem;
}

.cart-title {
  font-size: 2rem;
  font-weight: 700;
  color: #1F2937;
  margin-bottom: 2rem;
  text-align: center;
}

.cart-content {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 2rem;
}

.cart-items {
  background: white;
  border-radius: 10px;
  padding: 1.5rem;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.shop_table {
  width: 100%;
  border-collapse: collapse;
}

.shop_table th {
  padding: 1rem;
  background: #F9FAFB;
  font-weight: 600;
  color: #374151;
  border-bottom: 1px solid #E5E7EB;
}

.shop_table td {
  padding: 1rem;
  border-bottom: 1px solid #E5E7EB;
  vertical-align: middle;
}

.product-info {
  display: flex;
  gap: 1rem;
  align-items: center;
}

.product-info img {
  width: 60px;
  height: 60px;
  object-fit: cover;
  border-radius: 5px;
}

.cart-totals {
  background: white;
  border-radius: 10px;
  padding: 1.5rem;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
  height: fit-content;
}

/* BOTÕES WOOCOMMERCE */
.woocommerce .button,
.woocommerce button.button,
.woocommerce input.button,
.woocommerce .single_add_to_cart_button {
  background: #0066CC;
  color: white;
  border: 1px solid #0066CC;
  border-radius: 8px;
  padding: 0.75rem 1.5rem;
  font-weight: 600;
  text-decoration: none;
  transition: all 0.3s ease;
  cursor: pointer;
}

.woocommerce .button:hover,
.woocommerce button.button:hover,
.woocommerce input.button:hover,
.woocommerce .single_add_to_cart_button:hover {
  background: #0052A3;
  border-color: #0052A3;
  color: white;
  transform: translateY(-1px);
}

/* PREÇOS */
.woocommerce .price {
  color: #0066CC;
  font-weight: 700;
  font-size: 1.25rem;
}

.woocommerce .price del {
  color: #9CA3AF;
  opacity: 0.7;
}

.woocommerce .price ins {
  color: #EF4444;
  text-decoration: none;
  font-weight: 800;
}

/* RESPONSIVE */
@media (max-width: 1024px) {
  .shop-content,
  .product-layout,
  .cart-content {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
}

@media (max-width: 768px) {
  .shop-header {
    flex-direction: column;
    gap: 1rem;
    align-items: flex-start;
  }
  
  .products-grid {
    grid-template-columns: 1fr;
  }
  
  .product-info {
    flex-direction: column;
    text-align: center;
  }
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
echo -e "║  ✅ WOOCOMMERCE INTEGRADO COM SUCESSO! ✅    ║"
echo -e "║    Shop + Single Product + Cart              ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Suporte WooCommerce adicionado ao functions.php"
log_success "✅ Shop page (archive-product.php) criada"
log_success "✅ Single product template criado"
log_success "✅ Cart template criado"
log_success "✅ CSS WooCommerce seguindo tema VancouverTec"
log_success "✅ Páginas WooCommerce configuradas automaticamente"

echo -e "\n${YELLOW}🎯 Templates WooCommerce criados:${NC}"
echo -e "• Shop: /shop (lista de produtos)"
echo -e "• Produto: /produto/[nome] (página individual)"
echo -e "• Carrinho: /carrinho (itens do carrinho)"

echo -e "\n${BLUE}📄 Digite 'continuar' para PARTE 2: Checkout + My Account${NC}"

exit 0