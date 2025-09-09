<?php
defined('ABSPATH') || exit;
do_action('woocommerce_before_cart'); ?>

<div class="vt-cart-page">
    <div class="container">
        <h1 class="vt-page-title">Carrinho de Compras</h1>
        
        <form class="woocommerce-cart-form" action="<?php echo esc_url(wc_get_cart_url()); ?>" method="post">
            <div class="vt-cart-content">
                <div class="vt-cart-items">
                    <table class="shop_table vt-cart-table">
                        <thead>
                            <tr>
                                <th>Produto</th>
                                <th>Preço</th>
                                <th>Quantidade</th>
                                <th>Subtotal</th>
                                <th></th>
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
                                        <td class="product-info">
                                            <?php echo apply_filters('woocommerce_cart_item_thumbnail', $_product->get_image(), $cart_item, $cart_item_key); ?>
                                            <div class="product-details">
                                                <h4><?php echo $_product->get_name(); ?></h4>
                                            </div>
                                        </td>
                                        <td class="product-price">
                                            <?php echo apply_filters('woocommerce_cart_item_price', WC()->cart->get_product_price($_product), $cart_item, $cart_item_key); ?>
                                        </td>
                                        <td class="product-quantity">
                                            <?php
                                            if ($_product->is_sold_individually()) {
                                                $product_quantity = sprintf('1 <input type="hidden" name="cart[%s][qty]" value="1" />', $cart_item_key);
                                            } else {
                                                $product_quantity = woocommerce_quantity_input(array(
                                                    'input_name'   => "cart[{$cart_item_key}][qty]",
                                                    'input_value'  => $cart_item['quantity'],
                                                    'max_value'    => $_product->get_max_purchase_quantity(),
                                                    'min_value'    => '0',
                                                    'product_name' => $_product->get_name(),
                                                ), $_product, false);
                                            }
                                            echo apply_filters('woocommerce_cart_item_quantity', $product_quantity, $cart_item_key, $cart_item);
                                            ?>
                                        </td>
                                        <td class="product-subtotal">
                                            <?php echo apply_filters('woocommerce_cart_item_subtotal', WC()->cart->get_product_subtotal($_product, $cart_item['quantity']), $cart_item, $cart_item_key); ?>
                                        </td>
                                        <td class="product-remove">
                                            <?php
                                                echo apply_filters('woocommerce_cart_item_remove_link', sprintf(
                                                    '<a href="%s" class="remove" aria-label="Remover item">×</a>',
                                                    esc_url(wc_get_cart_remove_url($cart_item_key))
                                                ), $cart_item_key);
                                            ?>
                                        </td>
                                    </tr>
                                    <?php
                                }
                            } ?>

                            <tr>
                                <td colspan="5" class="actions">
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
