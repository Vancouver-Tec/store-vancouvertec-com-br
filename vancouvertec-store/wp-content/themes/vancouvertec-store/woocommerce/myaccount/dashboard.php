<?php
/**
 * VancouverTec Store - My Account Dashboard
 */

if (!defined('ABSPATH')) exit;

$allowed_html = [
    'a' => [
        'href' => [],
    ],
];
?>

<div class="vt-dashboard">
    
    <div class="vt-dashboard-welcome">
        <h2><?php esc_html_e('Dashboard', 'vancouvertec'); ?></h2>
        <p>
            <?php
            printf(
                wp_kses(__('Olá <strong>%1$s</strong>, gerencie sua conta e pedidos aqui.', 'vancouvertec'), $allowed_html),
                esc_html($current_user->display_name)
            );
            ?>
        </p>
    </div>

    <div class="vt-dashboard-stats">
        <?php
        $customer_orders = wc_get_orders([
            'customer' => get_current_user_id(),
            'status' => ['completed', 'processing'],
            'limit' => -1,
        ]);
        
        $downloads_remaining = 0;
        foreach ($customer_orders as $order) {
            $downloads = $order->get_downloadable_items();
            foreach ($downloads as $download) {
                if ($download['downloads_remaining'] !== '') {
                    $downloads_remaining += $download['downloads_remaining'];
                }
            }
        }
        ?>
        
        <div class="vt-stat-grid">
            <div class="vt-stat-item">
                <span class="vt-stat-icon">📦</span>
                <div class="vt-stat-content">
                    <span class="vt-stat-number"><?php echo count($customer_orders); ?></span>
                    <span class="vt-stat-label"><?php esc_html_e('Pedidos', 'vancouvertec'); ?></span>
                </div>
            </div>
            
            <div class="vt-stat-item">
                <span class="vt-stat-icon">⬇️</span>
                <div class="vt-stat-content">
                    <span class="vt-stat-number"><?php echo $downloads_remaining; ?></span>
                    <span class="vt-stat-label"><?php esc_html_e('Downloads', 'vancouvertec'); ?></span>
                </div>
            </div>
            
            <div class="vt-stat-item">
                <span class="vt-stat-icon">🎯</span>
                <div class="vt-stat-content">
                    <span class="vt-stat-number">24/7</span>
                    <span class="vt-stat-label"><?php esc_html_e('Suporte', 'vancouvertec'); ?></span>
                </div>
            </div>
        </div>
    </div>

    <div class="vt-dashboard-actions">
        <p>
            <?php
            printf(
                wp_kses(__('Na sua conta você pode <a href="%1$s">ver seus pedidos recentes</a>, gerenciar seus <a href="%2$s">endereços de cobrança</a> e <a href="%3$s">editar sua senha e dados da conta</a>.', 'vancouvertec'), $allowed_html),
                esc_url(wc_get_account_endpoint_url('orders')),
                esc_url(wc_get_account_endpoint_url('edit-address')),
                esc_url(wc_get_account_endpoint_url('edit-account'))
            );
            ?>
        </p>
        
        <div class="vt-quick-actions">
            <a href="<?php echo esc_url(wc_get_account_endpoint_url('orders')); ?>" class="button btn-primary">
                <?php esc_html_e('Ver Pedidos', 'vancouvertec'); ?>
            </a>
            <a href="<?php echo esc_url(wc_get_account_endpoint_url('downloads')); ?>" class="button">
                <?php esc_html_e('Meus Downloads', 'vancouvertec'); ?>
            </a>
        </div>
    </div>

</div>

<?php do_action('woocommerce_account_dashboard'); ?>
