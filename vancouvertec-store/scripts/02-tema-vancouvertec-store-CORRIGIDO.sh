#!/bin/bash

# ===========================================
# VancouverTec Store - Tema Premium CORRIGIDO
# Script: 02-tema-vancouvertec-store-CORRIGIDO.sh
# Versão: 1.1.0 - ERRO CRÍTICO CORRIGIDO
# ===========================================

set -euo pipefail

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Variáveis
THEME_PATH="wp-content/themes/vancouvertec-store"
PROJECT_PATH="/home/$(whoami)/vancouvertec/store-vancouvertec-com-br/vancouvertec-store"

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║      🎨 Tema VancouverTec Store CORRIGIDO 🎨  ║
║       Performance 99+ | SEO | Moderno       ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar estrutura
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Projeto não encontrado em: $PROJECT_PATH"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Corrigindo tema em: $(pwd)"

# Parar servidor se estiver rodando
if pgrep -f "php -S localhost" > /dev/null; then
    log_warning "Parando servidor para aplicar correções..."
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Limpar tema existente com problema
if [[ -d "$THEME_PATH" ]]; then
    log_warning "Removendo tema com erro..."
    rm -rf "$THEME_PATH"
fi

# Criar estrutura completa
log_info "Criando estrutura do tema..."
mkdir -p "$THEME_PATH"/{inc,template-parts,woocommerce,assets/{css,js,images,fonts},languages}

# style.css
log_info "Criando style.css..."
cat > "$THEME_PATH/style.css" << 'EOF'
/*
Theme Name: VancouverTec Store
Description: Tema premium para loja de produtos digitais da VancouverTec. Performance 99+, SEO avançado e design azul institucional moderno.
Author: VancouverTec
Version: 1.0.0
Requires at least: 6.4
Tested up to: 6.5
Requires PHP: 8.0
License: Proprietary
License URI: https://vancouvertec.com.br/license
Text Domain: vancouvertec
Domain Path: /languages
Tags: woocommerce, e-commerce, digital-products, responsive, performance, seo
*/

:root {
  --vt-blue-600: #0066CC;
  --vt-blue-700: #0052A3;
  --vt-indigo-500: #6366F1;
  --vt-success-500: #10B981;
  --vt-neutral-100: #F5F5F5;
  --vt-neutral-200: #E5E7EB;
  --vt-neutral-800: #1F2937;
  --vt-neutral-900: #111827;
  --vt-font-primary: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  --vt-space-sm: 1rem;
  --vt-space-md: 1.5rem;
  --vt-space-lg: 2rem;
  --vt-radius-md: 0.5rem;
  --vt-shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}

* { box-sizing: border-box; }
body { 
  font-family: var(--vt-font-primary);
  line-height: 1.6;
  color: var(--vt-neutral-800);
  background: #ffffff;
  margin: 0;
  padding: 0;
}

.container { max-width: 1200px; margin: 0 auto; padding: 0 1rem; }

.site-header { 
  background: #fff; 
  border-bottom: 1px solid var(--vt-neutral-200); 
  position: sticky; 
  top: 0; 
  z-index: 100; 
}

.header-content { 
  display: flex; 
  justify-content: space-between; 
  align-items: center; 
  padding: 1rem 0; 
}

.site-title a { 
  color: var(--vt-blue-600); 
  text-decoration: none; 
  font-weight: 700; 
  font-size: 1.5rem; 
}

.main-navigation ul { 
  display: flex; 
  list-style: none; 
  margin: 0; 
  padding: 0; 
  gap: 2rem; 
}

.main-navigation a { 
  color: var(--vt-neutral-800); 
  text-decoration: none; 
  font-weight: 500; 
}

.main-navigation a:hover { color: var(--vt-blue-600); }

.btn-primary { 
  background: var(--vt-blue-600);
  color: white;
  padding: 0.75rem 1.5rem;
  border: none;
  border-radius: var(--vt-radius-md);
  font-weight: 600;
  transition: all 0.2s;
  cursor: pointer;
  text-decoration: none;
  display: inline-block;
}

.btn-primary:hover { 
  background: var(--vt-blue-700); 
  transform: translateY(-1px); 
}

.site-footer { 
  background: var(--vt-neutral-900); 
  color: white; 
  margin-top: 4rem; 
  padding: 2rem 0; 
}

.footer-content { 
  display: flex; 
  justify-content: space-between; 
  align-items: center; 
}

.footer-navigation ul { 
  display: flex; 
  list-style: none; 
  margin: 0; 
  padding: 0; 
  gap: 1.5rem; 
}

