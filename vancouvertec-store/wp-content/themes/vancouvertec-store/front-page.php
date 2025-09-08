<?php
/**
 * Front Page - VancouverTec Store
 * Layout de Alta Conversão para Vendas Digitais
 */

get_header(); ?>

<!-- 1. HERO SECTION IMPACTANTE -->
<section class="hero-section-conversao">
    <div class="hero-background">
        <div class="hero-gradient"></div>
        <div class="hero-pattern"></div>
    </div>
    
    <div class="container">
        <div class="hero-content">
            <!-- Badge Social Proof -->
            <div class="hero-badge">
                <span class="badge-icon">🏆</span>
                <span>Mais de 500 projetos entregues com 99% de satisfação</span>
            </div>
            
            <!-- Título Impactante -->
            <h1 class="hero-title">
                Transforme Sua <span class="highlight-blue">Ideia</span> em um 
                <span class="highlight-gradient">Negócio Digital</span> de Sucesso
            </h1>
            
            <!-- Subtítulo Convincente -->
            <p class="hero-subtitle">
                Desenvolvemos <strong>sistemas, sites, aplicativos e automações</strong> 
                que fazem sua empresa <span class="text-success">faturar mais</span> 
                e conquistar novos clientes no digital.
            </p>
            
            <!-- Stats Impactantes -->
            <div class="hero-stats">
                <div class="stat-item">
                    <div class="stat-number">500+</div>
                    <div class="stat-label">Projetos Entregues</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">99%</div>
                    <div class="stat-label">Satisfação</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">300%</div>
                    <div class="stat-label">ROI Médio</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">7 Dias</div>
                    <div class="stat-label">Entrega Rápida</div>
                </div>
            </div>
            
            <!-- CTAs Poderosos -->
            <div class="hero-actions">
                <?php if (class_exists('WooCommerce')) : ?>
                    <a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>" class="btn-cta-primary">
                        <span>🛒 Ver Produtos</span>
                        <span class="btn-arrow">→</span>
                    </a>
                <?php endif; ?>
                <a href="/contato" class="btn-cta-secondary">
                    <span>💬 Consultoria Grátis</span>
                </a>
            </div>
            
            <!-- Garantia -->
            <div class="hero-guarantee">
                <span class="guarantee-icon">🛡️</span>
                <span><strong>Garantia</strong> de qualidade dos nossos serviços</span>
            </div>
        </div>
    </div>
</section>

<!-- 2. BANNER PROMOÇÕES URGENTES -->
<section class="promo-banner-section">
    <div class="container">
        <div class="promo-banner">
            <div class="promo-content">
                <div class="promo-badge">⚡ OFERTA RELÂMPAGO</div>
                <h3 class="promo-title">50% OFF em Todos os Produtos Digitais</h3>
                <p class="promo-subtitle">Últimas 48 horas! Não perca esta oportunidade única.</p>
                <div class="promo-countdown">
                    <div class="countdown-item">
                        <span class="countdown-number">23</span>
                        <span class="countdown-label">Horas</span>
                    </div>
                    <div class="countdown-divider">:</div>
                    <div class="countdown-item">
                        <span class="countdown-number">45</span>
                        <span class="countdown-label">Min</span>
                    </div>
                    <div class="countdown-divider">:</div>
                    <div class="countdown-item">
                        <span class="countdown-number">12</span>
                        <span class="countdown-label">Seg</span>
                    </div>
                </div>
            </div>
            <div class="promo-action">
                <a href="<?php echo class_exists('WooCommerce') ? get_permalink(wc_get_page_id('shop')) : '#'; ?>" class="btn-promo">
                    Aproveitar Oferta
                </a>
            </div>
        </div>
    </div>
</section>

