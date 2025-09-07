<?php get_header(); ?>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="hero-content">
            <div class="hero-badge">
                <span>🚀</span>
                <span>Mais de 500 projetos entregues com sucesso</span>
            </div>
            
            <h1 class="hero-title">
                Transforme sua <span class="highlight">Ideia</span> em um 
                <span class="highlight">Negócio Digital</span> Lucrativo
            </h1>
            
            <h2 class="hero-subtitle">
                Soluções Digitais que Fazem sua Empresa Faturar Mais
            </h2>
            
            <p class="hero-description">
                Desenvolvemos <strong>sistemas, sites, aplicativos e automações</strong> 
                que transformam visitantes em clientes e aumentam seu faturamento em até 300%.
            </p>
            
            <div class="hero-stats">
                <div class="stat-item">
                    <span class="stat-number">500+</span>
                    <span class="stat-label">Projetos</span>
                </div>
                <div class="stat-item">
                    <span class="stat-number">99%</span>
                    <span class="stat-label">Satisfação</span>
                </div>
                <div class="stat-item">
                    <span class="stat-number">24/7</span>
                    <span class="stat-label">Suporte</span>
                </div>
            </div>
            
            <div class="hero-actions">
                <?php if (class_exists('WooCommerce')) : ?>
                    <a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>" 
                       class="btn btn-success btn-large">
                        💎 Ver Nossos Produtos
                    </a>
                <?php endif; ?>
                
                <a href="<?php echo esc_url(home_url('/contato')); ?>" 
                   class="btn btn-primary btn-large">
                    📞 Falar com Especialista
                </a>
            </div>
        </div>
    </div>
</section>

<?php get_footer(); ?>
