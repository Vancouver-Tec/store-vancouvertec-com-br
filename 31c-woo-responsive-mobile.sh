#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce Responsivo + Mobile
# Script: 31c-woo-responsive-mobile.sh
# Versão: 1.0.0 - Responsivo Mobile + UX Otimizada
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
CSS_PATH="${THEME_PATH}/assets/css"
JS_PATH="${THEME_PATH}/assets/js"

# Funções de log
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║      📱 Responsivo + Mobile UX 📱           ║
║         JavaScript + CSS Mobile             ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar base
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Execute antes: 31b-woo-css-vancouvertec.sh"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Criando responsivo mobile em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost:8080" > /dev/null; then
    log_warning "Parando servidor..."
    pkill -f "php -S localhost:8080" || true
    sleep 2
fi

# 1. CSS MOBILE ESPECÍFICO
log_info "Criando CSS mobile específico..."
cat > "${CSS_PATH}/mobile.css" << 'EOF'
/**
 * VancouverTec Store - Mobile CSS
 * Mobile-First Responsive Design
 */

/* ========================================
   MOBILE BREAKPOINTS
   ======================================== */
@media (max-width: 1024px) {
  .container {
    max-width: 100%;
    padding: 0 var(--vt-space-md);
  }
  
  .vt-product-container {
    grid-template-columns: 1fr;
    gap: var(--vt-space-lg);
  }
}

@media (max-width: 768px) {
  /* Typography mobile */
  h1 { font-size: 1.875rem; }
  h2 { font-size: 1.5rem; }
  h3 { font-size: 1.25rem; }
  
  .vt-page-title {
    font-size: 2rem;
    text-align: center;
  }
  
  /* Navigation mobile */
  .vt-mobile-nav {
    display: block;
  }
  
  .vt-desktop-nav {
    display: none;
  }
  
  /* Products grid mobile */
  .woocommerce ul.products {
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: var(--vt-space-md);
  }
  
  /* Single product mobile */
  .vt-single-product {
    padding: var(--vt-space-md);
    margin-bottom: var(--vt-space-md);
  }
  
  .woocommerce div.product .product_title {
    font-size: 1.5rem;
    text-align: center;
  }
  
  .vt-price-section {
    text-align: center;
  }
  
  .woocommerce div.product p.price {
    font-size: 1.75rem;
  }
  
  /* Trust badges mobile */
  .vt-trust-badges {
    grid-template-columns: 1fr;
  }
  
  /* Cart mobile */
  .woocommerce table.cart {
    font-size: 0.875rem;
  }
  
  .woocommerce table.cart th,
  .woocommerce table.cart td {
    padding: var(--vt-space-sm);
  }
  
  /* Checkout mobile */
  .vt-checkout-steps {
    flex-direction: column;
    gap: var(--vt-space-sm);
  }
  
  .vt-step {
    width: 100%;
    justify-content: center;
  }
  
  .vt-step-separator {
    width: 2px;
    height: 20px;
  }
  
  /* Security badges mobile */
  .vt-security-badges {
    grid-template-columns: 1fr;
    gap: var(--vt-space-sm);
  }
  
  /* Account navigation mobile */
  .vt-account-nav ul {
    display: grid;
    grid-template-columns: 1fr;
    gap: var(--vt-space-xs);
  }
}

@media (max-width: 480px) {
  /* Extra small screens */
  :root {
    --vt-space-sm: 0.75rem;
    --vt-space-md: 1rem;
    --vt-space-lg: 1.5rem;
  }
  
  .container {
    padding: 0 var(--vt-space-sm);
  }
  
  /* Products single column */
  .woocommerce ul.products {
    grid-template-columns: 1fr;
    gap: var(--vt-space-sm);
  }
  
  /* Mobile buttons */
  .button, .btn {
    width: 100%;
    padding: var(--vt-space-md);
    font-size: 1rem;
  }
  
  .woocommerce .single_add_to_cart_button {
    width: 100%;
    padding: var(--vt-space-lg);
    font-size: 1.125rem;
  }
  
  /* Typography extra small */
  .vt-page-title {
    font-size: 1.75rem;
  }
  
  h1 { font-size: 1.5rem; }
  h2 { font-size: 1.25rem; }
  h3 { font-size: 1.125rem; }
  
  /* Mobile spacing */
  .vt-main-content {
    padding: var(--vt-space-md) 0;
  }
}

