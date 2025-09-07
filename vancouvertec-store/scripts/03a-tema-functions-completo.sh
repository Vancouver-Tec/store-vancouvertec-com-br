#!/bin/bash

# ===========================================
# VancouverTec Store - Functions + Templates
# Script: 03a-tema-functions-completo.sh
# Versão: 1.0.0 - Functions.php + Templates Completos
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
║     🔧 Functions + Templates Completos 🔧    ║
║   Performance 99+ | WooCommerce | Security  ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar se tema base existe
if [[ ! -d "$PROJECT_PATH/$THEME_PATH" ]]; then
    log_error "Tema base não encontrado! Execute primeiro: 03-tema-completo-vancouvertec.sh"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Criando functions.php e templates em: $(pwd)"

# functions.php COMPLETO
log_info "Criando functions.php completo..."
cat > "$THEME_PATH/functions.php" << 'EOF'
<?php
/**
 * VancouverTec Store Theme Functions
 * Performance 99+ | SEO | WooCommerce | Elementor | Security
 * 
 * @package VancouverTec_Store
 * @version 1.0.0
 */

if (!defined('ABSPATH')) exit;

// Theme Constants
define('VT_THEME_VERSION', '1.0.0');
define('VT_THEME_DIR', get_template_directory());
define('VT_THEME_URI', get_template_directory_uri());
define('VT_THEME_NAME', 'VancouverTec Store');

/**
 * Main Theme Class
 */
class VancouverTec_Theme {
    
    public function __construct() {
        add_action('after_setup_theme', [$this, 'theme_setup']);
        add_action('wp_enqueue_scripts', [$this, 'enqueue_assets']);
        add_action('init', [$this, 'init_theme']);
        add_action('widgets_init', [$this, 'widgets_init']);
        add_filter('wp_nav_menu_args', [$this, 'optimize_menu']);
        add_action('wp_head', [$this, 'add_meta_tags'], 1);
    }
    
    /**
     * Theme Setup
     */
    public function theme_setup() {
        // Language support
        load_theme_textdomain('vancouvertec', VT_THEME_DIR . '/languages');
        
        // Theme support features
        add_theme_support('post-thumbnails');
        add_theme_support('title-tag');
        add_theme_support('custom-logo', [
            'height' => 60,
            'width' => 240,
            'flex-height' => true,
            'flex-width' => true,
        ]);
        add_theme_support('html5', [
            'search-form', 'comment-form', 'comment-list', 
            'gallery', 'caption', 'navigation-widgets'
        ]);
        add_theme_support('customize-selective-refresh-widgets');
        add_theme_support('responsive-embeds');
        add_theme_support('automatic-feed-links');
        
        // WooCommerce support
        add_theme_support('woocommerce', [
            'thumbnail_image_width' => 400,
            'single_image_width' => 600,
            'product_grid' => [
                'default_rows' => 3,
                'min_rows' => 2,
                'max_rows' => 8,
                'default_columns' => 3,
                'min_columns' => 2,
                'max_columns' => 4,
            ],
        ]);
        add_theme_support('wc-product-gallery-zoom');
        add_theme_support('wc-product-gallery-lightbox');
        add_theme_support('wc-product-gallery-slider');
        
        // Elementor support
        add_theme_support('elementor');
        
        // Navigation menus
        register_nav_menus([
            'primary' => __('Menu Principal', 'vancouvertec'),
            'footer' => __('Menu do Rodapé', 'vancouvertec'),
            'mobile' => __('Menu Mobile', 'vancouvertec'),
        ]);
        
        // Image sizes
        add_image_size('vt-hero', 1200, 600, true);
        add_image_size('vt-product', 400, 400, true);
        add_image_size('vt-product-large', 800, 800, true);
        add_image_size('vt-thumbnail', 150, 150, true);
        add_image_size('vt-card', 350, 250, true);
        
        // Content width
        if (!isset($content_width)) {
            $content_width = 1200;
        }
    }
    
