#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce Fixes PARTE 1
# Script: 11a-woocommerce-fixes-parte1.sh
# Versão: 1.0.0 - Corrigir Produtos + Layout + Estrutura
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
║    🔧 WOOCOMMERCE FIXES - PARTE 1 🔧         ║
║   Produtos + Layout + Estrutura Corrigida    ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Corrigindo problemas WooCommerce..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Criar estrutura correta de pastas WooCommerce
log_info "Criando estrutura de pastas WooCommerce..."
mkdir -p "$THEME_PATH/woocommerce"
mkdir -p "$THEME_PATH/woocommerce/cart"
mkdir -p "$THEME_PATH/woocommerce/checkout"
mkdir -p "$THEME_PATH/woocommerce/myaccount"
mkdir -p "$THEME_PATH/woocommerce/single-product"

# 1. Corrigir seção de produtos na home (máximo 4, layout correto)
log_info "Corrigindo seção de produtos na home..."
sed -i '/<!-- 4. PRODUTOS REAIS DO WOOCOMMERCE -->/,/<!-- 5. DEPOIMENTOS COM FOTOS -->/c\
<!-- 4. PRODUTOS REAIS DO WOOCOMMERCE -->\
<section class="real-products-section">\
    <div class="container">\
        <div class="section-header">\
            <div class="section-badge">🛒 NOSSOS PRODUTOS</div>\
            <h2 class="section-title">Produtos em Destaque</h2>\
            <p class="section-subtitle">Soluções digitais desenvolvidas para fazer seu negócio crescer</p>\
        </div>\
        \
        <?php if (class_exists("WooCommerce")) : ?>\
            <div class="woo-products-grid-fixed">\
                <?php\
                // Buscar produtos (primeiro em destaque, depois mais recentes)\
                $featured_products = wc_get_featured_product_ids();\
                \
                if (!empty($featured_products)) {\
                    $args = array(\
                        "post_type" => "product",\
                        "posts_per_page" => 4,\
                        "post__in" => array_slice($featured_products, 0, 4),\
                        "post_status" => "publish",\
                        "orderby" => "menu_order",\
                        "order" => "ASC"\
                    );\
                } else {\
                    $args = array(\
                        "post_type" => "product",\
                        "posts_per_page" => 4,\
                        "post_status" => "publish",\
                        "orderby" => "date",\
                        "order" => "DESC",\
                        "meta_query" => array(\
                            array(\
                                "key" => "_stock_status",\
                                "value" => "instock"\
                            )\
                        )\
                    );\
                }\
                \
                $products = new WP_Query($args);\
                \
                if ($products->have_posts()) :\
                    $count = 0;\
                    while ($products->have_posts() && $count < 4) : $products->the_post();\
                        global $product;\
                        $product_id = get_the_ID();\
                        $is_on_sale = $product->is_on_sale();\
                        $regular_price = $product->get_regular_price();\
                        $sale_price = $product->get_sale_price();\
                        $price_html = $product->get_price_html();\
                        $count++;\
                ?>\
                <div class="woo-product-card-home <?php echo $is_on_sale ? "on-sale" : ""; ?>">\
                    <?php if ($is_on_sale) : ?>\
                        <div class="sale-badge-home">\
                            <?php\
                            if ($regular_price && $sale_price) {\
                                $discount = round((($regular_price - $sale_price) / $regular_price) * 100);\
                                echo $discount . "% OFF";\
                            } else {\
                                echo "OFERTA";\
                            }\
                            ?>\
                        </div>\
                    <?php endif; ?>\
                    \
                    <div class="woo-product-image-home">\
                        <a href="<?php the_permalink(); ?>">\
                            <?php if (has_post_thumbnail()) : ?>\
                                <?php the_post_thumbnail("medium", array("class" => "product-thumb-home")); ?>\
                            <?php else : ?>\
                                <div class="no-image-home">📦<br><small>Sem Imagem</small></div>\
                            <?php endif; ?>\
                        </a>\
                        \
                        <div class="product-overlay-home">\
                            <a href="<?php the_permalink(); ?>" class="quick-view-home">👁️ Ver Produto</a>\
                            <?php\
                            echo sprintf(\
                                '<a href="%s" data-quantity="1" class="button product_type_%s add-to-cart-home" data-product_id="%s" data-product_sku="%s" aria-label="%s" rel="nofollow">🛒 Adicionar</a>',\
                                esc_url($product->add_to_cart_url()),\
                                esc_attr($product->get_type()),\
                                esc_attr($product->get_id()),\
                                esc_attr($product->get_sku()),\
                                esc_attr($product->add_to_cart_description())\
                            );\
                            ?>\
                        </div>\
                    </div>\
                    \
                    <div class="woo-product-content-home">\
                        <h3 class="woo-product-title-home">\
                            <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>\
                        </h3>\
                        \
                        <div class="woo-product-excerpt-home">\
                            <?php echo wp_trim_words(get_the_excerpt(), 12); ?>\
                        </div>\
                        \
                        <div class="woo-product-price-home">\
                            <?php echo $price_html; ?>\
                        </div>\
                        \
                        <div class="woo-product-rating-home">\
                            <?php\
                            $rating_count = $product->get_rating_count();\
                            $average = $product->get_average_rating();\
                            if ($rating_count > 0) {\
                                echo wc_get_rating_html($average, $rating_count);\
                            } else {\
                                echo "<div class=\"no-rating\">⭐⭐⭐⭐⭐</div>";\
                            }\
                            ?>\
                        </div>\
                    </div>\
                </div>\
                <?php\
                    endwhile;\
                    wp_reset_postdata();\
                else :\
                ?>\
                <div class="no-products-home">\
                    <div class="empty-state">\
                        <div class="empty-icon">📦</div>\
                        <h3>Nenhum produto encontrado</h3>\
                        <p>Cadastre produtos no WooCommerce para exibir aqui.</p>\
                        <?php if (current_user_can("manage_options")) : ?>\
                            <a href="/wp-admin/post-new.php?post_type=product" class="btn-add-product">Adicionar Produto</a>\
                        <?php endif; ?>\
                    </div>\
                </div>\
                <?php endif; ?>\
            </div>\
            \
            <div class="products-cta-home">\
                <a href="<?php echo get_permalink(wc_get_page_id("shop")); ?>" class="view-all-products-btn-home">\
                    Ver Todos os Produtos →\
                </a>\
            </div>\
        <?php else : ?>\
            <div class="woocommerce-not-active">\
                <div class="empty-state">\
                    <div class="empty-icon">⚠️</div>\
                    <h3>WooCommerce não está ativo</h3>\
                    <p>Ative o plugin WooCommerce para exibir produtos.</p>\
                </div>\
            </div>\
        <?php endif; ?>\
    </div>\
</section>\
\
<!-- 5. DEPOIMENTOS COM FOTOS -->' "$THEME_PATH/front-page.php"

