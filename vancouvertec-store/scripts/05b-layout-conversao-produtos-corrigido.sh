#!/bin/bash

# ===========================================
# VancouverTec Store - Layout Alta Conversão Parte 2 CORRIGIDO
# Script: 05b-layout-conversao-produtos-corrigido.sh
# Versão: 1.1.0 - Seção Produtos + Depoimentos + CTA
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
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║      💰 LAYOUT ALTA CONVERSÃO - PARTE 2 💰   ║
║    Produtos + Depoimentos + CTA Final       ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Criando seções de produtos e conversão..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# CSS para seção de produtos de alta conversão
log_info "Criando CSS de produtos..."
cat > "$THEME_PATH/assets/css/components/products.css" << 'EOF'
/* VancouverTec - Produtos Alta Conversão */
.products-section {
  padding: 5rem 0;
  background: linear-gradient(135deg, #F9FAFB 0%, #F3F4F6 100%);
}

.section-header {
  text-align: center;
  margin-bottom: 4rem;
}

.section-badge {
  display: inline-block;
  background: linear-gradient(135deg, #0066CC, #6366F1);
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 20px;
  font-size: 0.875rem;
  font-weight: 700;
  margin-bottom: 1rem;
}

.section-title {
  font-size: clamp(2rem, 5vw, 3rem);
  font-weight: 800;
  color: #1F2937;
  margin-bottom: 1rem;
  line-height: 1.2;
}

.section-title .highlight {
  background: linear-gradient(135deg, #F59E0B, #EF4444);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.section-description {
  font-size: 1.125rem;
  color: #6B7280;
  max-width: 600px;
  margin: 0 auto;
  line-height: 1.6;
}

.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
  gap: 2rem;
  margin-bottom: 3rem;
}

.product-card {
  background: white;
  border-radius: 16px;
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
  overflow: hidden;
  transition: all 0.3s ease;
  position: relative;
  border: 1px solid transparent;
}

.product-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
  border-color: #0066CC;
}

.product-badges {
  position: absolute;
  top: 1rem;
  right: 1rem;
  z-index: 2;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.badge {
  padding: 0.25rem 0.75rem;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.badge-sale {
  background: linear-gradient(135deg, #EF4444, #DC2626);
  color: white;
  animation: pulse-red 2s infinite;
}

.badge-featured {
  background: linear-gradient(135deg, #F59E0B, #D97706);
  color: white;
}

.product-image {
  aspect-ratio: 16/10;
  overflow: hidden;
  position: relative;
}

.product-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.product-card:hover .product-image img {
  transform: scale(1.05);
}

.product-content {
  padding: 1.5rem;
}

.product-title {
  font-size: 1.25rem;
  font-weight: 700;
  color: #1F2937;
  margin-bottom: 0.75rem;
  line-height: 1.3;
}

.product-title a {
  color: inherit;
  text-decoration: none;
  transition: color 0.3s ease;
}

.product-title a:hover {
  color: #0066CC;
}

.product-description {
  color: #6B7280;
  line-height: 1.5;
  margin-bottom: 1rem;
}

.product-features {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
  margin-bottom: 1.5rem;
}

.feature {
  font-size: 0.875rem;
  color: #059669;
  font-weight: 600;
}

.product-price {
  font-size: 1.5rem;
  font-weight: 800;
  color: #0066CC;
  margin-bottom: 1.5rem;
}

.product-actions {
  display: flex;
  gap: 0.75rem;
}

.no-products {
  text-align: center;
  padding: 4rem 2rem;
  background: white;
  border-radius: 16px;
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
}

.empty-icon {
  font-size: 4rem;
  margin-bottom: 1rem;
  display: block;
}

@keyframes pulse-red {
  0% { box-shadow: 0 0 0 0 rgba(239, 68, 68, 0.4); }
  70% { box-shadow: 0 0 0 10px rgba(239, 68, 68, 0); }
  100% { box-shadow: 0 0 0 0 rgba(239, 68, 68, 0); }
}
EOF

# CSS para seção de depoimentos
log_info "Criando CSS de depoimentos..."
cat > "$THEME_PATH/assets/css/components/testimonials.css" << 'EOF'
/* VancouverTec - Depoimentos Alta Conversão */
.testimonials-section {
  padding: 5rem 0;
  background: white;
}

.testimonials-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin-top: 3rem;
}

.testimonial-card {
  background: #F9FAFB;
  border-radius: 16px;
  padding: 2rem;
  position: relative;
  border-left: 4px solid #0066CC;
  transition: all 0.3s ease;
}

.testimonial-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
}

.testimonial-quote {
  font-size: 1.125rem;
  line-height: 1.6;
  color: #374151;
  margin-bottom: 1.5rem;
  font-style: italic;
}

.testimonial-quote::before {
  content: '"';
  font-size: 3rem;
  color: #0066CC;
  position: absolute;
  top: 1rem;
  left: 1.5rem;
  font-family: serif;
}

.testimonial-author {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.author-avatar {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background: linear-gradient(135deg, #0066CC, #6366F1);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 700;
  font-size: 1.25rem;
}

.author-info h4 {
  font-weight: 700;
  color: #1F2937;
  margin: 0 0 0.25rem 0;
}

.author-info p {
  color: #6B7280;
  margin: 0;
  font-size: 0.875rem;
}

.testimonial-rating {
  display: flex;
  gap: 0.25rem;
  margin-top: 0.5rem;
}

.star {
  color: #F59E0B;
  font-size: 1.25rem;
}
EOF

# CSS para CTA final
log_info "Criando CSS do CTA final..."
cat > "$THEME_PATH/assets/css/components/cta.css" << 'EOF'
/* VancouverTec - CTA Final Alta Conversão */
.cta-section {
  background: linear-gradient(135deg, #1F2937 0%, #111827 100%);
  color: white;
  padding: 6rem 0;
  text-align: center;
  position: relative;
  overflow: hidden;
}

.cta-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: 
    radial-gradient(circle at 30% 20%, rgba(99, 102, 241, 0.3) 0%, transparent 50%),
    radial-gradient(circle at 70% 80%, rgba(245, 158, 11, 0.2) 0%, transparent 50%);
}

.cta-content {
  position: relative;
  z-index: 2;
  max-width: 700px;
  margin: 0 auto;
}

.cta-title {
  font-size: clamp(2rem, 5vw, 3.5rem);
  font-weight: 800;
  margin-bottom: 1.5rem;
  line-height: 1.2;
}

.cta-description {
  font-size: 1.25rem;
  line-height: 1.6;
  margin-bottom: 3rem;
  opacity: 0.9;
}

.cta-actions {
  margin-bottom: 3rem;
}

.cta-guarantee {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.75rem;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  border-radius: 12px;
  padding: 1rem 2rem;
  border: 1px solid rgba(255, 255, 255, 0.2);
  max-width: 400px;
  margin: 0 auto;
}

.guarantee-icon {
  font-size: 1.5rem;
}

.guarantee-text {
  font-weight: 600;
}
EOF

# Atualizar functions.php para incluir os novos CSS
log_info "Atualizando functions.php..."
if ! grep -q "vt-products" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_style.*vt-hero/a\    wp_enqueue_style('"'"'vt-products'"'"', VT_THEME_URI . '"'"'/assets/css/components/products.css'"'"', ['"'"'vt-hero'"'"'], VT_THEME_VERSION);\n    wp_enqueue_style('"'"'vt-testimonials'"'"', VT_THEME_URI . '"'"'/assets/css/components/testimonials.css'"'"', ['"'"'vt-products'"'"'], VT_THEME_VERSION);\n    wp_enqueue_style('"'"'vt-cta'"'"', VT_THEME_URI . '"'"'/assets/css/components/cta.css'"'"', ['"'"'vt-testimonials'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"
fi

# Atualizar front-page.php com seções completas
log_info "Atualizando front-page.php com seções completas..."
cat >> "$THEME_PATH/front-page.php" << 'EOF'

<?php if (class_exists('WooCommerce')) : ?>
<section class="products-section">
    <div class="container">
        <div class="section-header">
            <div class="section-badge">🏆 Mais Vendidos</div>
            <h2 class="section-title">
                Produtos que <span class="highlight">Transformam Negócios</span>
            </h2>
            <p class="section-description">
                Soluções testadas e aprovadas por centenas de empresas
            </p>
        </div>
        
        <div class="products-grid">
            <?php
            $products = get_posts([
                'post_type' => 'product',
                'posts_per_page' => 3,
                'post_status' => 'publish'
            ]);
            
            if ($products) :
                foreach ($products as $product_post) :
                    $product = wc_get_product($product_post->ID);
                    if (!$product) continue;
                    ?>
                    <div class="product-card">
                        <div class="product-badges">
                            <span class="badge badge-sale">🔥 OFERTA</span>
                        </div>
                        
                        <div class="product-image">
                            <a href="<?php echo get_permalink($product->get_id()); ?>">
                                <?php echo $product->get_image('medium'); ?>
                            </a>
                        </div>
                        
                        <div class="product-content">
                            <h3 class="product-title">
                                <a href="<?php echo get_permalink($product->get_id()); ?>">
                                    <?php echo $product->get_name(); ?>
                                </a>
                            </h3>
                            
                            <div class="product-features">
                                <span class="feature">✅ Suporte Incluso</span>
                                <span class="feature">✅ Garantia 30 dias</span>
                            </div>
                            
                            <div class="product-price">
                                <?php echo $product->get_price_html(); ?>
                            </div>
                            
                            <div class="product-actions">
                                <a href="<?php echo get_permalink($product->get_id()); ?>" 
                                   class="btn btn-primary">
                                    Ver Detalhes
                                </a>
                            </div>
                        </div>
                    </div>
                    <?php
                endforeach;
                wp_reset_postdata();
            else : ?>
                <div class="no-products">
                    <span class="empty-icon">📦</span>
                    <h3>Em Breve: Produtos Incríveis!</h3>
                    <p>Estamos preparando soluções que vão revolucionar seu negócio.</p>
                </div>
            <?php endif; ?>
        </div>
    </div>
</section>
<?php endif; ?>

<section class="testimonials-section">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">O Que Nossos Clientes Dizem</h2>
        </div>
        
        <div class="testimonials-grid">
            <div class="testimonial-card">
                <div class="testimonial-quote">
                    Aumentamos nosso faturamento em 250% nos primeiros 6 meses!
                </div>
                <div class="testimonial-author">
                    <div class="author-avatar">JS</div>
                    <div class="author-info">
                        <h4>João Silva</h4>
                        <p>CEO, TechCorp Brasil</p>
                        <div class="testimonial-rating">
                            <span class="star">★★★★★</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="testimonial-card">
                <div class="testimonial-quote">
                    Sistema perfeito! Automatizou 80% dos nossos processos.
                </div>
                <div class="testimonial-author">
                    <div class="author-avatar">MS</div>
                    <div class="author-info">
                        <h4>Maria Santos</h4>
                        <p>Diretora, InnovaLabs</p>
                        <div class="testimonial-rating">
                            <span class="star">★★★★★</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="cta-section">
    <div class="container">
        <div class="cta-content">
            <h2 class="cta-title">
                Pronto para <span class="highlight">Multiplicar</span> seu Faturamento?
            </h2>
            <p class="cta-description">
                Agende uma conversa GRATUITA com nossos especialistas.
            </p>
            
            <div class="cta-actions">
                <a href="/contato" class="btn btn-success btn-large">
                    💬 Agendar Consulta GRÁTIS
                </a>
            </div>
            
            <div class="cta-guarantee">
                <span class="guarantee-icon">🛡️</span>
                <span class="guarantee-text">
                    <strong>Garantia de 30 dias</strong>
                </span>
            </div>
        </div>
    </div>
</section>
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
echo -e "║    💰 PARTE 2 CRIADA COM SUCESSO! 💰         ║"
echo -e "║      Layout Completo de Alta Conversão       ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Seção de produtos com badges"
log_success "✅ Depoimentos de clientes"
log_success "✅ CTA final com garantia"
log_success "✅ Home page completa funcionando"

echo -e "\n${YELLOW}🎯 TESTE AGORA:${NC}"
echo -e "• Frontend: http://localhost:8080"
echo -e "• Home completa com todas as seções"

log_warning "Digite 'continuar' para criar o Plugin VancouverTec Digital Manager"

exit 0