#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce Templates Override PARTE 1
# Script: 31a-woo-templates-override.sh
# Versão: 1.0.0 - Single Product Templates
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
║  🛒 Templates Override - PARTE 1 (Single)   ║
║           Single Product Templates           ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar base
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Execute antes: 31-woo-base-funcionando.sh"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Criando templates em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost:8080" > /dev/null; then
    log_warning "Parando servidor..."
    pkill -f "php -S localhost:8080" || true
    sleep 2
fi

# Criar estrutura single-product
log_info "Criando estrutura single-product..."
mkdir -p "${WC_TEMPLATES_PATH}/single-product"

# 1. Template single-product-image.php
log_info "Criando single-product-image.php..."
cat > "${WC_TEMPLATES_PATH}/single-product/single-product-image.php" << 'EOF'
<?php
/**
 * VancouverTec Store - Single Product Image
 */

if (!defined('ABSPATH')) exit;

global $product;
$post_thumbnail_id = $product->get_image_id();
$wrapper_classes = ['woocommerce-product-gallery', 'vt-product-gallery'];
?>

<div class="<?php echo esc_attr(implode(' ', $wrapper_classes)); ?>" 
     style="opacity: 0; transition: opacity .25s ease-in-out;">
     
    <div class="vt-product-images">
        <?php if ($product->get_image_id()): ?>
            <div class="vt-main-image">
                <?php
                echo wp_get_attachment_image($post_thumbnail_id, 'woocommerce_single', false, [
                    'class' => 'wp-post-image vt-product-image',
                    'data-src' => esc_url(wp_get_attachment_url($post_thumbnail_id))
                ]);
                ?>
            </div>
        <?php else: ?>
            <div class="vt-main-image vt-placeholder">
                <?php echo wc_placeholder_img(); ?>
            </div>
        <?php endif; ?>
        
        <?php
        $attachment_ids = $product->get_gallery_image_ids();
        if ($attachment_ids): ?>
            <div class="vt-gallery-thumbs">
                <?php foreach ($attachment_ids as $attachment_id): ?>
                    <div class="vt-thumb">
                        <?php echo wp_get_attachment_image($attachment_id, 'woocommerce_gallery_thumbnail'); ?>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>
</div>
EOF

# 2. Template single-product-summary.php
log_info "Criando single-product-summary.php..."
cat > "${WC_TEMPLATES_PATH}/single-product/single-product-summary.php" << 'EOF'
<?php
/**
 * VancouverTec Store - Single Product Summary
 */

if (!defined('ABSPATH')) exit;

global $product;
?>

<div class="vt-product-summary summary entry-summary">
    
    <div class="vt-product-header">
        <?php do_action('woocommerce_single_product_summary', 5); ?>
        
        <div class="vt-product-badges">
            <?php if ($product->is_on_sale()): ?>
                <span class="vt-badge vt-sale-badge">
                    <?php esc_html_e('Promoção', 'vancouvertec'); ?>
                </span>
            <?php endif; ?>
            
            <?php if ($product->is_featured()): ?>
                <span class="vt-badge vt-featured-badge">
                    <?php esc_html_e('Destaque', 'vancouvertec'); ?>
                </span>
            <?php endif; ?>
        </div>
    </div>
    
    <div class="vt-price-section">
        <?php do_action('woocommerce_single_product_summary', 10); ?>
        
        <?php if ($product->get_price()): ?>
            <div class="vt-payment-info">
                <span class="vt-installments">
                    <?php 
                    $price = $product->get_price();
                    $installment = $price / 12;
                    printf(__('ou 12x de %s sem juros', 'vancouvertec'), wc_price($installment));
                    ?>
                </span>
            </div>
        <?php endif; ?>
    </div>
    
    <div class="vt-product-form">
        <?php do_action('woocommerce_single_product_summary', 30); ?>
    </div>
    
    <div class="vt-trust-badges">
        <div class="vt-trust-item">
            <span class="vt-icon">🔒</span>
            <span><?php esc_html_e('Compra Segura', 'vancouvertec'); ?></span>
        </div>
        <div class="vt-trust-item">
            <span class="vt-icon">⚡</span>
            <span><?php esc_html_e('Download Imediato', 'vancouvertec'); ?></span>
        </div>
        <div class="vt-trust-item">
            <span class="vt-icon">🎯</span>
            <span><?php esc_html_e('Suporte Técnico', 'vancouvertec'); ?></span>
        </div>
    </div>
    
    <div class="vt-product-meta">
        <?php do_action('woocommerce_single_product_summary', 40); ?>
    </div>
    
