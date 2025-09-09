#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce Layout Completo PARTE 3
# Script: 23c-woocommerce-layout-completo-parte3.sh
# Versão: 1.0.0 - Responsive + Wishlist + Finalizações
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
║  🎨 WOOCOMMERCE LAYOUT COMPLETO - PARTE 3 🎨 ║
║    Responsive + Wishlist + Finalizações      ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Finalizando layout VancouverTec - Parte 3..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# 1. ADICIONAR CSS SHOP PAGE + RESPONSIVE
log_info "Adicionando CSS Shop + Responsive..."
cat >> "$THEME_PATH/assets/css/components/woocommerce-vancouvertec-complete.css" << 'EOF'

/* ===== SHOP PAGE LAYOUT ===== */
body.woocommerce.archive .site-main {
  display: grid !important;
  grid-template-columns: 280px 1fr !important;
  gap: 3rem !important;
  align-items: flex-start !important;
}

body.woocommerce.archive .woocommerce-ordering,
body.woocommerce.archive .woocommerce-result-count {
  grid-column: 2 !important;
  background: white !important;
  padding: 1rem 1.5rem !important;
  border-radius: 12px !important;
  border: 2px solid rgba(0, 102, 204, 0.1) !important;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05) !important;
  margin-bottom: 1.5rem !important;
  font-weight: 600 !important;
  color: var(--vt-neutral-800) !important;
}

body.woocommerce.archive .woocommerce-result-count {
  order: 1 !important;
}

body.woocommerce.archive .woocommerce-ordering {
  order: 2 !important;
}

/* Sidebar Shop */
body.woocommerce.archive .widget-area,
body.woocommerce.archive .sidebar {
  background: white !important;
  border-radius: 20px !important;
  padding: 2rem !important;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1) !important;
  border: 2px solid rgba(0, 102, 204, 0.1) !important;
  position: sticky !important;
  top: 2rem !important;
  height: fit-content !important;
  grid-column: 1 !important;
  grid-row: 1 / -1 !important;
}

body.woocommerce.archive .widget {
  margin-bottom: 2rem !important;
  padding-bottom: 2rem !important;
  border-bottom: 2px solid #E5E7EB !important;
}

body.woocommerce.archive .widget:last-child {
  border-bottom: none !important;
  margin-bottom: 0 !important;
}

body.woocommerce.archive .widget-title,
body.woocommerce.archive .widget h3 {
  color: var(--vt-neutral-800) !important;
  font-weight: 800 !important;
  margin-bottom: 1.5rem !important;
  padding-bottom: 0.75rem !important;
  border-bottom: 3px solid var(--vt-blue-600) !important;
  font-size: 1.125rem !important;
}

body.woocommerce.archive .widget ul {
  list-style: none !important;
  padding: 0 !important;
  margin: 0 !important;
}

body.woocommerce.archive .widget li {
  margin-bottom: 0.75rem !important;
  padding: 0.5rem 0 !important;
  border-bottom: 1px solid #F3F4F6 !important;
}

body.woocommerce.archive .widget li:last-child {
  border-bottom: none !important;
}

body.woocommerce.archive .widget a {
  color: #6B7280 !important;
  text-decoration: none !important;
  font-weight: 600 !important;
  transition: all 0.3s ease !important;
  display: flex !important;
  justify-content: space-between !important;
  align-items: center !important;
}

body.woocommerce.archive .widget a:hover {
  color: var(--vt-blue-600) !important;
  padding-left: 0.5rem !important;
}

body.woocommerce.archive .widget .count {
  background: var(--vt-blue-600) !important;
  color: white !important;
  padding: 0.25rem 0.5rem !important;
  border-radius: 10px !important;
  font-size: 0.75rem !important;
  font-weight: 700 !important;
}

/* Grid de Produtos Shop */
body.woocommerce.archive .products {
  display: grid !important;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)) !important;
  gap: 2rem !important;
  grid-column: 2 !important;
  margin-top: 0 !important;
}

body.woocommerce.archive .products .product {
  background: white !important;
  border-radius: 20px !important;
  overflow: hidden !important;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1) !important;
  border: 2px solid rgba(0, 102, 204, 0.1) !important;
  transition: all 0.4s ease !important;
  height: 100% !important;
  display: flex !important;
  flex-direction: column !important;
}

