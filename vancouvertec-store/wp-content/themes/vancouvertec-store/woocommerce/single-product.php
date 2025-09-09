<?php get_header(); ?>

<div class="vt-single-product">
    <div class="container">
        <?php while (have_posts()) : the_post(); ?>
            
            <!-- Breadcrumb VancouverTec -->
            <nav class="vt-breadcrumb">
                <?php woocommerce_breadcrumb(); ?>
            </nav>
            
            <div class="vt-product-main">
                <!-- Galeria Produto -->
                <div class="vt-product-gallery">
                    <?php woocommerce_show_product_images(); ?>
                </div>
                
                <!-- Info Produto -->
                <div class="vt-product-info">
                    <?php global $product; ?>
                    
                    <!-- Badges -->
                    <div class="vt-product-badges">
                        <?php if ($product->is_on_sale()) : ?>
                            <span class="vt-badge sale">🔥 Em Oferta</span>
                        <?php endif; ?>
                        <?php if ($product->is_featured()) : ?>
                            <span class="vt-badge featured">⭐ Destaque</span>
                        <?php endif; ?>
                        <?php if ($product->is_virtual()) : ?>
                            <span class="vt-badge digital">💻 Digital</span>
                        <?php endif; ?>
                    </div>
                    
                    <h1 class="vt-product-title"><?php the_title(); ?></h1>
                    
                    <?php woocommerce_template_single_rating(); ?>
                    
                    <div class="vt-product-price">
                        <?php woocommerce_template_single_price(); ?>
                    </div>
                    
                    <div class="vt-product-description">
                        <?php woocommerce_template_single_excerpt(); ?>
                    </div>
                    
                    <!-- Form Compra -->
                    <div class="vt-product-form">
                        <?php woocommerce_template_single_add_to_cart(); ?>
                    </div>
                    
                    <!-- Garantias VancouverTec -->
                    <div class="vt-guarantees">
                        <h4>Garantias VancouverTec</h4>
                        <div class="vt-guarantees-list">
                            <div class="guarantee-item">
                                <span class="guarantee-icon">🛡️</span>
                                <div>
                                    <strong>30 dias de garantia</strong>
                                    <small>Satisfação garantida ou dinheiro de volta</small>
                                </div>
                            </div>
                            <div class="guarantee-item">
                                <span class="guarantee-icon">🚀</span>
                                <div>
                                    <strong>Entrega imediata</strong>
                                    <small>Acesso instantâneo após pagamento</small>
                                </div>
                            </div>
                            <div class="guarantee-item">
                                <span class="guarantee-icon">📞</span>
                                <div>
                                    <strong>Suporte 24/7</strong>
                                    <small>Equipe sempre disponível</small>
                                </div>
                            </div>
                            <div class="guarantee-item">
                                <span class="guarantee-icon">🔄</span>
                                <div>
                                    <strong>Atualizações gratuitas</strong>
                                    <small>Sempre atualizado</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <?php woocommerce_template_single_meta(); ?>
                </div>
            </div>
            
            <!-- Tabs Produto -->
            <div class="vt-product-tabs">
                <?php woocommerce_output_product_data_tabs(); ?>
            </div>
            
            <!-- Produtos Relacionados -->
            <?php woocommerce_output_related_products(); ?>
            
        <?php endwhile; ?>
    </div>
</div>

<?php get_footer(); ?>