<!-- 3. CATEGORIAS COM IMAGENS -->
<section class="categories-section">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">Escolha Sua Solução Digital</h2>
            <p class="section-subtitle">
                Produtos desenvolvidos especialmente para fazer seu negócio crescer no digital
            </p>
        </div>
        
        <div class="categories-grid">
            <!-- Sites WordPress -->
            <div class="category-card">
                <div class="category-image">
                    <div class="category-icon">🌐</div>
                    <div class="category-badge">Mais Vendido</div>
                </div>
                <div class="category-content">
                    <h3 class="category-title">Sites WordPress</h3>
                    <p class="category-description">
                        Sites profissionais, responsivos e otimizados para conversão.
                    </p>
                    <div class="category-price">A partir de <span class="price">R$ 497</span></div>
                    <a href="/categoria/sites" class="category-btn">Ver Sites</a>
                </div>
            </div>
            
            <!-- Lojas Virtuais -->
            <div class="category-card">
                <div class="category-image">
                    <div class="category-icon">🛒</div>
                    <div class="category-badge">ROI 300%</div>
                </div>
                <div class="category-content">
                    <h3 class="category-title">Lojas Virtuais</h3>
                    <p class="category-description">
                        E-commerce completo com WooCommerce e sistema de pagamento.
                    </p>
                    <div class="category-price">A partir de <span class="price">R$ 997</span></div>
                    <a href="/categoria/lojas" class="category-btn">Ver Lojas</a>
                </div>
            </div>
            
            <!-- Aplicativos Mobile -->
            <div class="category-card">
                <div class="category-image">
                    <div class="category-icon">📱</div>
                    <div class="category-badge">Novidade</div>
                </div>
                <div class="category-content">
                    <h3 class="category-title">Apps Mobile</h3>
                    <p class="category-description">
                        Aplicativos nativos para Android e iOS com design moderno.
                    </p>
                    <div class="category-price">A partir de <span class="price">R$ 1.497</span></div>
                    <a href="/categoria/apps" class="category-btn">Ver Apps</a>
                </div>
            </div>
            
            <!-- Sistemas Web -->
            <div class="category-card">
                <div class="category-image">
                    <div class="category-icon">⚙️</div>
                    <div class="category-badge">Personalizado</div>
                </div>
                <div class="category-content">
                    <h3 class="category-title">Sistemas Web</h3>
                    <p class="category-description">
                        Sistemas sob medida para automação e gestão empresarial.
                    </p>
                    <div class="category-price">A partir de <span class="price">R$ 2.497</span></div>
                    <a href="/categoria/sistemas" class="category-btn">Ver Sistemas</a>
                </div>
            </div>
            
            <!-- Cursos Online -->
            <div class="category-card">
                <div class="category-image">
                    <div class="category-icon">🎓</div>
                    <div class="category-badge">Aprenda</div>
                </div>
                <div class="category-content">
                    <h3 class="category-title">Cursos Online</h3>
                    <p class="category-description">
                        Treinamentos completos para você criar seus próprios projetos.
                    </p>
                    <div class="category-price">A partir de <span class="price">R$ 197</span></div>
                    <a href="/categoria/cursos" class="category-btn">Ver Cursos</a>
                </div>
            </div>
            
            <!-- Automações -->
            <div class="category-card">
                <div class="category-image">
                    <div class="category-icon">🤖</div>
                    <div class="category-badge">Eficiência</div>
                </div>
                <div class="category-content">
                    <h3 class="category-title">Automações</h3>
                    <p class="category-description">
                        Automações inteligentes para otimizar processos e tempo.
                    </p>
                    <div class="category-price">A partir de <span class="price">R$ 697</span></div>
                    <a href="/categoria/automacoes" class="category-btn">Ver Automações</a>
                </div>
            </div>
        </div>
    </div>
</section>