/* ========================================
   MOBILE TOUCH INTERACTIONS
   ======================================== */
@media (hover: none) and (pointer: coarse) {
  /* Touch devices */
  .woocommerce ul.products li.product:hover {
    transform: none;
  }
  
  .button:hover,
  .btn:hover {
    transform: none;
  }
  
  .vt-card:hover {
    transform: none;
  }
  
  /* Bigger touch targets */
  .button, .btn, 
  .woocommerce .button {
    min-height: 44px;
    min-width: 44px;
  }
}

/* ========================================
   MOBILE NAVIGATION
   ======================================== */
.vt-mobile-menu {
  position: fixed;
  top: 0;
  left: -100%;
  width: 280px;
  height: 100vh;
  background: white;
  box-shadow: var(--vt-shadow-xl);
  transition: left 0.3s ease;
  z-index: 9999;
  overflow-y: auto;
}

.vt-mobile-menu.active {
  left: 0;
}

.vt-mobile-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background: rgba(0, 0, 0, 0.5);
  opacity: 0;
  visibility: hidden;
  transition: all 0.3s ease;
  z-index: 9998;
}

.vt-mobile-overlay.active {
  opacity: 1;
  visibility: visible;
}

.vt-mobile-toggle {
  display: none;
  background: none;
  border: none;
  font-size: 1.5rem;
  color: var(--vt-neutral-800);
  cursor: pointer;
  padding: var(--vt-space-sm);
}

@media (max-width: 768px) {
  .vt-mobile-toggle {
    display: block;
  }
}

/* ========================================
   LOADING STATES MOBILE
   ======================================== */
.vt-mobile-loading {
  display: none;
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: white;
  padding: var(--vt-space-lg);
  border-radius: var(--vt-radius-lg);
  box-shadow: var(--vt-shadow-xl);
  z-index: 10000;
}

.vt-mobile-loading.active {
  display: block;
}

.vt-mobile-loading .vt-spinner {
  width: 40px;
  height: 40px;
  border: 3px solid var(--vt-neutral-200);
  border-top-color: var(--vt-blue-600);
  border-radius: 50%;
  animation: vt-spin 1s linear infinite;
}

/* ========================================
   MOBILE UTILITIES
   ======================================== */
@media (max-width: 768px) {
  .vt-hide-mobile {
    display: none !important;
  }
  
  .vt-show-mobile {
    display: block !important;
  }
  
  .vt-text-center-mobile {
    text-align: center !important;
  }
  
  .vt-full-width-mobile {
    width: 100% !important;
  }
}

/* ========================================
   PRINT STYLES
   ======================================== */
@media print {
  .vt-mobile-toggle,
  .vt-mobile-menu,
  .vt-mobile-overlay,
  .button,
  .btn {
    display: none !important;
  }
  
  body {
    font-size: 12pt;
    line-height: 1.4;
  }
  
  .container {
    max-width: none;
    padding: 0;
  }
}
EOF

# 2. JAVASCRIPT MOBILE INTERATIVO
log_info "Criando JavaScript mobile..."
cat > "${JS_PATH}/mobile.js" << 'EOF'
/**
 * VancouverTec Store - Mobile JavaScript
 * Touch Interactions + Mobile UX
 */

