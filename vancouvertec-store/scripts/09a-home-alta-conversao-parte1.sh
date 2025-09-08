#!/bin/bash

# ===========================================
# VancouverTec Store - Home Alta Conversão PARTE 1
# Script: 09a-home-alta-conversao-parte1.sh
# Versão: 1.0.0 - Hero + Categorias + Promoções
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
║    🚀 HOME ALTA CONVERSÃO - PARTE 1 🚀       ║
║     Hero + Categorias + Banner Promoções     ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Criando home de alta conversão em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Criar estrutura de pastas
mkdir -p "$THEME_PATH/assets/css/pages"
mkdir -p "$THEME_PATH/assets/images"

# 1. FRONT-PAGE.PHP - Layout de alta conversão
log_info "Criando front-page.php de alta conversão..."
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
                <span><strong>Garantia de 30 dias</strong> ou seu dinheiro de volta</span>
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

<?php get_footer(); ?>
EOF

# 2. CSS PARA HOME DE ALTA CONVERSÃO
log_info "Criando CSS de alta conversão..."
cat > "$THEME_PATH/assets/css/pages/front-page.css" << 'EOF'
/* VancouverTec Store - Home Alta Conversão */

/* 1. HERO SECTION IMPACTANTE */
.hero-section-conversao {
  position: relative;
  min-height: 80vh;
  display: flex;
  align-items: center;
  overflow: hidden;
}

.hero-background {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: -1;
}

.hero-gradient {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, #0066CC 0%, #6366F1 50%, #8B5CF6 100%);
  opacity: 0.95;
}

.hero-pattern {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-image: 
    radial-gradient(circle at 25% 25%, rgba(255,255,255,0.1) 2px, transparent 2px),
    radial-gradient(circle at 75% 75%, rgba(255,255,255,0.1) 2px, transparent 2px);
  background-size: 50px 50px;
}

.hero-content {
  text-align: center;
  color: white;
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem 0;
}

.hero-badge {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  background: rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  padding: 0.75rem 1.5rem;
  border-radius: 50px;
  margin-bottom: 2rem;
  font-size: 0.875rem;
  font-weight: 600;
  border: 1px solid rgba(255, 255, 255, 0.3);
}

.badge-icon {
  font-size: 1.25rem;
}

.hero-title {
  font-size: clamp(2.5rem, 6vw, 4rem);
  font-weight: 800;
  line-height: 1.1;
  margin-bottom: 1.5rem;
}

.highlight-blue {
  color: #60A5FA;
}

