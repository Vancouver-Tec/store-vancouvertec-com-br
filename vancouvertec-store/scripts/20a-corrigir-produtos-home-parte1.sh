#!/bin/bash

# ===========================================
# VancouverTec Store - Corrigir Produtos na Home PARTE 1
# Script: 20a-corrigir-produtos-home-parte1.sh
# Versão: 1.0.0 - Fix Query + Display Produtos
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
║    🔧 CORRIGIR PRODUTOS HOME - PARTE 1 🔧    ║
║           Fix Query + Display                ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Corrigindo query e display de produtos..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# 1. CORRIGIR QUERY DE PRODUTOS NO FRONT-PAGE.PHP
log_info "Corrigindo seção produtos no front-page.php..."
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
                // Query corrigida e mais robusta\
                $args = array(\
                    "post_type" => "product",\
                    "posts_per_page" => 6,\
                    "post_status" => "publish",\
                    "orderby" => "date",\
                    "order" => "DESC",\
                    "meta_query" => array(\
                        "relation" => "AND",\
                        array(\
                            "key" => "_stock_status",\
                            "value" => "instock",\
                            "compare" => "="\
                        )\
                    )\
                );\
                \
                $products = new WP_Query($args);\
                \
                if ($products->have_posts()) :\
                    $count = 0;\
                    while ($products->have_posts() && $count < 6) : $products->the_post();\
                        global $product;\
                        if (!$product || !$product->is_visible()) continue;\
                        \
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
                                <div class="no-image-home">\
                                    <span class="product-icon">📦</span>\
                                    <span class="product-placeholder">Produto Digital</span>\
                                </div>\
                            <?php endif; ?>\
                        </a>\
                        \
                        <div class="product-overlay-home">\
                            <?php\
                            $add_to_cart_url = $product->add_to_cart_url();\
                            $product_type = $product->get_type();\
                            ?>\
                            <a href="<?php echo esc_url($add_to_cart_url); ?>" \
                               data-quantity="1" \
                               class="button product_type_<?php echo esc_attr($product_type); ?> add-to-cart-home" \
                               data-product_id="<?php echo esc_attr($product_id); ?>" \
                               data-product_sku="<?php echo esc_attr($product->get_sku()); ?>" \
                               rel="nofollow">\
                                🛒 Adicionar\
                            </a>\
                            <a href="<?php the_permalink(); ?>" class="view-product-home">👁️ Ver Detalhes</a>\
                        </div>\
                    </div>\
                    \
                    <div class="woo-product-content-home">\
                        <h3 class="woo-product-title-home">\
                            <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>\
                        </h3>\
                        \
                        <div class="woo-product-excerpt-home">\
                            <?php echo wp_trim_words(get_the_excerpt() ?: "Produto digital de qualidade premium", 12, "..."); ?>\
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
                                echo "<div class=\"no-rating\">⭐⭐⭐⭐⭐ <small>Sem avaliações</small></div>";\
                            }\
                            ?>\
                        </div>\
                        \
                        <div class="woo-product-meta-home">\
                            <?php if ($product->is_virtual()) : ?>\
                                <span class="meta-tag digital">💻 Digital</span>\
                            <?php endif; ?>\
                            <?php if ($product->is_downloadable()) : ?>\
                                <span class="meta-tag download">⬇️ Download</span>\
                            <?php endif; ?>\
                            <?php if ($product->is_featured()) : ?>\
                                <span class="meta-tag featured">⭐ Destaque</span>\
                            <?php endif; ?>\
                        </div>\
                    </div>\
                </div>\
                <?php\
                    endwhile;\
                    wp_reset_postdata();\
                else :\
                ?>\
                <div class="no-products-home">\
                    <div class="empty-state-home">\
                        <div class="empty-icon-home">🛒</div>\
                        <h3>Nenhum produto cadastrado</h3>\
                        <p>Cadastre seus primeiros produtos para começar a vender!</p>\
                        <?php if (current_user_can("manage_options")) : ?>\
                            <a href="<?php echo admin_url("post-new.php?post_type=product"); ?>" class="btn-add-product-home">\
                                ➕ Cadastrar Primeiro Produto\
                            </a>\
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
            <div class="woocommerce-not-active-home">\
                <div class="empty-state-home">\
                    <div class="empty-icon-home">⚠️</div>\
                    <h3>WooCommerce não está ativo</h3>\
                    <p>Ative o plugin WooCommerce para exibir produtos.</p>\
                </div>\
            </div>\
        <?php endif; ?>\
    </div>\
</section>\
\
<!-- 5. DEPOIMENTOS COM FOTOS -->' "$THEME_PATH/front-page.php"

# 2. CRIAR VARIÁVEIS CSS
log_info "Criando variáveis CSS..."
cat > "$THEME_PATH/assets/css/variables.css" << 'EOF'
/* VancouverTec Store - CSS Variables */
:root {
  --vt-blue-600: #0066CC;
  --vt-blue-700: #0052A3;
  --vt-indigo-500: #6366F1;
  --vt-success-500: #10B981;
  --vt-error-500: #EF4444;
  --vt-neutral-100: #F3F4F6;
  --vt-neutral-800: #1F2937;
}
EOF

# Incluir variáveis no functions.php
if ! grep -q "variables.css" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_style.*vt-style/a\    wp_enqueue_style('"'"'vt-variables'"'"', VT_THEME_URI . '"'"'/assets/css/variables.css'"'"', [], VT_THEME_VERSION);' "$THEME_PATH/functions.php"
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
echo -e "║    ✅ QUERY PRODUTOS CORRIGIDA - PARTE 1! ✅  ║"
echo -e "║          Query + Display + Variáveis         ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Query de produtos corrigida e mais robusta"
log_success "✅ Seção produtos atualizada no front-page.php"
log_success "✅ Estados vazios melhorados"
log_success "✅ Variáveis CSS criadas"
log_success "✅ Botões add to cart funcionais"

echo -e "\n${BLUE}📄 Digite 'continuar' para PARTE 2: CSS Avançado${NC}"

exit 0