<?php
/**
 * VancouverTec Store - Product Loop Content
 */

if (!defined('ABSPATH')) exit;

global $product;

if (empty($product) || !$product->is_visible()) {
    return;
}
?>

<li <?php wc_product_class('vt-product-card', $product); ?>>
    
    <div class="vt-product-image">
        <?php
        do_action('woocommerce_before_shop_loop_item');
        do_action('woocommerce_before_shop_loop_item_title');
        ?>
        
        <div class="vt-product-badges">
            <?php if ($product->is_on_sale()): ?>
                <span class="vt-badge vt-sale-badge">Oferta</span>
            <?php endif; ?>
            <?php if ($product->is_featured()): ?>
                <span class="vt-badge vt-featured-badge">Destaque</span>
            <?php endif; ?>
        </div>
    </div>
    
    <div class="vt-product-content">
        <div class="vt-product-info">
            <?php do_action('woocommerce_shop_loop_item_title'); ?>
        </div>
        
        <div class="vt-product-price">
            <?php do_action('woocommerce_after_shop_loop_item_title'); ?>
        </div>
        
        <div class="vt-product-actions">
            <?php do_action('woocommerce_after_shop_loop_item'); ?>
        </div>
    </div>

</li>
