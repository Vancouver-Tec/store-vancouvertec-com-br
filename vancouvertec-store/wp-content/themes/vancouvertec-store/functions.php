<?php
/**
 * VancouverTec Store Theme Functions
 * @package VancouverTec_Store
 * @version 1.0.0
 */

if (!defined('ABSPATH')) exit;

define('VT_THEME_VERSION', '1.0.0');
define('VT_THEME_DIR', get_template_directory());
define('VT_THEME_URI', get_template_directory_uri());

function vt_theme_setup() {
    add_theme_support('post-thumbnails');
    add_theme_support('title-tag');
    add_theme_support('custom-logo');
    add_theme_support('html5', array('search-form', 'comment-form', 'comment-list', 'gallery', 'caption'));
    add_theme_support('customize-selective-refresh-widgets');
    
    // WooCommerce support
    add_theme_support('woocommerce');
    add_theme_support('wc-product-gallery-zoom');
    add_theme_support('wc-product-gallery-lightbox');
    add_theme_support('wc-product-gallery-slider');
    
    register_nav_menus(array(
        'primary' => __('Primary Menu', 'vancouvertec'),
        'footer' => __('Footer Menu', 'vancouvertec'),
    ));
    
    load_theme_textdomain('vancouvertec', VT_THEME_DIR . '/languages');
}
add_action('after_setup_theme', 'vt_theme_setup');

function vt_enqueue_assets() {
    wp_enqueue_style('vt-style', VT_THEME_URI . '/style.css', array(), VT_THEME_VERSION);
    wp_enqueue_style('vt-main', VT_THEME_URI . '/assets/css/main.css', array('vt-style'), VT_THEME_VERSION);
    wp_enqueue_script('vt-main', VT_THEME_URI . '/assets/js/main.js', array('jquery'), VT_THEME_VERSION, true);
    wp_localize_script('vt-main', 'vt_ajax', array(
        'ajax_url' => admin_url('admin-ajax.php'),
        'nonce' => wp_create_nonce('vt_nonce'),
    ));
}
add_action('wp_enqueue_scripts', 'vt_enqueue_assets');

function vt_performance_optimizations() {
    wp_deregister_script('wp-embed');
    if (!is_admin() && !is_customize_preview()) {
        wp_deregister_script('jquery');
        wp_register_script('jquery', 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js', false, '3.6.0', true);
        wp_enqueue_script('jquery');
    }
}
add_action('wp_enqueue_scripts', 'vt_performance_optimizations');
