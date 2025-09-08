#!/bin/bash

# ===========================================
# VancouverTec Store - Home Alta Conversão PARTE 2
# Script: 09b-home-alta-conversao-parte2.sh
# Versão: 1.0.0 - Produtos + Depoimentos + CTAs
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
║    🛒 HOME ALTA CONVERSÃO - PARTE 2 🛒       ║
║    Produtos + Depoimentos + CTA Final       ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Adicionando seções de produtos e depoimentos..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Adicionar seções ao front-page.php
log_info "Adicionando seções de produtos em promoção..."
sed -i '/<?php get_footer(); ?>/i\
\
<!-- 4. PRODUTOS EM PROMOÇÃO -->\
<section class="featured-products-section">\
    <div class="container">\
        <div class="section-header">\
            <div class="section-badge">⚡ OFERTAS LIMITADAS</div>\
            <h2 class="section-title">Produtos em Promoção</h2>\
            <p class="section-subtitle">Aproveite os descontos especiais antes que acabem!</p>\
        </div>\
        \
        <div class="products-grid">\
            <div class="product-card featured">\
                <div class="product-badge">50% OFF</div>\
                <div class="product-image">\
                    <div class="product-icon">🌐</div>\
                </div>\
                <div class="product-content">\
                    <h3 class="product-title">Site WordPress Profissional</h3>\
                    <p class="product-description">Site completo com design moderno, responsivo e otimizado para SEO.</p>\
                    <div class="product-features">\
                        <span class="feature">✓ Design Responsivo</span>\
                        <span class="feature">✓ SEO Otimizado</span>\
                        <span class="feature">✓ Entrega 7 dias</span>\
                    </div>\
                    <div class="product-pricing">\
                        <span class="price-old">R$ 997</span>\
                        <span class="price-current">R$ 497</span>\
                    </div>\
                    <div class="product-urgency">\
                        <span class="urgency-text">⏰ Restam apenas 12 unidades!</span>\
                    </div>\
                    <a href="/produto/site-wordpress" class="product-btn">Comprar Agora</a>\
                </div>\
            </div>\
            \
            <div class="product-card">\
                <div class="product-badge">40% OFF</div>\
                <div class="product-image">\
                    <div class="product-icon">🛒</div>\
                </div>\
                <div class="product-content">\
                    <h3 class="product-title">Loja Virtual Completa</h3>\
                    <p class="product-description">E-commerce profissional com sistema de pagamento e gestão.</p>\
                    <div class="product-features">\
                        <span class="feature">✓ WooCommerce</span>\
                        <span class="feature">✓ Pagamento Online</span>\
                        <span class="feature">✓ Dashboard Admin</span>\
                    </div>\
                    <div class="product-pricing">\
                        <span class="price-old">R$ 1.997</span>\
                        <span class="price-current">R$ 1.197</span>\
                    </div>\
                    <div class="product-urgency">\
                        <span class="urgency-text">⏰ Oferta termina em 2 dias!</span>\
                    </div>\
                    <a href="/produto/loja-virtual" class="product-btn">Comprar Agora</a>\
                </div>\
            </div>\
            \
            <div class="product-card">\
                <div class="product-badge">30% OFF</div>\
                <div class="product-image">\
                    <div class="product-icon">📱</div>\
                </div>\
                <div class="product-content">\
                    <h3 class="product-title">App Mobile Nativo</h3>\
                    <p class="product-description">Aplicativo para Android e iOS com design moderno.</p>\
                    <div class="product-features">\
                        <span class="feature">✓ Android + iOS</span>\
                        <span class="feature">✓ Design Nativo</span>\
                        <span class="feature">✓ Push Notifications</span>\
                    </div>\
                    <div class="product-pricing">\
                        <span class="price-old">R$ 2.497</span>\
                        <span class="price-current">R$ 1.747</span>\
                    </div>\
                    <div class="product-urgency">\
                        <span class="urgency-text">⏰ Últimas 5 vagas!</span>\
                    </div>\
                    <a href="/produto/app-mobile" class="product-btn">Comprar Agora</a>\
                </div>\
            </div>\
        </div>\
    </div>\
</section>\
\
<!-- 5. DEPOIMENTOS COM FOTOS -->\
<section class="testimonials-section">\
    <div class="container">\
        <div class="section-header">\
            <h2 class="section-title">O Que Nossos Clientes Dizem</h2>\
            <p class="section-subtitle">Mais de 500 empresas já transformaram seus negócios conosco</p>\
        </div>\
        \
        <div class="testimonials-grid">\
            <div class="testimonial-card">\
                <div class="testimonial-content">\
                    <div class="stars">⭐⭐⭐⭐⭐</div>\
                    <p class="testimonial-text">\
                        "A VancouverTec criou nossa loja virtual e em 3 meses triplicamos as vendas online. \
                        O suporte é excepcional e a qualidade impecável!"\
                    </p>\
                </div>\
                <div class="testimonial-author">\
                    <div class="author-avatar">👨‍💼</div>\
                    <div class="author-info">\
                        <h4 class="author-name">Carlos Silva</h4>\
                        <span class="author-company">CEO - TechModa Ltda</span>\
                        <span class="author-result">+300% vendas online</span>\
                    </div>\
                </div>\
            </div>\
            \
            <div class="testimonial-card">\
                <div class="testimonial-content">\
                    <div class="stars">⭐⭐⭐⭐⭐</div>\
                    <p class="testimonial-text">\
                        "O sistema desenvolvido automatizou 80% dos nossos processos. \
                        Economizamos 20 horas por semana e aumentamos a produtividade!"\
                    </p>\
                </div>\
                <div class="testimonial-author">\
                    <div class="author-avatar">👩‍💼</div>\
                    <div class="author-info">\
                        <h4 class="author-name">Ana Costa</h4>\
                        <span class="author-company">Diretora - Inovare Soluções</span>\
                        <span class="author-result">-80% tempo processos</span>\
                    </div>\
                </div>\
            </div>\
            \
            <div class="testimonial-card">\
                <div class="testimonial-content">\
                    <div class="stars">⭐⭐⭐⭐⭐</div>\
                    <p class="testimonial-text">\
                        "O aplicativo mobile trouxe nossos clientes mais próximos. \
                        Engajamento aumentou 400% e fidelização melhorou drasticamente!"\
                    </p>\
                </div>\
                <div class="testimonial-author">\
                    <div class="author-avatar">👨‍💻</div>\
                    <div class="author-info">\
                        <h4 class="author-name">Roberto Lima</h4>\
                        <span class="author-company">Fundador - FitApp Brasil</span>\
                        <span class="author-result">+400% engajamento</span>\
                    </div>\
                </div>\
            </div>\
        </div>\
        \
        <div class="testimonials-stats">\
            <div class="stat-testimonial">\
                <div class="stat-number">99%</div>\
                <div class="stat-label">Clientes Satisfeitos</div>\
            </div>\
            <div class="stat-testimonial">\
                <div class="stat-number">500+</div>\
                <div class="stat-label">Projetos Entregues</div>\
            </div>\
            <div class="stat-testimonial">\
                <div class="stat-number">300%</div>\
                <div class="stat-label">ROI Médio</div>\
            </div>\
            <div class="stat-testimonial">\
                <div class="stat-number">24h</div>\
                <div class="stat-label">Suporte Rápido</div>\
            </div>\
        </div>\
    </div>\
</section>\
\
<!-- 6. POR QUE ESCOLHER -->\
<section class="why-choose-section">\
    <div class="container">\
        <div class="section-header">\
            <h2 class="section-title">Por Que Escolher a VancouverTec?</h2>\
            <p class="section-subtitle">Somos especialistas em transformar ideias em negócios digitais de sucesso</p>\
        </div>\
        \
        <div class="benefits-grid">\
            <div class="benefit-card">\
                <div class="benefit-icon">🚀</div>\
                <h3 class="benefit-title">Entrega Rápida</h3>\
                <p class="benefit-description">Seus projetos prontos em até 7 dias úteis com qualidade profissional.</p>\
            </div>\
            \
            <div class="benefit-card">\
                <div class="benefit-icon">🛡️</div>\
                <h3 class="benefit-title">Garantia Total</h3>\
                <p class="benefit-description">30 dias de garantia ou seu dinheiro de volta. Sua satisfação é garantida.</p>\
            </div>\
            \
            <div class="benefit-card">\
                <div class="benefit-icon">💎</div>\
                <h3 class="benefit-title">Qualidade Premium</h3>\
                <p class="benefit-description">Código limpo, design moderno e tecnologia de ponta em todos os projetos.</p>\
            </div>\
            \
            <div class="benefit-card">\
                <div class="benefit-icon">📞</div>\
                <h3 class="benefit-title">Suporte 24/7</h3>\
                <p class="benefit-description">Suporte técnico completo via WhatsApp, email e telefone quando precisar.</p>\
            </div>\
            \
            <div class="benefit-card">\
                <div class="benefit-icon">📈</div>\
                <h3 class="benefit-title">ROI Comprovado</h3>\
                <p class="benefit-description">Nossos clientes aumentam faturamento em média 300% no primeiro ano.</p>\
            </div>\
            \
            <div class="benefit-card">\
                <div class="benefit-icon">🔧</div>\
                <h3 class="benefit-title">Personalização</h3>\
                <p class="benefit-description">Soluções sob medida para as necessidades específicas do seu negócio.</p>\
            </div>\
        </div>\
    </div>\
</section>\
\
<!-- 7. CTA FINAL IMPACTANTE -->\
<section class="final-cta-section">\
    <div class="container">\
        <div class="cta-content">\
            <div class="cta-badge">🎯 OFERTA LIMITADA</div>\
            <h2 class="cta-title">\
                Pronto para Transformar Seu Negócio?\
            </h2>\
            <p class="cta-subtitle">\
                Junte-se a mais de 500 empresas que já escolheram a VancouverTec \
                para acelerar seus resultados no digital.\
            </p>\
            \
            <div class="cta-offer">\
                <div class="offer-text">\
                    <span class="offer-discount">50% OFF</span>\
                    <span class="offer-description">em todos os produtos até o final do mês</span>\
                </div>\
                <div class="offer-urgency">⏰ Oferta válida por apenas 48 horas!</div>\
            </div>\
            \
            <div class="cta-actions">\
                <a href="<?php echo class_exists(\"WooCommerce\") ? get_permalink(wc_get_page_id(\"shop\")) : \"#\"; ?>" class="cta-btn-primary">\
                    🛒 Ver Produtos em Oferta\
                </a>\
                <a href="/contato" class="cta-btn-secondary">\
                    💬 Falar com Especialista\
                </a>\
            </div>\
            \
            <div class="cta-guarantees">\
                <div class="guarantee-item">\
                    <span class="guarantee-icon">🛡️</span>\
                    <span>Garantia 30 dias</span>\
                </div>\
                <div class="guarantee-item">\
                    <span class="guarantee-icon">🚀</span>\
                    <span>Entrega em 7 dias</span>\
                </div>\
                <div class="guarantee-item">\
                    <span class="guarantee-icon">📞</span>\
                    <span>Suporte 24/7</span>\
                </div>\
            </div>\
        </div>\
    </div>\
</section>' "$THEME_PATH/front-page.php"