.highlight-gradient {
  background: linear-gradient(135deg, #F59E0B, #EF4444);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero-subtitle {
  font-size: 1.25rem;
  line-height: 1.6;
  margin-bottom: 2rem;
  opacity: 0.95;
}

.text-success {
  color: #10B981;
  font-weight: 700;
}

/* Stats */
.hero-stats {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
  gap: 1.5rem;
  margin: 2.5rem 0;
  padding: 2rem;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(20px);
  border-radius: 20px;
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.stat-item {
  text-align: center;
}

.stat-number {
  font-size: 2.5rem;
  font-weight: 800;
  color: #F59E0B;
  line-height: 1;
  margin-bottom: 0.5rem;
}

.stat-label {
  font-size: 0.875rem;
  font-weight: 600;
  opacity: 0.9;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

/* CTAs */
.hero-actions {
  display: flex;
  gap: 1.5rem;
  justify-content: center;
  margin-bottom: 2rem;
  flex-wrap: wrap;
}

.btn-cta-primary {
  display: inline-flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1.25rem 2.5rem;
  background: linear-gradient(135deg, #F59E0B, #EF4444);
  color: white;
  text-decoration: none;
  border-radius: 50px;
  font-weight: 700;
  font-size: 1.125rem;
  transition: all 0.3s ease;
  box-shadow: 0 10px 30px rgba(245, 158, 11, 0.3);
}

.btn-cta-primary:hover {
  transform: translateY(-3px);
  box-shadow: 0 15px 40px rgba(245, 158, 11, 0.4);
  color: white;
}

.btn-arrow {
  transition: transform 0.3s ease;
}

.btn-cta-primary:hover .btn-arrow {
  transform: translateX(5px);
}

.btn-cta-secondary {
  display: inline-flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1.25rem 2.5rem;
  background: rgba(255, 255, 255, 0.15);
  backdrop-filter: blur(10px);
  color: white;
  text-decoration: none;
  border-radius: 50px;
  font-weight: 700;
  font-size: 1.125rem;
  border: 2px solid rgba(255, 255, 255, 0.3);
  transition: all 0.3s ease;
}

.btn-cta-secondary:hover {
  background: rgba(255, 255, 255, 0.25);
  transform: translateY(-3px);
  color: white;
}

/* Garantia */
.hero-guarantee {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem 1.5rem;
  background: rgba(16, 185, 129, 0.2);
  border: 1px solid rgba(16, 185, 129, 0.4);
  border-radius: 50px;
  font-size: 0.875rem;
  font-weight: 600;
}

.guarantee-icon {
  font-size: 1.25rem;
}

/* 2. BANNER PROMOÇÕES */
.promo-banner-section {
  padding: 0;
  background: linear-gradient(135deg, #EF4444, #F59E0B);
}

.promo-banner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 2rem;
  color: white;
  text-align: center;
  gap: 2rem;
}

.promo-badge {
  display: inline-block;
  background: rgba(255, 255, 255, 0.2);
  padding: 0.5rem 1rem;
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 700;
  margin-bottom: 1rem;
  text-transform: uppercase;
  letter-spacing: 1px;
}

.promo-title {
  font-size: 2rem;
  font-weight: 800;
  margin-bottom: 0.5rem;
}

.promo-subtitle {
  font-size: 1rem;
  opacity: 0.9;
  margin-bottom: 1.5rem;
}

.promo-countdown {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  margin-bottom: 1rem;
}

.countdown-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  background: rgba(255, 255, 255, 0.2);
  padding: 0.75rem;
  border-radius: 10px;
  min-width: 60px;
}

.countdown-number {
  font-size: 1.5rem;
  font-weight: 800;
  line-height: 1;
}

.countdown-label {
  font-size: 0.75rem;
  font-weight: 600;
  opacity: 0.8;
  text-transform: uppercase;
}

.countdown-divider {
  font-size: 1.5rem;
  font-weight: 800;
}

.btn-promo {
  padding: 1rem 2rem;
  background: white;
  color: #EF4444;
  text-decoration: none;
  border-radius: 50px;
  font-weight: 700;
  font-size: 1.125rem;
  transition: all 0.3s ease;
  display: inline-block;
}

.btn-promo:hover {
  transform: translateY(-3px);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
  color: #EF4444;
}

/* 3. CATEGORIAS */
.categories-section {
  padding: 5rem 0;
  background: #F9FAFB;
}

.section-header {
  text-align: center;
  margin-bottom: 4rem;
}

.section-title {
  font-size: clamp(2rem, 5vw, 3rem);
  font-weight: 800;
  color: #1F2937;
  margin-bottom: 1rem;
}

.section-subtitle {
  font-size: 1.25rem;
  color: #6B7280;
  max-width: 600px;
  margin: 0 auto;
}

.categories-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  max-width: 1200px;
  margin: 0 auto;
}

.category-card {
  background: white;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  position: relative;
}

.category-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
}

.category-image {
  position: relative;
  padding: 3rem 2rem 2rem;
  background: linear-gradient(135deg, #0066CC, #6366F1);
  text-align: center;
}

.category-icon {
  font-size: 4rem;
  margin-bottom: 1rem;
}

.category-badge {
  position: absolute;
  top: 1rem;
  right: 1rem;
  background: #F59E0B;
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 700;
}

.category-content {
  padding: 2rem;
  text-align: center;
}

.category-title {
  font-size: 1.5rem;
  font-weight: 700;
  color: #1F2937;
  margin-bottom: 1rem;
}

.category-description {
  color: #6B7280;
  margin-bottom: 1.5rem;
  line-height: 1.6;
}

.category-price {
  font-size: 1rem;
  color: #6B7280;
  margin-bottom: 1.5rem;
}

.price {
  font-size: 1.5rem;
  font-weight: 800;
  color: #0066CC;
}

.category-btn {
  display: inline-block;
  padding: 0.75rem 2rem;
  background: #0066CC;
  color: white;
  text-decoration: none;
  border-radius: 50px;
  font-weight: 600;
  transition: all 0.3s ease;
}

.category-btn:hover {
  background: #0052A3;
  transform: translateY(-2px);
  color: white;
}

/* Responsive */
@media (max-width: 768px) {
  .hero-stats {
    grid-template-columns: repeat(2, 1fr);
    gap: 1rem;
    padding: 1.5rem;
  }
  
  .hero-actions {
    flex-direction: column;
    align-items: center;
  }
  
  .promo-banner {
    flex-direction: column;
    text-align: center;
  }
  
  .promo-title {
    font-size: 1.5rem;
  }
  
  .categories-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
}

@media (max-width: 480px) {
  .hero-content {
    padding: 1rem 0;
  }
  
  .countdown-item {
    min-width: 50px;
    padding: 0.5rem;
  }
  
  .countdown-number {
    font-size: 1.25rem;
  }
}
EOF

# Atualizar functions.php para carregar o CSS
log_info "Atualizando functions.php..."
if ! grep -q "front-page.css" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_style.*vt-style/a\    wp_enqueue_style('"'"'vt-front-page'"'"', VT_THEME_URI . '"'"'/assets/css/pages/front-page.css'"'"', ['"'"'vt-style'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"
fi

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
echo -e "║     ✅ HOME ALTA CONVERSÃO - PARTE 1 ✅      ║"
echo -e "║    Hero + Categorias + Banner Criados       ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Hero section impactante com stats e CTAs"
log_success "✅ Banner de promoções com urgência e countdown"
log_success "✅ Categorias com cards visuais e preços"
log_success "✅ Design de alta conversão implementado"
log_success "✅ CSS responsivo para todos os dispositivos"

echo -e "\n${YELLOW}🎯 ELEMENTOS DE CONVERSÃO CRIADOS:${NC}"
echo -e "• Hero com social proof (500+ projetos, 99% satisfação)"
echo -e "• Stats impactantes (ROI 300%, entrega 7 dias)"
echo -e "• CTAs poderosos com cores chamativas"
echo -e "• Banner urgência com countdown"
echo -e "• Categorias com badges e preços claros"
echo -e "• Garantia de 30 dias visível"

echo -e "\n${BLUE}📱 TESTE AGORA:${NC}"
echo -e "• Desktop: http://localhost:8080"
echo -e "• Mobile: Redimensione para testar responsivo"
echo -e "• Veja hero impactante com gradiente"
echo -e "• Banner urgência no topo"
echo -e "• Cards de categorias com hover effects"

echo -e "\n${PURPLE}🔄 PRÓXIMA PARTE:${NC}"
log_info "Digite 'continuar' para PARTE 2 (Produtos + Depoimentos + CTAs)"

exit 0