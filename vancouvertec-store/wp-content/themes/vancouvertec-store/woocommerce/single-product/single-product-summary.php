<?php
/**
 * VancouverTec Store - Single Product Summary CORRIGIDO
 */

if (!defined('ABSPATH')) exit;

global $product;
?>

<div class="vt-product-summary summary entry-summary">
    
    <div class="vt-product-header">
        <h1 class="product_title entry-title"><?php echo $product->get_name(); ?></h1>
        
        <div class="vt-product-badges">
            <?php if ($product->is_on_sale()): ?>
                <span class="vt-badge vt-sale-badge">Promoção</span>
            <?php endif; ?>
            
            <?php if ($product->is_featured()): ?>
                <span class="vt-badge vt-featured-badge">Destaque</span>
            <?php endif; ?>
        </div>
    </div>
    
    <div class="vt-price-section">
        <div class="price-wrapper">
            <?php echo $product->get_price_html(); ?>
        </div>
        
        <?php if ($product->get_price()): ?>
            <div class="vt-payment-info">
                <span class="vt-installments">
                    <?php 
                    $price = $product->get_price();
                    $installment = $price / 12;
                    printf('ou 12x de %s sem juros', wc_price($installment));
                    ?>
                </span>
            </div>
        <?php endif; ?>
    </div>
    
    <div class="vt-product-description">
        <?php echo $product->get_short_description(); ?>
    </div>
    
    <div class="vt-product-form">
        <?php woocommerce_template_single_add_to_cart(); ?>
    </div>
    
    <div class="vt-trust-badges">
        <div class="vt-trust-item">
            <span class="vt-icon">🔒</span>
            <span>Compra 100% Segura</span>
        </div>
        <div class="vt-trust-item">
            <span class="vt-icon">⚡</span>
            <span>Download Imediato</span>
        </div>
        <div class="vt-trust-item">
            <span class="vt-icon">🎯</span>
            <span>Suporte Especializado</span>
        </div>
        <div class="vt-trust-item">
            <span class="vt-icon">🚀</span>
            <span>Performance 99+</span>
        </div>
    </div>
    
    <?php echo do_shortcode('[vt_specifications]'); ?>
    
</div>
