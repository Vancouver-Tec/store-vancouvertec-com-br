#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce Templates PARTE 2
# Script: 10b-woocommerce-templates-parte2.sh
# Versão: 1.0.0 - Shop + Single Product + Archive
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
║   🛒 WOOCOMMERCE TEMPLATES - PARTE 2 🛒      ║
║      Shop + Single Product + Archive         ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Criando templates WooCommerce..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Criar pasta woocommerce
mkdir -p "$THEME_PATH/woocommerce"

# 1. ARCHIVE-PRODUCT.PHP (Página Shop)
log_info "Criando archive-product.php (página shop)..."
cat > "$THEME_PATH/woocommerce/archive-product.php" << 'EOF'
<?php
/**
 * Shop Page Template - VancouverTec Store
 */

get_header(); ?>

<div class="shop-page">
    <div class="container">
        <!-- Breadcrumb -->
        <div class="shop-breadcrumb">
            <?php woocommerce_breadcrumb(); ?>
        </div>
        
        <!-- Shop Header -->
        <div class="shop-header">
            <div class="shop-title-area">
                <h1 class="shop-title">
                    <?php woocommerce_page_title(); ?>
                </h1>
                <?php if (is_product_category()) : ?>
                    <div class="category-description">
                        <?php echo category_description(); ?>
                    </div>
                <?php endif; ?>
            </div>
            
            <!-- Filtros e Ordenação -->
            <div class="shop-controls">
                <div class="shop-filters">
                    <?php woocommerce_catalog_ordering(); ?>
                </div>
                <div class="results-count">
                    <?php woocommerce_result_count(); ?>
                </div>
            </div>
        </div>
        
        <div class="shop-content">
            <!-- Sidebar com Filtros -->
            <aside class="shop-sidebar">
                <div class="sidebar-widget">
                    <h3>Categorias</h3>
                    <?php the_widget('WC_Widget_Product_Categories'); ?>
                </div>
                
                <div class="sidebar-widget">
                    <h3>Filtrar por Preço</h3>
                    <?php the_widget('WC_Widget_Price_Filter'); ?>
                </div>
                
                <div class="sidebar-widget">
                    <h3>Produtos em Oferta</h3>
                    <?php the_widget('WC_Widget_Products', array('show' => 'onsale', 'number' => 3)); ?>
                </div>
            </aside>
            
            <!-- Grid de Produtos -->
            <main class="shop-main">
                <?php if (woocommerce_product_loop()) : ?>
                    <div class="products-grid-shop">
                        <?php
                        woocommerce_product_loop_start();
                        
                        if (wc_get_loop_prop('is_shortcode')) {
                            $columns = absint(wc_get_loop_prop('columns'));
                        }
                        
                        while (have_posts()) :
                            the_post();
                            global $product;
                            $product_id = get_the_ID();
                        ?>
                        
                        <div class="product-card-shop">
                            <?php if ($product->is_on_sale()) : ?>
                                <div class="sale-badge-shop">
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
                            
                            <div class="product-image-shop">
                                <a href="<?php the_permalink(); ?>">
                                    <?php echo woocommerce_get_product_thumbnail(); ?>
                                </a>
                                
                                <div class="product-actions-overlay">
                                    <?php woocommerce_template_loop_add_to_cart(); ?>
                                    <button class="quick-view-btn" data-product-id="<?php echo $product_id; ?>">
                                        👁️ Visualização Rápida
                                    </button>
                                </div>
                            </div>
                            
                            <div class="product-info-shop">
                                <h3 class="product-title-shop">
                                    <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
                                </h3>
                                
                                <div class="product-price-shop">
                                    <?php echo $product->get_price_html(); ?>
                                </div>
                                
                                <div class="product-rating-shop">
                                    <?php woocommerce_template_loop_rating(); ?>
                                </div>
                            </div>
                        </div>
                        
                        <?php endwhile; ?>
                        
                        <?php woocommerce_product_loop_end(); ?>
                    </div>
                    
                    <?php woocommerce_pagination(); ?>
                    
                <?php else : ?>
                    <div class="no-products-found">
                        <h2>Nenhum produto encontrado</h2>
                        <p>Não há produtos que correspondam à sua seleção.</p>
                        <a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>" class="btn">
                            Ver Todos os Produtos
                        </a>
                    </div>
                <?php endif; ?>
            </main>
        </div>
    </div>
