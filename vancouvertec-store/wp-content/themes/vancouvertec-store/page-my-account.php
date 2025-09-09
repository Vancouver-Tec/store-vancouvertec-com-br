<?php
/**
 * Template Name: My Account VancouverTec
 */

get_header(); ?>

<div class="vt-account-page">
    <div class="container">
        <h1 class="vt-page-title">Minha Conta</h1>
        
        <?php if (function_exists('woocommerce_account_content')) : ?>
            <?php echo do_shortcode('[woocommerce_my_account]'); ?>
        <?php else : ?>
            <p>WooCommerce não está ativo.</p>
        <?php endif; ?>
    </div>
</div>

<?php get_footer(); ?>