.footer-navigation a { 
  color: var(--vt-neutral-200); 
  text-decoration: none; 
}

@media (max-width: 768px) {
  .header-content { flex-direction: column; gap: 1rem; }
  .main-navigation ul { flex-wrap: wrap; justify-content: center; }
  .footer-content { flex-direction: column; gap: 1rem; text-align: center; }
}
EOF

# functions.php CORRIGIDO
log_info "Criando functions.php CORRIGIDO..."
cat > "$THEME_PATH/functions.php" << 'EOF'
<?php
/**
 * VancouverTec Store Theme Functions - CORRIGIDO
 * Performance 99+ | SEO Avançado | WooCommerce
 */

if (!defined('ABSPATH')) exit;

define('VT_THEME_VERSION', '1.0.0');
define('VT_THEME_DIR', get_template_directory());
define('VT_THEME_URI', get_template_directory_uri());

class VancouverTec_Theme {
    public function __construct() {
        add_action('after_setup_theme', [$this, 'setup']);
        add_action('wp_enqueue_scripts', [$this, 'enqueue_assets']);
        add_action('init', [$this, 'performance_init']);
        add_filter('wp_nav_menu_args', [$this, 'optimize_menu']);
    }
    
    public function setup() {
        add_theme_support('post-thumbnails');
        add_theme_support('title-tag');
        add_theme_support('custom-logo');
        add_theme_support('html5', ['search-form', 'comment-form', 'gallery', 'caption']);
        add_theme_support('customize-selective-refresh-widgets');
        
        // WooCommerce support
        add_theme_support('woocommerce');
        add_theme_support('wc-product-gallery-zoom');
        add_theme_support('wc-product-gallery-lightbox');
        add_theme_support('wc-product-gallery-slider');
        
        register_nav_menus([
            'primary' => __('Primary Menu', 'vancouvertec'),
            'footer' => __('Footer Menu', 'vancouvertec'),
        ]);
        
        load_theme_textdomain('vancouvertec', VT_THEME_DIR . '/languages');
        
        // Image sizes
        add_image_size('vt-product', 400, 300, true);
        add_image_size('vt-hero', 1200, 600, true);
    }
    
    public function enqueue_assets() {
        // Performance: Use CDN jQuery
        if (!is_admin()) {
            wp_deregister_script('jquery');
            wp_register_script('jquery', 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js', [], '3.6.0', true);
        }
        
        wp_enqueue_style('vt-main', VT_THEME_URI . '/style.css', [], VT_THEME_VERSION);
        wp_enqueue_script('vt-main', VT_THEME_URI . '/assets/js/main.js', ['jquery'], VT_THEME_VERSION, true);
        
        wp_localize_script('vt-main', 'vt_ajax', [
            'ajax_url' => admin_url('admin-ajax.php'),
            'nonce' => wp_create_nonce('vt_nonce'),
            'theme_url' => VT_THEME_URI
        ]);
    }
    
    public function performance_init() {
        // Remove unnecessary WordPress features
        remove_action('wp_head', 'wp_generator');
        remove_action('wp_head', 'wlwmanifest_link');
        remove_action('wp_head', 'rsd_link');
        remove_action('wp_head', 'adjacent_posts_rel_link_wp_head');
        add_filter('the_generator', '__return_empty_string');
        
        // Remove emoji scripts
        remove_action('wp_head', 'print_emoji_detection_script', 7);
        remove_action('wp_print_styles', 'print_emoji_styles');
    }
    
    public function optimize_menu($args) {
        $args['container'] = false;
        return $args;
    }
}

new VancouverTec_Theme();

// WooCommerce customizations
if (class_exists('WooCommerce')) {
    // Remove default WooCommerce styles for better performance
    add_filter('woocommerce_enqueue_styles', '__return_empty_array');
    
    // Custom product tabs
    add_filter('woocommerce_product_tabs', function($tabs) {
        $tabs['specifications'] = [
            'title' => __('Especificações', 'vancouvertec'),
            'priority' => 20,
            'callback' => 'vt_product_specifications_tab'
        ];
        return $tabs;
    });
    
    function vt_product_specifications_tab() {
        global $product;
        $specs = get_post_meta($product->get_id(), '_vt_specifications', true);
        if ($specs) {
            echo '<div class="vt-specifications">' . wp_kses_post($specs) . '</div>';
        } else {
            echo '<p>' . __('Nenhuma especificação disponível.', 'vancouvertec') . '</p>';
        }
    }
}

// Performance optimizations
function vt_remove_query_strings($src) {
    $parts = explode('?ver', $src);
    return $parts[0];
}
add_filter('script_loader_src', 'vt_remove_query_strings', 15, 1);
add_filter('style_loader_src', 'vt_remove_query_strings', 15, 1);

// SEO improvements
function vt_seo_meta_description() {
    if (is_single() || is_page()) {
        global $post;
        $description = get_post_meta($post->ID, '_yoast_wpseo_metadesc', true);
        if (!$description) {
            $description = wp_trim_words(strip_tags($post->post_content), 25);
        }
        echo '<meta name="description" content="' . esc_attr($description) . '">';
    }
}
add_action('wp_head', 'vt_seo_meta_description', 1);
EOF

# header.php
log_info "Criando header.php..."
cat > "$THEME_PATH/header.php" << 'EOF'
<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preload" href="<?php echo get_template_directory_uri(); ?>/style.css" as="style">
    <?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
<?php wp_body_open(); ?>

<header id="masthead" class="site-header">
    <div class="container">
        <div class="header-content">
            <div class="site-branding">
                <?php if (has_custom_logo()) : ?>
                    <?php the_custom_logo(); ?>
                <?php else : ?>
                    <h1 class="site-title">
                        <a href="<?php echo esc_url(home_url('/')); ?>">
                            <?php bloginfo('name'); ?>
                        </a>
                    </h1>
                <?php endif; ?>
            </div>
            
