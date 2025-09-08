<?php
/**
 * Shop Page Template - VancouverTec Store
 */

get_header(); ?>

<div class="shop-page">
    <div class="container">
        <!-- Breadcrumb -->
        <div class="shop-breadcrumb">
            <?php woocommerce_breadcrumb(); ?>
        </div>
        
        <!-- Shop Header -->
        <div class="shop-header">
            <div class="shop-title-area">
                <h1 class="shop-title">
                    <?php woocommerce_page_title(); ?>
                </h1>
                <?php if (is_product_category()) : ?>
                    <div class="category-description">
                        <?php echo category_description(); ?>
                    </div>
                <?php endif; ?>
            </div>
            
            <!-- Filtros e Ordenação -->
            <div class="shop-controls">
                <div class="shop-filters">
                    <?php woocommerce_catalog_ordering(); ?>
                </div>
                <div class="results-count">
                    <?php woocommerce_result_count(); ?>
                </div>
            </div>
        </div>
        
        <div class="shop-content">
            <!-- Sidebar com Filtros -->
            <aside class="shop-sidebar">
                <div class="sidebar-widget">
                    <h3>Categorias</h3>
                    <?php the_widget('WC_Widget_Product_Categories'); ?>
                </div>
                
                <div class="sidebar-widget">
                    <h3>Filtrar por Preço</h3>
                    <?php the_widget('WC_Widget_Price_Filter'); ?>
                </div>
                
                <div class="sidebar-widget">
                    <h3>Produtos em Oferta</h3>
                    <?php the_widget('WC_Widget_Products', array('show' => 'onsale', 'number' => 3)); ?>
                </div>
            </aside>
            
            <!-- Grid de Produtos -->
            <main class="shop-main">
                <?php if (woocommerce_product_loop()) : ?>
                    <div class="products-grid-shop">
                        <?php
                        woocommerce_product_loop_start();
                        
                        if (wc_get_loop_prop('is_shortcode')) {
                            $columns = absint(wc_get_loop_prop('columns'));
                        }
                        
                        while (have_posts()) :
                            the_post();
                            global $product;
                            $product_id = get_the_ID();
                        ?>
                        
                        <div class="product-card-shop">
                            <?php if ($product->is_on_sale()) : ?>
                                <div class="sale-badge-shop">
                                    <?php
                                    $regular_price = $product->get_regular_price();
                                    $sale_price = $product->get_sale_price();
                                    if ($regular_price && $sale_price) {
                                        $discount = round((($regular_price - $sale_price) / $regular_price) * 100);
                                        echo $discount . '% OFF';
                                    } else {
                                        echo 'OFERTA';
                                    }
                                    ?>
                                </div>
                            <?php endif; ?>
                            
                            <div class="product-image-shop">
                                <a href="<?php the_permalink(); ?>">
                                    <?php echo woocommerce_get_product_thumbnail(); ?>
                                </a>
                                
                                <div class="product-actions-overlay">
                                    <?php woocommerce_template_loop_add_to_cart(); ?>
                                    <button class="quick-view-btn" data-product-id="<?php echo $product_id; ?>">
                                        👁️ Visualização Rápida
                                    </button>
                                </div>
                            </div>
                            
                            <div class="product-info-shop">
                                <h3 class="product-title-shop">
                                    <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
                                </h3>
                                
                                <div class="product-price-shop">
                                    <?php echo $product->get_price_html(); ?>
                                </div>
                                
                                <div class="product-rating-shop">
                                    <?php woocommerce_template_loop_rating(); ?>
                                </div>
                            </div>
                        </div>
                        
                        <?php endwhile; ?>
                        
                        <?php woocommerce_product_loop_end(); ?>
                    </div>
                    
                    <?php woocommerce_pagination(); ?>
                    
                <?php else : ?>
                    <div class="no-products-found">
                        <h2>Nenhum produto encontrado</h2>
                        <p>Não há produtos que correspondam à sua seleção.</p>
                        <a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>" class="btn">
                            Ver Todos os Produtos
                        </a>
                    </div>
                <?php endif; ?>
            </main>
        </div>
    </div>
</div>

<?php get_footer(); ?>
