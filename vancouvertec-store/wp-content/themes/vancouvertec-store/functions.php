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