body.woocommerce.archive .products .product:hover {
  transform: translateY(-8px) !important;
  box-shadow: 0 12px 40px rgba(0, 102, 204, 0.2) !important;
  border-color: var(--vt-blue-600) !important;
}

/* ===== SINGLE PRODUCT PAGE ===== */
body.single-product .woocommerce div.product {
  display: grid !important;
  grid-template-columns: 1fr 1fr !important;
  gap: 4rem !important;
  margin-bottom: 3rem !important;
}

body.single-product .woocommerce div.product .woocommerce-product-gallery {
  grid-column: 1 !important;
  position: sticky !important;
  top: 2rem !important;
  height: fit-content !important;
}

body.single-product .woocommerce div.product .summary {
  grid-column: 2 !important;
  padding: 2rem !important;
  background: white !important;
  border-radius: 20px !important;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1) !important;
  border: 2px solid rgba(0, 102, 204, 0.1) !important;
}

body.single-product .woocommerce div.product .product_title {
  font-size: 2.5rem !important;
  font-weight: 800 !important;
  color: var(--vt-neutral-800) !important;
  margin-bottom: 1.5rem !important;
  line-height: 1.2 !important;
}

body.single-product .woocommerce div.product .price {
  font-size: 2rem !important;
  font-weight: 800 !important;
  color: var(--vt-blue-600) !important;
  margin-bottom: 2rem !important;
}

/* ===== WISHLIST/FAVORITOS ===== */
.vt-wishlist-btn {
  display: inline-flex !important;
  align-items: center !important;
  gap: 0.5rem !important;
  background: rgba(239, 68, 68, 0.1) !important;
  color: #EF4444 !important;
  border: 2px solid #EF4444 !important;
  border-radius: 12px !important;
  padding: 0.75rem 1.5rem !important;
  font-weight: 700 !important;
  text-decoration: none !important;
  transition: all 0.3s ease !important;
  cursor: pointer !important;
}

.vt-wishlist-btn:hover,
.vt-wishlist-btn.active {
  background: #EF4444 !important;
  color: white !important;
  transform: translateY(-2px) !important;
  box-shadow: 0 8px 25px rgba(239, 68, 68, 0.3) !important;
}

.vt-wishlist-btn .heart-icon {
  font-size: 1.125rem !important;
  transition: transform 0.3s ease !important;
}

.vt-wishlist-btn.active .heart-icon {
  transform: scale(1.2) !important;
}

/* Página Wishlist */
.vt-wishlist-page {
  padding: 3rem 0 !important;
}

.vt-wishlist-page .page-header {
  text-align: center !important;
  margin-bottom: 3rem !important;
  background: linear-gradient(135deg, white 0%, var(--vt-neutral-50) 100%) !important;
  padding: 3rem 2rem !important;
  border-radius: 20px !important;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1) !important;
  border: 2px solid rgba(0, 102, 204, 0.1) !important;
}

.vt-wishlist-page .page-title {
  font-size: 2.5rem !important;
  font-weight: 800 !important;
  color: var(--vt-neutral-800) !important;
  margin-bottom: 1rem !important;
}

.vt-wishlist-page .page-title::before {
  content: "💝 " !important;
  color: #EF4444 !important;
}

.vt-wishlist-empty {
  text-align: center !important;
  padding: 4rem 2rem !important;
  background: white !important;
  border-radius: 20px !important;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1) !important;
  border: 2px solid rgba(0, 102, 204, 0.1) !important;
}

.vt-wishlist-empty::before {
  content: "💔" !important;
  font-size: 4rem !important;
  display: block !important;
  margin-bottom: 1.5rem !important;
  opacity: 0.7 !important;
}

