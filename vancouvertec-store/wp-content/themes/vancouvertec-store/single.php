<?php
/**
 * VancouverTec Store - Single Post Template
 */

get_header(); ?>

<div class="vt-single-content">
    <div class="container">
        
        <?php while (have_posts()): the_post(); ?>
            
            <article id="post-<?php the_ID(); ?>" <?php post_class('vt-single-article'); ?>>
                
                <header class="vt-single-header">
                    <h1 class="vt-single-title"><?php the_title(); ?></h1>
                    <div class="vt-single-meta">
                        <span class="vt-date"><?php echo get_the_date(); ?></span>
                        <span class="vt-author">Por <?php the_author(); ?></span>
                    </div>
                </header>
                
                <?php if (has_post_thumbnail()): ?>
                <div class="vt-single-featured">
                    <?php the_post_thumbnail('large'); ?>
                </div>
                <?php endif; ?>
                
                <div class="vt-single-content">
                    <?php the_content(); ?>
                </div>
                
            </article>
            
        <?php endwhile; ?>
        
    </div>
</div>

<?php get_footer(); ?>
