<?php
/**
 * VancouverTec Store - Checkout Form
 */

if (!defined('ABSPATH')) exit;

do_action('woocommerce_before_checkout_form', $checkout);

if (!$checkout->is_registration_enabled() && $checkout->is_registration_required() && !is_user_logged_in()) {
    echo esc_html__('Você deve estar logado para finalizar a compra.', 'vancouvertec');
    return;
}
?>

<div class="vt-checkout-page">
    <div class="container">
        
        <div class="vt-checkout-header">
            <h1><?php esc_html_e('Finalizar Compra', 'vancouvertec'); ?></h1>
            <div class="vt-checkout-steps">
                <div class="vt-step active">
                    <span class="step-number">1</span>
                    <span class="step-label"><?php esc_html_e('Informações', 'vancouvertec'); ?></span>
                </div>
                <div class="vt-step-separator"></div>
                <div class="vt-step">
                    <span class="step-number">2</span>
                    <span class="step-label"><?php esc_html_e('Pagamento', 'vancouvertec'); ?></span>
                </div>
                <div class="vt-step-separator"></div>
                <div class="vt-step">
                    <span class="step-number">3</span>
                    <span class="step-label"><?php esc_html_e('Confirmação', 'vancouvertec'); ?></span>
                </div>
            </div>
        </div>

        <form name="checkout" method="post" class="checkout woocommerce-checkout" action="<?php echo esc_url(wc_get_checkout_url()); ?>" enctype="multipart/form-data">

            <div class="vt-checkout-content">
                
                <?php if ($checkout->get_checkout_fields()): ?>
                    <div class="vt-checkout-billing">
                        
                        <?php do_action('woocommerce_checkout_before_customer_details'); ?>

                        <div class="col2-set" id="customer_details">
                            <div class="col-1">
                                <?php do_action('woocommerce_checkout_billing'); ?>
                            </div>

                            <div class="col-2">
                                <?php do_action('woocommerce_checkout_shipping'); ?>
                            </div>
                        </div>

                        <?php do_action('woocommerce_checkout_after_customer_details'); ?>

                    </div>
                <?php endif; ?>
                
                <div class="vt-checkout-review">
                    
                    <?php do_action('woocommerce_checkout_before_order_review_heading'); ?>
                    
                    <h3 id="order_review_heading" class="vt-section-title">
                        <?php esc_html_e('Seu Pedido', 'vancouvertec'); ?>
                    </h3>
                    
                    <?php do_action('woocommerce_checkout_before_order_review'); ?>

                    <div id="order_review" class="woocommerce-checkout-review-order">
                        <?php do_action('woocommerce_checkout_order_review'); ?>
                    </div>

                    <?php do_action('woocommerce_checkout_after_order_review'); ?>
                    
                </div>
                
            </div>

        </form>

        <div class="vt-checkout-security">
            <div class="vt-security-badges">
                <div class="vt-security-item">
                    <span class="vt-icon">🔒</span>
                    <span><?php esc_html_e('SSL 256-bits', 'vancouvertec'); ?></span>
                </div>
                <div class="vt-security-item">
                    <span class="vt-icon">💳</span>
                    <span><?php esc_html_e('Pagamento Seguro', 'vancouvertec'); ?></span>
                </div>
                <div class="vt-security-item">
                    <span class="vt-icon">📞</span>
                    <span><?php esc_html_e('Suporte 24h', 'vancouvertec'); ?></span>
                </div>
            </div>
        </div>

    </div>
</div>

<?php do_action('woocommerce_after_checkout_form', $checkout); ?>

<?php get_footer(); ?>
