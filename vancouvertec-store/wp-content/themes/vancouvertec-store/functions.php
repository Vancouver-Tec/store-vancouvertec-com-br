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

/**
 * Conectar todos os assets VancouverTec
 */
function vt_enqueue_all_assets() {
    // CSS Principal
    wp_enqueue_style('vt-style', VT_THEME_URI . '/style.css', [], VT_THEME_VERSION);
    
    // CSS WooCommerce
    wp_enqueue_style('vt-woocommerce', 
        VT_THEME_URI . '/assets/css/woocommerce/woocommerce.css', 
        ['vt-style'], VT_THEME_VERSION);
    
    // CSS Mobile
    if (wp_is_mobile()) {
        wp_enqueue_style('vt-mobile', 
            VT_THEME_URI . '/assets/css/mobile.css', 
            ['vt-woocommerce'], VT_THEME_VERSION);
    }
    
    // JavaScript
    wp_enqueue_script('vt-main', 
        VT_THEME_URI . '/assets/js/main.js', 
        ['jquery'], VT_THEME_VERSION, true);
    
    if (wp_is_mobile()) {
        wp_enqueue_script('vt-mobile', 
            VT_THEME_URI . '/assets/js/mobile.js', 
            ['vt-main'], VT_THEME_VERSION, true);
    }
}
add_action('wp_enqueue_scripts', 'vt_enqueue_all_assets', 5);

/**
 * Ativar tema automaticamente
 */
function vt_activate_theme() {
    if (get_option('stylesheet') !== 'vancouvertec-store') {
        switch_theme('vancouvertec-store');
        
        // Definir páginas padrão WooCommerce
        if (class_exists('WooCommerce')) {
            WC_Install::create_pages();
        }
    }
}
add_action('init', 'vt_activate_theme');

/**
 * Customizer VancouverTec
 */
function vt_customize_register($wp_customize) {
    // Seção VancouverTec
    $wp_customize->add_section('vt_options', [
        'title' => __('VancouverTec Store', 'vancouvertec'),
        'priority' => 30,
    ]);
    
    // Cor primária
    $wp_customize->add_setting('vt_primary_color', [
        'default' => '#0066CC',
        'sanitize_callback' => 'sanitize_hex_color',
    ]);
    
    $wp_customize->add_control(new WP_Customize_Color_Control($wp_customize, 'vt_primary_color', [
        'label' => __('Cor Primária VancouverTec', 'vancouvertec'),
        'section' => 'vt_options',
    ]));
}
add_action('customize_register', 'vt_customize_register');

/**
 * CSS customizado do Customizer
 */
function vt_customizer_css() {
    $primary_color = get_theme_mod('vt_primary_color', '#0066CC');
    ?>
    <style type="text/css">
        :root {
            --vt-blue-600: <?php echo $primary_color; ?>;
        }
    </style>
    <?php
}
add_action('wp_head', 'vt_customizer_css');

/**
 * Performance 99+ Optimizations
 */
