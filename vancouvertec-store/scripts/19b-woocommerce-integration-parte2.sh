#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce Integration PARTE 2
# Script: 19b-woocommerce-integration-parte2.sh
# Versão: 1.0.0 - Templates Avançados + Customizações
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
║  🎯 WOOCOMMERCE TEMPLATES AVANÇADOS 🎯      ║
║    Content-Product + Loop + Customizações    ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Criando templates avançados WooCommerce..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# 1. CONTENT-PRODUCT.PHP (usado no loop de produtos)
log_info "Criando content-product.php..."
cat > "$THEME_PATH/woocommerce/content-product.php" << 'EOF'
<?php
/**
 * The template for displaying product content within loops
 */

defined('ABSPATH') || exit;

global $product;

if (empty($product) || !$product->is_visible()) {
    return;
}
?>

<div <?php wc_product_class('product-card-loop', $product); ?>>
    <?php if ($product->is_on_sale()) : ?>
        <div class="sale-badge-loop">
            <?php
            $regular_price = $product->get_regular_price();
            $sale_price = $product->get_sale_price();
            if ($regular_price && $sale_price) {
                $discount = round((($regular_price - $sale_price) / $regular_price) * 100);
                echo $discount . '% OFF';
            } else {
                echo 'OFERTA';
            }
            ?>
        </div>
    <?php endif; ?>
    
    <div class="product-image-wrapper">
        <a href="<?php the_permalink(); ?>" class="product-image-link">
            <?php echo woocommerce_get_product_thumbnail('medium'); ?>
        </a>
        
        <div class="product-actions-hover">
            <?php woocommerce_template_loop_add_to_cart(); ?>
            <button class="quick-view-btn" data-product-id="<?php echo esc_attr($product->get_id()); ?>">
                👁️ Visualização Rápida
            </button>
        </div>
        
        <?php if ($product->is_featured()) : ?>
            <div class="featured-badge">⭐ Destaque</div>
        <?php endif; ?>
    </div>
    
    <div class="product-info-wrapper">
        <?php
        // Categoria
        $terms = get_the_terms($product->get_id(), 'product_cat');
        if ($terms && !is_wp_error($terms)) :
        ?>
            <div class="product-category">
                <a href="<?php echo get_term_link($terms[0]); ?>">
                    <?php echo esc_html($terms[0]->name); ?>
                </a>
            </div>
        <?php endif; ?>
        
        <h3 class="product-title-loop">
            <a href="<?php the_permalink(); ?>">
                <?php the_title(); ?>
            </a>
        </h3>
        
        <div class="product-excerpt-loop">
            <?php echo wp_trim_words(get_the_excerpt(), 15, '...'); ?>
        </div>
        
        <?php woocommerce_template_loop_rating(); ?>
        
        <div class="product-price-wrapper">
            <?php woocommerce_template_loop_price(); ?>
        </div>
        
        <div class="product-meta-info">
            <?php if ($product->is_type('variable')) : ?>
                <span class="variable-info">📋 Várias opções</span>
            <?php endif; ?>
            
            <?php if ($product->is_downloadable()) : ?>
                <span class="download-info">⬇️ Download</span>
            <?php endif; ?>
            
            <?php if ($product->is_virtual()) : ?>
                <span class="virtual-info">💻 Digital</span>
            <?php endif; ?>
        </div>
    </div>
</div>
EOF

# 2. PRODUCT TABS CUSTOMIZADO
log_info "Criando product-tabs personalizado..."
mkdir -p "$THEME_PATH/woocommerce/single-product"
cat > "$THEME_PATH/woocommerce/single-product/tabs/tabs.php" << 'EOF'
<?php
/**
 * Single Product tabs template with VancouverTec design
 */

if (!defined('ABSPATH')) {
    exit;
}

$tabs = apply_filters('woocommerce_product_tabs', array());