    /**
     * Enqueue Scripts and Styles
     */
    public function enqueue_assets() {
        // Remove default WordPress styles/scripts
        wp_dequeue_style('wp-block-library');
        wp_dequeue_style('wp-block-library-theme');
        wp_dequeue_style('wc-block-style');
        
        // Performance: Use CDN jQuery
        if (!is_admin()) {
            wp_deregister_script('jquery');
            wp_register_script('jquery', 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js', [], '3.6.0', true);
            wp_enqueue_script('jquery');
        }
        
        // Theme styles
        wp_enqueue_style('vt-style', VT_THEME_URI . '/style.css', [], VT_THEME_VERSION);
        wp_enqueue_style('vt-main', VT_THEME_URI . '/assets/css/main.css', ['vt-style'], VT_THEME_VERSION);
        
        // Conditional styles
        if (is_woocommerce() || is_cart() || is_checkout() || is_account_page()) {
            wp_enqueue_style('vt-woocommerce', VT_THEME_URI . '/assets/css/woocommerce.css', ['vt-main'], VT_THEME_VERSION);
        }
        
        // Scripts
        wp_enqueue_script('vt-main', VT_THEME_URI . '/assets/js/main.js', ['jquery'], VT_THEME_VERSION, true);
        
        // Localize script for AJAX
        wp_localize_script('vt-main', 'vt_ajax', [
            'ajax_url' => admin_url('admin-ajax.php'),
            'nonce' => wp_create_nonce('vt_nonce'),
            'theme_url' => VT_THEME_URI,
            'site_url' => home_url(),
            'is_woocommerce' => class_exists('WooCommerce'),
        ]);
        
        // Conditional scripts
        if (is_singular() && comments_open() && get_option('thread_comments')) {
            wp_enqueue_script('comment-reply');
        }
    }
    
    /**
     * Initialize Theme Features
     */
    public function init_theme() {
        // Performance optimizations
        $this->performance_optimizations();
        
        // Security enhancements
        $this->security_enhancements();
        
        // SEO improvements
        $this->seo_improvements();
    }
    
    /**
     * Performance Optimizations
     */
    private function performance_optimizations() {
        // Remove unnecessary WordPress features
        remove_action('wp_head', 'wp_generator');
        remove_action('wp_head', 'wlwmanifest_link');
        remove_action('wp_head', 'rsd_link');
        remove_action('wp_head', 'adjacent_posts_rel_link_wp_head');
        remove_action('wp_head', 'wp_shortlink_wp_head');
        add_filter('the_generator', '__return_empty_string');
        
        // Remove emoji scripts (performance)
        remove_action('wp_head', 'print_emoji_detection_script', 7);
        remove_action('wp_print_styles', 'print_emoji_styles');
        remove_action('admin_print_scripts', 'print_emoji_detection_script');
        remove_action('admin_print_styles', 'print_emoji_styles');
        
        // Remove query strings from static resources
        add_filter('script_loader_src', [$this, 'remove_query_strings'], 15, 1);
        add_filter('style_loader_src', [$this, 'remove_query_strings'], 15, 1);
        
        // Optimize jQuery loading
        add_filter('wp_default_scripts', [$this, 'optimize_jquery']);
    }
    
    /**
     * Security Enhancements
     */
    private function security_enhancements() {
        // Hide WordPress version
        remove_action('wp_head', 'wp_generator');
        
        // Disable file editing
        if (!defined('DISALLOW_FILE_EDIT')) {
            define('DISALLOW_FILE_EDIT', true);
        }
        
        // Remove version from scripts and styles
        add_filter('script_loader_src', [$this, 'remove_version'], 15, 1);
        add_filter('style_loader_src', [$this, 'remove_version'], 15, 1);
    }
    
    /**
     * SEO Improvements
     */
    private function seo_improvements() {
        // Add meta description if not provided by SEO plugin
        if (!function_exists('yoast_breadcrumb') && !class_exists('RankMath')) {
            add_action('wp_head', [$this, 'add_meta_description'], 1);
        }
        
        // Add structured data
        add_action('wp_head', [$this, 'add_structured_data'], 5);
    }
    
    /**
     * Widgets Areas
     */
    public function widgets_init() {
        register_sidebar([
            'name' => __('Sidebar Principal', 'vancouvertec'),
            'id' => 'sidebar-1',
            'description' => __('Widgets que aparecem na sidebar principal.', 'vancouvertec'),
            'before_widget' => '<section id="%1$s" class="widget %2$s">',
            'after_widget' => '</section>',
            'before_title' => '<h2 class="widget-title">',
            'after_title' => '</h2>',
        ]);
        
        register_sidebar([
            'name' => __('Rodapé 1', 'vancouvertec'),
            'id' => 'footer-1',
            'description' => __('Primeira coluna do rodapé.', 'vancouvertec'),
            'before_widget' => '<div id="%1$s" class="widget %2$s">',
            'after_widget' => '</div>',
            'before_title' => '<h3 class="widget-title">',
            'after_title' => '</h3>',
        ]);
        
        register_sidebar([
            'name' => __('Rodapé 2', 'vancouvertec'),
            'id' => 'footer-2',
            'description' => __('Segunda coluna do rodapé.', 'vancouvertec'),
            'before_widget' => '<div id="%1$s" class="widget %2$s">',
            'after_widget' => '</div>',
            'before_title' => '<h3 class="widget-title">',
            'after_title' => '</h3>',
        ]);
    }
    
    /**
     * Helper Methods
     */
    public function optimize_menu($args) {
        $args['container'] = false;
        return $args;
    }
    
    public function remove_query_strings($src) {
        $parts = explode('?ver', $src);
        return $parts[0];
    }
    
    public function remove_version($src) {
        if (strpos($src, 'ver=')) {
            $src = remove_query_arg('ver', $src);
        }
        return $src;
    }
    
    public function optimize_jquery($scripts) {
        if (!is_admin() && isset($scripts->registered['jquery'])) {
            $scripts->registered['jquery']->deps = array_diff($scripts->registered['jquery']->deps, ['jquery-migrate']);
        }
    }
    
    public function add_meta_tags() {
        echo '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">' . "\n";
        echo '<meta name="format-detection" content="telephone=no">' . "\n";
        echo '<meta name="theme-color" content="#0066CC">' . "\n";
    }
    
    public function add_meta_description() {
        if (is_single() || is_page()) {
            global $post;
            $excerpt = wp_trim_words(strip_tags($post->post_content), 25);
            if ($excerpt) {
                echo '<meta name="description" content="' . esc_attr($excerpt) . '">' . "\n";
            }
        }
    }
    
    public function add_structured_data() {
        if (is_front_page()) {
            $schema = [
                '@context' => 'https://schema.org',
                '@type' => 'Organization',
                'name' => get_bloginfo('name'),
                'url' => home_url(),
                'description' => get_bloginfo('description'),
                'sameAs' => [
                    'https://vancouvertec.com.br'
                ]
            ];
            echo '<script type="application/ld+json">' . json_encode($schema, JSON_UNESCAPED_SLASHES) . '</script>' . "\n";
        }
    }
}

// Initialize theme
new VancouverTec_Theme();

/**
 * WooCommerce Customizations
 */
if (class_exists('WooCommerce')) {
    // Remove WooCommerce default styles for performance
    add_filter('woocommerce_enqueue_styles', '__return_empty_array');
    
    // Customize WooCommerce
    require_once VT_THEME_DIR . '/inc/woocommerce-functions.php';
}

/**
 * Elementor Compatibility
 */
if (defined('ELEMENTOR_VERSION')) {
    require_once VT_THEME_DIR . '/inc/elementor-functions.php';
}

/**
 * Custom Post Types and Fields
 */
require_once VT_THEME_DIR . '/inc/custom-post-types.php';

/**
 * AJAX Functions
 */
require_once VT_THEME_DIR . '/inc/ajax-functions.php';

/**
 * Template Functions
 */
require_once VT_THEME_DIR . '/inc/template-functions.php';
EOF

log_success "functions.php completo criado!"

# header.php COMPLETO
log_info "Criando header.php completo..."
cat > "$THEME_PATH/header.php" << 'EOF'
<!DOCTYPE html>
<html <?php language_attributes(); ?> class="no-js">
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
    <link rel="profile" href="https://gmpg.org/xfn/11">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="preload" href="<?php echo get_template_directory_uri(); ?>/assets/css/main.css" as="style">
    
