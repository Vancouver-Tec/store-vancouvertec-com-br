#!/bin/bash

# ===========================================
# VancouverTec Store - Templates WooCommerce Customizados
# Script: 21a-templates-woocommerce-customizados.sh
# Versão: 1.0.0 - Single Product + Content Product
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
║    🎨 TEMPLATES WOOCOMMERCE CUSTOMIZADOS 🎨  ║
║        Single Product + Content Product      ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Criando templates WooCommerce customizados..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# 1. SINGLE PRODUCT TEMPLATE (seguindo layout VancouverTec)
log_info "Criando single-product.php customizado..."
cat > "$THEME_PATH/woocommerce/single-product.php" << 'EOF'
<?php get_header(); ?>

<div class="vt-single-product">
    <div class="container">
        <?php while (have_posts()) : the_post(); ?>
            
            <!-- Breadcrumb VancouverTec -->
            <nav class="vt-breadcrumb">
                <?php woocommerce_breadcrumb(); ?>
            </nav>
            
            <div class="vt-product-main">
                <!-- Galeria Produto -->
                <div class="vt-product-gallery">
                    <?php woocommerce_show_product_images(); ?>
                </div>
                
                <!-- Info Produto -->
                <div class="vt-product-info">
                    <?php global $product; ?>
                    
                    <!-- Badges -->
                    <div class="vt-product-badges">
                        <?php if ($product->is_on_sale()) : ?>
                            <span class="vt-badge sale">🔥 Em Oferta</span>
                        <?php endif; ?>
                        <?php if ($product->is_featured()) : ?>
                            <span class="vt-badge featured">⭐ Destaque</span>
                        <?php endif; ?>
                        <?php if ($product->is_virtual()) : ?>
                            <span class="vt-badge digital">💻 Digital</span>
                        <?php endif; ?>
                    </div>
                    
                    <h1 class="vt-product-title"><?php the_title(); ?></h1>
                    
                    <?php woocommerce_template_single_rating(); ?>
                    
                    <div class="vt-product-price">
                        <?php woocommerce_template_single_price(); ?>
                    </div>
                    
                    <div class="vt-product-description">
                        <?php woocommerce_template_single_excerpt(); ?>
                    </div>
                    
                    <!-- Form Compra -->
                    <div class="vt-product-form">
                        <?php woocommerce_template_single_add_to_cart(); ?>
                    </div>
                    
                    <!-- Garantias VancouverTec -->
                    <div class="vt-guarantees">
                        <h4>Garantias VancouverTec</h4>
                        <div class="vt-guarantees-list">
                            <div class="guarantee-item">
                                <span class="guarantee-icon">🛡️</span>
                                <div>
                                    <strong>30 dias de garantia</strong>
                                    <small>Satisfação garantida ou dinheiro de volta</small>
                                </div>
                            </div>
                            <div class="guarantee-item">
                                <span class="guarantee-icon">🚀</span>
                                <div>
                                    <strong>Entrega imediata</strong>
                                    <small>Acesso instantâneo após pagamento</small>
                                </div>
                            </div>
                            <div class="guarantee-item">
                                <span class="guarantee-icon">📞</span>
                                <div>
                                    <strong>Suporte 24/7</strong>
                                    <small>Equipe sempre disponível</small>
                                </div>
                            </div>
                            <div class="guarantee-item">
                                <span class="guarantee-icon">🔄</span>
                                <div>
                                    <strong>Atualizações gratuitas</strong>
                                    <small>Sempre atualizado</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <?php woocommerce_template_single_meta(); ?>
                </div>
            </div>
            
            <!-- Tabs Produto -->
            <div class="vt-product-tabs">
                <?php woocommerce_output_product_data_tabs(); ?>
            </div>
            
            <!-- Produtos Relacionados -->
            <?php woocommerce_output_related_products(); ?>
            
        <?php endwhile; ?>
    </div>
</div>

<?php get_footer(); ?>
EOF

# 2. CONTENT PRODUCT (para loops de produtos)
log_info "Criando content-product.php..."
cat > "$THEME_PATH/woocommerce/content-product.php" << 'EOF'
<?php
defined('ABSPATH') || exit;

global $product;
if (empty($product) || !$product->is_visible()) {
    return;
}
?>

