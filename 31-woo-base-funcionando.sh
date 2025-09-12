#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce Base Funcionando
# Script: 31-woo-base-funcionando.sh
# Versão: 1.0.0 - Base sólida WooCommerce + Template Override
# ===========================================

set -euo pipefail

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Variáveis do projeto
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
║    🛒 WooCommerce Base Funcionando 🛒        ║
║      Template Override + CSS Custom          ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificações iniciais
log_info "Verificando estrutura do projeto..."
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Projeto não encontrado em: $PROJECT_PATH"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Trabalhando em: $(pwd)"

# Parar servidor se estiver rodando
if pgrep -f "php -S localhost:8080" > /dev/null; then
    log_warning "Parando servidor para atualizações..."
    pkill -f "php -S localhost:8080" || true
    sleep 2
fi

# Criar estrutura WooCommerce
log_info "Criando estrutura de templates WooCommerce..."
mkdir -p "${WC_TEMPLATES_PATH}"/{cart,checkout,single-product,account,emails}
mkdir -p "${THEME_PATH}/assets/css/woocommerce"

# 1. ATUALIZAR functions.php - Base WooCommerce
log_info "Atualizando functions.php com suporte WooCommerce..."
cat > "${THEME_PATH}/functions.php" << 'EOF'
<?php
/**
 * VancouverTec Store - WooCommerce Base Functions
 * Performance 99+ | Template Override Strategy
 */

if (!defined('ABSPATH')) exit;

define('VT_THEME_VERSION', '1.0.0');
define('VT_THEME_DIR', get_template_directory());
define('VT_THEME_URI', get_template_directory_uri());

class VancouverTec_WooCommerce {
    public function __construct() {
        add_action('after_setup_theme', [$this, 'setup']);
        add_action('wp_enqueue_scripts', [$this, 'enqueue_assets']);
        add_action('init', [$this, 'woocommerce_setup']);
        
        // Desabilitar CSS padrão WooCommerce
        add_filter('woocommerce_enqueue_styles', '__return_empty_array');
        
        // Template hooks
        add_action('wp_head', [$this, 'add_critical_css'], 1);
        add_filter('body_class', [$this, 'add_body_classes']);
    }
    
    public function setup() {
        // Theme supports
        add_theme_support('title-tag');
        add_theme_support('post-thumbnails');
        add_theme_support('custom-logo');
        add_theme_support('html5', ['search-form', 'comment-form', 'gallery', 'caption']);
        
        // WooCommerce theme support
        add_theme_support('woocommerce');
        add_theme_support('wc-product-gallery-zoom');
        add_theme_support('wc-product-gallery-lightbox');
        add_theme_support('wc-product-gallery-slider');
        
        // Navigation menus
        register_nav_menus([
            'primary' => __('Menu Principal', 'vancouvertec'),
            'footer' => __('Menu Footer', 'vancouvertec'),
        ]);
        
        // Load text domain
        load_theme_textdomain('vancouvertec', VT_THEME_DIR . '/languages');
        
        // Image sizes para produtos
        add_image_size('vt-product-thumb', 300, 300, true);
        add_image_size('vt-product-single', 600, 600, true);
        add_image_size('vt-product-gallery', 100, 100, true);
    }
    
    public function enqueue_assets() {
        // jQuery otimizado
        if (!is_admin()) {
            wp_deregister_script('jquery');
            wp_register_script('jquery', 
                'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js', 
                [], '3.7.1', true);
        }
        
        // CSS Principal
        wp_enqueue_style('vt-style', VT_THEME_URI . '/style.css', [], VT_THEME_VERSION);
        
        // CSS WooCommerce customizado
        wp_enqueue_style('vt-woocommerce', 
            VT_THEME_URI . '/assets/css/woocommerce/woocommerce.css', 
            ['vt-style'], VT_THEME_VERSION);
        
        // JavaScript principal
        wp_enqueue_script('vt-main', 
            VT_THEME_URI . '/assets/js/main.js', 
            ['jquery'], VT_THEME_VERSION, true);
            
        // Localizar script
        wp_localize_script('vt-main', 'vt_ajax', [
            'ajax_url' => admin_url('admin-ajax.php'),
            'nonce' => wp_create_nonce('vt_nonce'),
            'theme_url' => VT_THEME_URI,
        ]);
    }
    
