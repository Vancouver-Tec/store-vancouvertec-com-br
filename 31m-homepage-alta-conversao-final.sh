#!/bin/bash

# ===========================================
# VancouverTec Store - Homepage Alta Conversão Final
# Script: 31m-homepage-alta-conversao-final.sh
# Versão: 1.0.0 - Homepage completa com layout de conversão
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
PROJECT_PATH="/home/$(whoami)/vancouvertec/store-vancouvertec-com-br/vancouvertec-store"
THEME_PATH="wp-content/themes/vancouvertec-store"

# Funções de log
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║    🏠 HOMEPAGE ALTA CONVERSÃO FINAL 🏠       ║
║     Layout Profissional + Vendas Digitais   ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar base
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Projeto não encontrado: $PROJECT_PATH"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Criando homepage final em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost:8080" > /dev/null; then
    log_warning "Parando servidor..."
    pkill -f "php -S localhost:8080" || true
    sleep 2
fi

# 1. CRIAR INDEX.PHP COMPLETO COM ALTA CONVERSÃO
log_info "Criando index.php com layout de conversão..."
cat > "${THEME_PATH}/index.php" << 'EOF'
<?php
/**
 * VancouverTec Store - Homepage Alta Conversão
 */

get_header(); ?>

<div class="vt-homepage">
    
    <!-- Hero Section -->
    <section class="vt-hero-section">
        <div class="container">
            <div class="vt-hero-content">
                <div class="vt-hero-text">
                    <span class="vt-hero-badge">🚀 Líder em Soluções Digitais</span>
                    <h1 class="vt-hero-title">
                        Transforme Seu Negócio com 
                        <span class="vt-text-gradient">Soluções Digitais Premium</span>
                    </h1>
                    <p class="vt-hero-description">
                        Sites, Sistemas, Aplicativos e Automação profissionais para empresas que querem crescer e se destacar no mercado digital.
                    </p>
                    
                    <div class="vt-hero-stats">
                        <div class="vt-stat">
                            <span class="vt-stat-number">500+</span>
                            <span class="vt-stat-label">Projetos Entregues</span>
                        </div>
                        <div class="vt-stat">
                            <span class="vt-stat-number">99%</span>
                            <span class="vt-stat-label">Clientes Satisfeitos</span>
                        </div>
                        <div class="vt-stat">
                            <span class="vt-stat-number">24/7</span>
                            <span class="vt-stat-label">Suporte Técnico</span>
                        </div>
                    </div>
                    
                    <div class="vt-hero-actions">
                        <?php if (class_exists('WooCommerce')): ?>
                        <a href="<?php echo esc_url(wc_get_page_permalink('shop')); ?>" class="button btn-primary btn-large">
                            🛒 Ver Produtos Digitais
                        </a>
                        <?php endif; ?>
                        <a href="#cases" class="button btn-outline">
                            📈 Ver Cases de Sucesso
                        </a>
                    </div>
                </div>
                
                <div class="vt-hero-visual">
                    <div class="vt-hero-image">
                        <img src="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 400 300'><rect fill='%23e2e8f0' width='400' height='300'/><text x='50%' y='50%' font-size='18' text-anchor='middle' alignment-baseline='middle' fill='%230066CC'>📱💻🚀 Soluções Digitais</text></svg>" alt="Soluções VancouverTec" />
                        
                        <div class="vt-floating-cards">
                            <div class="vt-float-card vt-float-1">
                                <span class="vt-card-icon">💻</span>
                                <span>Sites Profissionais</span>
                            </div>
                            <div class="vt-float-card vt-float-2">
                                <span class="vt-card-icon">📱</span>
                                <span>Apps Mobile</span>
                            </div>
                            <div class="vt-float-card vt-float-3">
                                <span class="vt-card-icon">🏪</span>
                                <span>E-commerce</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Produtos em Destaque -->
    <?php if (class_exists('WooCommerce')): ?>
    <section class="vt-featured-products">
        <div class="container">
            <div class="vt-section-header">
                <h2 class="vt-section-title">Produtos Mais Vendidos</h2>
                <p class="vt-section-subtitle">Soluções testadas e aprovadas por centenas de clientes</p>
            </div>
            
            <div class="vt-products-showcase">
                <?php
                $featured_products = wc_get_products([
                    'limit' => 4,
                    'status' => 'publish',
                    'featured' => true,
                    'visibility' => 'catalog',
                ]);
                
                if (!empty($featured_products)):
                    foreach ($featured_products as $product):
                ?>
                <div class="vt-product-showcase">
                    <div class="vt-product-image">
                        <?php echo $product->get_image(); ?>
                        <?php if ($product->is_on_sale()): ?>
                        <span class="vt-sale-badge">🔥 Oferta</span>
                        <?php endif; ?>
                    </div>
                    
                    <div class="vt-product-info">
                        <h3><?php echo $product->get_name(); ?></h3>
                        <div class="vt-product-price">
                            <?php echo $product->get_price_html(); ?>
                        </div>
                        <div class="vt-product-rating">
                            ⭐⭐⭐⭐⭐ <span>(4.9)</span>
                        </div>
                        <a href="<?php echo $product->get_permalink(); ?>" class="button btn-primary">
                            Ver Detalhes
                        </a>
                    </div>
                </div>
                <?php 
                    endforeach;
                else:
                    echo do_shortcode('[featured_products limit="4" columns="4"]');
                endif; 
                ?>
            </div>
            
            <div class="vt-section-action">
                <a href="<?php echo esc_url(wc_get_page_permalink('shop')); ?>" class="button btn-outline btn-large">
                    Ver Todos os Produtos 🚀
                </a>
            </div>
        </div>
    </section>
    <?php endif; ?>

    <!-- Por Que Escolher -->
    <section class="vt-why-choose" id="sobre">
        <div class="container">
            <div class="vt-section-header">
                <h2 class="vt-section-title">Por que 500+ empresas escolheram a VancouverTec?</h2>
                <p class="vt-section-subtitle">Qualidade, performance e resultados comprovados</p>
            </div>
            
            <div class="vt-benefits-grid">
                <div class="vt-benefit-card">
                    <div class="vt-benefit-icon">⚡</div>
                    <h3>Performance 99+</h3>
                    <p>Sites e sistemas otimizados para carregamento ultra-rápido e melhor experiência do usuário.</p>
                    <div class="vt-benefit-proof">
                        <span class="vt-proof-badge">PageSpeed Score: 99/100</span>
                    </div>
                </div>
                
                <div class="vt-benefit-card">
                    <div class="vt-benefit-icon">🎯</div>
                    <h3>Suporte Especializado</h3>
                    <p>Equipe técnica dedicada 24/7 para garantir que seu projeto funcione perfeitamente sempre.</p>
                    <div class="vt-benefit-proof">
                        <span class="vt-proof-badge">Tempo resposta: < 2h</span>
                    </div>
                </div>
                
                <div class="vt-benefit-card">
                    <div class="vt-benefit-icon">🔒</div>
                    <h3>Segurança Máxima</h3>
                    <p>Código limpo, criptografia avançada e proteção contra ameaças digitais mais modernas.</p>
                    <div class="vt-benefit-proof">
                        <span class="vt-proof-badge">SSL + Firewall Inclusos</span>
                    </div>
                </div>
                
                <div class="vt-benefit-card">
                    <div class="vt-benefit-icon">📈</div>
                    <h3>ROI Comprovado</h3>
                    <p>Nossas soluções aumentam em média 300% a conversão e vendas dos nossos clientes.</p>
                    <div class="vt-benefit-proof">
                        <span class="vt-proof-badge">+300% Conversão Média</span>
                    </div>
                </div>
                
                <div class="vt-benefit-card">
                    <div class="vt-benefit-icon">🚀</div>
                    <h3>Entrega Rápida</h3>
                    <p>Projetos entregues em até 48h para produtos digitais e 15 dias para desenvolvimentos custom.</p>
                    <div class="vt-benefit-proof">
                        <span class="vt-proof-badge">Prazo garantido</span>
                    </div>
                </div>
                
                <div class="vt-benefit-card">
                    <div class="vt-benefit-icon">💎</div>
                    <h3>Qualidade Premium</h3>
                    <p>Design moderno, código limpo e funcionalidades avançadas que destacam sua marca no mercado.</p>
                    <div class="vt-benefit-proof">
                        <span class="vt-proof-badge">Código clean + comentado</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action Final -->
    <section class="vt-final-cta">
        <div class="container">
            <div class="vt-cta-content">
                <div class="vt-cta-text">
                    <h2>Pronto para Transformar Seu Negócio?</h2>
                    <p>Junte-se a mais de 500 empresas que já transformaram seus resultados com nossas soluções digitais premium.</p>
                    
                    <div class="vt-urgency">
                        <span class="vt-urgency-icon">🔥</span>
                        <span class="vt-urgency-text">Oferta limitada: 50% OFF em todos os produtos até o final do mês!</span>
                    </div>
                </div>
                
                <div class="vt-cta-actions">
                    <?php if (class_exists('WooCommerce')): ?>
                    <a href="<?php echo esc_url(wc_get_page_permalink('shop')); ?>" class="button btn-success btn-large">
                        🚀 Começar Agora - 50% OFF
                    </a>
                    <?php endif; ?>
                    
                    <div class="vt-guarantee">
                        <span class="vt-guarantee-icon">✅</span>
                        <span>Garantia de 30 dias ou seu dinheiro de volta</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