<div <?php wc_product_class('vt-product-loop-card', $product); ?>>
    <?php if ($product->is_on_sale()) : ?>
        <div class="vt-sale-badge">
            <?php
            $regular = $product->get_regular_price();
            $sale = $product->get_sale_price();
            if ($regular && $sale) {
                $discount = round((($regular - $sale) / $regular) * 100);
                echo $discount . '% OFF';
            } else {
                echo 'OFERTA';
            }
            ?>
        </div>
    <?php endif; ?>
    
    <div class="vt-product-image">
        <a href="<?php the_permalink(); ?>">
            <?php echo woocommerce_get_product_thumbnail('medium'); ?>
        </a>
        
        <div class="vt-product-overlay">
            <?php woocommerce_template_loop_add_to_cart(); ?>
            <a href="<?php the_permalink(); ?>" class="vt-quick-view">Ver Detalhes</a>
        </div>
        
        <?php if ($product->is_featured()) : ?>
            <div class="vt-featured-badge">⭐</div>
        <?php endif; ?>
    </div>
    
    <div class="vt-product-content">
        <?php
        $terms = get_the_terms($product->get_id(), 'product_cat');
        if ($terms && !is_wp_error($terms)) :
        ?>
            <div class="vt-product-category">
                <a href="<?php echo get_term_link($terms[0]); ?>">
                    <?php echo esc_html($terms[0]->name); ?>
                </a>
            </div>
        <?php endif; ?>
        
        <h3 class="vt-product-title">
            <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
        </h3>
        
        <div class="vt-product-excerpt">
            <?php echo wp_trim_words(get_the_excerpt(), 15, '...'); ?>
        </div>
        
        <?php woocommerce_template_loop_rating(); ?>
        
        <div class="vt-product-price">
            <?php woocommerce_template_loop_price(); ?>
        </div>
        
        <div class="vt-product-meta">
            <?php if ($product->is_virtual()) : ?>
                <span class="vt-meta-tag digital">💻 Digital</span>
            <?php endif; ?>
            <?php if ($product->is_downloadable()) : ?>
                <span class="vt-meta-tag download">⬇️ Download</span>
            <?php endif; ?>
        </div>
    </div>
</div>
EOF

# 3. CSS ESPECÍFICO PARA TEMPLATES (não override geral)
log_info "Criando CSS específico para templates..."
cat > "$THEME_PATH/assets/css/components/woocommerce-templates-vt.css" << 'EOF'
/* VancouverTec - Templates WooCommerce Específicos */

/* SINGLE PRODUCT */
.vt-single-product {
  padding: 2rem 0 4rem;
}

.vt-breadcrumb {
  margin-bottom: 2rem;
  font-size: 0.875rem;
}

.vt-breadcrumb .woocommerce-breadcrumb a {
  color: var(--vt-blue-600);
  text-decoration: none;
}

.vt-product-main {
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

.vt-product-info {
  padding: 1rem 0;
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

.vt-product-price .price {
  font-size: 2rem;
  font-weight: 800;
  color: var(--vt-blue-600);
}

.vt-product-description {
  font-size: 1.125rem;
  line-height: 1.6;
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
}

.vt-product-form .single_add_to_cart_button {
  flex: 1;
  padding: 1.25rem 2rem;
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500));
  color: white;
  border: none;
  border-radius: 10px;
  font-size: 1.125rem;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s ease;
}