</div>
EOF

# 3. Template content-single-product.php
log_info "Criando content-single-product.php..."
cat > "${WC_TEMPLATES_PATH}/content-single-product.php" << 'EOF'
<?php
/**
 * VancouverTec Store - Single Product Content
 */

if (!defined('ABSPATH')) exit;

global $product;

do_action('woocommerce_before_single_product');

if (post_password_required()) {
    echo get_the_password_form();
    return;
}
?>

<div id="product-<?php the_ID(); ?>" <?php wc_product_class('vt-single-product', $product); ?>>

    <div class="vt-product-container">
        
        <div class="vt-product-gallery-wrapper">
            <?php do_action('woocommerce_before_single_product_summary'); ?>
        </div>

        <div class="vt-product-summary-wrapper">
            <?php do_action('woocommerce_single_product_summary'); ?>
        </div>

    </div>

    <div class="vt-product-details">
        <?php do_action('woocommerce_after_single_product_summary'); ?>
    </div>

</div>

<?php do_action('woocommerce_after_single_product'); ?>
EOF

# 4. Template content-product.php (loop)
log_info "Criando content-product.php..."
cat > "${WC_TEMPLATES_PATH}/content-product.php" << 'EOF'
<?php
/**
 * VancouverTec Store - Product Loop Content
 */

if (!defined('ABSPATH')) exit;

global $product;

if (empty($product) || !$product->is_visible()) {
    return;
}
?>

<li <?php wc_product_class('vt-product-card', $product); ?>>
    
    <div class="vt-product-image">
        <?php
        do_action('woocommerce_before_shop_loop_item');
        do_action('woocommerce_before_shop_loop_item_title');
        ?>
        
        <div class="vt-product-badges">
            <?php if ($product->is_on_sale()): ?>
                <span class="vt-badge vt-sale-badge">Oferta</span>
            <?php endif; ?>
            <?php if ($product->is_featured()): ?>
                <span class="vt-badge vt-featured-badge">Destaque</span>
            <?php endif; ?>
        </div>
    </div>
    
    <div class="vt-product-content">
        <div class="vt-product-info">
            <?php do_action('woocommerce_shop_loop_item_title'); ?>
        </div>
        
        <div class="vt-product-price">
            <?php do_action('woocommerce_after_shop_loop_item_title'); ?>
        </div>
        
        <div class="vt-product-actions">
            <?php do_action('woocommerce_after_shop_loop_item'); ?>
        </div>
    </div>

</li>
EOF

# Iniciar servidor
log_info "Iniciando servidor..."
nohup php -S localhost:8080 router.php > server.log 2>&1 &
echo $! > .server_pid
sleep 3

# Verificar arquivos criados
created_files=(
    "${WC_TEMPLATES_PATH}/single-product/single-product-image.php"
    "${WC_TEMPLATES_PATH}/single-product/single-product-summary.php"
    "${WC_TEMPLATES_PATH}/content-single-product.php"
    "${WC_TEMPLATES_PATH}/content-product.php"
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
echo -e "║    ✅ TEMPLATES SINGLE PRODUCT CRIADOS! ✅   ║"
echo -e "║                                              ║"
echo -e "║  📄 single-product-image.php                ║"
echo -e "║  📄 single-product-summary.php              ║"  
echo -e "║  📄 content-single-product.php              ║"
echo -e "║  📄 content-product.php (loop)              ║"
echo -e "║                                              ║"
echo -e "║  🌐 Servidor: http://localhost:8080          ║"
echo -e "║                                              ║"
echo -e "║  ➡️  Próximo: 31a1-woo-cart-checkout.sh      ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_info "Execute para continuar:"
echo -e "${BLUE}chmod +x 31a1-woo-cart-checkout.sh && ./31a1-woo-cart-checkout.sh${NC}"