</div>

<?php get_footer(); ?>
EOF

# 2. SINGLE-PRODUCT.PHP
log_info "Criando single-product.php..."
cat > "$THEME_PATH/woocommerce/single-product.php" << 'EOF'
<?php
/**
 * Single Product Template - VancouverTec Store
 */

get_header(); ?>

<div class="single-product-page">
    <div class="container">
        <?php while (have_posts()) : the_post(); ?>
            
            <!-- Breadcrumb -->
            <div class="product-breadcrumb">
                <?php woocommerce_breadcrumb(); ?>
            </div>
            
            <div class="product-content">
                <!-- Imagens do Produto -->
                <div class="product-images">
                    <?php woocommerce_show_product_images(); ?>
                </div>
                
                <!-- Informações do Produto -->
                <div class="product-summary">
                    <h1 class="product-title"><?php the_title(); ?></h1>
                    
                    <div class="product-rating">
                        <?php woocommerce_template_single_rating(); ?>
                    </div>
                    
                    <div class="product-price">
                        <?php woocommerce_template_single_price(); ?>
                    </div>
                    
                    <div class="product-excerpt">
                        <?php woocommerce_template_single_excerpt(); ?>
                    </div>
                    
                    <div class="product-form">
                        <?php woocommerce_template_single_add_to_cart(); ?>
                    </div>
                    
                    <div class="product-meta">
                        <?php woocommerce_template_single_meta(); ?>
                    </div>
                    
                    <!-- Garantias e Benefícios -->
                    <div class="product-guarantees">
                        <div class="guarantee-item">
                            <span class="guarantee-icon">🛡️</span>
                            <span>Garantia de 30 dias</span>
                        </div>
                        <div class="guarantee-item">
                            <span class="guarantee-icon">🚀</span>
                            <span>Entrega em 7 dias</span>
                        </div>
                        <div class="guarantee-item">
                            <span class="guarantee-icon">📞</span>
                            <span>Suporte 24/7</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Abas do Produto -->
            <div class="product-tabs">
                <?php woocommerce_output_product_data_tabs(); ?>
            </div>
            
            <!-- Produtos Relacionados -->
            <div class="related-products">
                <?php woocommerce_output_related_products(); ?>
            </div>
            
        <?php endwhile; ?>
    </div>
</div>

<?php get_footer(); ?>
EOF

# 3. CSS para templates WooCommerce
log_info "Criando CSS para templates WooCommerce..."
cat > "$THEME_PATH/assets/css/components/woocommerce-pages.css" << 'EOF'
/* VancouverTec Store - WooCommerce Pages */

/* SHOP PAGE */
.shop-page {
  padding: 2rem 0 5rem;
  min-height: 70vh;
}

.shop-breadcrumb {
  margin-bottom: 2rem;
}

.shop-breadcrumb .woocommerce-breadcrumb {
  color: #6B7280;
  font-size: 0.875rem;
}

.shop-breadcrumb .woocommerce-breadcrumb a {
  color: #0066CC;
  text-decoration: none;
}

.shop-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 3rem;
  padding-bottom: 2rem;
  border-bottom: 1px solid #E5E7EB;
}

.shop-title {
  font-size: 2.5rem;
  font-weight: 800;
  color: #1F2937;
  margin-bottom: 0.5rem;
}

.category-description {
  color: #6B7280;
  line-height: 1.6;
}

.shop-controls {
  display: flex;
  gap: 2rem;
  align-items: center;
}

.shop-content {
  display: grid;
  grid-template-columns: 280px 1fr;
  gap: 3rem;
}

