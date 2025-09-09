<?php get_header(); ?>

<div class="vt-shop-page">
    <div class="container">
        <div class="vt-shop-header">
            <h1 class="vt-shop-title"><?php woocommerce_page_title(); ?></h1>
            <div class="vt-shop-controls">
                <?php woocommerce_catalog_ordering(); ?>
                <?php woocommerce_result_count(); ?>
            </div>
        </div>
        
        <div class="vt-shop-content">
            <aside class="vt-shop-sidebar">
                <div class="vt-widget">
                    <h3>Categorias</h3>
                    <?php the_widget('WC_Widget_Product_Categories'); ?>
                </div>
                <div class="vt-widget">
                    <h3>Filtrar por Preço</h3>
                    <?php the_widget('WC_Widget_Price_Filter'); ?>
                </div>
            </aside>
            
            <main class="vt-shop-main">
                <?php if (woocommerce_product_loop()) : ?>
                    <div class="vt-products-grid">
                        <?php woocommerce_product_loop_start(); ?>
                        <?php while (have_posts()) : the_post(); ?>
                            <?php wc_get_template_part('content', 'product'); ?>
                        <?php endwhile; ?>
                        <?php woocommerce_product_loop_end(); ?>
                    </div>
                    <?php woocommerce_pagination(); ?>
                <?php else : ?>
                    <p>Nenhum produto encontrado.</p>
                <?php endif; ?>
            </main>
        </div>
    </div>
</div>

<?php get_footer(); ?>