<!-- 4. PRODUTOS EM PROMOÇÃO -->
<section class="featured-products-section">
    <div class="container">
        <div class="section-header">
            <div class="section-badge">⚡ OFERTAS LIMITADAS</div>
            <h2 class="section-title">Produtos em Promoção</h2>
            <p class="section-subtitle">Aproveite os descontos especiais antes que acabem!</p>
        </div>
        
        <div class="products-grid">
            <div class="product-card featured">
                <div class="product-badge">50% OFF</div>
                <div class="product-image">
                    <div class="product-icon">🌐</div>
                </div>
                <div class="product-content">
                    <h3 class="product-title">Site WordPress Profissional</h3>
                    <p class="product-description">Site completo com design moderno, responsivo e otimizado para SEO.</p>
                    <div class="product-features">
                        <span class="feature">✓ Design Responsivo</span>
                        <span class="feature">✓ SEO Otimizado</span>
                        <span class="feature">✓ Entrega 7 dias</span>
                    </div>
                    <div class="product-pricing">
                        <span class="price-old">R$ 997</span>
                        <span class="price-current">R$ 497</span>
                    </div>
                    <div class="product-urgency">
                        <span class="urgency-text">⏰ Restam apenas 12 unidades!</span>
                    </div>
                    <a href="/produto/site-wordpress" class="product-btn">Comprar Agora</a>
                </div>
            </div>
            
            <div class="product-card">
                <div class="product-badge">40% OFF</div>
                <div class="product-image">
                    <div class="product-icon">🛒</div>
                </div>
                <div class="product-content">
                    <h3 class="product-title">Loja Virtual Completa</h3>
                    <p class="product-description">E-commerce profissional com sistema de pagamento e gestão.</p>
                    <div class="product-features">
                        <span class="feature">✓ WooCommerce</span>
                        <span class="feature">✓ Pagamento Online</span>
                        <span class="feature">✓ Dashboard Admin</span>
                    </div>
                    <div class="product-pricing">
                        <span class="price-old">R$ 1.997</span>
                        <span class="price-current">R$ 1.197</span>
                    </div>
                    <div class="product-urgency">
                        <span class="urgency-text">⏰ Oferta termina em 2 dias!</span>
                    </div>
                    <a href="/produto/loja-virtual" class="product-btn">Comprar Agora</a>
                </div>
            </div>
            
            <div class="product-card">
                <div class="product-badge">30% OFF</div>
                <div class="product-image">
                    <div class="product-icon">📱</div>
                </div>
                <div class="product-content">
                    <h3 class="product-title">App Mobile Nativo</h3>
                    <p class="product-description">Aplicativo para Android e iOS com design moderno.</p>
                    <div class="product-features">
                        <span class="feature">✓ Android + iOS</span>
                        <span class="feature">✓ Design Nativo</span>
                        <span class="feature">✓ Push Notifications</span>
                    </div>
                    <div class="product-pricing">
                        <span class="price-old">R$ 2.497</span>
                        <span class="price-current">R$ 1.747</span>
                    </div>
                    <div class="product-urgency">
                        <span class="urgency-text">⏰ Últimas 5 vagas!</span>
                    </div>
                    <a href="/produto/app-mobile" class="product-btn">Comprar Agora</a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 5. DEPOIMENTOS COM FOTOS -->
<section class="testimonials-section">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">O Que Nossos Clientes Dizem</h2>
            <p class="section-subtitle">Mais de 500 empresas já transformaram seus negócios conosco</p>
        </div>
        
        <div class="testimonials-grid">
            <div class="testimonial-card">
                <div class="testimonial-content">
                    <div class="stars">⭐⭐⭐⭐⭐</div>
                    <p class="testimonial-text">
                        "A VancouverTec criou nossa loja virtual e em 3 meses triplicamos as vendas online. 
                        O suporte é excepcional e a qualidade impecável!"
                    </p>
                </div>
                <div class="testimonial-author">
                    <div class="author-avatar">👨‍💼</div>
                    <div class="author-info">
                        <h4 class="author-name">Carlos Silva</h4>
                        <span class="author-company">CEO - TechModa Ltda</span>
                        <span class="author-result">+300% vendas online</span>
                    </div>
                </div>
            </div>
            
            <div class="testimonial-card">
                <div class="testimonial-content">
                    <div class="stars">⭐⭐⭐⭐⭐</div>
                    <p class="testimonial-text">
                        "O sistema desenvolvido automatizou 80% dos nossos processos. 
                        Economizamos 20 horas por semana e aumentamos a produtividade!"
                    </p>
                </div>
                <div class="testimonial-author">
                    <div class="author-avatar">👩‍💼</div>
                    <div class="author-info">
                        <h4 class="author-name">Ana Costa</h4>
                        <span class="author-company">Diretora - Inovare Soluções</span>
                        <span class="author-result">-80% tempo processos</span>
                    </div>
                </div>
            </div>
            
            <div class="testimonial-card">
                <div class="testimonial-content">
                    <div class="stars">⭐⭐⭐⭐⭐</div>
                    <p class="testimonial-text">
                        "O aplicativo mobile trouxe nossos clientes mais próximos. 
                        Engajamento aumentou 400% e fidelização melhorou drasticamente!"
                    </p>
                </div>
                <div class="testimonial-author">
                    <div class="author-avatar">👨‍💻</div>
                    <div class="author-info">
                        <h4 class="author-name">Roberto Lima</h4>
                        <span class="author-company">Fundador - FitApp Brasil</span>
                        <span class="author-result">+400% engajamento</span>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="testimonials-stats">
            <div class="stat-testimonial">
                <div class="stat-number">99%</div>
                <div class="stat-label">Clientes Satisfeitos</div>
            </div>
            <div class="stat-testimonial">
                <div class="stat-number">500+</div>
                <div class="stat-label">Projetos Entregues</div>
            </div>
            <div class="stat-testimonial">
                <div class="stat-number">300%</div>
                <div class="stat-label">ROI Médio</div>
            </div>
            <div class="stat-testimonial">
                <div class="stat-number">24h</div>
                <div class="stat-label">Suporte Rápido</div>
            </div>
        </div>
    </div>