# 2. CSS corrigido para produtos na home
log_info "Corrigindo CSS dos produtos na home..."
cat > "$THEME_PATH/assets/css/components/woocommerce-home-fixed.css" << 'EOF'
/* VancouverTec - Produtos Home CORRIGIDOS */

/* PRODUTOS WOOCOMMERCE HOME - LAYOUT FIXO */
.real-products-section {
  padding: 5rem 0;
  background: #F9FAFB;
}

.woo-products-grid-fixed {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 2rem;
  margin: 3rem 0;
  max-width: 1200px;
  margin-left: auto;
  margin-right: auto;
}

.woo-product-card-home {
  background: white;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  position: relative;
  border: 2px solid transparent;
  height: auto;
  display: flex;
  flex-direction: column;
}

.woo-product-card-home:hover {
  transform: translateY(-8px);
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
  border-color: #0066CC;
}

.woo-product-card-home.on-sale {
  border-color: #F59E0B;
}

.sale-badge-home {
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

.woo-product-image-home {
  position: relative;
  height: 220px;
  overflow: hidden;
  background: linear-gradient(135deg, #F8FAFC, #E2E8F0);
  display: flex;
  align-items: center;
  justify-content: center;
}

.woo-product-image-home a {
  display: block;
  width: 100%;
  height: 100%;
  overflow: hidden;
}

.product-thumb-home {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.woo-product-card-home:hover .product-thumb-home {
  transform: scale(1.1);
}

.no-image-home {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
  font-size: 3rem;
  color: #94A3B8;
  text-align: center;
}

.no-image-home small {
  font-size: 0.875rem;
  margin-top: 0.5rem;
  font-weight: 600;
}

.product-overlay-home {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(transparent, rgba(0, 0, 0, 0.9));
  padding: 2rem 1rem 1rem;
  display: flex;
  gap: 0.5rem;
  transform: translateY(100%);
  transition: transform 0.3s ease;
}

.woo-product-card-home:hover .product-overlay-home {
  transform: translateY(0);
}

.quick-view-home,
.add-to-cart-home {
  flex: 1;
  padding: 0.75rem 1rem;
  color: white;
  text-decoration: none;
  border-radius: 8px;
  font-weight: 600;
  font-size: 0.875rem;
  text-align: center;
  transition: all 0.3s ease;
  border: 1px solid rgba(255, 255, 255, 0.3);
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
}

.add-to-cart-home {
  background: #0066CC !important;
  border-color: #0066CC !important;
}

.quick-view-home:hover,
.add-to-cart-home:hover {
  background: #0052A3 !important;
  border-color: #0052A3 !important;
  transform: translateY(-2px);
  color: white !important;
}

.woo-product-content-home {
  padding: 1.5rem;
  flex: 1;
  display: flex;
  flex-direction: column;
}

.woo-product-title-home {
  margin-bottom: 1rem;
  flex-shrink: 0;
}

.woo-product-title-home a {
  color: #1F2937;
  text-decoration: none;
  font-size: 1.125rem;
  font-weight: 700;
  line-height: 1.4;
  transition: color 0.3s ease;
  display: block;
}

.woo-product-title-home a:hover {
  color: #0066CC;
}

.woo-product-excerpt-home {
  color: #6B7280;
  line-height: 1.6;
  margin-bottom: 1rem;
  font-size: 0.875rem;
  flex: 1;
}

.woo-product-price-home {
  margin-bottom: 1rem;
  flex-shrink: 0;
}

.woo-product-price-home .price {
  font-size: 1.25rem;
  font-weight: 800;
  color: #0066CC;
}

.woo-product-price-home del {
  color: #9CA3AF;
  margin-right: 0.5rem;
  font-size: 1rem;
}

.woo-product-price-home ins {
  text-decoration: none;
  color: #EF4444;
  font-weight: 800;
}

.woo-product-rating-home {
  flex-shrink: 0;
}

.woo-product-rating-home .star-rating {
  color: #F59E0B;
}

.no-rating {
  color: #E5E7EB;
  font-size: 0.875rem;
}

.products-cta-home {
  text-align: center;
  margin-top: 3rem;
}

.view-all-products-btn-home {
  display: inline-block;
  padding: 1rem 2.5rem;
  background: linear-gradient(135deg, #0066CC, #6366F1);
  color: white;
  text-decoration: none;
  border-radius: 50px;
  font-weight: 700;
  font-size: 1.125rem;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(0, 102, 204, 0.3);
}

.view-all-products-btn-home:hover {
  background: linear-gradient(135deg, #0052A3, #4F46E5);
  transform: translateY(-3px);
  box-shadow: 0 8px 25px rgba(0, 102, 204, 0.4);
  color: white;
}

/* Empty States */
.no-products-home,
.woocommerce-not-active {
  grid-column: 1 / -1;
  text-align: center;
  padding: 4rem 2rem;
}

.empty-state {
  max-width: 400px;
  margin: 0 auto;
}

.empty-icon {
  font-size: 4rem;
  margin-bottom: 1.5rem;
}

.empty-state h3 {
  font-size: 1.5rem;
  font-weight: 700;
  color: #1F2937;
  margin-bottom: 1rem;
}

.empty-state p {
  color: #6B7280;
  margin-bottom: 2rem;
  line-height: 1.6;
}

.btn-add-product {
  display: inline-block;
  padding: 0.75rem 2rem;
  background: #0066CC;
  color: white;
  text-decoration: none;
  border-radius: 10px;
  font-weight: 600;
  transition: all 0.3s ease;
}

.btn-add-product:hover {
  background: #0052A3;
  transform: translateY(-2px);
  color: white;
}

/* Responsive */
@media (max-width: 768px) {
  .woo-products-grid-fixed {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
  
  .woo-product-image-home {
    height: 200px;
  }
  
  .product-overlay-home {
    position: static;
    background: none;
    padding: 1rem 0 0;
    transform: none;
    flex-direction: column;
  }
  
  .quick-view-home,
  .add-to-cart-home {
    background: #0066CC !important;
    color: white !important;
    border-color: #0066CC !important;
  }
}

@media (max-width: 480px) {
  .real-products-section {
    padding: 3rem 0;
  }
  
  .woo-product-content-home {
    padding: 1rem;
  }
  
  .empty-state {
    padding: 2rem 1rem;
  }
}

/* Garantir que botões WooCommerce sigam o tema */
.woocommerce .button,
.woocommerce button.button,
.woocommerce input.button,
.woocommerce #respond input#submit {
  background: #0066CC !important;
  color: white !important;
  border: 1px solid #0066CC !important;
  border-radius: 8px !important;
  font-weight: 600 !important;
  transition: all 0.3s ease !important;
}

.woocommerce .button:hover,
.woocommerce button.button:hover,
.woocommerce input.button:hover {
  background: #0052A3 !important;
  border-color: #0052A3 !important;
  color: white !important;
}
EOF

# Atualizar functions.php
log_info "Atualizando functions.php..."
if ! grep -q "woocommerce-home-fixed.css" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_style.*vt-woo-home/a\    wp_enqueue_style('"'"'vt-woo-home-fixed'"'"', VT_THEME_URI . '"'"'/assets/css/components/woocommerce-home-fixed.css'"'"', ['"'"'vt-woo-home'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"
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
echo -e "║    ✅ WOOCOMMERCE FIXES - PARTE 1! ✅        ║"
echo -e "║     Produtos + Layout Corrigidos             ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Seção produtos corrigida (máximo 4)"
log_success "✅ Layout responsivo 100% funcional"
log_success "✅ Botões alinhados e azuis (tema)"
log_success "✅ Overlay com hover effects"
log_success "✅ Estrutura de pastas criada"

echo -e "\n${BLUE}🔄 Próxima parte: Single Product + Templates${NC}"
log_info "Digite 'continuar' para PARTE 2"

exit 0