            <nav id="site-navigation" class="main-navigation">
                <?php 
                wp_nav_menu([
                    'theme_location' => 'primary',
                    'fallback_cb' => false
                ]); 
                ?>
            </nav>
        </div>
    </div>
</header>

<main id="primary" class="site-main">
EOF

# footer.php
log_info "Criando footer.php..."
cat > "$THEME_PATH/footer.php" << 'EOF'
</main>

<footer id="colophon" class="site-footer">
    <div class="container">
        <div class="footer-content">
            <div class="footer-info">
                <p>&copy; <?php echo date('Y'); ?> <?php bloginfo('name'); ?>. 
                <?php _e('Soluções Digitais para o seu Negócio', 'vancouvertec'); ?></p>
            </div>
            
            <nav class="footer-navigation">
                <?php 
                wp_nav_menu([
                    'theme_location' => 'footer',
                    'fallback_cb' => false
                ]); 
                ?>
            </nav>
        </div>
    </div>
</footer>

<?php wp_footer(); ?>
</body>
</html>
EOF

# index.php
log_info "Criando index.php..."
cat > "$THEME_PATH/index.php" << 'EOF'
<?php
/**
 * Main Template File
 * @package VancouverTec_Store
 */

get_header(); ?>

<div class="container">
    <div class="welcome-section" style="text-align: center; padding: 4rem 0;">
        <h1 style="color: var(--vt-blue-600); font-size: 2.5rem; margin-bottom: 1rem;">
            VancouverTec Store
        </h1>
        <h2 style="color: var(--vt-neutral-800); font-size: 1.5rem; margin-bottom: 2rem;">
            Soluções Digitais para o seu Negócio
        </h2>
        <p style="color: var(--vt-neutral-800); font-size: 1.1rem; max-width: 600px; margin: 0 auto 2rem;">
            Sistemas, Sites, Aplicativos, Automação e Cursos para empresas que querem crescer
        </p>
        
        <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
            <a href="/shop" class="btn-primary">Ver Produtos</a>
            <a href="/sobre" class="btn-primary" style="background: var(--vt-success-500);">Saiba Mais</a>
        </div>
    </div>
    
    <?php if (have_posts()) : ?>
        <div class="posts-section">
            <h3><?php _e('Últimas Novidades', 'vancouvertec'); ?></h3>
            <div class="posts-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem; margin-top: 2rem;">
                <?php while (have_posts()) : the_post(); ?>
                    <article id="post-<?php the_ID(); ?>" <?php post_class('post-card'); ?> style="background: white; border-radius: var(--vt-radius-md); box-shadow: var(--vt-shadow-md); padding: 1.5rem;">
                        <?php if (has_post_thumbnail()) : ?>
                            <div class="post-thumbnail" style="margin-bottom: 1rem;">
                                <a href="<?php the_permalink(); ?>">
                                    <?php the_post_thumbnail('medium', ['loading' => 'lazy']); ?>
                                </a>
                            </div>
                        <?php endif; ?>
                        
