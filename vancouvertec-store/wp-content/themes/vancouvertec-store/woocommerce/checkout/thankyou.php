<?php
/**
 * VancouverTec Store - Thank You Page
 */

if (!defined('ABSPATH')) exit;
?>

<div class="vt-thankyou-page">
    <div class="container">

        <?php if ($order): ?>

            <div class="vt-thankyou-success">
                
                <div class="vt-success-header">
                    <div class="vt-success-icon">✅</div>
                    <h1><?php esc_html_e('Pedido Confirmado!', 'vancouvertec'); ?></h1>
                    <p class="vt-success-message">
                        <?php esc_html_e('Obrigado pelo seu pedido. Você receberá um email de confirmação em breve.', 'vancouvertec'); ?>
                    </p>
                </div>

                <div class="vt-order-summary">
                    <?php if ($order->has_status('failed')): ?>
                        
                        <div class="vt-payment-failed">
                            <h2><?php esc_html_e('Falha no Pagamento', 'vancouvertec'); ?></h2>
                            <p><?php esc_html_e('Infelizmente, seu pedido não pode ser processado devido a uma falha no pagamento. Entre em contato conosco para obter ajuda.', 'vancouvertec'); ?></p>
                            <a href="<?php echo esc_url($order->get_checkout_payment_url()); ?>" class="button pay btn-primary">
                                <?php esc_html_e('Pagar', 'vancouvertec'); ?>
                            </a>
                        </div>

                    <?php else: ?>

                        <div class="vt-order-details">
                            
                            <div class="vt-order-info">
                                <h2><?php esc_html_e('Detalhes do Pedido', 'vancouvertec'); ?></h2>
                                
                                <div class="vt-order-meta">
                                    <div class="vt-meta-item">
                                        <span class="vt-meta-label"><?php esc_html_e('Número do Pedido:', 'vancouvertec'); ?></span>
                                        <span class="vt-meta-value">#<?php echo $order->get_order_number(); ?></span>
                                    </div>
                                    <div class="vt-meta-item">
                                        <span class="vt-meta-label"><?php esc_html_e('Data:', 'vancouvertec'); ?></span>
                                        <span class="vt-meta-value"><?php echo wc_format_datetime($order->get_date_created()); ?></span>
                                    </div>
                                    <div class="vt-meta-item">
                                        <span class="vt-meta-label"><?php esc_html_e('Total:', 'vancouvertec'); ?></span>
                                        <span class="vt-meta-value"><?php echo $order->get_formatted_order_total(); ?></span>
                                    </div>
                                    <?php if ($order->get_payment_method_title()): ?>
                                    <div class="vt-meta-item">
                                        <span class="vt-meta-label"><?php esc_html_e('Método de Pagamento:', 'vancouvertec'); ?></span>
                                        <span class="vt-meta-value"><?php echo wp_kses_post($order->get_payment_method_title()); ?></span>
                                    </div>
                                    <?php endif; ?>
                                </div>
                            </div>

                            <?php do_action('woocommerce_thankyou_order_received_text', $order); ?>

                            <div class="vt-order-actions">
                                <a href="<?php echo esc_url(wc_get_account_endpoint_url('orders')); ?>" class="button btn-primary">
                                    <?php esc_html_e('Ver Pedidos', 'vancouvertec'); ?>
                                </a>
                                
                                <?php if ($order->get_downloadable_items()): ?>
                                <a href="<?php echo esc_url(wc_get_account_endpoint_url('downloads')); ?>" class="button">
                                    <?php esc_html_e('Fazer Downloads', 'vancouvertec'); ?>
                                </a>
                                <?php endif; ?>
                            </div>

                        </div>

                    <?php endif; ?>

                    <div class="vt-order-table">
                        <?php do_action('woocommerce_thankyou_' . $order->get_payment_method(), $order->get_id()); ?>
                        <?php do_action('woocommerce_thankyou', $order->get_id()); ?>
                    </div>

                </div>

            </div>

        <?php else: ?>

            <div class="vt-thankyou-error">
                <h1><?php esc_html_e('Pedido não encontrado', 'vancouvertec'); ?></h1>
                <p><?php esc_html_e('Desculpe, não conseguimos encontrar seu pedido.', 'vancouvertec'); ?></p>
                <a href="<?php echo esc_url(home_url('/')); ?>" class="button btn-primary">
                    <?php esc_html_e('Voltar ao Início', 'vancouvertec'); ?>
                </a>
            </div>

        <?php endif; ?>

    </div>
</div>