    public function woocommerce_setup() {
        // Declarar compatibilidade WooCommerce
        if (class_exists('WooCommerce')) {
            // Remove estilos padrão
            add_filter('woocommerce_enqueue_styles', '__return_false');
            
            // Custom wrapper
            remove_action('woocommerce_before_main_content', 'woocommerce_output_content_wrapper', 10);
            remove_action('woocommerce_after_main_content', 'woocommerce_output_content_wrapper_end', 10);
            
            add_action('woocommerce_before_main_content', [$this, 'wrapper_start'], 10);
            add_action('woocommerce_after_main_content', [$this, 'wrapper_end'], 10);
            
            // Remove breadcrumb padrão - vamos customizar
            remove_action('woocommerce_before_main_content', 'woocommerce_breadcrumb', 20);
        }
    }
    
    public function wrapper_start() {
        echo '<main class="vt-main-content"><div class="container">';
    }
    
    public function wrapper_end() {
        echo '</div></main>';
    }
    
    public function add_critical_css() {
        // CSS crítico inline para performance
        echo '<style id="vt-critical-css">
        .vt-main-content{padding:2rem 0}
        .container{max-width:1200px;margin:0 auto;padding:0 1rem}
        .btn-primary{background:#0066CC;color:#fff;padding:0.75rem 1.5rem;border:none;border-radius:0.5rem;font-weight:600;transition:all 0.2s}
        .btn-primary:hover{background:#0052A3;transform:translateY(-1px)}
        .woocommerce-loading{opacity:0;transition:opacity 0.3s}
        .woocommerce-loaded{opacity:1}
        </style>';
    }
    
    public function add_body_classes($classes) {
        if (is_woocommerce() || is_cart() || is_checkout() || is_account_page()) {
            $classes[] = 'vt-woocommerce-page';
        }
        return $classes;
    }
}

// Inicializar classe
new VancouverTec_WooCommerce();

// Include arquivos de customização
if (file_exists(VT_THEME_DIR . '/inc/woocommerce-hooks.php')) {
    require_once VT_THEME_DIR . '/inc/woocommerce-hooks.php';
}
EOF

# 2. CRIAR CSS BASE WOOCOMMERCE
log_info "Criando CSS base WooCommerce..."
cat > "${THEME_PATH}/assets/css/woocommerce/woocommerce.css" << 'EOF'
/**
 * VancouverTec Store - WooCommerce Base CSS
 * Template Override Strategy
 */

/* Variáveis CSS VancouverTec */
:root {
  --vt-blue-600: #0066CC;
  --vt-blue-700: #0052A3;
  --vt-indigo-500: #6366F1;
  --vt-success-500: #10B981;
  --vt-warning-500: #F59E0B;
  --vt-error-500: #EF4444;
  --vt-neutral-100: #F5F5F5;
  --vt-neutral-200: #E5E7EB;
  --vt-neutral-800: #1F2937;
  --vt-space-xs: 0.5rem;
  --vt-space-sm: 1rem;
  --vt-space-md: 1.5rem;
  --vt-space-lg: 2rem;
  --vt-radius-md: 0.5rem;
  --vt-shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

/* Reset WooCommerce */
.woocommerce * {
  box-sizing: border-box;
}

/* Container principal */
.vt-main-content {
  padding: var(--vt-space-lg) 0;
  min-height: 70vh;
}

/* Botões VancouverTec */
.woocommerce .button,
.woocommerce button,
.woocommerce input[type="submit"] {
  background: var(--vt-blue-600);
  color: white;
  border: none;
  padding: var(--vt-space-xs) var(--vt-space-md);
  border-radius: var(--vt-radius-md);
  font-weight: 600;
  transition: all 0.2s ease;
  cursor: pointer;
  text-decoration: none;
}

.woocommerce .button:hover,
.woocommerce button:hover,
.woocommerce input[type="submit"]:hover {
  background: var(--vt-blue-700);
  color: white;
  transform: translateY(-1px);
  box-shadow: var(--vt-shadow-md);
}

/* Botão adicionar ao carrinho */
.woocommerce .single_add_to_cart_button {
  background: var(--vt-success-500);
  font-size: 1.1rem;
  padding: var(--vt-space-sm) var(--vt-space-lg);
}

.woocommerce .single_add_to_cart_button:hover {
  background: #059669;
}

/* Cards de produto */
.woocommerce ul.products li.product {
  background: white;
  border-radius: var(--vt-radius-md);
  box-shadow: var(--vt-shadow-md);
  padding: var(--vt-space-md);
  transition: all 0.3s ease;
  margin-bottom: var(--vt-space-lg);
}

.woocommerce ul.products li.product:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

/* Preços */
.woocommerce .price {
  color: var(--vt-blue-600);
  font-weight: bold;
  font-size: 1.2rem;
}

.woocommerce .price del {
  color: var(--vt-neutral-800);
  opacity: 0.6;
}

/* Mensagens */
.woocommerce-message {
  background: var(--vt-success-500);
  color: white;
  padding: var(--vt-space-sm);
  border-radius: var(--vt-radius-md);
  margin: var(--vt-space-md) 0;
}

.woocommerce-error {
  background: var(--vt-error-500);
  color: white;
  padding: var(--vt-space-sm);
  border-radius: var(--vt-radius-md);
  margin: var(--vt-space-md) 0;
}

.woocommerce-info {
  background: var(--vt-indigo-500);
  color: white;
  padding: var(--vt-space-sm);
  border-radius: var(--vt-radius-md);
  margin: var(--vt-space-md) 0;
}

/* Responsivo */
@media (max-width: 768px) {
  .vt-main-content {
    padding: var(--vt-space-md) 0;
  }
  
  .woocommerce ul.products {
    display: block;
  }
  
  .woocommerce ul.products li.product {
    width: 100%;
    margin: 0 0 var(--vt-space-lg) 0;
  }
}

/* Loading states */
.woocommerce-loading {
  opacity: 0.6;
  pointer-events: none;
}

.woocommerce-loading::after {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  width: 20px;
  height: 20px;
  margin: -10px 0 0 -10px;
  border: 2px solid var(--vt-blue-600);
  border-radius: 50%;
  border-top-color: transparent;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}
EOF

# 3. CRIAR ARQUIVO DE HOOKS WOOCOMMERCE
log_info "Criando hooks customizados WooCommerce..."
mkdir -p "${THEME_PATH}/inc"
cat > "${THEME_PATH}/inc/woocommerce-hooks.php" << 'EOF'
<?php
/**
 * VancouverTec Store - WooCommerce Hooks Customization
 */

if (!defined('ABSPATH')) exit;

// Remove elementos desnecessários
remove_action('woocommerce_before_shop_loop', 'woocommerce_output_all_notices', 10);
remove_action('woocommerce_before_single_product', 'woocommerce_output_all_notices', 10);

// Customizar breadcrumb
function vt_custom_breadcrumb() {
    if (is_woocommerce() && !is_shop()) {
        echo '<nav class="vt-breadcrumb" aria-label="Breadcrumb">';
        woocommerce_breadcrumb([
            'delimiter' => ' <span class="separator">/</span> ',
            'wrap_before' => '<ol class="breadcrumb-list">',
            'wrap_after' => '</ol>',
            'before' => '<li>',
            'after' => '</li>',
            'home' => _x('Início', 'breadcrumb', 'vancouvertec'),
        ]);
        echo '</nav>';
    }
}
add_action('woocommerce_before_main_content', 'vt_custom_breadcrumb', 15);

// Otimizar quantidade de produtos por página
function vt_products_per_page() {
    return 12;
}
add_filter('loop_shop_per_page', 'vt_products_per_page');

// Adicionar classes CSS customizadas
function vt_wc_body_class($classes) {
    if (is_shop()) {
        $classes[] = 'vt-shop-page';
    }
    if (is_product()) {
        $classes[] = 'vt-single-product-page';
    }
    if (is_cart()) {
        $classes[] = 'vt-cart-page';
    }
    if (is_checkout()) {
        $classes[] = 'vt-checkout-page';
    }
    return $classes;
}
add_filter('body_class', 'vt_wc_body_class');

// Customizar texto do botão adicionar ao carrinho
function vt_add_to_cart_text() {
    return __('Adicionar ao Carrinho', 'vancouvertec');
}
add_filter('woocommerce_product_add_to_cart_text', 'vt_add_to_cart_text');
add_filter('woocommerce_product_single_add_to_cart_text', 'vt_add_to_cart_text');

// AJAX para adicionar ao carrinho
function vt_ajax_add_to_cart() {
    wp_enqueue_script('wc-add-to-cart');
}
add_action('wp_enqueue_scripts', 'vt_ajax_add_to_cart');
EOF

# 4. ATUALIZAR JAVASCRIPT PRINCIPAL
log_info "Atualizando JavaScript principal..."
cat > "${THEME_PATH}/assets/js/main.js" << 'EOF'
/**
 * VancouverTec Store - Main JavaScript
 * WooCommerce + Performance Optimization
 */

(function($) {
    'use strict';
    
    const VTWooCommerce = {
        init() {
            console.log('VancouverTec WooCommerce initialized');
            this.setupAjaxCart();
            this.setupProductGallery();
            this.setupPerformance();
            this.setupAccessibility();
        },
        
        setupAjaxCart() {
            // AJAX add to cart
            $('body').on('added_to_cart', function(event, fragments, cart_hash, $button) {
                console.log('Product added to cart');
                $button.removeClass('loading');
                
                // Show success message
                const message = $('<div class="vt-cart-success">Produto adicionado ao carrinho!</div>');
                $button.after(message);
                setTimeout(() => message.fadeOut(), 3000);
            });
            
            // Loading state
            $(document).on('click', '.ajax_add_to_cart', function() {
                $(this).addClass('loading');
            });
        },
        
        setupProductGallery() {
            // Lazy loading para imagens
            if ('IntersectionObserver' in window) {
                const imageObserver = new IntersectionObserver((entries, observer) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            const img = entry.target;
                            img.src = img.dataset.src;
                            img.classList.remove('lazy');
                            img.classList.add('loaded');
                            imageObserver.unobserve(img);
                        }
                    });
                });
                
                document.querySelectorAll('img[data-src]').forEach(img => {
                    imageObserver.observe(img);
                });
            }
        },
        
        setupPerformance() {
            // Preload critical resources
            const preloadCSS = (href) => {
                const link = document.createElement('link');
                link.rel = 'preload';
                link.href = href;
                link.as = 'style';
                link.onload = function() {
                    this.onload = null;
                    this.rel = 'stylesheet';
                };
                document.head.appendChild(link);
            };
            
            // Performance monitoring
            if ('performance' in window) {
                window.addEventListener('load', () => {
                    const perfData = performance.timing;
                    const loadTime = perfData.loadEventEnd - perfData.navigationStart;
                    console.log('VT WooCommerce Page Load Time:', loadTime + 'ms');
                });
            }
        },
        
        setupAccessibility() {
            // Adicionar ARIA labels para botões
            $('.ajax_add_to_cart').attr('aria-label', 'Adicionar produto ao carrinho');
            
            // Focus management
            $(document).on('wc_fragments_refreshed', function() {
                $('.cart-contents').attr('aria-live', 'polite');
            });
        }
    };
    