    <?php wp_head(); ?>
</head>

<body <?php body_class('vt-loading'); ?>>
<?php wp_body_open(); ?>

<a class="sr-only" href="#main"><?php _e('Pular para o conteúdo principal', 'vancouvertec'); ?></a>

<header id="masthead" class="site-header" role="banner">
    <div class="container">
        <div class="header-content">
            <div class="site-branding">
                <?php if (has_custom_logo()) : ?>
                    <div class="site-logo">
                        <?php the_custom_logo(); ?>
                    </div>
                <?php else : ?>
                    <div class="site-title-wrapper">
                        <h1 class="site-title">
                            <a href="<?php echo esc_url(home_url('/')); ?>" rel="home">
                                <?php bloginfo('name'); ?>
                            </a>
                        </h1>
                        <?php 
                        $description = get_bloginfo('description', 'display');
                        if ($description || is_customize_preview()) : ?>
                            <p class="site-description"><?php echo $description; ?></p>
                        <?php endif; ?>
                    </div>
                <?php endif; ?>
            </div>
            
            <nav id="site-navigation" class="main-navigation" role="navigation" aria-label="<?php _e('Menu Principal', 'vancouvertec'); ?>">
                <button class="menu-toggle" aria-controls="primary-menu" aria-expanded="false">
                    <span class="sr-only"><?php _e('Menu Principal', 'vancouvertec'); ?></span>
                    <span class="menu-icon"></span>
                </button>
                
