<?php
/**
 * The template for displaying product content within loops
 */

defined('ABSPATH') || exit;

global $product;

if (empty($product) || !$product->is_visible()) {
    return;
}
?>

<div <?php wc_product_class('product-card-loop', $product); ?>>
    <?php if ($product->is_on_sale()) : ?>
        <div class="sale-badge-loop">
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
    
    <div class="product-image-wrapper">
        <a href="<?php the_permalink(); ?>" class="product-image-link">
            <?php echo woocommerce_get_product_thumbnail('medium'); ?>
        </a>
        
        <div class="product-actions-hover">
            <?php woocommerce_template_loop_add_to_cart(); ?>
            <button class="quick-view-btn" data-product-id="<?php echo esc_attr($product->get_id()); ?>">
                👁️ Visualização Rápida
            </button>
        </div>
        
        <?php if ($product->is_featured()) : ?>
            <div class="featured-badge">⭐ Destaque</div>
        <?php endif; ?>
    </div>
    
    <div class="product-info-wrapper">
        <?php
        // Categoria
        $terms = get_the_terms($product->get_id(), 'product_cat');
        if ($terms && !is_wp_error($terms)) :
        ?>
            <div class="product-category">
                <a href="<?php echo get_term_link($terms[0]); ?>">
                    <?php echo esc_html($terms[0]->name); ?>
                </a>
            </div>
        <?php endif; ?>
        
        <h3 class="product-title-loop">
            <a href="<?php the_permalink(); ?>">
                <?php the_title(); ?>
            </a>
        </h3>
        
        <div class="product-excerpt-loop">
            <?php echo wp_trim_words(get_the_excerpt(), 15, '...'); ?>
        </div>
        
        <?php woocommerce_template_loop_rating(); ?>
        
        <div class="product-price-wrapper">
            <?php woocommerce_template_loop_price(); ?>
        </div>
        
        <div class="product-meta-info">
            <?php if ($product->is_type('variable')) : ?>
                <span class="variable-info">📋 Várias opções</span>
            <?php endif; ?>
            
            <?php if ($product->is_downloadable()) : ?>
                <span class="download-info">⬇️ Download</span>
            <?php endif; ?>
            
            <?php if ($product->is_virtual()) : ?>
                <span class="virtual-info">💻 Digital</span>
            <?php endif; ?>
        </div>
    </div>
</div>