(function($) {
    'use strict';
    
    const VTMobile = {
        init() {
            console.log('VancouverTec Mobile initialized');
            this.setupMobileMenu();
            this.setupTouchGestures();
            this.setupMobileCart();
            this.setupMobileSearch();
            this.optimizeForMobile();
        },
        
        setupMobileMenu() {
            // Mobile menu toggle
            const $toggle = $('.vt-mobile-toggle');
            const $menu = $('.vt-mobile-menu');
            const $overlay = $('.vt-mobile-overlay');
            
            $toggle.on('click', () => {
                $menu.toggleClass('active');
                $overlay.toggleClass('active');
                $('body').toggleClass('mobile-menu-open');
            });
            
            $overlay.on('click', () => {
                $menu.removeClass('active');
                $overlay.removeClass('active');
                $('body').removeClass('mobile-menu-open');
            });
            
            // Close menu on escape
            $(document).on('keydown', (e) => {
                if (e.key === 'Escape' && $menu.hasClass('active')) {
                    $menu.removeClass('active');
                    $overlay.removeClass('active');
                    $('body').removeClass('mobile-menu-open');
                }
            });
        },
        
        setupTouchGestures() {
            // Swipe gestures for product gallery
            let startX = 0;
            let startY = 0;
            
            $('.vt-product-gallery').on('touchstart', (e) => {
                startX = e.originalEvent.touches[0].clientX;
                startY = e.originalEvent.touches[0].clientY;
            });
            
            $('.vt-product-gallery').on('touchmove', (e) => {
                if (!startX || !startY) return;
                
                const currentX = e.originalEvent.touches[0].clientX;
                const currentY = e.originalEvent.touches[0].clientY;
                
                const diffX = startX - currentX;
                const diffY = startY - currentY;
                
                if (Math.abs(diffX) > Math.abs(diffY)) {
                    // Horizontal swipe
                    if (diffX > 50) {
                        // Swipe left - next image
                        this.nextImage();
                    } else if (diffX < -50) {
                        // Swipe right - previous image
                        this.prevImage();
                    }
                }
                
                startX = 0;
                startY = 0;
            });
        },
        
        setupMobileCart() {
            // Mobile cart drawer
            const $cartTrigger = $('.vt-cart-trigger');
            const $cartDrawer = $('.vt-cart-drawer');
            const $cartOverlay = $('.vt-cart-overlay');
            
            $cartTrigger.on('click', (e) => {
                e.preventDefault();
                $cartDrawer.addClass('active');
                $cartOverlay.addClass('active');
                $('body').addClass('cart-drawer-open');
            });
            
            $cartOverlay.on('click', () => {
                $cartDrawer.removeClass('active');
                $cartOverlay.removeClass('active');
                $('body').removeClass('cart-drawer-open');
            });
            
            // Update cart via AJAX on mobile
            $(document.body).on('added_to_cart', (event, fragments, cart_hash, $button) => {
                // Show mobile cart notification
                this.showMobileNotification('✅ Produto adicionado ao carrinho!', 'success');
                
                // Update cart count
                this.updateCartCount();
            });
        },
        
        setupMobileSearch() {
            // Mobile search experience
            const $searchToggle = $('.vt-search-toggle');
            const $searchOverlay = $('.vt-search-overlay');
            const $searchInput = $('.vt-mobile-search-input');
            
            $searchToggle.on('click', () => {
                $searchOverlay.addClass('active');
                $searchInput.focus();
            });
            
            // Search suggestions
            $searchInput.on('input', debounce((e) => {
                const query = $(e.target).val();
                if (query.length > 2) {
                    this.loadSearchSuggestions(query);
                }
            }, 300));
        },
        
        optimizeForMobile() {
            // Lazy load images on mobile
            if ('IntersectionObserver' in window) {
                const imageObserver = new IntersectionObserver((entries, observer) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            const img = entry.target;
                            img.src = img.dataset.src;
                            img.classList.remove('lazy');
                            img.classList.add('loaded');
                            observer.unobserve(img);
                        }
                    });
                });
                
                document.querySelectorAll('img[data-src]').forEach(img => {
                    imageObserver.observe(img);
                });
            }
            
            // Optimize form inputs for mobile
            $('input[type="tel"]').attr('inputmode', 'numeric');
            $('input[type="email"]').attr('inputmode', 'email');
            
            // Prevent zoom on input focus
            if (this.isMobile()) {
                $('input, select, textarea').attr('user-scalable', 'no');
            }
            
            // Mobile-specific performance optimizations
            this.optimizeScrolling();
            this.preloadCriticalImages();
        },
        
        nextImage() {
            const $current = $('.vt-main-image img');
            const $thumbs = $('.vt-gallery-thumbs .vt-thumb');
            const currentIndex = $thumbs.index($('.vt-thumb.active'));
            const nextIndex = (currentIndex + 1) % $thumbs.length;
            
            $thumbs.removeClass('active').eq(nextIndex).addClass('active');
            const nextSrc = $thumbs.eq(nextIndex).find('img').attr('src');
            $current.attr('src', nextSrc);
        },
        
        prevImage() {
            const $current = $('.vt-main-image img');
            const $thumbs = $('.vt-gallery-thumbs .vt-thumb');
            const currentIndex = $thumbs.index($('.vt-thumb.active'));
            const prevIndex = currentIndex === 0 ? $thumbs.length - 1 : currentIndex - 1;
            
            $thumbs.removeClass('active').eq(prevIndex).addClass('active');
            const prevSrc = $thumbs.eq(prevIndex).find('img').attr('src');
            $current.attr('src', prevSrc);
        },
        
        showMobileNotification(message, type = 'info') {
            const $notification = $(`
                <div class="vt-mobile-notification vt-notification-${type}">
                    ${message}
                </div>
            `);
            
            $('body').append($notification);
            
            setTimeout(() => {
                $notification.addClass('show');
            }, 100);
            
            setTimeout(() => {
                $notification.removeClass('show');
                setTimeout(() => $notification.remove(), 300);
            }, 3000);
        },
        
        updateCartCount() {
            // Update cart count in header
            $.get(wc_add_to_cart_params.wc_ajax_url.toString().replace('%%endpoint%%', 'get_cart_count'))
                .done((response) => {
                    $('.vt-cart-count').text(response.count);
                });
        },
        
        loadSearchSuggestions(query) {
            // Load search suggestions via AJAX
            $.ajax({
                url: vt_ajax.ajax_url,
                type: 'POST',
                data: {
                    action: 'vt_search_suggestions',
                    query: query,
                    nonce: vt_ajax.nonce
                },
                success: (response) => {
                    if (response.success) {
                        this.displaySearchSuggestions(response.data);
                    }
                }
            });
        },
        
        displaySearchSuggestions(suggestions) {
            const $container = $('.vt-search-suggestions');
            $container.empty();
            
            suggestions.forEach(suggestion => {
                const $item = $(`
                    <div class="vt-suggestion-item">
                        <a href="${suggestion.url}">
                            <img src="${suggestion.image}" alt="${suggestion.title}">
                            <div class="vt-suggestion-info">
                                <h4>${suggestion.title}</h4>
                                <span class="vt-suggestion-price">${suggestion.price}</span>
                            </div>
                        </a>
                    </div>
                `);
                $container.append($item);
            });
            
            $container.show();
        },
        
        optimizeScrolling() {
            // Smooth scrolling for mobile
            let ticking = false;
            
            function updateScrollPosition() {
                // Update scroll-based animations
                const scrollTop = $(window).scrollTop();
                
                // Parallax effects on mobile
                $('.vt-parallax').each(function() {
                    const $this = $(this);
                    const speed = $this.data('speed') || 0.5;
                    const yPos = -(scrollTop * speed);
                    $this.css('transform', `translateY(${yPos}px)`);
                });
                
                ticking = false;
            }
            
            $(window).on('scroll', () => {
                if (!ticking) {
                    requestAnimationFrame(updateScrollPosition);
                    ticking = true;
                }
            });
        },
        
        preloadCriticalImages() {
            // Preload critical images for mobile
            const criticalImages = [
                '/wp-content/themes/vancouvertec-store/assets/images/logo.png',
                '/wp-content/themes/vancouvertec-store/assets/images/hero-mobile.jpg'
            ];
            
            criticalImages.forEach(src => {
                const img = new Image();
                img.src = src;
            });
        },
        
        isMobile() {
            return window.innerWidth <= 768;
        }
    };
    
    // Debounce utility function
    function debounce(func, wait, immediate) {
        let timeout;
        return function() {
            const context = this;
            const args = arguments;
            const later = function() {
                timeout = null;
                if (!immediate) func.apply(context, args);
            };
            const callNow = immediate && !timeout;
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
            if (callNow) func.apply(context, args);
        };
    }
    
    // Initialize on document ready and window resize
    $(document).ready(() => VTMobile.init());
    
    $(window).on('resize', debounce(() => {
        if (VTMobile.isMobile()) {
            VTMobile.optimizeForMobile();
        }
    }, 250));
    
})(jQuery);
EOF

