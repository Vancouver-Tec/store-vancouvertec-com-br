<?php get_header(); ?>

<div class="single-product">
    <div class="container">
        <?php while (have_posts()) : the_post(); ?>
            <div class="product-layout">
                <div class="product-images">
                    <?php woocommerce_show_product_images(); ?>
                </div>
                
                <div class="product-summary">
                    <h1 class="product-title"><?php the_title(); ?></h1>
                    <?php woocommerce_template_single_rating(); ?>
                    <?php woocommerce_template_single_price(); ?>
                    <?php woocommerce_template_single_excerpt(); ?>
                    <?php woocommerce_template_single_add_to_cart(); ?>
                    <?php woocommerce_template_single_meta(); ?>
                    
                    <div class="product-guarantees">
                        <div class="guarantee-item">
                            <span>🛡️ Garantia de 30 dias</span>
                        </div>
                        <div class="guarantee-item">
                            <span>🚀 Entrega em 7 dias</span>
                        </div>
                        <div class="guarantee-item">
                            <span>📞 Suporte 24/7</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="product-tabs">
                <?php woocommerce_output_product_data_tabs(); ?>
            </div>
            
            <div class="related-products">
                <?php woocommerce_output_related_products(); ?>
            </div>
        <?php endwhile; ?>
    </div>
</div>

<?php get_footer(); ?>
