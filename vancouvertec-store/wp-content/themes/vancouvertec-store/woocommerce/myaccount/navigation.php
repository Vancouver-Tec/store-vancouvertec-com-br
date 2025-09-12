<?php
/**
 * VancouverTec Store - My Account Navigation
 */

if (!defined('ABSPATH')) exit;

do_action('woocommerce_before_account_navigation');
?>

<nav class="woocommerce-MyAccount-navigation vt-account-nav">
    <ul class="vt-nav-list">
        <?php foreach (wc_get_account_menu_items() as $endpoint => $label): ?>
            <li class="vt-nav-item <?php echo wc_get_account_menu_item_classes($endpoint); ?>">
                <a href="<?php echo esc_url(wc_get_account_endpoint_url($endpoint)); ?>" class="vt-nav-link">
                    
                    <?php // Adicionar ícones para cada seção ?>
                    <span class="vt-nav-icon">
                        <?php
                        switch ($endpoint) {
                            case 'dashboard': echo '🏠'; break;
                            case 'orders': echo '📦'; break;
                            case 'downloads': echo '⬇️'; break;
                            case 'edit-address': echo '📍'; break;
                            case 'edit-account': echo '👤'; break;
                            case 'customer-logout': echo '🚪'; break;
                            default: echo '📄'; break;
                        }
                        ?>
                    </span>
                    
                    <span class="vt-nav-text"><?php echo esc_html($label); ?></span>
                </a>
            </li>
        <?php endforeach; ?>
    </ul>
</nav>

<?php do_action('woocommerce_after_account_navigation'); ?>