if (!empty($tabs)) : ?>
<div class="vt-product-tabs">
    <nav class="vt-tabs-nav" role="tablist">
        <?php $i = 0; foreach ($tabs as $key => $tab) : $i++; ?>
            <button 
                class="vt-tab-button <?php echo $i === 1 ? 'active' : ''; ?>" 
                id="tab-title-<?php echo esc_attr($key); ?>"
                data-tab="<?php echo esc_attr($key); ?>"
                role="tab"
                aria-selected="<?php echo $i === 1 ? 'true' : 'false'; ?>"
                aria-controls="tab-<?php echo esc_attr($key); ?>"
            >
                <?php echo wp_kses_post(apply_filters('woocommerce_product_' . $key . '_tab_title', $tab['title'], $key)); ?>
            </button>
        <?php endforeach; ?>
    </nav>
    
    <div class="vt-tabs-content">
        <?php $i = 0; foreach ($tabs as $key => $tab) : $i++; ?>
            <div 
                class="vt-tab-panel <?php echo $i === 1 ? 'active' : ''; ?>" 
                id="tab-<?php echo esc_attr($key); ?>"
                role="tabpanel" 
                aria-labelledby="tab-title-<?php echo esc_attr($key); ?>"
            >
                <?php
                if (isset($tab['callback'])) {
                    call_user_func($tab['callback'], $key, $tab);
                }
                ?>
            </div>
        <?php endforeach; ?>
    </div>
</div>
<?php endif; ?>
EOF

# 3. SINGLE PRODUCT CUSTOMIZADO
log_info "Atualizando single-product.php com design VancouverTec..."
cat > "$THEME_PATH/woocommerce/single-product.php" << 'EOF'
<?php get_header(); ?>

<div class="vt-single-product-page">
    <div class="container">
        <?php while (have_posts()) : the_post(); ?>
            
            <!-- Breadcrumb VancouverTec -->
            <nav class="vt-breadcrumb" aria-label="Navegação">
                <?php woocommerce_breadcrumb(); ?>
            </nav>
            
            <div class="vt-product-layout">
                <!-- Galeria de Imagens -->
                <div class="vt-product-gallery">
                    <?php woocommerce_show_product_images(); ?>
                </div>
                
                <!-- Resumo do Produto -->
                <div class="vt-product-summary">
                    <div class="vt-product-badges">
                        <?php global $product; ?>
                        <?php if ($product->is_on_sale()) : ?>
                            <span class="vt-badge sale">🔥 Em Oferta</span>
                        <?php endif; ?>
                        <?php if ($product->is_featured()) : ?>
                            <span class="vt-badge featured">⭐ Destaque</span>
                        <?php endif; ?>
                        <?php if ($product->is_virtual()) : ?>
                            <span class="vt-badge digital">💻 Produto Digital</span>
                        <?php endif; ?>
                    </div>
                    
                    <h1 class="vt-product-title"><?php the_title(); ?></h1>
                    
                    <div class="vt-product-rating">
                        <?php woocommerce_template_single_rating(); ?>
                    </div>
                    
                    <div class="vt-product-price">
                        <?php woocommerce_template_single_price(); ?>
                    </div>
                    
                    <div class="vt-product-description">
                        <?php woocommerce_template_single_excerpt(); ?>
                    </div>
                    
                    <!-- Formulário de Compra -->
                    <div class="vt-product-form">
                        <?php woocommerce_template_single_add_to_cart(); ?>
                    </div>
                    
                    <!-- Garantias VancouverTec -->
                    <div class="vt-product-guarantees">
                        <h4>Garantias VancouverTec</h4>
                        <div class="vt-guarantees-grid">
                            <div class="vt-guarantee-item">
                                <span class="vt-guarantee-icon">🛡️</span>
                                <div class="vt-guarantee-text">
                                    <strong>Garantia de 30 dias</strong>
                                    <small>Satisfação garantida ou dinheiro de volta</small>
                                </div>
                            </div>
                            <div class="vt-guarantee-item">
                                <span class="vt-guarantee-icon">🚀</span>
                                <div class="vt-guarantee-text">
                                    <strong>Entrega Imediata</strong>
                                    <small>Acesso instantâneo após o pagamento</small>
                                </div>
                            </div>
                            <div class="vt-guarantee-item">
                                <span class="vt-guarantee-icon">📞</span>
                                <div class="vt-guarantee-text">
                                    <strong>Suporte 24/7</strong>
                                    <small>Equipe especializada sempre disponível</small>
                                </div>
                            </div>
                            <div class="vt-guarantee-item">
                                <span class="vt-guarantee-icon">🔄</span>
                                <div class="vt-guarantee-text">
                                    <strong>Atualizações Gratuitas</strong>
                                    <small>Sempre com a versão mais recente</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Meta Information -->
                    <div class="vt-product-meta">
                        <?php woocommerce_template_single_meta(); ?>
                    </div>
                </div>
            </div>
            
            <!-- Tabs do Produto -->
            <div class="vt-product-tabs-section">
                <?php woocommerce_output_product_data_tabs(); ?>
            </div>
            
            <!-- Produtos Relacionados -->
            <div class="vt-related-products">
                <?php woocommerce_output_related_products(); ?>
            </div>
            
        <?php endwhile; ?>
    </div>
