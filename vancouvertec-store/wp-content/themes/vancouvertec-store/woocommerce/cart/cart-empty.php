<?php
/**
 * VancouverTec Store - Empty Cart
 */

if (!defined('ABSPATH')) exit;

wc_print_notices();

do_action('woocommerce_cart_is_empty');

if (wc_get_page_id('shop') > 0): ?>
    <div class="vt-empty-cart">
        <div class="container">
            <div class="vt-empty-content">
                <div class="vt-empty-icon">🛒</div>
                <h2><?php esc_html_e('Seu carrinho está vazio', 'vancouvertec'); ?></h2>
                <p><?php esc_html_e('Adicione produtos incríveis ao seu carrinho e finalize sua compra.', 'vancouvertec'); ?></p>
                
                <div class="vt-empty-actions">
                    <a class="button wc-backward btn-primary" href="<?php echo esc_url(apply_filters('woocommerce_return_to_shop_redirect', wc_get_page_permalink('shop'))); ?>">
                        <?php esc_html_e('Continuar Comprando', 'vancouvertec'); ?>
                    </a>
                </div>
                
                <div class="vt-why-choose">
                    <h3><?php esc_html_e('Por que escolher a VancouverTec?', 'vancouvertec'); ?></h3>
                    <div class="vt-benefits">
                        <div class="vt-benefit">
                            <span class="vt-icon">⚡</span>
                            <span><?php esc_html_e('Download Imediato', 'vancouvertec'); ?></span>
                        </div>
                        <div class="vt-benefit">
                            <span class="vt-icon">🎯</span>
                            <span><?php esc_html_e('Suporte Especializado', 'vancouvertec'); ?></span>
                        </div>
                        <div class="vt-benefit">
                            <span class="vt-icon">🔒</span>
                            <span><?php esc_html_e('Pagamento 100% Seguro', 'vancouvertec'); ?></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<?php endif; ?>