                <?php
                wp_nav_menu([
                    'theme_location' => 'primary',
                    'menu_id' => 'primary-menu',
                    'menu_class' => 'nav-menu',
                    'container' => false,
                    'fallback_cb' => false,
                ]);
                ?>
            </nav>
            
            <div class="header-actions">
                <?php if (class_exists('WooCommerce')) : ?>
                    <div class="header-cart">
                        <a href="<?php echo wc_get_cart_url(); ?>" class="cart-contents" title="<?php _e('Ver carrinho', 'vancouvertec'); ?>">
                            <span class="cart-icon">🛒</span>
                            <span class="cart-count"><?php echo WC()->cart->get_cart_contents_count(); ?></span>
                        </a>
                    </div>
                <?php endif; ?>
                
                <div class="header-search">
                    <button class="search-toggle" aria-expanded="false" aria-controls="header-search-form">
                        <span class="sr-only"><?php _e('Pesquisar', 'vancouvertec'); ?></span>
                        <span class="search-icon">🔍</span>
                    </button>
                    <div id="header-search-form" class="search-form-wrapper" hidden>
                        <?php get_search_form(); ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<main id="main" class="site-main" role="main">
EOF

log_success "header.php completo criado!"

# footer.php COMPLETO
log_info "Criando footer.php completo..."
cat > "$THEME_PATH/footer.php" << 'EOF'
</main>

<footer id="colophon" class="site-footer" role="contentinfo">
    <div class="container">
        <?php if (is_active_sidebar('footer-1') || is_active_sidebar('footer-2')) : ?>
            <div class="footer-widgets">
                <div class="footer-widget-area">
                    <?php if (is_active_sidebar('footer-1')) : ?>
                        <div class="footer-widget">
                            <?php dynamic_sidebar('footer-1'); ?>
                        </div>
                    <?php endif; ?>
                    
