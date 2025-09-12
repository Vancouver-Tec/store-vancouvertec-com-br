<?php
/**
 * VancouverTec Store - Single Product Content
 */

if (!defined('ABSPATH')) exit;

global $product;

do_action('woocommerce_before_single_product');

if (post_password_required()) {
    echo get_the_password_form();
    return;
}
?>

<div id="product-<?php the_ID(); ?>" <?php wc_product_class('vt-single-product', $product); ?>>

    <div class="vt-product-container">
        
        <div class="vt-product-gallery-wrapper">
            <?php do_action('woocommerce_before_single_product_summary'); ?>
        </div>

        <div class="vt-product-summary-wrapper">
            <?php do_action('woocommerce_single_product_summary'); ?>
        </div>

    </div>

    <div class="vt-product-details">
        <?php do_action('woocommerce_after_single_product_summary'); ?>
    </div>

</div>

<?php do_action('woocommerce_after_single_product'); ?>