</div>

<?php get_footer(); ?>
EOF

# 2. CSS ESPECÍFICO PARA HOMEPAGE
log_info "Criando CSS específico da homepage..."
cat > "${THEME_PATH}/assets/css/homepage.css" << 'EOF'
/* VancouverTec Homepage - Alta Conversão */

.vt-homepage {
  overflow-x: hidden;
}

/* Hero Section */
.vt-hero-section {
  background: linear-gradient(135deg, #0066CC 0%, #6366F1 50%, #0052A3 100%);
  color: white;
  padding: 4rem 0;
  position: relative;
  overflow: hidden;
}

.vt-hero-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
  align-items: center;
  min-height: 70vh;
}

.vt-hero-badge {
  background: rgba(255, 255, 255, 0.2);
  padding: 0.5rem 1rem;
  border-radius: 2rem;
  font-size: 0.875rem;
  font-weight: 600;
  margin-bottom: 1.5rem;
  display: inline-block;
}

.vt-hero-title {
  font-size: 3.5rem;
  font-weight: 800;
  line-height: 1.1;
  margin-bottom: 1.5rem;
}

.vt-text-gradient {
  background: linear-gradient(135deg, #10B981, #F59E0B);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.vt-hero-description {
  font-size: 1.25rem;
  opacity: 0.9;
  line-height: 1.6;
  margin-bottom: 2rem;
}

.vt-hero-stats {
  display: flex;
  gap: 2rem;
  margin-bottom: 2.5rem;
}

.vt-stat {
  text-align: center;
}

.vt-stat-number {
  display: block;
  font-size: 2rem;
  font-weight: 800;
  color: #10B981;
}

.vt-stat-label {
  font-size: 0.875rem;
  opacity: 0.8;
}

.vt-hero-actions {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
}

/* Hero Visual */
.vt-hero-visual {
  position: relative;
}

.vt-hero-image {
  position: relative;
  border-radius: 1rem;
  overflow: hidden;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
}

.vt-hero-image img {
  width: 100%;
  height: auto;
}

.vt-floating-cards {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

.vt-float-card {
  position: absolute;
  background: white;
  padding: 0.75rem 1rem;
  border-radius: 0.5rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
  font-size: 0.875rem;
  font-weight: 600;
  color: #1F2937;
  animation: float 3s ease-in-out infinite;
}

.vt-float-1 { top: 15%; right: -10%; animation-delay: 0s; }
.vt-float-2 { bottom: 30%; left: -15%; animation-delay: 1s; }
.vt-float-3 { top: 60%; right: 10%; animation-delay: 2s; }

@keyframes float {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-10px); }
}

