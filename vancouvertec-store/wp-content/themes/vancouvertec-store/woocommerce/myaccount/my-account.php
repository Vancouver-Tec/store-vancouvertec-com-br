<?php
if (!defined('ABSPATH')) exit;

do_action('woocommerce_before_account_navigation');
?>

<div class="vt-account-page">
    <div class="container">
        <h1 class="vt-page-title">Minha Conta</h1>
        <p class="vt-account-welcome">Olá, <?php echo esc_html($current_user->display_name); ?>!</p>

        <div class="vt-account-content">
            <nav class="woocommerce-MyAccount-navigation">
                <ul>
                    <?php foreach (wc_get_account_menu_items() as $endpoint => $label) : ?>
                        <li class="<?php echo wc_get_account_menu_item_classes($endpoint); ?>">
                            <a href="<?php echo esc_url(wc_get_account_endpoint_url($endpoint)); ?>" class="vt-account-nav-link">
                                <?php 
                                $icons = array(
                                    'dashboard' => '🏠',
                                    'orders' => '📦',
                                    'downloads' => '⬇️',
                                    'edit-address' => '📍',
                                    'edit-account' => '👤',
                                    'customer-logout' => '🚪'
                                );
                                echo isset($icons[$endpoint]) ? $icons[$endpoint] . ' ' : '';
                                echo esc_html($label); 
                                ?>
                            </a>
                        </li>
                    <?php endforeach; ?>
                </ul>
            </nav>

            <div class="woocommerce-MyAccount-content">
                <?php do_action('woocommerce_account_content'); ?>
            </div>
        </div>
    </div>
</div>
