<?php
/**
 * VancouverTec Store - Single Product Image
 */

if (!defined('ABSPATH')) exit;

global $product;
$post_thumbnail_id = $product->get_image_id();
$wrapper_classes = ['woocommerce-product-gallery', 'vt-product-gallery'];
?>

<div class="<?php echo esc_attr(implode(' ', $wrapper_classes)); ?>" 
     style="opacity: 0; transition: opacity .25s ease-in-out;">
     
    <div class="vt-product-images">
        <?php if ($product->get_image_id()): ?>
            <div class="vt-main-image">
                <?php
                echo wp_get_attachment_image($post_thumbnail_id, 'woocommerce_single', false, [
                    'class' => 'wp-post-image vt-product-image',
                    'data-src' => esc_url(wp_get_attachment_url($post_thumbnail_id))
                ]);
                ?>
            </div>
        <?php else: ?>
            <div class="vt-main-image vt-placeholder">
                <?php echo wc_placeholder_img(); ?>
            </div>
        <?php endif; ?>
        
        <?php
        $attachment_ids = $product->get_gallery_image_ids();
        if ($attachment_ids): ?>
            <div class="vt-gallery-thumbs">
                <?php foreach ($attachment_ids as $attachment_id): ?>
                    <div class="vt-thumb">
                        <?php echo wp_get_attachment_image($attachment_id, 'woocommerce_gallery_thumbnail'); ?>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>
</div>
