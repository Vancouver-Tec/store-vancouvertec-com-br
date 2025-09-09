<?php
if (!defined('ABSPATH')) exit;

do_action('woocommerce_before_checkout_form', $checkout);

if (!$checkout->is_registration_enabled() && $checkout->is_registration_required() && !is_user_logged_in()) {
    echo esc_html(apply_filters('woocommerce_checkout_must_be_logged_in_message', __('Você deve estar logado para finalizar a compra.', 'vancouvertec')));
    return;
}
?>

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

        <form name="checkout" method="post" class="checkout woocommerce-checkout" action="<?php echo esc_url(wc_get_checkout_url()); ?>" enctype="multipart/form-data">

            <div class="vt-checkout-content">
                <div class="vt-checkout-form">
                    <?php if ($checkout->get_checkout_fields()) : ?>
                        <?php do_action('woocommerce_checkout_before_customer_details'); ?>

                        <div class="vt-customer-details">
                            <div class="vt-billing-fields">
                                <h3>Informações de Cobrança</h3>
                                <?php do_action('woocommerce_checkout_billing'); ?>
                            </div>

                            <?php if (WC()->cart->needs_shipping_address()) : ?>
                                <div class="vt-shipping-fields">
                                    <h3>Informações de Entrega</h3>
                                    <?php do_action('woocommerce_checkout_shipping'); ?>
                                </div>
                            <?php endif; ?>
                        </div>

                        <?php do_action('woocommerce_checkout_after_customer_details'); ?>
                    <?php endif; ?>
                </div>

                <div class="vt-order-review">
                    <h3>Seu Pedido</h3>
                    <?php do_action('woocommerce_checkout_before_order_review_heading'); ?>
                    <?php do_action('woocommerce_checkout_before_order_review'); ?>

                    <div id="order_review" class="woocommerce-checkout-review-order">
                        <?php do_action('woocommerce_checkout_order_review'); ?>
                    </div>

                    <?php do_action('woocommerce_checkout_after_order_review'); ?>
                </div>
            </div>
        </form>
    </div>
</div>

<?php do_action('woocommerce_after_checkout_form', $checkout); ?>