# 3. ATUALIZAR functions.php para incluir mobile assets
log_info "Atualizando functions.php para mobile..."
cat >> "${THEME_PATH}/functions.php" << 'EOF'

/**
 * Mobile Assets Enqueue
 */
function vt_enqueue_mobile_assets() {
    if (wp_is_mobile() || is_admin()) {
        // CSS Mobile
        wp_enqueue_style('vt-mobile', 
            VT_THEME_URI . '/assets/css/mobile.css', 
            ['vt-style'], VT_THEME_VERSION, 'screen');
        
        // JavaScript Mobile
        wp_enqueue_script('vt-mobile', 
            VT_THEME_URI . '/assets/js/mobile.js', 
            ['vt-main'], VT_THEME_VERSION, true);
    }
}
add_action('wp_enqueue_scripts', 'vt_enqueue_mobile_assets');

/**
 * Mobile Menu Support
 */
function vt_mobile_menu_support() {
    register_nav_menus([
        'mobile' => __('Mobile Menu', 'vancouvertec'),
    ]);
}
add_action('after_setup_theme', 'vt_mobile_menu_support');

/**
 * Search Suggestions AJAX
 */
function vt_search_suggestions_ajax() {
    check_ajax_referer('vt_nonce', 'nonce');
    
    $query = sanitize_text_field($_POST['query']);
    $suggestions = [];
    
    if (strlen($query) > 2) {
        $products = wc_get_products([
            'status' => 'publish',
            'limit' => 5,
            'meta_query' => [
                [
                    'key' => '_stock_status',
                    'value' => 'instock'
                ]
            ],
            's' => $query
        ]);
        
        foreach ($products as $product) {
            $suggestions[] = [
                'title' => $product->get_name(),
                'url' => $product->get_permalink(),
                'price' => $product->get_price_html(),
                'image' => wp_get_attachment_image_url($product->get_image_id(), 'thumbnail')
            ];
        }
    }
    
    wp_send_json_success($suggestions);
}
add_action('wp_ajax_vt_search_suggestions', 'vt_search_suggestions_ajax');
add_action('wp_ajax_nopriv_vt_search_suggestions', 'vt_search_suggestions_ajax');
EOF

