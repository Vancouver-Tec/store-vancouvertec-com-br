<?php
/**
 * Template Name: Checkout VancouverTec
 */

get_header(); ?>

<div class="vt-checkout-page">
    <div class="container">
        <h1 class="vt-page-title">Finalizar Compra</h1>
        
        <div class="vt-checkout-steps">
            <div class="vt-step active">
                <span class="vt-step-number">1</span>
                <span class="vt-step-label">Informações</span>
            </div>
            <div class="vt-step">
                <span class="vt-step-number">2</span>
                <span class="vt-step-label">Pagamento</span>
            </div>
            <div class="vt-step">
                <span class="vt-step-number">3</span>
                <span class="vt-step-label">Confirmação</span>
            </div>
        </div>
        
        <?php if (function_exists('woocommerce_checkout')) : ?>
            <?php echo do_shortcode('[woocommerce_checkout]'); ?>
        <?php else : ?>
            <p>WooCommerce não está ativo.</p>
        <?php endif; ?>
    </div>
</div>

<?php get_footer(); ?>
