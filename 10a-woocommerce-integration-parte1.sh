#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce Integration PARTE 1
# Script: 10a-woocommerce-integration-parte1.sh
# Versão: 1.0.0 - Produtos Reais + Posts + Base WooCommerce
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
║   🛒 WOOCOMMERCE INTEGRATION - PARTE 1 🛒    ║
║     Produtos Reais + Posts + Templates       ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Integrando WooCommerce ao layout..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# 1. Atualizar front-page.php com produtos reais do WooCommerce
log_info "Atualizando front-page.php com produtos reais..."
sed -i '/<!-- 4. PRODUTOS EM PROMOÇÃO -->/,/<!-- 5. DEPOIMENTOS COM FOTOS -->/c\
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
            <div class="woo-products-grid">\
                <?php\
                $featured_products = wc_get_featured_product_ids();\
                if (empty($featured_products)) {\
                    // Se não há produtos em destaque, pegar os mais recentes\
                    $args = array(\
                        "post_type" => "product",\
                        "posts_per_page" => 6,\
                        "post_status" => "publish",\
                        "meta_query" => array(\
                            array(\
                                "key" => "_visibility",\
                                "value" => array("catalog", "visible"),\
                                "compare" => "IN"\
                            )\
                        )\
                    );\
                } else {\
                    $args = array(\
                        "post_type" => "product",\
                        "posts_per_page" => 6,\
                        "post__in" => $featured_products,\
                        "post_status" => "publish"\
                    );\
                }\
                \
                $products = new WP_Query($args);\
                \
                if ($products->have_posts()) :\
                    while ($products->have_posts()) : $products->the_post();\
                        global $product;\
                        $product_id = get_the_ID();\
                        $is_on_sale = $product->is_on_sale();\
                        $regular_price = $product->get_regular_price();\
                        $sale_price = $product->get_sale_price();\
                        $price_html = $product->get_price_html();\
                ?>\
                <div class="woo-product-card <?php echo $is_on_sale ? "on-sale" : ""; ?>">\
                    <?php if ($is_on_sale) : ?>\
                        <div class="sale-badge">\
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
                    <div class="woo-product-image">\
                        <a href="<?php the_permalink(); ?>">\
                            <?php if (has_post_thumbnail()) : ?>\
                                <?php the_post_thumbnail("medium", array("class" => "product-thumb")); ?>\
                            <?php else : ?>\
                                <div class="no-image">📦</div>\
                            <?php endif; ?>\
                        </a>\
                    </div>\
                    \
                    <div class="woo-product-content">\
                        <h3 class="woo-product-title">\
                            <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>\
                        </h3>\
                        \
                        <div class="woo-product-excerpt">\
                            <?php echo wp_trim_words(get_the_excerpt(), 15); ?>\
                        </div>\
                        \
                        <div class="woo-product-price">\
                            <?php echo $price_html; ?>\
                        </div>\
                        \
                        <div class="woo-product-actions">\
                            <?php woocommerce_template_loop_add_to_cart(); ?>\
                            <a href="<?php the_permalink(); ?>" class="view-product-btn">Ver Detalhes</a>\
                        </div>\
                    </div>\
                </div>\
                <?php\
                    endwhile;\
                    wp_reset_postdata();\
                else :\
                ?>\
                <div class="no-products">\
                    <p>Nenhum produto encontrado. <a href="/wp-admin/post-new.php?post_type=product">Cadastre produtos</a> para exibir aqui.</p>\
                </div>\
                <?php endif; ?>\
            </div>\
            \
            <div class="products-cta">\
                <a href="<?php echo get_permalink(wc_get_page_id("shop")); ?>" class="view-all-products-btn">\
                    Ver Todos os Produtos\
                </a>\
            </div>\
        <?php else : ?>\
            <div class="woocommerce-not-active">\
                <p>WooCommerce não está ativo. Ative o plugin para exibir produtos.</p>\
            </div>\
        <?php endif; ?>\
    </div>\
</section>\
\
<!-- 5. DEPOIMENTOS COM FOTOS -->' "$THEME_PATH/front-page.php"