/* Produtos Showcase */
.vt-featured-products {
  padding: 5rem 0;
  background: #F8FAFC;
}

.vt-section-header {
  text-align: center;
  margin-bottom: 3rem;
}

.vt-section-title {
  font-size: 2.5rem;
  font-weight: 700;
  color: #0066CC;
  margin-bottom: 1rem;
}

.vt-section-subtitle {
  font-size: 1.125rem;
  color: #6B7280;
  max-width: 600px;
  margin: 0 auto;
}

.vt-products-showcase {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 2rem;
  margin-bottom: 3rem;
}

.vt-product-showcase {
  background: white;
  border-radius: 1rem;
  overflow: hidden;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
}

.vt-product-showcase:hover {
  transform: translateY(-5px);
}

.vt-product-image {
  position: relative;
  height: 200px;
  overflow: hidden;
}

.vt-product-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.vt-sale-badge {
  position: absolute;
  top: 1rem;
  right: 1rem;
  background: #EF4444;
  color: white;
  padding: 0.5rem 0.75rem;
  border-radius: 0.5rem;
  font-size: 0.75rem;
  font-weight: 600;
}

.vt-product-info {
  padding: 1.5rem;
}

.vt-product-info h3 {
  font-size: 1.25rem;
  font-weight: 600;
  margin-bottom: 0.75rem;
  color: #1F2937;
}

.vt-product-price {
  font-size: 1.5rem;
  font-weight: 700;
  color: #0066CC;
  margin-bottom: 0.5rem;
}

.vt-product-rating {
  margin-bottom: 1rem;
  color: #F59E0B;
}

/* Benefits Grid */
.vt-why-choose {
  padding: 5rem 0;
}

.vt-benefits-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
}

.vt-benefit-card {
  background: white;
  padding: 2rem;
  border-radius: 1rem;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
  text-align: center;
  transition: transform 0.3s ease;
}

.vt-benefit-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 30px rgba(0, 102, 204, 0.15);
}