/* Sidebar */
.shop-sidebar {
  background: #F9FAFB;
  padding: 2rem;
  border-radius: 15px;
  height: fit-content;
  position: sticky;
  top: 2rem;
}

.sidebar-widget {
  margin-bottom: 2rem;
}

.sidebar-widget:last-child {
  margin-bottom: 0;
}

.sidebar-widget h3 {
  font-size: 1.125rem;
  font-weight: 700;
  color: #1F2937;
  margin-bottom: 1rem;
}

.sidebar-widget ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.sidebar-widget li {
  margin-bottom: 0.5rem;
}

.sidebar-widget a {
  color: #6B7280;
  text-decoration: none;
  transition: color 0.3s ease;
}

.sidebar-widget a:hover {
  color: #0066CC;
}

/* Grid de Produtos */
.products-grid-shop {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 2rem;
}

.product-card-shop {
  background: white;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  position: relative;
  border: 1px solid #E5E7EB;
}

.product-card-shop:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
  border-color: #0066CC;
}

.sale-badge-shop {
  position: absolute;
  top: 1rem;
  right: 1rem;
  background: #EF4444;
  color: white;
  padding: 0.5rem 0.75rem;
  border-radius: 15px;
  font-size: 0.75rem;
  font-weight: 700;
  z-index: 10;
}

.product-image-shop {
  position: relative;
  overflow: hidden;
  height: 200px;
}

.product-image-shop img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.product-card-shop:hover .product-image-shop img {
  transform: scale(1.1);
}

.product-actions-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.8);
  padding: 1rem;
  transform: translateY(100%);
  transition: transform 0.3s ease;
  display: flex;
  gap: 0.5rem;
}

.product-card-shop:hover .product-actions-overlay {
  transform: translateY(0);
}

.product-actions-overlay .button,
.product-actions-overlay .add_to_cart_button {
  flex: 1;
  background: #0066CC;
  color: white;
  border: none;
  padding: 0.5rem;
  border-radius: 8px;
  font-size: 0.875rem;
  font-weight: 600;
}

.quick-view-btn {
  flex: 1;
  background: #6B7280;
  color: white;
  border: none;
  padding: 0.5rem;
  border-radius: 8px;
  font-size: 0.875rem;
  font-weight: 600;
  cursor: pointer;
}

.product-info-shop {
  padding: 1.5rem;
}

.product-title-shop {
  margin-bottom: 0.75rem;
}

.product-title-shop a {
  color: #1F2937;
  text-decoration: none;
  font-size: 1.125rem;
  font-weight: 700;
  line-height: 1.4;
}

.product-title-shop a:hover {
  color: #0066CC;
}

.product-price-shop {
  margin-bottom: 0.75rem;
}

.product-price-shop .price {
  font-size: 1.25rem;
  font-weight: 800;
  color: #0066CC;
}

.product-price-shop del {
  color: #9CA3AF;
  margin-right: 0.5rem;
}

.product-price-shop ins {
  text-decoration: none;
  color: #EF4444;
}

/* SINGLE PRODUCT */
.single-product-page {
  padding: 2rem 0 5rem;
}

.product-breadcrumb {
  margin-bottom: 2rem;
}

.product-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 4rem;
  margin-bottom: 4rem;
}

.product-images {
  position: sticky;
  top: 2rem;
  height: fit-content;
}

.product-images img {
  width: 100%;
  border-radius: 15px;
}

.product-summary {
  padding: 2rem 0;
}

.product-title {
  font-size: 2.5rem;
  font-weight: 800;
  color: #1F2937;
  margin-bottom: 1rem;
}

.product-rating {
  margin-bottom: 1.5rem;
}

.product-price {
  margin-bottom: 2rem;
}

.product-price .price {
  font-size: 2rem;
  font-weight: 800;
  color: #0066CC;
}

.product-excerpt {
  font-size: 1.125rem;
  line-height: 1.6;
  color: #6B7280;
  margin-bottom: 2rem;
}

.product-form {
  margin-bottom: 2rem;
}