/* ===== RESPONSIVE DESIGN ===== */
@media (max-width: 1024px) {
  /* Shop Page Mobile */
  body.woocommerce.archive .site-main {
    grid-template-columns: 1fr !important;
    gap: 2rem !important;
  }
  
  body.woocommerce.archive .widget-area,
  body.woocommerce.archive .sidebar {
    position: relative !important;
    top: 0 !important;
    grid-column: 1 !important;
    grid-row: 1 !important;
    order: 1 !important;
  }
  
  body.woocommerce.archive .products {
    grid-column: 1 !important;
    order: 2 !important;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)) !important;
    gap: 1.5rem !important;
  }
  
  /* Checkout Mobile */
  body.woocommerce-checkout .woocommerce .woocommerce-checkout {
    grid-template-columns: 1fr !important;
    gap: 2rem !important;
  }
  
  body.woocommerce-checkout .col2-set .col-1,
  body.woocommerce-checkout .col2-set .col-2 {
    padding: 1.5rem !important;
  }
  
  /* My Account Mobile */
  body.woocommerce-account .woocommerce {
    grid-template-columns: 1fr !important;
    gap: 2rem !important;
  }
  
  body.woocommerce-account .woocommerce-MyAccount-navigation {
    position: relative !important;
    top: 0 !important;
    order: 1 !important;
  }
  
  body.woocommerce-account .woocommerce-MyAccount-content {
    order: 2 !important;
    padding: 2rem !important;
  }
  
  /* Single Product Mobile */
  body.single-product .woocommerce div.product {
    grid-template-columns: 1fr !important;
    gap: 2rem !important;
  }
  
  body.single-product .woocommerce div.product .woocommerce-product-gallery {
    position: relative !important;
    top: 0 !important;
  }
  
  body.single-product .woocommerce div.product .summary {
    padding: 1.5rem !important;
  }
}

@media (max-width: 768px) {
  /* Geral */
  body.woocommerce .site-main,
  body.woocommerce-page .site-main {
    padding: 1rem !important;
  }
  
  body.woocommerce .woocommerce,
  body.woocommerce-page .woocommerce {
    padding: 1.5rem !important;
    border-radius: 15px !important;
  }
  
  /* Títulos */
  body.woocommerce .entry-title,
  body.woocommerce-page .entry-title {
    font-size: 1.875rem !important;
  }
  
  /* Produtos Grid */
  body.woocommerce.archive .products {
    grid-template-columns: 1fr !important;
    gap: 1rem !important;
  }
  
  /* Tabelas */
  body.woocommerce table.cart,
  body.woocommerce table.shop_table {
    font-size: 0.875rem !important;
  }
  
  body.woocommerce table.cart th,
  body.woocommerce table.shop_table th,
  body.woocommerce table.cart td,
  body.woocommerce table.shop_table td {
    padding: 0.75rem 0.5rem !important;
  }
  
  /* Cart Totals */
  body.woocommerce .cart_totals {
    padding: 1.5rem !important;
  }
  
  /* Botões */
  body.woocommerce .button,
  body.woocommerce-page .button {
    padding: 0.875rem 1.5rem !important;
    font-size: 0.9rem !important;
  }
  
  /* Formulários */
  body.woocommerce .form-row input.input-text,
  body.woocommerce .form-row select,
  body.woocommerce .form-row textarea {
    padding: 0.875rem 1rem !important;
    font-size: 0.9rem !important;
  }
}

@media (max-width: 480px) {
  /* Extra Small Mobile */
  body.woocommerce .entry-header,
  body.woocommerce-page .entry-header {
    padding: 2rem 1rem !important;
  }
  
  body.woocommerce .entry-title,
  body.woocommerce-page .entry-title {
    font-size: 1.5rem !important;
  }
  
  body.woocommerce .woocommerce,
  body.woocommerce-page .woocommerce {
    padding: 1rem !important;
    border-radius: 12px !important;
  }
  
  /* Single Product Title */
  body.single-product .woocommerce div.product .product_title {
    font-size: 1.75rem !important;
  }
  
  body.single-product .woocommerce div.product .price {
    font-size: 1.5rem !important;
  }
  
  /* Navigation Mobile */
  body.woocommerce-account .woocommerce-MyAccount-navigation a {
    padding: 1rem 1.5rem !important;
    font-size: 0.9rem !important;
  }
}

/* ===== CORREÇÕES DE SOBREPOSIÇÃO ===== */
body.woocommerce *,
body.woocommerce-page * {
  box-sizing: border-box !important;
}