    // Initialize when DOM is ready
    $(document).ready(() => VTWooCommerce.init());
    
    // Initialize when WooCommerce is ready
    $(document.body).on('wc_fragments_refreshed wc_fragments_loaded', () => {
        VTWooCommerce.setupAjaxCart();
    });
    
})(jQuery);
EOF

# 5. CRIAR TEMPLATE BÁSICO archive-product.php
log_info "Criando template archive-product.php..."
cat > "${WC_TEMPLATES_PATH}/archive-product.php" << 'EOF'
<?php
/**
 * VancouverTec Store - Products Archive
 * Template Override
 */

if (!defined('ABSPATH')) exit;

get_header('shop');

/**
 * Hook: woocommerce_before_main_content
 *
 * @hooked woocommerce_output_content_wrapper - 10 (removed)
 * @hooked woocommerce_breadcrumb - 20 (removed, custom added)
 */
do_action('woocommerce_before_main_content');
?>

<div class="vt-shop-header">
    <div class="container">
        <?php if (apply_filters('woocommerce_show_page_title', true)): ?>
            <h1 class="vt-shop-title"><?php woocommerce_page_title(); ?></h1>
        <?php endif; ?>
        
        <?php
        /**
         * Hook: woocommerce_archive_description
         *
         * @hooked woocommerce_taxonomy_archive_description - 10
         * @hooked woocommerce_product_archive_description - 10
         */
        do_action('woocommerce_archive_description');
        ?>
    </div>
