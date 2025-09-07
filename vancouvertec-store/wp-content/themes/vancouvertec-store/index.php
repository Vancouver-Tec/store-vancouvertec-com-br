<?php get_header(); ?>

<div class="container">
    <?php if (is_home() && is_front_page()) : ?>
        <section class="hero-section">
            <h1 class="hero-title">VancouverTec Store</h1>
            <h2 class="hero-subtitle">Soluções Digitais para o seu Negócio</h2>
            <p class="hero-description">
                Sistemas, Sites, Aplicativos, Automação e Cursos para empresas que querem crescer
            </p>
            
            <div class="hero-actions">
                <?php if (class_exists('WooCommerce')) : ?>
                    <a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>" class="btn">
                        Ver Produtos
                    </a>
                <?php endif; ?>
                <a href="/sobre" class="btn btn-secondary">
                    Saiba Mais
                </a>
            </div>
        </section>
    <?php endif; ?>
    
    <?php if (have_posts()) : ?>
        <section class="posts-section">
            <h3>Últimas Novidades</h3>
            <div class="posts-grid">
                <?php while (have_posts()) : the_post(); ?>
                    <article class="post-card">
                        <?php if (has_post_thumbnail()) : ?>
                            <div class="post-thumbnail">
                                <a href="<?php the_permalink(); ?>">
                                    <?php the_post_thumbnail('medium'); ?>
                                </a>
                            </div>
                        <?php endif; ?>
                        
                        <div class="post-content">
                            <h4 class="post-title">
                                <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
                            </h4>
                            
                            <div class="post-excerpt">
                                <?php the_excerpt(); ?>
                            </div>
                            
                            <div class="post-meta">
                                <time datetime="<?php echo get_the_date('c'); ?>">
                                    <?php echo get_the_date(); ?>
                                </time>
                            </div>
                        </div>
                    </article>
                <?php endwhile; ?>
            </div>
            
            <?php the_posts_navigation(); ?>
        </section>
    <?php endif; ?>
</div>

<?php get_footer(); ?>
