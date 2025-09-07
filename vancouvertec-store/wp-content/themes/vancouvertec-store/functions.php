<?php
/**
 * VancouverTec Store Theme Functions
 * @package VancouverTec_Store
 */

if (!defined('ABSPATH')) exit;

define('VT_THEME_VERSION', '1.0.0');
define('VT_THEME_DIR', get_template_directory());
define('VT_THEME_URI', get_template_directory_uri());

function vt_theme_setup() {
    add_theme_support('post-thumbnails');
    add_theme_support('title-tag');
    add_theme_support('custom-logo');
    add_theme_support('html5', ['search-form', 'comment-form', 'gallery', 'caption']);
    
    // WooCommerce support
    add_theme_support('woocommerce');
    add_theme_support('wc-product-gallery-zoom');
    add_theme_support('wc-product-gallery-lightbox');
    
    register_nav_menus([
        'primary' => __('Primary Menu', 'vancouvertec'),
        'footer' => __('Footer Menu', 'vancouvertec'),
    ]);
    
    load_theme_textdomain('vancouvertec', VT_THEME_DIR . '/languages');
    
    add_image_size('vt-product', 400, 300, true);
    add_image_size('vt-hero', 1200, 600, true);
}
add_action('after_setup_theme', 'vt_theme_setup');

function vt_enqueue_assets() {
    if (!is_admin()) {
        wp_deregister_script('jquery');
        wp_register_script('jquery', 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js', [], '3.6.0', true);
    }
    
    wp_enqueue_style('vt-style', VT_THEME_URI . '/style.css', [], VT_THEME_VERSION);
    wp_enqueue_style('vt-header', VT_THEME_URI . '/assets/css/layouts/header.css', ['vt-style'], VT_THEME_VERSION);
    wp_enqueue_style('vt-footer', VT_THEME_URI . '/assets/css/layouts/footer.css', ['vt-header'], VT_THEME_VERSION);
    wp_enqueue_style('vt-responsive', VT_THEME_URI . '/assets/css/responsive.css', ['vt-footer'], VT_THEME_VERSION);
    wp_enqueue_style('vt-buttons', VT_THEME_URI . '/assets/css/components/buttons.css', ['vt-style'], VT_THEME_VERSION);
    wp_enqueue_style('vt-header', VT_THEME_URI . '/assets/css/layouts/header.css', ['vt-style'], VT_THEME_VERSION);
    wp_enqueue_style('vt-footer', VT_THEME_URI . '/assets/css/layouts/footer.css', ['vt-header'], VT_THEME_VERSION);
    wp_enqueue_style('vt-responsive', VT_THEME_URI . '/assets/css/responsive.css', ['vt-footer'], VT_THEME_VERSION);
    wp_enqueue_style('vt-hero', VT_THEME_URI . '/assets/css/layouts/hero.css', ['vt-buttons'], VT_THEME_VERSION);
    wp_enqueue_style('vt-products', VT_THEME_URI . '/assets/css/components/products.css', ['vt-hero'], VT_THEME_VERSION);
    wp_enqueue_style('vt-testimonials', VT_THEME_URI . '/assets/css/components/testimonials.css', ['vt-products'], VT_THEME_VERSION);
    wp_enqueue_style('vt-cta', VT_THEME_URI . '/assets/css/components/cta.css', ['vt-testimonials'], VT_THEME_VERSION);
    wp_enqueue_script('vt-main', VT_THEME_URI . '/assets/js/main.js', ['jquery'], VT_THEME_VERSION, true);
    wp_enqueue_script('vt-mobile', VT_THEME_URI . '/assets/js/mobile.js', ['vt-main'], VT_THEME_VERSION, true);
    
    wp_localize_script('vt-main', 'vt_ajax', [
        'ajax_url' => admin_url('admin-ajax.php'),
        'nonce' => wp_create_nonce('vt_nonce'),
    ]);
}
add_action('wp_enqueue_scripts', 'vt_enqueue_assets');

function vt_widgets_init() {
    register_sidebar([
        'name' => __('Sidebar', 'vancouvertec'),
        'id' => 'sidebar-1',
        'before_widget' => '<div id="%1$s" class="widget %2$s">',
        'after_widget' => '</div>',
        'before_title' => '<h3 class="widget-title">',
        'after_title' => '</h3>',
    ]);
}
add_action('widgets_init', 'vt_widgets_init');

// Performance
remove_action('wp_head', 'wp_generator');
remove_action('wp_head', 'print_emoji_detection_script', 7);
remove_action('wp_print_styles', 'print_emoji_styles');
