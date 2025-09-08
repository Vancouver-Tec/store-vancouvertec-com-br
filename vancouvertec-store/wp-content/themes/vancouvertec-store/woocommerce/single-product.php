<?php
/**
 * Single Product Template - VancouverTec Store
 */

get_header(); ?>

<div class="single-product-page">
    <div class="container">
        <?php while (have_posts()) : the_post(); ?>
            
            <!-- Breadcrumb -->
            <div class="product-breadcrumb">
                <?php woocommerce_breadcrumb(); ?>
            </div>
            
            <div class="product-content">
                <!-- Imagens do Produto -->
                <div class="product-images">
                    <?php woocommerce_show_product_images(); ?>
                </div>
                
                <!-- Informações do Produto -->
                <div class="product-summary">
                    <h1 class="product-title"><?php the_title(); ?></h1>
                    
                    <div class="product-rating">
                        <?php woocommerce_template_single_rating(); ?>
                    </div>
                    
                    <div class="product-price">
                        <?php woocommerce_template_single_price(); ?>
                    </div>
                    
                    <div class="product-excerpt">
                        <?php woocommerce_template_single_excerpt(); ?>
                    </div>
                    
                    <div class="product-form">
                        <?php woocommerce_template_single_add_to_cart(); ?>
                    </div>
                    
                    <div class="product-meta">
                        <?php woocommerce_template_single_meta(); ?>
                    </div>
                    
                    <!-- Garantias e Benefícios -->
                    <div class="product-guarantees">
                        <div class="guarantee-item">
                            <span class="guarantee-icon">🛡️</span>
                            <span>Garantia de 30 dias</span>
                        </div>
                        <div class="guarantee-item">
                            <span class="guarantee-icon">🚀</span>
                            <span>Entrega em 7 dias</span>
                        </div>
                        <div class="guarantee-item">
                            <span class="guarantee-icon">📞</span>
                            <span>Suporte 24/7</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Abas do Produto -->
            <div class="product-tabs">
                <?php woocommerce_output_product_data_tabs(); ?>
            </div>
            
            <!-- Produtos Relacionados -->
            <div class="related-products">
                <?php woocommerce_output_related_products(); ?>
            </div>
            
        <?php endwhile; ?>
    </div>
</div>

<?php get_footer(); ?>
