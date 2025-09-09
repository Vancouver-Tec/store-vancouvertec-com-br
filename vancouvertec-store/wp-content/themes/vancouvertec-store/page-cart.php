<?php
/**
 * Template Name: Cart VancouverTec
 */

get_header(); ?>

<div class="vt-cart-page">
    <div class="container">
        <h1 class="vt-page-title">Carrinho de Compras</h1>
        
        <?php if (function_exists('woocommerce_cart_totals')) : ?>
            <?php echo do_shortcode('[woocommerce_cart]'); ?>
        <?php else : ?>
            <p>WooCommerce não está ativo.</p>
        <?php endif; ?>
    </div>
</div>

<?php get_footer(); ?>