</div>

<?php get_footer(); ?>
EOF

# 4. CSS para Templates Avançados
log_info "Criando CSS para templates avançados..."
cat > "$THEME_PATH/assets/css/components/woocommerce-advanced.css" << 'EOF'
/* VancouverTec Store - WooCommerce Templates Avançados */

/* PRODUCT LOOP CARD */
.product-card-loop {
  background: white;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  position: relative;
  border: 1px solid #E5E7EB;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.product-card-loop:hover {
  transform: translateY(-5px);
  box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
  border-color: var(--vt-blue-600);
}

.sale-badge-loop {
  position: absolute;
  top: 1rem;
  right: 1rem;
  background: linear-gradient(135deg, #EF4444, #DC2626);
  color: white;
  padding: 0.5rem 0.75rem;
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 700;
  z-index: 10;
  text-transform: uppercase;
  box-shadow: 0 2px 10px rgba(239, 68, 68, 0.3);
}

.featured-badge {
  position: absolute;
  top: 1rem;
  left: 1rem;
  background: linear-gradient(135deg, #F59E0B, #D97706);
  color: white;
  padding: 0.5rem 0.75rem;
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 700;
  z-index: 9;
}

.product-image-wrapper {
  position: relative;
  height: 220px;
  overflow: hidden;
  background: linear-gradient(135deg, #F8FAFC, #E2E8F0);
}

.product-image-link {
  display: block;
  width: 100%;
  height: 100%;
}

.product-image-wrapper img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.product-card-loop:hover .product-image-wrapper img {
  transform: scale(1.1);
}

.product-actions-hover {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(transparent, rgba(0, 0, 0, 0.9));
  padding: 2rem 1rem 1rem;
  transform: translateY(100%);
  transition: transform 0.3s ease;
  display: flex;
  gap: 0.5rem;
}

.product-card-loop:hover .product-actions-hover {
  transform: translateY(0);
}

.product-actions-hover .button,
.product-actions-hover .add_to_cart_button {
  flex: 1;
  background: var(--vt-blue-600) !important;
  color: white !important;
  border: none;
  padding: 0.75rem;
  border-radius: 8px;
  font-weight: 600;
  font-size: 0.875rem;
  text-align: center;
  transition: all 0.3s ease;
}

.quick-view-btn {
  flex: 1;
  background: rgba(255, 255, 255, 0.2);
  color: white;
  border: 1px solid rgba(255, 255, 255, 0.3);
  padding: 0.75rem;
  border-radius: 8px;
  font-weight: 600;
  font-size: 0.875rem;
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
}

.quick-view-btn:hover {
  background: rgba(255, 255, 255, 0.3);
}

.product-info-wrapper {
  padding: 1.5rem;
  flex: 1;
  display: flex;
  flex-direction: column;
}

.product-category {
  margin-bottom: 0.5rem;
}

.product-category a {
  color: var(--vt-blue-600);
  text-decoration: none;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.product-title-loop {
  margin-bottom: 0.75rem;
  flex-shrink: 0;
}

.product-title-loop a {
  color: #1F2937;
  text-decoration: none;
  font-size: 1.125rem;
  font-weight: 700;
  line-height: 1.4;
  transition: color 0.3s ease;
}

.product-title-loop a:hover {
  color: var(--vt-blue-600);
}

.product-excerpt-loop {
  color: #6B7280;
  line-height: 1.6;
  margin-bottom: 1rem;
  font-size: 0.875rem;
  flex: 1;
}

.product-price-wrapper {
  margin-bottom: 1rem;
  flex-shrink: 0;
}

.product-price-wrapper .price {
  font-size: 1.25rem;
  font-weight: 800;
  color: var(--vt-blue-600);
}

.product-price-wrapper del {
  color: #9CA3AF;
  margin-right: 0.5rem;
  font-size: 1rem;
}

.product-price-wrapper ins {
  text-decoration: none;
  color: #EF4444;
  font-weight: 800;
}

.product-meta-info {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
  flex-shrink: 0;
}

.product-meta-info span {
  background: #F3F4F6;
  color: #6B7280;
  padding: 0.25rem 0.5rem;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: 600;
}

/* SINGLE PRODUCT AVANÇADO */
.vt-single-product-page {
  padding: 2rem 0 5rem;
}

.vt-breadcrumb {
  margin-bottom: 2rem;
}

.vt-breadcrumb .woocommerce-breadcrumb {
  color: #6B7280;
  font-size: 0.875rem;
}

.vt-breadcrumb .woocommerce-breadcrumb a {
  color: var(--vt-blue-600);
  text-decoration: none;
}

.vt-product-layout {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  margin-bottom: 4rem;
}

.vt-product-gallery {
  position: sticky;
  top: 2rem;
  height: fit-content;
}

.vt-product-summary {
  padding: 2rem 0;
}

.vt-product-badges {
  display: flex;
  gap: 0.75rem;
  margin-bottom: 1.5rem;
  flex-wrap: wrap;
}

.vt-badge {
  padding: 0.5rem 1rem;
  border-radius: 20px;
  font-size: 0.875rem;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.vt-badge.sale {
  background: linear-gradient(135deg, #EF4444, #DC2626);
  color: white;
}

.vt-badge.featured {
  background: linear-gradient(135deg, #F59E0B, #D97706);
  color: white;
}

.vt-badge.digital {
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500));
  color: white;
}

.vt-product-title {
  font-size: 2.5rem;
  font-weight: 800;
  color: #1F2937;
  margin-bottom: 1.5rem;
  line-height: 1.2;
}

.vt-product-price {
  margin-bottom: 2rem;
}

.vt-product-price .price {
  font-size: 2.5rem;
  font-weight: 800;
  color: var(--vt-blue-600);
}

.vt-product-description {
  font-size: 1.125rem;
  line-height: 1.7;
  color: #6B7280;
  margin-bottom: 2rem;
}

.vt-product-form {
  margin-bottom: 3rem;
}

.vt-product-form .cart {
  display: flex;
  gap: 1rem;
  align-items: flex-end;
  flex-wrap: wrap;
}

.vt-product-form .quantity {
  min-width: 120px;
}

.vt-product-form .single_add_to_cart_button {
  flex: 1;
  min-width: 200px;
  padding: 1.25rem 2rem;
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500));
  color: white;
  border: none;
  border-radius: 10px;
  font-size: 1.125rem;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s ease;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.vt-product-form .single_add_to_cart_button:hover {
  background: linear-gradient(135deg, var(--vt-blue-700), #4F46E5);
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(0, 102, 204, 0.3);
}

/* GARANTIAS VANCOUVERTEC */
.vt-product-guarantees {
  background: linear-gradient(135deg, #F0F9FF, #E0F2FE);
  padding: 2rem;
  border-radius: 15px;
  margin-bottom: 2rem;
  border: 1px solid #E0F2FE;
}

.vt-product-guarantees h4 {
  font-size: 1.25rem;
  font-weight: 700;
  color: #1F2937;
  margin-bottom: 1.5rem;
  text-align: center;
}

.vt-guarantees-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1.5rem;
}

.vt-guarantee-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  background: white;
  border-radius: 10px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

.vt-guarantee-icon {
  font-size: 2rem;
  flex-shrink: 0;
}

.vt-guarantee-text strong {
  display: block;
  color: #1F2937;
  font-weight: 700;
  margin-bottom: 0.25rem;
}

.vt-guarantee-text small {
  color: #6B7280;
  font-size: 0.875rem;
  line-height: 1.4;
}

/* PRODUCT TABS VANCOUVERTEC */
.vt-product-tabs-section {
  margin-bottom: 4rem;
}

.vt-product-tabs {
  background: white;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.vt-tabs-nav {
  display: flex;
  background: #F9FAFB;
  border-bottom: 1px solid #E5E7EB;
}

.vt-tab-button {
  flex: 1;
  padding: 1.5rem 2rem;
  background: transparent;
  border: none;
  color: #6B7280;
  font-weight: 600;
  font-size: 1rem;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
}

.vt-tab-button.active {
  color: var(--vt-blue-600);
  background: white;
}

.vt-tab-button.active::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: var(--vt-blue-600);
}

.vt-tab-button:hover {
  color: var(--vt-blue-600);
  background: rgba(0, 102, 204, 0.05);
}

.vt-tab-panel {
  display: none;
  padding: 2rem;
  min-height: 200px;
}

.vt-tab-panel.active {
  display: block;
}

/* RESPONSIVE */
@media (max-width: 1024px) {
  .vt-product-layout {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .vt-product-gallery {
    position: relative;
    top: 0;
  }
  
  .vt-guarantees-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .vt-product-title {
    font-size: 2rem;
  }
  
  .vt-product-price .price {
    font-size: 2rem;
  }
  
  .vt-tabs-nav {
    flex-direction: column;
  }
  
  .vt-tab-button {
    text-align: left;
  }
  
  .vt-product-form .cart {
    flex-direction: column;
    align-items: stretch;
  }
}

@media (max-width: 480px) {
  .vt-single-product-page {
    padding: 1rem 0 3rem;
  }
  
  .vt-product-guarantees {
    padding: 1rem;
  }
  
  .vt-guarantee-item {
    flex-direction: column;
    text-align: center;
  }
}
EOF

# Atualizar functions.php
log_info "Atualizando functions.php..."
if ! grep -q "woocommerce-advanced.css" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_style.*vt-woocommerce/a\        wp_enqueue_style('"'"'vt-woocommerce-advanced'"'"', VT_THEME_URI . '"'"'/assets/css/components/woocommerce-advanced.css'"'"', ['"'"'vt-woocommerce'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"
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
echo -e "║  ✅ TEMPLATES AVANÇADOS CRIADOS! ✅          ║"
echo -e "║    Content-Product + Tabs + Single           ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ content-product.php com cards avançados"
log_success "✅ Single product com design VancouverTec"
log_success "✅ Product tabs customizados"
log_success "✅ Garantias VancouverTec integradas"
log_success "✅ CSS avançado responsivo"

echo -e "\n${BLUE}📄 Digite 'continuar' para PARTE 3: My Account + Checkout${NC}"

exit 0