<?php
/**
 * VancouverTec Store - Generic Page Template
 */

get_header(); ?>

<div class="vt-page-content">
    <div class="container">
        
        <?php while (have_posts()): the_post(); ?>
            
            <article id="post-<?php the_ID(); ?>" <?php post_class('vt-page-article'); ?>>
                
                <header class="vt-page-header">
                    <h1 class="vt-page-title"><?php the_title(); ?></h1>
                </header>
                
                <div class="vt-page-content">
                    <?php the_content(); ?>
                </div>
                
            </article>
            
        <?php endwhile; ?>
        
    </div>
</div>

<?php get_footer(); ?>