</section>

<!-- 6. POR QUE ESCOLHER -->
<section class="why-choose-section">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">Por Que Escolher a VancouverTec?</h2>
            <p class="section-subtitle">Somos especialistas em transformar ideias em negócios digitais de sucesso</p>
        </div>
        
        <div class="benefits-grid">
            <div class="benefit-card">
                <div class="benefit-icon">🚀</div>
                <h3 class="benefit-title">Entrega Rápida</h3>
                <p class="benefit-description">Seus projetos prontos em até 7 dias úteis com qualidade profissional.</p>
            </div>
            
            <div class="benefit-card">
                <div class="benefit-icon">🛡️</div>
                <h3 class="benefit-title">Garantia Total</h3>
                <p class="benefit-description">30 dias de garantia ou seu dinheiro de volta. Sua satisfação é garantida.</p>
            </div>
            
            <div class="benefit-card">
                <div class="benefit-icon">💎</div>
                <h3 class="benefit-title">Qualidade Premium</h3>
                <p class="benefit-description">Código limpo, design moderno e tecnologia de ponta em todos os projetos.</p>
            </div>
            
            <div class="benefit-card">
                <div class="benefit-icon">📞</div>
                <h3 class="benefit-title">Suporte 24/7</h3>
                <p class="benefit-description">Suporte técnico completo via WhatsApp, email e telefone quando precisar.</p>
            </div>
            
            <div class="benefit-card">
                <div class="benefit-icon">📈</div>
                <h3 class="benefit-title">ROI Comprovado</h3>
                <p class="benefit-description">Nossos clientes aumentam faturamento em média 300% no primeiro ano.</p>
            </div>
            
            <div class="benefit-card">
                <div class="benefit-icon">🔧</div>
                <h3 class="benefit-title">Personalização</h3>
                <p class="benefit-description">Soluções sob medida para as necessidades específicas do seu negócio.</p>
            </div>
        </div>
    </div>
</section>

<!-- 7. CTA FINAL IMPACTANTE -->
<section class="final-cta-section">
    <div class="container">
        <div class="cta-content">
            <div class="cta-badge">🎯 OFERTA LIMITADA</div>
            <h2 class="cta-title">
                Pronto para Transformar Seu Negócio?
            </h2>
            <p class="cta-subtitle">
                Junte-se a mais de 500 empresas que já escolheram a VancouverTec 
                para acelerar seus resultados no digital.
            </p>
            
            <div class="cta-offer">
                <div class="offer-text">
                    <span class="offer-discount">50% OFF</span>
                    <span class="offer-description">em todos os produtos até o final do mês</span>
                </div>
                <div class="offer-urgency">⏰ Oferta válida por apenas 48 horas!</div>
            </div>
            
            <div class="cta-actions">
                <a href="<?php echo class_exists("WooCommerce") ? get_permalink(wc_get_page_id("shop")) : "#"; ?>" class="cta-btn-primary">
                    🛒 Ver Produtos em Oferta
                </a>
                <a href="/contato" class="cta-btn-secondary">
                    💬 Falar com Especialista
                </a>
            </div>
            
            <div class="cta-guarantees">
                <div class="guarantee-item">
                    <span class="guarantee-icon">🛡️</span>
                    <span>Garantia 30 dias</span>
                </div>
                <div class="guarantee-item">
                    <span class="guarantee-icon">🚀</span>
                    <span>Entrega em 7 dias</span>
                </div>
                <div class="guarantee-item">
                    <span class="guarantee-icon">📞</span>
                    <span>Suporte 24/7</span>
                </div>
            </div>
        </div>
    </div>
</section>
<?php get_footer(); ?>