# CSS para as novas seções
log_info "Adicionando CSS para produtos e depoimentos..."
cat >> "$THEME_PATH/assets/css/pages/front-page.css" << 'EOF'

/* 4. PRODUTOS EM PROMOÇÃO */
.featured-products-section {
  padding: 5rem 0;
  background: white;
}

.section-badge {
  display: inline-block;
  background: linear-gradient(135deg, #EF4444, #F59E0B);
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 20px;
  font-size: 0.875rem;
  font-weight: 700;
  margin-bottom: 1rem;
}

.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
  gap: 2rem;
  margin-top: 3rem;
}

.product-card {
  background: white;
  border-radius: 20px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  transition: all 0.3s ease;
  position: relative;
  border: 2px solid transparent;
}

.product-card.featured {
  border-color: #F59E0B;
  transform: scale(1.05);
}

.product-card:hover {
  transform: translateY(-10px) scale(1.02);
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
}

.product-badge {
  position: absolute;
  top: 1rem;
  right: 1rem;
  background: #EF4444;
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 20px;
  font-size: 0.875rem;
  font-weight: 700;
  z-index: 10;
}

.product-image {
  padding: 3rem 2rem 2rem;
  background: linear-gradient(135deg, #0066CC, #6366F1);
  text-align: center;
}

.product-icon {
  font-size: 4rem;
}

.product-content {
  padding: 2rem;
}

.product-title {
  font-size: 1.5rem;
  font-weight: 700;
  color: #1F2937;
  margin-bottom: 1rem;
}

.product-description {
  color: #6B7280;
  margin-bottom: 1.5rem;
  line-height: 1.6;
}

.product-features {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  margin-bottom: 1.5rem;
}

.feature {
  font-size: 0.875rem;
  color: #10B981;
  font-weight: 600;
}

.product-pricing {
  margin-bottom: 1rem;
}

.price-old {
  text-decoration: line-through;
  color: #9CA3AF;
  margin-right: 0.75rem;
  font-size: 1rem;
}

.price-current {
  font-size: 1.75rem;
  font-weight: 800;
  color: #EF4444;
}

.product-urgency {
  background: #FEF3C7;
  border: 1px solid #F59E0B;
  padding: 0.75rem;
  border-radius: 8px;
  margin-bottom: 1.5rem;
  text-align: center;
}

.urgency-text {
  color: #92400E;
  font-weight: 600;
  font-size: 0.875rem;
}

.product-btn {
  display: block;
  width: 100%;
  padding: 1rem;
  background: linear-gradient(135deg, #0066CC, #6366F1);
  color: white;
  text-decoration: none;
  border-radius: 10px;
  font-weight: 700;
  text-align: center;
  transition: all 0.3s ease;
}

.product-btn:hover {
  background: linear-gradient(135deg, #0052A3, #4F46E5);
  transform: translateY(-2px);
  color: white;
}

/* 5. DEPOIMENTOS */
.testimonials-section {
  padding: 5rem 0;
  background: #F9FAFB;
}

.testimonials-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
  margin: 3rem 0;
}

.testimonial-card {
  background: white;
  border-radius: 20px;
  padding: 2rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.testimonial-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
}

.stars {
  font-size: 1.25rem;
  margin-bottom: 1rem;
}

.testimonial-text {
  font-size: 1.125rem;
  line-height: 1.6;
  color: #374151;
  margin-bottom: 2rem;
  font-style: italic;
}

.testimonial-author {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.author-avatar {
  font-size: 3rem;
  width: 60px;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #F3F4F6;
  border-radius: 50%;
}

.author-name {
  font-size: 1.125rem;
  font-weight: 700;
  color: #1F2937;
  margin-bottom: 0.25rem;
}

.author-company {
  font-size: 0.875rem;
  color: #6B7280;
  margin-bottom: 0.5rem;
  display: block;
}

.author-result {
  font-size: 0.875rem;
  color: #10B981;
  font-weight: 700;
  background: #ECFDF5;
  padding: 0.25rem 0.75rem;
  border-radius: 20px;
  display: inline-block;
}

.testimonials-stats {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: 2rem;
  margin-top: 3rem;
  padding: 2rem;
  background: white;
  border-radius: 20px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.stat-testimonial {
  text-align: center;
}

.stat-testimonial .stat-number {
  font-size: 2.5rem;
  font-weight: 800;
  color: #0066CC;
  line-height: 1;
  margin-bottom: 0.5rem;
}

.stat-testimonial .stat-label {
  font-size: 0.875rem;
  color: #6B7280;
  font-weight: 600;
}

/* 6. POR QUE ESCOLHER */
.why-choose-section {
  padding: 5rem 0;
  background: white;
}

.benefits-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 2rem;
  margin-top: 3rem;
}

.benefit-card {
  text-align: center;
  padding: 2rem;
  background: #F9FAFB;
  border-radius: 20px;
  transition: all 0.3s ease;
  border: 2px solid transparent;
}

.benefit-card:hover {
  background: white;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
  border-color: #0066CC;
  transform: translateY(-5px);
}

.benefit-icon {
  font-size: 4rem;
  margin-bottom: 1.5rem;
}

.benefit-title {
  font-size: 1.5rem;
  font-weight: 700;
  color: #1F2937;
  margin-bottom: 1rem;
}

.benefit-description {
  color: #6B7280;
  line-height: 1.6;
}

/* 7. CTA FINAL */
.final-cta-section {
  padding: 5rem 0;
  background: linear-gradient(135deg, #1F2937 0%, #374151 100%);
  color: white;
  text-align: center;
}

.cta-content {
  max-width: 800px;
  margin: 0 auto;
}

.cta-badge {
  display: inline-block;
  background: linear-gradient(135deg, #EF4444, #F59E0B);
  padding: 0.75rem 1.5rem;
  border-radius: 30px;
  font-weight: 700;
  margin-bottom: 2rem;
}

.cta-title {
  font-size: clamp(2rem, 5vw, 3rem);
  font-weight: 800;
  margin-bottom: 1.5rem;
}

.cta-subtitle {
  font-size: 1.25rem;
  opacity: 0.9;
  margin-bottom: 2rem;
  line-height: 1.6;
}

.cta-offer {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  padding: 2rem;
  border-radius: 20px;
  margin-bottom: 2rem;
  border: 1px solid rgba(255, 255, 255, 0.2);
}

.offer-discount {
  font-size: 2.5rem;
  font-weight: 800;
  color: #F59E0B;
  display: block;
  margin-bottom: 0.5rem;
}

.offer-description {
  font-size: 1.125rem;
  opacity: 0.9;
}

.offer-urgency {
  color: #FEF3C7;
  font-weight: 700;
  margin-top: 1rem;
}

.cta-actions {
  display: flex;
  gap: 1.5rem;
  justify-content: center;
  margin-bottom: 2rem;
  flex-wrap: wrap;
}

.cta-btn-primary {
  padding: 1.25rem 2.5rem;
  background: linear-gradient(135deg, #F59E0B, #EF4444);
  color: white;
  text-decoration: none;
  border-radius: 50px;
  font-weight: 700;
  font-size: 1.125rem;
  transition: all 0.3s ease;
}

.cta-btn-primary:hover {
  transform: translateY(-3px);
  box-shadow: 0 10px 30px rgba(245, 158, 11, 0.4);
  color: white;
}

.cta-btn-secondary {
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

.cta-btn-secondary:hover {
  background: rgba(255, 255, 255, 0.25);
  transform: translateY(-3px);
  color: white;
}

.cta-guarantees {
  display: flex;
  justify-content: center;
  gap: 2rem;
  flex-wrap: wrap;
  opacity: 0.9;
}

.guarantee-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.875rem;
  font-weight: 600;
}

.guarantee-icon {
  font-size: 1.25rem;
}

/* Responsive */
@media (max-width: 768px) {
  .products-grid {
    grid-template-columns: 1fr;
  }
  
  .product-card.featured {
    transform: none;
  }
  
  .testimonials-grid {
    grid-template-columns: 1fr;
  }
  
  .benefits-grid {
    grid-template-columns: 1fr;
  }
  
  .cta-actions {
    flex-direction: column;
    align-items: center;
  }
  
  .cta-guarantees {
    flex-direction: column;
    align-items: center;
  }
}
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
echo -e "║   ✅ HOME ALTA CONVERSÃO COMPLETA! ✅        ║"
echo -e "║    Todas as seções de vendas criadas        ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Produtos em promoção com urgência"
log_success "✅ Depoimentos com resultados reais"
log_success "✅ Seção 'Por que escolher' com benefícios"
log_success "✅ CTA final impactante com oferta"

echo -e "\n${YELLOW}🎯 Home completa para alta conversão criada!${NC}"

exit 0