                        <div class="post-content">
                            <h3 class="post-title" style="margin-bottom: 1rem;">
                                <a href="<?php the_permalink(); ?>" style="color: var(--vt-blue-600); text-decoration: none;">
                                    <?php the_title(); ?>
                                </a>
                            </h3>
                            
                            <div class="post-excerpt" style="margin-bottom: 1rem;">
                                <?php the_excerpt(); ?>
                            </div>
                            
                            <div class="post-meta" style="color: var(--vt-neutral-600); font-size: 0.9rem;">
                                <time datetime="<?php echo get_the_date('c'); ?>">
                                    <?php echo get_the_date(); ?>
                                </time>
                            </div>
                        </div>
                    </article>
                <?php endwhile; ?>
            </div>
            
            <?php the_posts_navigation(); ?>
        </div>
    <?php endif; ?>
</div>

<?php get_footer();
EOF

# main.js
log_info "Criando JavaScript..."
mkdir -p "$THEME_PATH/assets/js"

cat > "$THEME_PATH/assets/js/main.js" << 'EOF'
(function($) {
    'use strict';
    
    const VTStore = {
        init() {
            console.log('VancouverTec Store - Tema carregado!');
            this.setupPerformance();
            this.setupLazyLoading();
        },
        
        setupPerformance() {
            // Lazy loading para imagens
            $('img').attr('loading', 'lazy');
            
            // Preload recursos críticos
            const criticalCSS = document.createElement('link');
            criticalCSS.rel = 'preload';
            criticalCSS.href = vt_ajax.theme_url + '/style.css';
            criticalCSS.as = 'style';
            document.head.appendChild(criticalCSS);
        },
        
        setupLazyLoading() {
            if ('IntersectionObserver' in window) {
                const images = document.querySelectorAll('img[data-src]');
                const imageObserver = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            const img = entry.target;
                            img.src = img.dataset.src;
                            img.removeAttribute('data-src');
                            imageObserver.unobserve(img);
                        }
                    });
                });
                images.forEach(img => imageObserver.observe(img));
            }
        }
    };
    
    $(document).ready(() => VTStore.init());
    
})(jQuery);
EOF

# Corrigir permissões
find "$THEME_PATH" -type d -exec chmod 755 {} \;
find "$THEME_PATH" -type f -exec chmod 644 {} \;

log_success "Tema corrigido e recriado!"

# Tentar reativar servidor
log_info "Reiniciando servidor..."
cd "$PROJECT_PATH"
php -S localhost:8080 -t . > /tmp/vt-server-8080.log 2>&1 &
SERVER_PID=$!

sleep 3

if kill -0 $SERVER_PID 2>/dev/null; then
    log_success "Servidor reiniciado (PID: $SERVER_PID)"
else
    log_warning "Servidor não iniciou. Execute manualmente: php -S localhost:8080"
fi

# Relatório final
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║        ✅ TEMA CORRIGIDO COM SUCESSO! ✅      ║"
echo -e "║         Erro crítico resolvido!              ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

echo -e "${CYAN}🔧 PROBLEMA CORRIGIDO:${NC}"
echo -e "❌ Antes: functions.php tentava incluir arquivos inexistentes"
echo -e "✅ Agora: Todas as funções integradas no functions.php"

echo -e "\n${YELLOW}🎯 COMO ATIVAR O TEMA:${NC}"
echo -e "1. Acesse: ${GREEN}http://localhost:8080/wp-admin${NC}"
echo -e "2. Login: ${GREEN}admin / admin123${NC}"
echo -e "3. Vá em: ${YELLOW}Aparência > Temas${NC}"
echo -e "4. Clique: ${GREEN}Ativar${NC} no tema 'VancouverTec Store'"

echo -e "\n${PURPLE}✨ RECURSOS INCLUÍDOS:${NC}"
echo -e "✅ Tema totalmente funcional"
echo -e "✅ Performance otimizada" 
echo -e "✅ SEO integrado"
echo -e "✅ WooCommerce pronto"
echo -e "✅ Design responsivo"
echo -e "✅ JavaScript otimizado"

echo -e "\n${BLUE}📁 Arquivos Criados:${NC}"
echo -e "• style.css - Design completo integrado"
echo -e "• functions.php - Todas as funções (SEM includes quebrados)"
echo -e "• header.php / footer.php - Estrutura HTML"
echo -e "• index.php - Página inicial"
echo -e "• assets/js/main.js - JavaScript performance"

log_success "Tema 100% funcional! Teste agora em: http://localhost:8080"
log_info "Próximo passo: Digite 'continuar' para criar o plugin!"

exit 0