.vt-product-form .single_add_to_cart_button:hover {
  background: linear-gradient(135deg, var(--vt-blue-700), #4F46E5);
  transform: translateY(-2px);
}

/* GARANTIAS VANCOUVERTEC */
.vt-guarantees {
  background: linear-gradient(135deg, #F0F9FF, #E0F2FE);
  padding: 2rem;
  border-radius: 15px;
  margin-bottom: 2rem;
}

.vt-guarantees h4 {
  font-size: 1.25rem;
  font-weight: 700;
  color: #1F2937;
  margin-bottom: 1.5rem;
}

.vt-guarantees-list {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1.5rem;
}

.guarantee-item {
  display: flex;
  gap: 1rem;
  align-items: flex-start;
}

.guarantee-icon {
  font-size: 1.5rem;
  flex-shrink: 0;
}

.guarantee-item strong {
  display: block;
  color: #1F2937;
  font-weight: 600;
  margin-bottom: 0.25rem;
}

.guarantee-item small {
  color: #6B7280;
  font-size: 0.875rem;
}

/* PRODUCT LOOP CARDS */
.vt-product-loop-card {
  background: white;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  position: relative;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.vt-product-loop-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
}

.vt-sale-badge {
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

.vt-featured-badge {
  position: absolute;
  top: 1rem;
  left: 1rem;
  background: #F59E0B;
  color: white;
  padding: 0.5rem;
  border-radius: 50%;
  z-index: 9;
}

.vt-product-image {
  position: relative;
  height: 200px;
  overflow: hidden;
}

.vt-product-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.vt-product-loop-card:hover .vt-product-image img {
  transform: scale(1.1);
}

.vt-product-overlay {
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

.vt-product-loop-card:hover .vt-product-overlay {
  transform: translateY(0);
}

.vt-product-overlay .button,
.vt-quick-view {
  flex: 1;
  padding: 0.5rem;
  text-align: center;
  border-radius: 5px;
  font-size: 0.875rem;
  font-weight: 600;
  text-decoration: none;
}

.vt-product-overlay .button {
  background: var(--vt-blue-600);
  color: white;
  border: none;
}

.vt-quick-view {
  background: rgba(255, 255, 255, 0.2);
  color: white;
}

.vt-product-content {
  padding: 1.5rem;
  flex: 1;
  display: flex;
  flex-direction: column;
}

.vt-product-category a {
  color: var(--vt-blue-600);
  text-decoration: none;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
}

.vt-product-title {
  margin: 0.5rem 0 1rem;
  flex-shrink: 0;
}

.vt-product-title a {
  color: #1F2937;
  text-decoration: none;
  font-size: 1.125rem;
  font-weight: 700;
  line-height: 1.4;
}

.vt-product-title a:hover {
  color: var(--vt-blue-600);
}

.vt-product-excerpt {
  color: #6B7280;
  font-size: 0.875rem;
  line-height: 1.5;
  margin-bottom: 1rem;
  flex: 1;
}

.vt-product-price {
  margin-bottom: 1rem;
}

.vt-product-price .price {
  font-size: 1.25rem;
  font-weight: 800;
  color: var(--vt-blue-600);
}

.vt-product-meta {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.vt-meta-tag {
  background: #F3F4F6;
  color: #6B7280;
  padding: 0.25rem 0.5rem;
  border-radius: 10px;
  font-size: 0.75rem;
  font-weight: 600;
}

.vt-meta-tag.digital {
  background: #DBEAFE;
  color: var(--vt-blue-700);
}

.vt-meta-tag.download {
  background: #D1FAE5;
  color: #047857;
}

/* RESPONSIVE */
@media (max-width: 1024px) {
  .vt-product-main {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .vt-product-gallery {
    position: relative;
    top: 0;
  }
  
  .vt-guarantees-list {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .vt-product-title {
    font-size: 2rem;
  }
  
  .vt-product-form .cart {
    flex-direction: column;
    align-items: stretch;
  }
  
  .vt-product-overlay {
    position: static;
    background: none;
    padding: 1rem 0 0;
    transform: none;
    flex-direction: column;
  }
  
  .vt-product-overlay .button,
  .vt-quick-view {
    background: var(--vt-blue-600);
    color: white;
  }
}
EOF

# Incluir CSS no functions.php
if ! grep -q "woocommerce-templates-vt.css" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_style.*vt-woocommerce-templates/a\    wp_enqueue_style('"'"'vt-woocommerce-templates-vt'"'"', VT_THEME_URI . '"'"'/assets/css/components/woocommerce-templates-vt.css'"'"', ['"'"'vt-woocommerce-templates'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"
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
echo -e "║  ✅ TEMPLATES WOOCOMMERCE CUSTOMIZADOS! ✅   ║"
echo -e "║    Single Product + Content Product          ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ single-product.php com layout VancouverTec"
log_success "✅ content-product.php para loops de produtos"
log_success "✅ Garantias VancouverTec integradas"
log_success "✅ CSS específico (não override geral)"
log_success "✅ Design responsivo completo"

echo -e "\n${BLUE}📄 Digite 'continuar' para próxima parte: Shop + Archive${NC}"

exit 0