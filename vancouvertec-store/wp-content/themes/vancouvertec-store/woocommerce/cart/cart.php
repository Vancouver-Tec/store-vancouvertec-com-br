<?php
/**
 * VancouverTec Store - Shopping Cart
 */

if (!defined('ABSPATH')) exit;

do_action('woocommerce_before_cart'); ?>

<div class="vt-cart-page">
    <div class="container">
        
        <div class="vt-cart-header">
            <h1><?php esc_html_e('Seu Carrinho', 'vancouvertec'); ?></h1>
            <p class="vt-cart-subtitle">
                <?php esc_html_e('Revise seus produtos antes de finalizar', 'vancouvertec'); ?>
            </p>
        </div>

        <form class="woocommerce-cart-form" action="<?php echo esc_url(wc_get_cart_url()); ?>" method="post">
            
            <?php do_action('woocommerce_before_cart_table'); ?>
            
            <div class="vt-cart-content">
                <div class="vt-cart-items">
                    <table class="shop_table cart woocommerce-cart-form__contents" cellspacing="0">
                        <thead>
                            <tr>
                                <th class="product-thumbnail"><?php esc_html_e('Produto', 'vancouvertec'); ?></th>
                                <th class="product-name">&nbsp;</th>
                                <th class="product-price"><?php esc_html_e('Preço', 'vancouvertec'); ?></th>
                                <th class="product-quantity"><?php esc_html_e('Quantidade', 'vancouvertec'); ?></th>
                                <th class="product-subtotal"><?php esc_html_e('Subtotal', 'vancouvertec'); ?></th>
                                <th class="product-remove">&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php do_action('woocommerce_before_cart_contents'); ?>

                            <?php foreach (WC()->cart->get_cart() as $cart_item_key => $cart_item):
                                $_product = apply_filters('woocommerce_cart_item_product', $cart_item['data'], $cart_item, $cart_item_key);
                                $product_id = apply_filters('woocommerce_cart_item_product_id', $cart_item['product_id'], $cart_item, $cart_item_key);

                                if ($_product && $_product->exists() && $cart_item['quantity'] > 0):
                                    $product_permalink = $_product->is_visible() ? $_product->get_permalink($cart_item) : '';
                            ?>
                                <tr class="woocommerce-cart-form__cart-item cart_item">

                                    <td class="product-thumbnail">
                                        <?php
                                        $thumbnail = $_product->get_image();
                                        if (!$product_permalink) {
                                            echo $thumbnail;
                                        } else {
                                            printf('<a href="%s">%s</a>', esc_url($product_permalink), $thumbnail);
                                        }
                                        ?>
                                    </td>

                                    <td class="product-name" data-title="<?php esc_attr_e('Produto', 'vancouvertec'); ?>">
                                        <?php
                                        if (!$product_permalink) {
                                            echo wp_kses_post($_product->get_name());
                                        } else {
                                            echo wp_kses_post(sprintf('<a href="%s">%s</a>', esc_url($product_permalink), $_product->get_name()));
                                        }

                                        do_action('woocommerce_after_cart_item_name', $cart_item, $cart_item_key);
                                        echo wc_get_formatted_cart_item_data($cart_item);

                                        if ($_product->backorders_require_notification() && $_product->is_on_backorder($cart_item['quantity'])) {
                                            echo wp_kses_post('<p class="backorder_notification">' . esc_html__('Disponível em pré-venda', 'vancouvertec') . '</p>');
                                        }
                                        ?>
                                    </td>

                                    <td class="product-price" data-title="<?php esc_attr_e('Preço', 'vancouvertec'); ?>">
                                        <?php echo WC()->cart->get_product_price($_product); ?>
                                    </td>

                                    <td class="product-quantity" data-title="<?php esc_attr_e('Quantidade', 'vancouvertec'); ?>">
                                        <?php
                                        $product_quantity = woocommerce_quantity_input([
                                            'input_name'   => "cart[{$cart_item_key}][qty]",
                                            'input_value'  => $cart_item['quantity'],
                                            'max_value'    => $_product->get_max_purchase_quantity(),
                                            'min_value'    => '0',
                                            'product_name' => $_product->get_name(),
                                        ], $_product, false);

                                        echo $product_quantity;
                                        ?>
                                    </td>

                                    <td class="product-subtotal" data-title="<?php esc_attr_e('Subtotal', 'vancouvertec'); ?>">
                                        <?php echo WC()->cart->get_product_subtotal($_product, $cart_item['quantity']); ?>
                                    </td>

                                    <td class="product-remove">
                                        <?php
                                        echo sprintf(
                                            '<a href="%s" class="remove" aria-label="%s" data-product_id="%s" data-product_sku="%s">&times;</a>',
                                            esc_url(wc_get_cart_remove_url($cart_item_key)),
                                            esc_attr__('Remover este item', 'vancouvertec'),
                                            esc_attr($product_id),
                                            esc_attr($_product->get_sku())
                                        );
                                        ?>
                                    </td>
                                </tr>
                            <?php endif; ?>
                            <?php endforeach; ?>

                            <tr>
                                <td colspan="6" class="actions">
                                    <div class="vt-cart-actions">
                                        <?php if (wc_coupons_enabled()): ?>
                                            <div class="coupon">
                                                <input type="text" name="coupon_code" class="input-text" value="" placeholder="<?php esc_attr_e('Código do cupom', 'vancouvertec'); ?>" />
                                                <button type="submit" class="button" name="apply_coupon" value="<?php esc_attr_e('Aplicar cupom', 'vancouvertec'); ?>">
                                                    <?php esc_html_e('Aplicar cupom', 'vancouvertec'); ?>
                                                </button>
                                            </div>
                                        <?php endif; ?>

                                        <button type="submit" class="button" name="update_cart" value="<?php esc_attr_e('Atualizar carrinho', 'vancouvertec'); ?>">
                                            <?php esc_html_e('Atualizar carrinho', 'vancouvertec'); ?>
                                        </button>

                                        <?php wp_nonce_field('woocommerce-cart', 'woocommerce-cart-nonce'); ?>
                                    </div>
                                </td>
                            </tr>

                            <?php do_action('woocommerce_after_cart_contents'); ?>
                        </tbody>
                    </table>
                </div>
                
                <div class="vt-cart-collaterals">
                    <?php do_action('woocommerce_cart_collaterals'); ?>
                </div>
            </div>

            <?php do_action('woocommerce_after_cart_table'); ?>
        </form>

    </div>
</div>

<?php do_action('woocommerce_after_cart'); ?>

<?php get_footer(); ?>