                    <?php if (is_active_sidebar('footer-2')) : ?>
                        <div class="footer-widget">
                            <?php dynamic_sidebar('footer-2'); ?>
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        <?php endif; ?>
        
        <div class="footer-content">
            <div class="footer-info">
                <p class="copyright">
                    &copy; <?php echo date('Y'); ?> 
                    <a href="<?php echo esc_url(home_url('/')); ?>"><?php bloginfo('name'); ?></a>. 
                    <?php _e('Soluções Digitais para o seu Negócio', 'vancouvertec'); ?>
                </p>
                <p class="powered-by">
                    <?php _e('Desenvolvido por', 'vancouvertec'); ?> 
                    <a href="https://vancouvertec.com.br" target="_blank" rel="noopener">VancouverTec</a>
                </p>
            </div>
            
            <?php if (has_nav_menu('footer')) : ?>
                <nav class="footer-navigation" role="navigation" aria-label="<?php _e('Menu do Rodapé', 'vancouvertec'); ?>">
                    <?php
                    wp_nav_menu([
                        'theme_location' => 'footer',
                        'menu_class' => 'footer-menu',
                        'container' => false,
                        'depth' => 1,
                        'fallback_cb' => false,
                    ]);
                    ?>
                </nav>
            <?php endif; ?>
        </div>
    </div>
</footer>

<?php wp_footer(); ?>

<script>
// Remove no-js class and add loaded class for performance
document.documentElement.classList.remove('no-js');
document.body.classList.add('vt-loaded');
</script>

</body>
</html>
EOF

log_success "footer.php completo criado!"

# index.php MELHORADO
log_info "Criando index.php melhorado..."
cat > "$THEME_PATH/index.php" << 'EOF'
<?php
/**
 * Main Template File
 * 
 * @package VancouverTec_Store
 */

get_header(); ?>

<div class="container">
    <?php if (is_home() && is_front_page()) : ?>
        <!-- Hero Section for Home Page -->
        <section class="hero-section text-center">
            <div class="hero-content">
                <h1 class="hero-title">
                    <?php echo get_bloginfo('name'); ?>
                </h1>
                <h2 class="hero-subtitle">
                    <?php _e('Soluções Digitais para o seu Negócio', 'vancouvertec'); ?>
                </h2>
                <p class="hero-description">
                    <?php _e('Sistemas, Sites, Aplicativos, Automação e Cursos para empresas que querem crescer', 'vancouvertec'); ?>
                </p>
                
                <div class="hero-actions">
                    <?php if (class_exists('WooCommerce')) : ?>
                        <a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>" class="btn btn-primary">
                            <?php _e('Ver Produtos', 'vancouvertec'); ?>
                        </a>
                    <?php endif; ?>
                    <a href="<?php echo esc_url(home_url('/sobre')); ?>" class="btn btn-secondary">
                        <?php _e('Saiba Mais', 'vancouvertec'); ?>
                    </a>
                </div>
            </div>
        </section>
    <?php endif; ?>
    
    <?php if (have_posts()) : ?>
        <section class="posts-section">
            <?php if (!is_front_page()) : ?>
                <header class="page-header">
                    <h1 class="page-title">
                        <?php
                        if (is_home()) {
                            _e('Últimas Novidades', 'vancouvertec');
                        } elseif (is_category()) {
                            single_cat_title();
                        } elseif (is_tag()) {
                            single_tag_title();
                        } elseif (is_author()) {
                            the_author();
                        } elseif (is_search()) {
                            printf(__('Resultados da busca por: %s', 'vancouvertec'), get_search_query());
                        } else {
                            _e('Blog', 'vancouvertec');
                        }
                        ?>
                    </h1>
                    
                    <?php if (is_category() || is_tag()) : ?>
                        <div class="page-description">
                            <?php echo term_description(); ?>
                        </div>
                    <?php endif; ?>
                </header>
            <?php else : ?>
                <h3 class="section-title"><?php _e('Últimas Novidades', 'vancouvertec'); ?></h3>
            <?php endif; ?>
            
