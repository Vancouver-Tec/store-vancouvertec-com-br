#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce Shop + Account Templates
# Script: 31a2-woo-shop-account.sh
# Versão: 1.0.0 - Shop e Account Templates
# ===========================================

set -euo pipefail

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Variáveis
PROJECT_PATH="/home/$(whoami)/vancouvertec/store-vancouvertec-com-br/vancouvertec-store"
THEME_PATH="wp-content/themes/vancouvertec-store"
WC_TEMPLATES_PATH="${THEME_PATH}/woocommerce"

# Funções de log
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║  🏪 Templates Override - PARTE 2 (Shop)     ║
║         Shop + Account + Thank You           ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar base
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Execute antes: 31a1-woo-cart-checkout.sh"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Criando templates shop/account em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost:8080" > /dev/null; then
    log_warning "Parando servidor..."
    pkill -f "php -S localhost:8080" || true
    sleep 2
fi

# Criar estrutura account/checkout
log_info "Criando estrutura account e checkout..."
mkdir -p "${WC_TEMPLATES_PATH}"/{account,checkout,emails}

# 1. Template archive-product.php (Shop)
log_info "Atualizando archive-product.php..."
cat > "${WC_TEMPLATES_PATH}/archive-product.php" << 'EOF'
<?php
/**
 * VancouverTec Store - Products Archive
 */

if (!defined('ABSPATH')) exit;

get_header('shop');

do_action('woocommerce_before_main_content');
?>

<div class="vt-shop-page">
    <div class="container">
        
        <div class="vt-shop-header">
            <?php if (apply_filters('woocommerce_show_page_title', true)): ?>
                <h1 class="vt-page-title"><?php woocommerce_page_title(); ?></h1>
            <?php endif; ?>
            
            <?php do_action('woocommerce_archive_description'); ?>
        </div>

        <?php if (woocommerce_product_loop()): ?>

            <div class="vt-shop-toolbar">
                <?php do_action('woocommerce_before_shop_loop'); ?>
            </div>
            
            <div class="vt-products-grid">
                <?php
                woocommerce_product_loop_start();
                
                while (have_posts()) {
                    the_post();
                    do_action('woocommerce_shop_loop');
                    wc_get_template_part('content', 'product');
                }
                
                woocommerce_product_loop_end();
                ?>
            </div>

            <div class="vt-shop-pagination">
                <?php do_action('woocommerce_after_shop_loop'); ?>
            </div>

        <?php else: ?>

            <div class="vt-no-products">
                <div class="vt-empty-content">
                    <div class="vt-empty-icon">🔍</div>
                    <h2><?php esc_html_e('Nenhum produto encontrado', 'vancouvertec'); ?></h2>
                    <p><?php esc_html_e('Tente ajustar seus filtros ou navegar pelas categorias.', 'vancouvertec'); ?></p>
                    
                    <div class="vt-empty-actions">
                        <a href="<?php echo esc_url(home_url('/')); ?>" class="button btn-primary">
                            <?php esc_html_e('Voltar ao Início', 'vancouvertec'); ?>
                        </a>
                    </div>
                </div>
            </div>

        <?php endif; ?>

    </div>
</div>

<?php
do_action('woocommerce_after_main_content');
get_footer('shop');
?>
EOF

# 2. Template my-account/my-account.php
log_info "Criando account/my-account.php..."
cat > "${WC_TEMPLATES_PATH}/myaccount/my-account.php" << 'EOF'
<?php
/**
 * VancouverTec Store - My Account
 */

if (!defined('ABSPATH')) exit;

wc_print_notices(); ?>

<div class="vt-my-account">
    <div class="container">
        
        <div class="vt-account-header">
            <h1><?php esc_html_e('Minha Conta', 'vancouvertec'); ?></h1>
            <p class="vt-account-subtitle">
                <?php 
                $user = wp_get_current_user();
                printf(esc_html__('Bem-vindo, %s!', 'vancouvertec'), $user->display_name); 
                ?>
            </p>
        </div>

        <div class="vt-account-content">
            
            <div class="vt-account-navigation">
                <?php do_action('woocommerce_account_navigation'); ?>
            </div>

            <div class="vt-account-main">
                <div class="woocommerce-MyAccount-content">
                    <?php do_action('woocommerce_account_content'); ?>
                </div>
            </div>

        </div>

    </div>
</div>
EOF

# 3. Template my-account/navigation.php
log_info "Criando account/navigation.php..."
cat > "${WC_TEMPLATES_PATH}/myaccount/navigation.php" << 'EOF'
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
EOF

# 4. Template my-account/dashboard.php
log_info "Criando account/dashboard.php..."
cat > "${WC_TEMPLATES_PATH}/myaccount/dashboard.php" << 'EOF'
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
EOF

# 5. Template checkout/thankyou.php
log_info "Criando checkout/thankyou.php..."
cat > "${WC_TEMPLATES_PATH}/checkout/thankyou.php" << 'EOF'
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
EOF

# Iniciar servidor
log_info "Iniciando servidor..."
nohup php -S localhost:8080 router.php > server.log 2>&1 &
echo $! > .server_pid
sleep 3

# Verificar arquivos criados
created_files=(
    "${WC_TEMPLATES_PATH}/archive-product.php"
    "${WC_TEMPLATES_PATH}/myaccount/my-account.php"
    "${WC_TEMPLATES_PATH}/myaccount/navigation.php"
    "${WC_TEMPLATES_PATH}/myaccount/dashboard.php"
    "${WC_TEMPLATES_PATH}/checkout/thankyou.php"
)

for file in "${created_files[@]}"; do
    if [[ -f "$file" ]]; then
        log_success "✅ $(basename "$file")"
    else
        log_error "❌ $(basename "$file")"
    fi
done

# Relatório
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║     ✅ TEMPLATES SHOP/ACCOUNT CRIADOS! ✅    ║"
echo -e "║                                              ║"
echo -e "║  🏪 archive-product.php (Shop)              ║"
echo -e "║  👤 myaccount/my-account.php                ║"  
echo -e "║  🧭 myaccount/navigation.php                ║"
echo -e "║  📊 myaccount/dashboard.php                 ║"
echo -e "║  🎉 checkout/thankyou.php                   ║"
echo -e "║                                              ║"
echo -e "║  Features:                                   ║"
echo -e "║  • Dashboard com estatísticas                ║"
echo -e "║  • Navegação com ícones                      ║"
echo -e "║  • Thank you page personalizada              ║"
echo -e "║  • Shop com grid responsivo                  ║"
echo -e "║                                              ║"
echo -e "║  🌐 Servidor: http://localhost:8080          ║"
echo -e "║                                              ║"
echo -e "║  ➡️  Próximo: 31b-woo-css-vancouvertec.sh    ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_info "Execute para continuar:"
echo -e "${BLUE}chmod +x 31b-woo-css-vancouvertec.sh && ./31b-woo-css-vancouvertec.sh${NC}"