/* Force z-index para elementos importantes */
body.woocommerce .woocommerce-message,
body.woocommerce .woocommerce-error,
body.woocommerce .woocommerce-info {
  position: relative !important;
  z-index: 999 !important;
}

/* Limpar estilos conflitantes */
body.woocommerce .woocommerce-ordering select,
body.woocommerce .widget select {
  appearance: none !important;
  -webkit-appearance: none !important;
  -moz-appearance: none !important;
  background-image: url("data:image/svg+xml;charset=US-ASCII,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 4 5'><path fill='%23666' d='M2 0L0 2h4zm0 5L0 3h4z'/></svg>") !important;
  background-repeat: no-repeat !important;
  background-position: right 1rem center !important;
  background-size: 12px !important;
}
EOF

# 2. CRIAR PÁGINA WISHLIST
log_info "Criando página Wishlist..."
cat > "$THEME_PATH/page-wishlist.php" << 'EOF'
<?php
/**
 * Template Name: Wishlist VancouverTec
 * Página de Lista de Desejos
 */

get_header(); ?>

<div class="vt-wishlist-page">
    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Lista de Desejos</h1>
            <p class="page-subtitle">Seus produtos favoritos salvos para depois</p>
        </div>
        
        <div id="vt-wishlist-content">
            <div class="vt-wishlist-empty">
                <h3>Sua lista de desejos está vazia!</h3>
                <p>Navegue pela nossa loja e adicione produtos aos seus favoritos.</p>
                <a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>" class="button">
                    Explorar Produtos
                </a>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Carregar wishlist do localStorage
    loadWishlist();
    
    function loadWishlist() {
        const wishlist = JSON.parse(localStorage.getItem('vt_wishlist') || '[]');
        const container = document.getElementById('vt-wishlist-content');
        
        if (wishlist.length === 0) {
            return; // Manter mensagem vazia
        }
        
        // Criar grid de produtos
        let html = '<div class="products" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 2rem;">';
        
        wishlist.forEach(product => {
            html += `
                <div class="product">
                    <div class="product-image">
                        <img src="${product.image}" alt="${product.name}" style="width: 100%; height: 200px; object-fit: cover; border-radius: 10px;">
                    </div>
                    <div class="product-content" style="padding: 1.5rem;">
                        <h3 style="font-size: 1.125rem; font-weight: 700; margin-bottom: 1rem;">
                            <a href="${product.url}" style="color: #1F2937; text-decoration: none;">${product.name}</a>
                        </h3>
                        <div class="product-price" style="font-size: 1.25rem; font-weight: 800; color: #0066CC; margin-bottom: 1rem;">
                            ${product.price}
                        </div>
                        <div style="display: flex; gap: 0.5rem;">
                            <a href="${product.url}" class="button" style="flex: 1; text-align: center;">Ver Produto</a>
                            <button onclick="removeFromWishlist(${product.id})" class="button" style="background: #EF4444 !important; border-color: #EF4444 !important;">Remover</button>
                        </div>
                    </div>
                </div>
            `;
        });
        
        html += '</div>';
        container.innerHTML = html;
    }
    
    window.removeFromWishlist = function(productId) {
        let wishlist = JSON.parse(localStorage.getItem('vt_wishlist') || '[]');
        wishlist = wishlist.filter(item => item.id !== productId);
        localStorage.setItem('vt_wishlist', JSON.stringify(wishlist));
        loadWishlist();
        
        // Atualizar contadores
        updateWishlistCount();
    }
    
    function updateWishlistCount() {
        const wishlist = JSON.parse(localStorage.getItem('vt_wishlist') || '[]');
        const count = wishlist.length;
        
        // Atualizar badges de contador se existirem
        document.querySelectorAll('.wishlist-count').forEach(el => {
            el.textContent = count;
            el.style.display = count > 0 ? 'inline' : 'none';
        });
    }
});
</script>

<?php get_footer(); ?>
EOF

# 3. ADICIONAR FUNCIONALIDADE WISHLIST NO FUNCTIONS.PHP
log_info "Adicionando funcionalidade Wishlist..."
cat >> "$THEME_PATH/functions.php" << 'EOF'