            <div class="posts-grid">
                <?php while (have_posts()) : the_post(); ?>
                    <article id="post-<?php the_ID(); ?>" <?php post_class('post-card'); ?>>
                        <?php if (has_post_thumbnail()) : ?>
                            <div class="post-thumbnail">
                                <a href="<?php the_permalink(); ?>" aria-hidden="true" tabindex="-1">
                                    <?php the_post_thumbnail('vt-card', ['loading' => 'lazy']); ?>
                                </a>
                            </div>
                        <?php endif; ?>
                        
                        <div class="post-content">
                            <header class="post-header">
                                <h2 class="post-title">
                                    <a href="<?php the_permalink(); ?>">
                                        <?php the_title(); ?>
                                    </a>
                                </h2>
                                
                                <div class="post-meta">
                                    <time datetime="<?php echo get_the_date('c'); ?>" class="post-date">
                                        <?php echo get_the_date(); ?>
                                    </time>
                                    
                                    <?php if (has_category()) : ?>
                                        <span class="post-category">
                                            <?php _e('em', 'vancouvertec'); ?> <?php the_category(', '); ?>
                                        </span>
                                    <?php endif; ?>
                                </div>
                            </header>
                            
                            <div class="post-excerpt">
                                <?php the_excerpt(); ?>
                            </div>
                            
                            <footer class="post-footer">
                                <a href="<?php the_permalink(); ?>" class="read-more">
                                    <?php _e('Leia mais', 'vancouvertec'); ?>
                                    <span class="sr-only"><?php _e('sobre', 'vancouvertec'); ?> "<?php the_title(); ?>"</span>
                                </a>
                            </footer>
                        </div>
                    </article>
                <?php endwhile; ?>
            </div>
            
            <?php
            // Pagination
            the_posts_pagination([
                'mid_size' => 2,
                'prev_text' => __('← Anterior', 'vancouvertec'),
                'next_text' => __('Próximo →', 'vancouvertec'),
            ]);
            ?>
        </section>
        
    <?php else : ?>
        <section class="no-results">
            <header class="page-header">
                <h1 class="page-title"><?php _e('Nada encontrado', 'vancouvertec'); ?></h1>
            </header>
            
            <div class="page-content">
                <?php if (is_home() && current_user_can('publish_posts')) : ?>
                    <p>
                        <?php
                        printf(
                            __('Pronto para publicar seu primeiro post? <a href="%1$s">Comece aqui</a>.', 'vancouvertec'),
                            esc_url(admin_url('post-new.php'))
                        );
                        ?>
                    </p>
                <?php elseif (is_search()) : ?>
                    <p><?php _e('Desculpe, mas nada foi encontrado para sua busca. Tente novamente com palavras-chave diferentes.', 'vancouvertec'); ?></p>
                    <?php get_search_form(); ?>
                <?php else : ?>
                    <p><?php _e('Parece que não conseguimos encontrar o que você está procurando. Talvez a busca possa ajudar.', 'vancouvertec'); ?></p>
                    <?php get_search_form(); ?>
                <?php endif; ?>
            </div>
        </section>
    <?php endif; ?>
</div>

<?php
get_sidebar();
get_footer();
EOF

log_success "index.php melhorado criado!"

echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║    ✅ FUNCTIONS + TEMPLATES CRIADOS! ✅      ║"
echo -e "║     Tema WordPress completo e funcional      ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "functions.php com classe completa criado!"
log_success "header.php com navegação e SEO criado!"
log_success "footer.php com widgets e menu criado!"
log_success "index.php responsivo criado!"

echo -e "\n${CYAN}🔧 Recursos Incluídos:${NC}"
echo -e "• ✅ Performance 99+ (jQuery CDN, scripts otimizados)"
echo -e "• ✅ SEO avançado (meta tags, structured data)"
echo -e "• ✅ Security (file edit disabled, version removal)"
echo -e "• ✅ WooCommerce integration"
echo -e "• ✅ Elementor"