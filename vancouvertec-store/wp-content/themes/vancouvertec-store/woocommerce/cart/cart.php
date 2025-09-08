<?php
defined('ABSPATH') || exit;
do_action('woocommerce_before_cart'); ?>

<div class="vt-cart-page">
    <div class="container">
        <h1 class="vt-cart-title">Carrinho de Compras</h1>
        
        <form class="woocommerce-cart-form" action="<?php echo esc_url(wc_get_cart_url()); ?>" method="post">
            <div class="vt-cart-content">
                <div class="vt-cart-items">
                    <table class="shop_table vt-cart-table">
                        <thead>
                            <tr>
                                <th class="product-thumbnail">Produto</th>
                                <th class="product-name"></th>
                                <th class="product-price">Preço</th>
                                <th class="product-quantity">Quantidade</th>
                                <th class="product-subtotal">Subtotal</th>
                                <th class="product-remove"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php do_action('woocommerce_before_cart_contents'); ?>

                            <?php foreach (WC()->cart->get_cart() as $cart_item_key => $cart_item) {
                                $_product = apply_filters('woocommerce_cart_item_product', $cart_item['data'], $cart_item, $cart_item_key);
                                $product_id = apply_filters('woocommerce_cart_item_product_id', $cart_item['product_id'], $cart_item, $cart_item_key);

                                if ($_product && $_product->exists() && $cart_item['quantity'] > 0 && apply_filters('woocommerce_cart_item_visible', true, $cart_item, $cart_item_key)) {
                                    $product_permalink = apply_filters('woocommerce_cart_item_permalink', $_product->is_visible() ? $_product->get_permalink($cart_item) : '', $cart_item, $cart_item_key);
                                    ?>
                                    <tr class="woocommerce-cart-form__cart-item">
                                        <td class="product-thumbnail">
                                            <?php echo apply_filters('woocommerce_cart_item_thumbnail', $_product->get_image(), $cart_item, $cart_item_key); ?>
                                        </td>
                                        <td class="product-name" data-title="Produto">
                                            <?php
                                            if (!$product_permalink) {
                                                echo wp_kses_post(apply_filters('woocommerce_cart_item_name', $_product->get_name(), $cart_item, $cart_item_key) . '&nbsp;');
                                            } else {
                                                echo wp_kses_post(apply_filters('woocommerce_cart_item_name', sprintf('<a href="%s">%s</a>', esc_url($product_permalink), $_product->get_name()), $cart_item, $cart_item_key));
                                            }
                                            ?>
                                        </td>
                                        <td class="product-price" data-title="Preço">
                                            <?php echo apply_filters('woocommerce_cart_item_price', WC()->cart->get_product_price($_product), $cart_item, $cart_item_key); ?>
                                        </td>
                                        <td class="product-quantity" data-title="Quantidade">
                                            <?php
                                            if ($_product->is_sold_individually()) {
                                                $product_quantity = sprintf('1 <input type="hidden" name="cart[%s][qty]" value="1" />', $cart_item_key);
                                            } else {
                                                $product_quantity = woocommerce_quantity_input(
                                                    array(
                                                        'input_name'   => "cart[{$cart_item_key}][qty]",
                                                        'input_value'  => $cart_item['quantity'],
                                                        'max_value'    => $_product->get_max_purchase_quantity(),
                                                        'min_value'    => '0',
                                                        'product_name' => $_product->get_name(),
                                                    ),
                                                    $_product,
                                                    false
                                                );
                                            }
                                            echo apply_filters('woocommerce_cart_item_quantity', $product_quantity, $cart_item_key, $cart_item);
                                            ?>
                                        </td>
                                        <td class="product-subtotal" data-title="Subtotal">
                                            <?php echo apply_filters('woocommerce_cart_item_subtotal', WC()->cart->get_product_subtotal($_product, $cart_item['quantity']), $cart_item, $cart_item_key); ?>
                                        </td>
                                        <td class="product-remove">
                                            <?php
                                                echo apply_filters(
                                                    'woocommerce_cart_item_remove_link',
                                                    sprintf(
                                                        '<a href="%s" class="remove" aria-label="Remover item" data-product_id="%s" data-product_sku="%s">×</a>',
                                                        esc_url(wc_get_cart_remove_url($cart_item_key)),
                                                        esc_attr($product_id),
                                                        esc_attr($_product->get_sku())
                                                    ),
                                                    $cart_item_key
                                                );
                                            ?>
                                        </td>
                                    </tr>
                                    <?php
                                }
                            } ?>

                            <tr>
                                <td colspan="6" class="actions">
                                    <div class="vt-cart-actions">
                                        <button type="submit" class="button update-cart" name="update_cart" value="Atualizar carrinho">
                                            Atualizar carrinho
                                        </button>
                                        
                                        <a href="<?php echo esc_url(apply_filters('woocommerce_return_to_shop_redirect', wc_get_page_permalink('shop'))); ?>" class="continue-shopping">
                                            ← Continuar Comprando
                                        </a>
                                    </div>
                                    <?php wp_nonce_field('woocommerce-cart', 'woocommerce-cart-nonce'); ?>
                                </td>
                            </tr>

                            <?php do_action('woocommerce_after_cart_contents'); ?>
                        </tbody>
                    </table>
                </div>

                <div class="vt-cart-totals">
                    <?php do_action('woocommerce_cart_collaterals'); ?>
                </div>
            </div>
        </form>
    </div>
</div>

<?php do_action('woocommerce_after_cart'); ?>
