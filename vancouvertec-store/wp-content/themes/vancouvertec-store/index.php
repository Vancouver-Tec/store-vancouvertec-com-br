<?php
/**
 * Main Template File
 * @package VancouverTec_Store
 */

get_header(); ?>

<div class="container">
    <div class="welcome-section" style="text-align: center; padding: 4rem 0;">
        <h1 style="color: var(--vt-blue-600); font-size: 2.5rem; margin-bottom: 1rem;">
            VancouverTec Store
        </h1>
        <h2 style="color: var(--vt-neutral-800); font-size: 1.5rem; margin-bottom: 2rem;">
            Soluções Digitais para o seu Negócio
        </h2>
        <p style="color: var(--vt-neutral-800); font-size: 1.1rem; max-width: 600px; margin: 0 auto 2rem;">
            Sistemas, Sites, Aplicativos, Automação e Cursos para empresas que querem crescer
        </p>
        
        <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
            <a href="/shop" class="btn-primary">Ver Produtos</a>
            <a href="/sobre" class="btn-primary" style="background: var(--vt-success-500);">Saiba Mais</a>
        </div>
    </div>
    
    <?php if (have_posts()) : ?>
        <div class="posts-section">
            <h3><?php _e('Últimas Novidades', 'vancouvertec'); ?></h3>
            <div class="posts-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem; margin-top: 2rem;">
                <?php while (have_posts()) : the_post(); ?>
                    <article id="post-<?php the_ID(); ?>" <?php post_class('post-card'); ?> style="background: white; border-radius: var(--vt-radius-md); box-shadow: var(--vt-shadow-md); padding: 1.5rem;">
                        <?php if (has_post_thumbnail()) : ?>
                            <div class="post-thumbnail" style="margin-bottom: 1rem;">
                                <a href="<?php the_permalink(); ?>">
                                    <?php the_post_thumbnail('medium', ['loading' => 'lazy']); ?>
                                </a>
                            </div>
                        <?php endif; ?>
                        
                        <div class="post-content">
                            <h3 class="post-title" style="margin-bottom: 1rem;">
                                <a href="<?php the_permalink(); ?>" style="color: var(--vt-blue-600); text-decoration: none;">
                                    <?php the_title(); ?>
                                </a>
                            </h3>
                            
                            <div class="post-excerpt" style="margin-bottom: 1rem;">
                                <?php the_excerpt(); ?>
                            </div>
                            
                            <div class="post-meta" style="color: var(--vt-neutral-600); font-size: 0.9rem;">
                                <time datetime="<?php echo get_the_date('c'); ?>">
                                    <?php echo get_the_date(); ?>
                                </time>
                            </div>
                        </div>
                    </article>
                <?php endwhile; ?>
            </div>
            
            <?php the_posts_navigation(); ?>
        </div>
    <?php endif; ?>
</div>

<?php get_footer();