function vt_performance_optimizations() {
    // Remove jQuery Migrate
    if (!is_admin()) {
        wp_deregister_script('jquery');
        wp_register_script('jquery', 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js', [], '3.7.1', true);
    }
    
    // Remove emoji scripts
    remove_action('wp_head', 'print_emoji_detection_script', 7);
    remove_action('wp_print_styles', 'print_emoji_styles');
    
    // Remove RSD link
    remove_action('wp_head', 'rsd_link');
    
    // Remove Windows Live Writer
    remove_action('wp_head', 'wlwmanifest_link');
    
    // Remove WordPress generator
    remove_action('wp_head', 'wp_generator');
    
    // Remove shortlink
    remove_action('wp_head', 'wp_shortlink_wp_head');
}
add_action('init', 'vt_performance_optimizations');

/**
 * Critical CSS Inline
 */
function vt_critical_css_inline() {
    if (is_front_page()) {
        $critical = '.vt-hero{background:linear-gradient(135deg,#0066CC,#6366F1);color:#fff;padding:4rem 0;text-align:center;border-radius:1rem}.vt-hero-title{font-size:3rem;font-weight:700;margin-bottom:1rem}.vt-features-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:2rem}';
        echo '<style id="vt-critical">' . $critical . '</style>';
    }
}
add_action('wp_head', 'vt_critical_css_inline', 1);

/**
 * Lazy Load Images
 */
function vt_add_lazy_loading($content) {
    if (is_admin() || is_feed()) return $content;
    
    $content = preg_replace('/<img(.*?)src=/i', '<img$1loading="lazy" src=', $content);
    return $content;
}
add_filter('the_content', 'vt_add_lazy_loading');

/**
 * Minify HTML Output
 */
function vt_minify_html($buffer) {
    if (!is_admin()) {
        $buffer = preg_replace('/\s+/', ' ', $buffer);
        $buffer = preg_replace('/<!--(?!s*(?:[if [^]]+]|!|>)).*?-->/', '', $buffer);
        $buffer = str_replace(['> <'], ['><'], $buffer);
    }
    return $buffer;
}
add_action('wp_loaded', function() {
    ob_start('vt_minify_html');
});

/**
 * SEO Schema.org JSON-LD
 */
function vt_schema_jsonld() {
    if (is_single() && get_post_type() === 'product') {
        global $product;
        
        $schema = [
            '@context' => 'https://schema.org/',
            '@type' => 'Product',
            'name' => $product->get_name(),
            'image' => wp_get_attachment_image_url($product->get_image_id(), 'full'),
            'description' => $product->get_short_description(),
            'sku' => $product->get_sku(),
            'brand' => [
                '@type' => 'Brand',
                'name' => 'VancouverTec'
            ],
            'offers' => [
                '@type' => 'Offer',
                'url' => $product->get_permalink(),
                'priceCurrency' => get_woocommerce_currency(),
                'price' => $product->get_price(),
                'priceValidUntil' => date('Y-12-31'),
                'availability' => $product->is_in_stock() ? 'https://schema.org/InStock' : 'https://schema.org/OutOfStock',
                'seller' => [
                    '@type' => 'Organization',
                    'name' => 'VancouverTec'
                ]
            ]
        ];
        
        // Add ratings if available
        $average = $product->get_average_rating();
        $count = $product->get_review_count();
        
        if ($average && $count) {
            $schema['aggregateRating'] = [
                '@type' => 'AggregateRating',
                'ratingValue' => $average,
                'reviewCount' => $count
            ];
        }
        
        echo '<script type="application/ld+json">' . wp_json_encode($schema) . '</script>';
    }
}
add_action('wp_head', 'vt_schema_jsonld');

/**
 * Preload Critical Resources
 */
function vt_preload_resources() {
    echo '<link rel="preload" href="' . VT_THEME_URI . '/style.css" as="style">';
    echo '<link rel="preload" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" as="script">';
    echo '<link rel="dns-prefetch" href="//cdnjs.cloudflare.com">';
    echo '<link rel="dns-prefetch" href="//fonts.googleapis.com">';
}
add_action('wp_head', 'vt_preload_resources', 1);

/**
 * Enqueue Visual Refinamento CSS
 */
function vt_enqueue_visual_refinamento() {
    wp_enqueue_style('vt-visual-refinamento', 
        VT_THEME_URI . '/assets/css/visual-refinamento.css', 
        ['vt-woocommerce'], VT_THEME_VERSION);
}
add_action('wp_enqueue_scripts', 'vt_enqueue_visual_refinamento', 15);

/**
 * Layout Fix CSS
 */
function vt_enqueue_layout_fix() {
    wp_enqueue_style('vt-layout-fix', 
        VT_THEME_URI . '/assets/css/layout-fix.css', 
        ['vt-visual-refinamento'], VT_THEME_VERSION);
}
add_action('wp_enqueue_scripts', 'vt_enqueue_layout_fix', 20);

/**
 * Header Footer CSS
 */
function vt_enqueue_header_footer_css() {
    wp_enqueue_style('vt-header-footer', 
        VT_THEME_URI . '/assets/css/header-footer.css', 
        ['vt-layout-fix'], VT_THEME_VERSION);
}
add_action('wp_enqueue_scripts', 'vt_enqueue_header_footer_css', 25);

/**
 * Garantir que footer apareça em todas as páginas
 */
function vt_ensure_footer() {
    if (!is_admin()) {
        // Adicionar wrapper para layout flex
        add_action('wp_body_open', function() {
            echo '<div id="page">';
        });
        
        add_action('wp_footer', function() {
            echo '</div>'; // Fechar #page
        }, 999);
    }
}
add_action('init', 'vt_ensure_footer');

/**
 * Body classes para identificar páginas
 */
function vt_custom_body_classes($classes) {
    if (is_front_page()) {
        $classes[] = 'vt-homepage';
    }
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
add_filter('body_class', 'vt_custom_body_classes');

/**
 * Homepage CSS
 */
function vt_enqueue_homepage_css() {
    if (is_front_page()) {
        wp_enqueue_style('vt-homepage', 
            VT_THEME_URI . '/assets/css/homepage.css', 
            ['vt-header-footer'], VT_THEME_VERSION);
    }
}
add_action('wp_enqueue_scripts', 'vt_enqueue_homepage_css', 30);