.vt-benefit-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.vt-benefit-card h3 {
  font-size: 1.5rem;
  font-weight: 600;
  color: #0066CC;
  margin-bottom: 1rem;
}

.vt-benefit-card p {
  color: #6B7280;
  line-height: 1.6;
  margin-bottom: 1.5rem;
}

.vt-proof-badge {
  background: #10B981;
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 0.5rem;
  font-size: 0.875rem;
  font-weight: 600;
}

/* Final CTA */
.vt-final-cta {
  background: linear-gradient(135deg, #1F2937 0%, #374151 100%);
  color: white;
  padding: 4rem 0;
}

.vt-cta-content {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 3rem;
  align-items: center;
}

.vt-cta-text h2 {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 1rem;
}

.vt-cta-text p {
  font-size: 1.125rem;
  opacity: 0.9;
  margin-bottom: 1.5rem;
}

.vt-urgency {
  background: rgba(239, 68, 68, 0.2);
  padding: 1rem;
  border-radius: 0.5rem;
  border-left: 4px solid #EF4444;
  margin-bottom: 1.5rem;
}

.vt-urgency-icon {
  margin-right: 0.5rem;
}

.vt-cta-actions {
  text-align: center;
}

.vt-guarantee {
  margin-top: 1rem;
  font-size: 0.875rem;
  opacity: 0.8;
}

.vt-guarantee-icon {
  margin-right: 0.5rem;
}

/* Buttons */
.btn-large {
  padding: 1rem 2rem;
  font-size: 1.125rem;
  min-width: 200px;
}

.btn-success {
  background: linear-gradient(135deg, #10B981 0%, #059669 100%);
  color: white;
  border: none;
  box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
}

.btn-success:hover {
  background: linear-gradient(135deg, #059669 0%, #047857 100%);
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(16, 185, 129, 0.4);
  color: white;
}

/* Responsive */
@media (max-width: 768px) {
  .vt-hero-content {
    grid-template-columns: 1fr;
    gap: 2rem;
    text-align: center;
  }
  
  .vt-hero-title {
    font-size: 2.5rem;
  }
  
  .vt-hero-stats {
    justify-content: center;
  }
  
  .vt-cta-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
  
  .vt-benefits-grid {
    grid-template-columns: 1fr;
  }
  
  .vt-hero-actions {
    justify-content: center;
  }
}
EOF

# Conectar CSS no functions.php
log_info "Conectando CSS da homepage..."
cat >> "${THEME_PATH}/functions.php" << 'EOF'

/**
 * Homepage CSS
 */
function vt_enqueue_homepage_css() {
    if (is_front_page()) {
        wp_enqueue_style('vt-homepage', 
            VT_THEME_URI . '/assets/css/homepage.css', 
            ['vt-header-footer'], VT_THEME_VERSION);
    }
}
add_action('wp_enqueue_scripts', 'vt_enqueue_homepage_css', 30);
EOF

# Iniciar servidor
log_info "Iniciando servidor com homepage completa..."
nohup php -S localhost:8080 router.php > server.log 2>&1 &
echo $! > .server_pid
sleep 3

# Verificar arquivos
created_files=(
    "${THEME_PATH}/index.php"
    "${THEME_PATH}/assets/css/homepage.css"
)

for file in "${created_files[@]}"; do
    if [[ -f "$file" ]]; then
        log_success "✅ $(basename "$file")"
    else
        log_error "❌ $(basename "$file")"
    fi
done

# Relatório
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║      ✅ HOMEPAGE ALTA CONVERSÃO CRIADA! ✅    ║"
echo -e "║                                              ║"
echo -e "║  🚀 Hero section com estatísticas            ║"
echo -e "║  🛒 Produtos em destaque integrados          ║"
echo -e "║  💎 6 benefícios com provas sociais          ║"
echo -e "║  📞 CTA final com urgência                   ║"
echo -e "║  📱 Layout 100% responsivo                   ║"
echo -e "║  ⚡ Animações CSS modernas                   ║"
echo -e "║                                              ║"
echo -e "║  Elementos de Conversão:                     ║"
echo -e "║  • Prova social (500+ projetos)             ║"
echo -e "║  • Urgência (oferta limitada)               ║"
echo -e "║  • Benefícios claros com badges             ║"
echo -e "║  • Garantia de 30 dias                      ║"
echo -e "║  • CTAs estratégicos                        ║"
echo -e "║                                              ║"
echo -e "║  🌐 Acesse: http://localhost:8080            ║"
echo -e "║     🎯 HOMEPAGE PROFISSIONAL PRONTA! 🎯     ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "🏠 Homepage de alta conversão criada!"
log_info "🚀 Layout otimizado para vendas digitais aplicado!"