# 2. Adicionar seção de posts após depoimentos
log_info "Adicionando seção de posts..."
sed -i '/<!-- 6. POR QUE ESCOLHER -->/i\
<!-- 5.5. ÚLTIMOS POSTS -->\
<section class="latest-posts-section">\
    <div class="container">\
        <div class="section-header">\
            <h2 class="section-title">Últimas Novidades</h2>\
            <p class="section-subtitle">Fique por dentro das tendências em tecnologia e negócios digitais</p>\
        </div>\
        \
        <div class="posts-grid">\
            <?php\
            $latest_posts = new WP_Query(array(\
                "post_type" => "post",\
                "posts_per_page" => 4,\
                "post_status" => "publish"\
            ));\
            \
            if ($latest_posts->have_posts()) :\
                while ($latest_posts->have_posts()) : $latest_posts->the_post();\
            ?>\
            <article class="post-card-home">\
                <div class="post-thumbnail">\
                    <a href="<?php the_permalink(); ?>">\
                        <?php if (has_post_thumbnail()) : ?>\
                            <?php the_post_thumbnail("medium", array("class" => "post-thumb")); ?>\
                        <?php else : ?>\
                            <div class="no-thumb">📰</div>\
                        <?php endif; ?>\
                    </a>\
                    <div class="post-category">\
                        <?php\
                        $categories = get_the_category();\
                        if (!empty($categories)) {\
                            echo esc_html($categories[0]->name);\
                        }\
                        ?>\
                    </div>\
                </div>\
                \
                <div class="post-content-home">\
                    <h3 class="post-title-home">\
                        <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>\
                    </h3>\
                    \
                    <div class="post-excerpt-home">\
                        <?php echo wp_trim_words(get_the_excerpt(), 20); ?>\
                    </div>\
                    \
                    <div class="post-meta-home">\
                        <time datetime="<?php echo get_the_date("c"); ?>">\
                            <?php echo get_the_date(); ?>\
                        </time>\
                        <span class="read-time">5 min de leitura</span>\
                    </div>\
                    \
                    <a href="<?php the_permalink(); ?>" class="read-more-btn">Ler Mais</a>\
                </div>\
            </article>\
            <?php\
                endwhile;\
                wp_reset_postdata();\
            else :\
            ?>\
            <div class="no-posts">\
                <p>Nenhum post encontrado. <a href="/wp-admin/post-new.php">Criar primeiro post</a>.</p>\
            </div>\
            <?php endif; ?>\
        </div>\
        \
        <div class="posts-cta">\
            <a href="/blog" class="view-all-posts-btn">Ver Todos os Posts</a>\
        </div>\
    </div>\
</section>\
' "$THEME_PATH/front-page.php"

# 3. CSS para produtos e posts reais
log_info "Criando CSS para produtos e posts reais..."
cat > "$THEME_PATH/assets/css/components/woocommerce-home.css" << 'EOF'
/* VancouverTec - Produtos e Posts Reais na Home */

/* PRODUTOS WOOCOMMERCE REAIS */
.real-products-section {
  padding: 5rem 0;
  background: #F9FAFB;
}

.woo-products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin: 3rem 0;
}

.woo-product-card {
  background: white;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  position: relative;
  border: 2px solid transparent;
}

.woo-product-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
  border-color: #0066CC;
}

.woo-product-card.on-sale {
  border-color: #F59E0B;
}

.sale-badge {
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
}

.woo-product-image {
  position: relative;
  height: 200px;
  overflow: hidden;
  background: #F3F4F6;
  display: flex;
  align-items: center;
  justify-content: center;
}

.woo-product-image a {
  display: block;
  width: 100%;
  height: 100%;
}

.product-thumb {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.woo-product-card:hover .product-thumb {
  transform: scale(1.05);
}

.no-image {
  font-size: 4rem;
  color: #9CA3AF;
}

.woo-product-content {
  padding: 1.5rem;
}

.woo-product-title {
  margin-bottom: 1rem;
}

.woo-product-title a {
  color: #1F2937;
  text-decoration: none;
  font-size: 1.25rem;
  font-weight: 700;
  line-height: 1.3;
  transition: color 0.3s ease;
}

.woo-product-title a:hover {
  color: #0066CC;
}

.woo-product-excerpt {
  color: #6B7280;
  line-height: 1.6;
  margin-bottom: 1rem;
  font-size: 0.875rem;
}

.woo-product-price {
  margin-bottom: 1.5rem;
}

.woo-product-price .price {
  font-size: 1.5rem;
  font-weight: 800;
  color: #0066CC;
}

.woo-product-price del {
  color: #9CA3AF;
  margin-right: 0.5rem;
  font-size: 1rem;
}

.woo-product-price ins {
  text-decoration: none;
  color: #EF4444;
}

.woo-product-actions {
  display: flex;
  gap: 0.75rem;
  align-items: center;
}

.woo-product-actions .button,
.woo-product-actions .add_to_cart_button {
  flex: 1;
  padding: 0.75rem 1rem;
  background: #0066CC;
  color: white;
  border: none;
  border-radius: 8px;
  font-weight: 600;
  text-decoration: none;
  text-align: center;
  transition: all 0.3s ease;
  font-size: 0.875rem;
}

.woo-product-actions .button:hover,
.woo-product-actions .add_to_cart_button:hover {
  background: #0052A3;
  transform: translateY(-2px);
  color: white;
}

.view-product-btn {
  flex: 1;
  padding: 0.75rem 1rem;
  background: #F3F4F6;
  color: #374151;
  border: none;
  border-radius: 8px;
  font-weight: 600;
  text-decoration: none;
  text-align: center;
  transition: all 0.3s ease;
  font-size: 0.875rem;
}

.view-product-btn:hover {
  background: #E5E7EB;
  color: #1F2937;
}

.products-cta {
  text-align: center;
  margin-top: 3rem;
}

.view-all-products-btn {
  display: inline-block;
  padding: 1rem 2.5rem;
  background: linear-gradient(135deg, #0066CC, #6366F1);
  color: white;
  text-decoration: none;
  border-radius: 50px;
  font-weight: 700;
  font-size: 1.125rem;
  transition: all 0.3s ease;
}

.view-all-products-btn:hover {
  background: linear-gradient(135deg, #0052A3, #4F46E5);
  transform: translateY(-3px);
  box-shadow: 0 10px 30px rgba(0, 102, 204, 0.3);
  color: white;
}

.no-products,
.woocommerce-not-active {
  text-align: center;
  padding: 3rem;
  color: #6B7280;
  background: white;
  border-radius: 15px;
  border: 2px dashed #E5E7EB;
}

/* POSTS SECTION */
.latest-posts-section {
  padding: 5rem 0;
  background: white;
}

.posts-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 2rem;
  margin: 3rem 0;
}

.post-card-home {
  background: white;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  border: 1px solid #E5E7EB;
}

.post-card-home:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.12);
  border-color: #0066CC;
}