</div>

<?php if (woocommerce_product_loop()): ?>

    <div class="vt-shop-content">
        <div class="container">
            <?php
            /**
             * Hook: woocommerce_before_shop_loop
             *
             * @hooked woocommerce_output_all_notices - 10 (removed)
             * @hooked woocommerce_result_count - 20
             * @hooked woocommerce_catalog_ordering - 30
             */
            do_action('woocommerce_before_shop_loop');
            
            woocommerce_product_loop_start();
            
            if (wc_get_loop_prop('is_shortcode')) {
                $columns = absint(wc_get_loop_prop('columns'));
            } else {
                $columns = wc_get_default_products_per_row();
            }
            
            while (have_posts()) {
                the_post();
                
                /**
                 * Hook: woocommerce_shop_loop
                 */
                do_action('woocommerce_shop_loop');
                
                wc_get_template_part('content', 'product');
            }
            
            woocommerce_product_loop_end();
            
            /**
             * Hook: woocommerce_after_shop_loop
             *
             * @hooked woocommerce_pagination - 10
             */
            do_action('woocommerce_after_shop_loop');
            ?>
        </div>
    </div>

<?php else: ?>

    <div class="vt-no-products">
        <div class="container">
            <?php
            /**
             * Hook: woocommerce_no_products_found
             *
             * @hooked wc_no_products_found - 10
             */
            do_action('woocommerce_no_products_found');
            ?>
        </div>
    </div>

