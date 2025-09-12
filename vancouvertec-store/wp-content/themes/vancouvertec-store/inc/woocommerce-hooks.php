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