.post-thumbnail {
  position: relative;
  height: 180px;
  overflow: hidden;
  background: #F3F4F6;
}

.post-thumbnail a {
  display: block;
  width: 100%;
  height: 100%;
}

.post-thumb {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.post-card-home:hover .post-thumb {
  transform: scale(1.1);
}

.no-thumb {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
  font-size: 3rem;
  color: #9CA3AF;
}

.post-category {
  position: absolute;
  top: 1rem;
  left: 1rem;
  background: #0066CC;
  color: white;
  padding: 0.5rem 0.75rem;
  border-radius: 15px;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
}

.post-content-home {
  padding: 1.5rem;
}

.post-title-home {
  margin-bottom: 1rem;
}

.post-title-home a {
  color: #1F2937;
  text-decoration: none;
  font-size: 1.125rem;
  font-weight: 700;
  line-height: 1.4;
  transition: color 0.3s ease;
}

.post-title-home a:hover {
  color: #0066CC;
}

.post-excerpt-home {
  color: #6B7280;
  line-height: 1.6;
  margin-bottom: 1rem;
  font-size: 0.875rem;
}

.post-meta-home {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
  font-size: 0.75rem;
  color: #9CA3AF;
}

.read-time {
  background: #F3F4F6;
  padding: 0.25rem 0.5rem;
  border-radius: 10px;
  font-weight: 600;
}

.read-more-btn {
  display: inline-block;
  color: #0066CC;
  text-decoration: none;
  font-weight: 600;
  font-size: 0.875rem;
  transition: all 0.3s ease;
}

.read-more-btn:hover {
  color: #0052A3;
  transform: translateX(5px);
}

.posts-cta {
  text-align: center;
  margin-top: 3rem;
}

.view-all-posts-btn {
  display: inline-block;
  padding: 1rem 2.5rem;
  background: #F3F4F6;
  color: #374151;
  text-decoration: none;
  border-radius: 50px;
  font-weight: 700;
  font-size: 1.125rem;
  border: 2px solid #E5E7EB;
  transition: all 0.3s ease;
}

.view-all-posts-btn:hover {
  background: #0066CC;
  color: white;
  border-color: #0066CC;
  transform: translateY(-3px);
  box-shadow: 0 8px 25px rgba(0, 102, 204, 0.2);
}

.no-posts {
  text-align: center;
  padding: 3rem;
  color: #6B7280;
  background: #F9FAFB;
  border-radius: 15px;
  border: 2px dashed #E5E7EB;
  grid-column: 1 / -1;
}

/* Responsive */
@media (max-width: 768px) {
  .woo-products-grid,
  .posts-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
  
  .woo-product-actions {
    flex-direction: column;
  }
  
  .post-meta-home {
    flex-direction: column;
    gap: 0.5rem;
    align-items: flex-start;
  }
}

@media (max-width: 480px) {
  .real-products-section,
  .latest-posts-section {
    padding: 3rem 0;
  }
  
  .woo-product-content,
  .post-content-home {
    padding: 1rem;
  }
}
EOF

# Atualizar functions.php para carregar o CSS
log_info "Atualizando functions.php..."
if ! grep -q "woocommerce-home.css" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_style.*vt-front-page/a\    wp_enqueue_style('"'"'vt-woo-home'"'"', VT_THEME_URI . '"'"'/assets/css/components/woocommerce-home.css'"'"', ['"'"'vt-front-page'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"
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
echo -e "║  ✅ WOOCOMMERCE + POSTS INTEGRADOS - P1! ✅ ║"
echo -e "║     Produtos Reais + Posts na Home           ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Produtos WooCommerce reais na home"
log_success "✅ Seção de posts (máximo 4) adicionada"
log_success "✅ CSS responsivo para produtos e posts"
log_success "✅ Integração com preços e botões reais"

echo -e "\n${YELLOW}📝 Para testar:${NC}"
echo -e "• Cadastre produtos no WooCommerce"
echo -e "• Crie alguns posts no WordPress"
echo -e "• Acesse: http://localhost:8080"

echo -e "\n${BLUE}🔄 Próxima parte: Templates WooCommerce${NC}"
log_info "Digite 'continuar' para PARTE 2 (Templates completos)"

exit 0