# Iniciar servidor
log_info "Iniciando servidor com mobile otimizado..."
nohup php -S localhost:8080 router.php > server.log 2>&1 &
echo $! > .server_pid
sleep 3

# Verificar arquivos criados
created_files=(
    "${CSS_PATH}/mobile.css"
    "${JS_PATH}/mobile.js"
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
echo -e "║      ✅ MOBILE RESPONSIVO CRIADO! ✅         ║"
echo -e "║                                              ║"
echo -e "║  📱 CSS Mobile-First responsive             ║"
echo -e "║  👆 Touch gestures para galeria             ║"
echo -e "║  🔍 Busca mobile com sugestões              ║"
echo -e "║  🛒 Cart drawer mobile                      ║"
echo -e "║  📱 Menu hambúrguer                         ║"
echo -e "║  ⚡ Lazy loading otimizado                  ║"
echo -e "║                                              ║"
echo -e "║  Mobile Features:                            ║"
echo -e "║  • Swipe na galeria de produtos              ║"
echo -e "║  • Menu lateral responsivo                   ║"
echo -e "║  • Notificações mobile                       ║"
echo -e "║  • Performance otimizada                     ║"
echo -e "║                                              ║"
echo -e "║  🌐 Servidor: http://localhost:8080          ║"
echo -e "║                                              ║"
echo -e "║  ➡️  Próximo: 31d-woo-extras-wishlist.sh     ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_info "Execute para continuar:"
echo -e "${BLUE}chmod +x 31d-woo-extras-wishlist.sh && ./31d-woo-extras-wishlist.sh${NC}"