/**
 * Adicionar botão Wishlist aos produtos
 */
function vt_add_wishlist_button() {
    global $product;
    if (!$product) return;
    
    $product_id = $product->get_id();
    $product_name = $product->get_name();
    $product_image = get_the_post_thumbnail_url($product_id, 'medium');
    $product_price = $product->get_price_html();
    $product_url = get_permalink($product_id);
    
    echo '<button class="vt-wishlist-btn" onclick="toggleWishlist(' . $product_id . ', \'' . esc_js($product_name) . '\', \'' . esc_url($product_image) . '\', \'' . esc_js($product_price) . '\', \'' . esc_url($product_url) . '\')">';
    echo '<span class="heart-icon">🤍</span>';
    echo '<span class="wishlist-text">Favoritar</span>';
    echo '</button>';
}
add_action('woocommerce_single_product_summary', 'vt_add_wishlist_button', 35);

/**
 * Adicionar JavaScript Wishlist
 */
function vt_wishlist_scripts() {
    if (is_woocommerce() || is_shop() || is_product() || is_page_template('page-wishlist.php')) {
        wp_add_inline_script('jquery', '
            window.toggleWishlist = function(id, name, image, price, url) {
                let wishlist = JSON.parse(localStorage.getItem("vt_wishlist") || "[]");
                const existingIndex = wishlist.findIndex(item => item.id === id);
                const btn = event.target.closest(".vt-wishlist-btn");
                const heartIcon = btn.querySelector(".heart-icon");
                const textEl = btn.querySelector(".wishlist-text");
                
                if (existingIndex > -1) {
                    // Remover dos favoritos
                    wishlist.splice(existingIndex, 1);
                    btn.classList.remove("active");
                    heartIcon.textContent = "🤍";
                    textEl.textContent = "Favoritar";
                } else {
                    // Adicionar aos favoritos
                    wishlist.push({id, name, image, price, url});
                    btn.classList.add("active");
                    heartIcon.textContent = "❤️";
                    textEl.textContent = "Favoritado";
                }
                
                localStorage.setItem("vt_wishlist", JSON.stringify(wishlist));
                updateWishlistCount();
            }
            
            function updateWishlistCount() {
                const wishlist = JSON.parse(localStorage.getItem("vt_wishlist") || "[]");
                jQuery(".wishlist-count").text(wishlist.length).toggle(wishlist.length > 0);
            }
            
            jQuery(document).ready(function($) {
                // Inicializar estado dos botões
                const wishlist = JSON.parse(localStorage.getItem("vt_wishlist") || "[]");
                
                $(".vt-wishlist-btn").each(function() {
                    const btn = $(this);
                    const onclick = btn.attr("onclick");
                    if (onclick) {
                        const match = onclick.match(/toggleWishlist\((\d+)/);
                        if (match) {
                            const productId = parseInt(match[1]);
                            const isInWishlist = wishlist.some(item => item.id === productId);
                            
                            if (isInWishlist) {
                                btn.addClass("active");
                                btn.find(".heart-icon").text("❤️");
                                btn.find(".wishlist-text").text("Favoritado");
                            }
                        }
                    }
                });
                
                updateWishlistCount();
            });
        ');
    }
}
add_action('wp_enqueue_scripts', 'vt_wishlist_scripts');
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
echo -e "║  ✅ PARTE 3 FINALIZADA COM SUCESSO! ✅       ║"
echo -e "║     Layout Completo + Responsive + Wishlist  ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Shop page com sidebar estilizada"
log_success "✅ Single product page moderna"
log_success "✅ Design 100% responsivo mobile"
log_success "✅ Página Wishlist/Favoritos criada"
log_success "✅ JavaScript funcional para wishlist"
log_success "✅ Correções de sobreposição aplicadas"
log_success "✅ Layout VancouverTec COMPLETO!"

echo -e "\n${BLUE}🎯 LAYOUT WOOCOMMERCE 100% FINALIZADO!${NC}"
echo -e "Teste todas as páginas: Shop, Cart, Checkout, My Account, Wishlist"
echo -e "Para criar página Wishlist: Páginas > Adicionar > Template: Wishlist VancouverTec"

exit 0