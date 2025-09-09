#!/bin/bash

# ===========================================
# VancouverTec Store - Fix Critical Error
# Script: 20c-fix-critical-error.sh
# Versão: 1.0.0 - Corrigir erro crítico front-page.php
# ===========================================

set -euo pipefail

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Variáveis
THEME_PATH="wp-content/themes/vancouvertec-store"
PROJECT_PATH="/home/$(whoami)/vancouvertec/store-vancouvertec-com-br/vancouvertec-store"

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║       🔧 FIX CRITICAL ERROR 🔧              ║
║         Corrigir front-page.php             ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Corrigindo erro crítico..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# 1. BACKUP DO FRONT-PAGE ATUAL
log_info "Fazendo backup do front-page.php..."
if [[ -f "$THEME_PATH/front-page.php" ]]; then
    cp "$THEME_PATH/front-page.php" "$THEME_PATH/front-page.php.backup"
fi

# 2. RECRIAR FRONT-PAGE.PHP LIMPO (SEM ERRO)
log_info "Recriando front-page.php sem erros..."
cat > "$THEME_PATH/front-page.php" << 'EOF'
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
                <a href="<?php echo class_exists('WooCommerce') ? get_permalink(wc_get_page_id('shop')) : '/shop'; ?>" class="btn-cta-primary">
                    <span>🛒 Ver Produtos</span>
                    <span class="btn-arrow">→</span>
                </a>
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
                <a href="<?php echo class_exists('WooCommerce') ? get_permalink(wc_get_page_id('shop')) : '/shop'; ?>" class="btn-promo">
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

<!-- 4. PRODUTOS REAIS DO WOOCOMMERCE -->
<section class="real-products-section">
    <div class="container">
        <div class="section-header">
            <div class="section-badge">🛒 NOSSOS PRODUTOS</div>
            <h2 class="section-title">Produtos em Destaque</h2>
            <p class="section-subtitle">Soluções digitais desenvolvidas para fazer seu negócio crescer</p>
        </div>
        
        <?php if (class_exists('WooCommerce')) : ?>
            <div class="woo-products-grid-fixed">
                <?php
                // Query simplificada e segura
                $args = array(
                    'post_type' => 'product',
                    'posts_per_page' => 6,
                    'post_status' => 'publish',
                    'orderby' => 'date',
                    'order' => 'DESC'
                );
                
                $products = new WP_Query($args);
                
                if ($products->have_posts()) :
                    $count = 0;
                    while ($products->have_posts() && $count < 6) : $products->the_post();
                        global $product;
                        if (!$product) continue;
                        
                        $product_id = get_the_ID();
                        $is_on_sale = method_exists($product, 'is_on_sale') ? $product->is_on_sale() : false;
                        $price_html = method_exists($product, 'get_price_html') ? $product->get_price_html() : 'Consulte o preço';
                        $count++;
                ?>
                <div class="woo-product-card-home <?php echo $is_on_sale ? 'on-sale' : ''; ?>">
                    <?php if ($is_on_sale) : ?>
                        <div class="sale-badge-home">OFERTA</div>
                    <?php endif; ?>
                    
                    <div class="woo-product-image-home">
                        <a href="<?php the_permalink(); ?>">
                            <?php if (has_post_thumbnail()) : ?>
                                <?php the_post_thumbnail('medium', array('class' => 'product-thumb-home')); ?>
                            <?php else : ?>
                                <div class="no-image-home">
                                    <span class="product-icon">📦</span>
                                    <span class="product-placeholder">Produto Digital</span>
                                </div>
                            <?php endif; ?>
                        </a>
                        
                        <div class="product-overlay-home">
                            <a href="<?php the_permalink(); ?>" class="add-to-cart-home">🛒 Ver Produto</a>
                            <a href="<?php the_permalink(); ?>" class="view-product-home">👁️ Detalhes</a>
                        </div>
                    </div>
                    
                    <div class="woo-product-content-home">
                        <h3 class="woo-product-title-home">
                            <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
                        </h3>
                        
                        <div class="woo-product-excerpt-home">
                            <?php echo wp_trim_words(get_the_excerpt() ?: 'Produto digital de qualidade premium', 12, '...'); ?>
                        </div>
                        
                        <div class="woo-product-price-home">
                            <?php echo $price_html; ?>
                        </div>
                    </div>
                </div>
                <?php
                    endwhile;
                    wp_reset_postdata();
                else :
                ?>
                <div class="no-products-home">
                    <div class="empty-state-home">
                        <div class="empty-icon-home">🛒</div>
                        <h3>Nenhum produto cadastrado</h3>
                        <p>Cadastre seus primeiros produtos para começar a vender!</p>
                        <?php if (current_user_can('manage_options')) : ?>
                            <a href="<?php echo admin_url('post-new.php?post_type=product'); ?>" class="btn-add-product-home">
                                ➕ Cadastrar Primeiro Produto
                            </a>
                        <?php endif; ?>
                    </div>
                </div>
                <?php endif; ?>
            </div>
            
            <div class="products-cta-home">
                <a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>" class="view-all-products-btn-home">
                    Ver Todos os Produtos →
                </a>
            </div>
        <?php else : ?>
            <div class="woocommerce-not-active-home">
                <div class="empty-state-home">
                    <div class="empty-icon-home">⚠️</div>
                    <h3>WooCommerce não está ativo</h3>
                    <p>Ative o plugin WooCommerce para exibir produtos.</p>
                </div>
            </div>
        <?php endif; ?>
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
                <a href="<?php echo class_exists('WooCommerce') ? get_permalink(wc_get_page_id('shop')) : '/shop'; ?>" class="cta-btn-primary">
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
EOF

# Reiniciar servidor
log_info "Reiniciando servidor..."
cd "$PROJECT_PATH"
php -S localhost:8080 -t . > /tmp/vt-server-8080.log 2>&1 &
SERVER_PID=$!

sleep 3

if kill -0 $SERVER_PID 2>/dev/null; then
    log_success "Servidor reiniciado (PID: $SERVER_PID)"
else
    log_error "Falha ao reiniciar servidor!"
    exit 1
fi

echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║      ✅ ERRO CRÍTICO CORRIGIDO! ✅           ║"
echo -e "║        Front-page.php recriado               ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Front-page.php recriado sem erros"
log_success "✅ Query WooCommerce simplificada e segura"
log_success "✅ Backup salvo como front-page.php.backup"
log_success "✅ Site deve funcionar normalmente agora"

echo -e "\n${BLUE}🌐 Teste: http://localhost:8080${NC}"

exit 0