.product-form .cart {
  display: flex;
  gap: 1rem;
  align-items: flex-end;
}

.product-form .quantity {
  width: 100px;
}

.product-form .single_add_to_cart_button {
  flex: 1;
  padding: 1rem 2rem;
  background: #0066CC;
  color: white;
  border: none;
  border-radius: 10px;
  font-size: 1.125rem;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s ease;
}

.product-form .single_add_to_cart_button:hover {
  background: #0052A3;
  transform: translateY(-2px);
}

.product-guarantees {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  padding: 2rem;
  background: #F0F9FF;
  border-radius: 15px;
  margin-top: 2rem;
}

.guarantee-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  font-weight: 600;
  color: #1F2937;
}

.guarantee-icon {
  font-size: 1.25rem;
}

/* Product Tabs */
.product-tabs {
  margin-bottom: 4rem;
}

.woocommerce-tabs {
  background: white;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.woocommerce-tabs .tabs {
  display: flex;
  background: #F9FAFB;
  border-bottom: 1px solid #E5E7EB;
  margin: 0;
  padding: 0;
  list-style: none;
}

.woocommerce-tabs .tabs li {
  flex: 1;
}

.woocommerce-tabs .tabs li a {
  display: block;
  padding: 1.5rem;
  text-align: center;
  color: #6B7280;
  text-decoration: none;
  font-weight: 600;
  transition: all 0.3s ease;
}

.woocommerce-tabs .tabs li.active a {
  background: white;
  color: #0066CC;
  border-bottom: 3px solid #0066CC;
}

.woocommerce-tabs .panel {
  padding: 2rem;
}

/* No Products */
.no-products-found {
  text-align: center;
  padding: 4rem 2rem;
  color: #6B7280;
}

.no-products-found h2 {
  font-size: 2rem;
  color: #1F2937;
  margin-bottom: 1rem;
}

/* Responsive */
@media (max-width: 1024px) {
  .shop-content {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .shop-sidebar {
    position: relative;
    top: 0;
  }
  
  .product-content {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
}

@media (max-width: 768px) {
  .shop-header {
    flex-direction: column;
    gap: 1rem;
    align-items: flex-start;
  }
  
  .shop-controls {
    width: 100%;
    justify-content: space-between;
  }
  
  .products-grid-shop {
    grid-template-columns: 1fr;
  }
  
  .product-title {
    font-size: 2rem;
  }
  
  .product-form .cart {
    flex-direction: column;
    align-items: stretch;
  }
  
  .woocommerce-tabs .tabs {
    flex-direction: column;
  }
}

@media (max-width: 480px) {
  .single-product-page,
  .shop-page {
    padding: 1rem 0 3rem;
  }
  
  .product-guarantees {
    padding: 1rem;
  }
}
EOF

# Atualizar functions.php
log_info "Atualizando functions.php para WooCommerce..."
if ! grep -q "woocommerce-pages.css" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_style.*vt-woo-home/a\    wp_enqueue_style('"'"'vt-woo-pages'"'"', VT_THEME_URI . '"'"'/assets/css/components/woocommerce-pages.css'"'"', ['"'"'vt-woo-home'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"
fi

# Adicionar suporte ao WooCommerce no functions.php
if ! grep -q "add_theme_support.*woocommerce" "$THEME_PATH/functions.php"; then
    sed -i '/add_theme_support.*post-thumbnails/a\    add_theme_support('"'"'woocommerce'"'"');' "$THEME_PATH/functions.php"
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
echo -e "║   ✅ TEMPLATES WOOCOMMERCE - PARTE 2! ✅     ║"
echo -e "║      Shop + Single Product Criados          ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ archive-product.php (página shop)"
log_success "✅ single-product.php (produto individual)"
log_success "✅ CSS completo para páginas WooCommerce"
log_success "✅ Suporte ao WooCommerce ativado"

echo -e "\n${BLUE}🔄 Próxima parte: Cart + Checkout + Account${NC}"
log_info "Digite 'continuar' para PARTE 3"

exit 0