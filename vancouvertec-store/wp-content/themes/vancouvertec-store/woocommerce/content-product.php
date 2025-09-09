<?php
defined('ABSPATH') || exit;

global $product;
if (empty($product) || !$product->is_visible()) {
    return;
}
?>

<div <?php wc_product_class('vt-product-loop-card', $product); ?>>
    <?php if ($product->is_on_sale()) : ?>
        <div class="vt-sale-badge">
            <?php
            $regular = $product->get_regular_price();
            $sale = $product->get_sale_price();
            if ($regular && $sale) {
                $discount = round((($regular - $sale) / $regular) * 100);
                echo $discount . '% OFF';
            } else {
                echo 'OFERTA';
            }
            ?>
        </div>
    <?php endif; ?>
    
    <div class="vt-product-image">
        <a href="<?php the_permalink(); ?>">
            <?php echo woocommerce_get_product_thumbnail('medium'); ?>
        </a>
        
        <div class="vt-product-overlay">
            <?php woocommerce_template_loop_add_to_cart(); ?>
            <a href="<?php the_permalink(); ?>" class="vt-quick-view">Ver Detalhes</a>
        </div>
        
        <?php if ($product->is_featured()) : ?>
            <div class="vt-featured-badge">⭐</div>
        <?php endif; ?>
    </div>
    
    <div class="vt-product-content">
        <?php
        $terms = get_the_terms($product->get_id(), 'product_cat');
        if ($terms && !is_wp_error($terms)) :
        ?>
            <div class="vt-product-category">
                <a href="<?php echo get_term_link($terms[0]); ?>">
                    <?php echo esc_html($terms[0]->name); ?>
                </a>
            </div>
        <?php endif; ?>
        
        <h3 class="vt-product-title">
            <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
        </h3>
        
        <div class="vt-product-excerpt">
            <?php echo wp_trim_words(get_the_excerpt(), 15, '...'); ?>
        </div>
        
        <?php woocommerce_template_loop_rating(); ?>
        
        <div class="vt-product-price">
            <?php woocommerce_template_loop_price(); ?>
        </div>
        
        <div class="vt-product-meta">
            <?php if ($product->is_virtual()) : ?>
                <span class="vt-meta-tag digital">💻 Digital</span>
            <?php endif; ?>
            <?php if ($product->is_downloadable()) : ?>
                <span class="vt-meta-tag download">⬇️ Download</span>
            <?php endif; ?>
        </div>
    </div>
</div>