<?php endif; ?>

<?php
/**
 * Hook: woocommerce_after_main_content
 *
 * @hooked woocommerce_output_content_wrapper_end - 10 (removed)
 */
do_action('woocommerce_after_main_content');

get_footer('shop');
?>
EOF

# 6. TESTAR CONFIGURAÇÃO
log_info "Testando configuração base..."

# Verificar se arquivos foram criados
required_files=(
    "${THEME_PATH}/functions.php"
    "${THEME_PATH}/assets/css/woocommerce/woocommerce.css"
    "${THEME_PATH}/inc/woocommerce-hooks.php"
    "${THEME_PATH}/assets/js/main.js"
    "${WC_TEMPLATES_PATH}/archive-product.php"
)

for file in "${required_files[@]}"; do
    if [[ -f "$file" ]]; then
        log_success "✅ $file criado"
    else
        log_error "❌ $file não encontrado"
    fi
done

# Iniciar servidor para teste
log_info "Iniciando servidor para teste..."
cd "$PROJECT_PATH"
nohup php -S localhost:8080 router.php > server.log 2>&1 &
SERVER_PID=$!
echo $SERVER_PID > .server_pid

sleep 3

if curl -s "http://localhost:8080" > /dev/null; then
    log_success "✅ Servidor rodando em http://localhost:8080"
else
    log_error "❌ Erro ao iniciar servidor"
fi

# Relatório final
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║        ✅ BASE WOOCOMMERCE CRIADA! ✅         ║"
echo -e "║                                              ║"
echo -e "║  🛒 Template Override Strategy implementada  ║"
echo -e "║  🎨 CSS VancouverTec aplicado                ║"
echo -e "║  ⚡ Performance otimizada                    ║"
echo -e "║  📱 Base responsiva criada                   ║"
echo -e "║                                              ║"
echo -e "║  🌐 Acesse: http://localhost:8080            ║"
echo -e "║                                              ║"
echo -e "║  ➡️  Execute: 31a-woo-templates-override.sh  ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_info "Para continuar com templates override, execute:"
echo -e "${CYAN}chmod +x 31a-woo-templates-override.sh && ./31a-woo-templates-override.sh${NC}"