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
