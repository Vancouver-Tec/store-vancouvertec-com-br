#!/bin/bash

# ===========================================
# VancouverTec Store - Layout Alta Conversão Parte 1
# Script: 05a-layout-conversao-hero.sh
# Versão: 1.0.0 - Hero Section + Estrutura Base
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
║      💰 LAYOUT ALTA CONVERSÃO - PARTE 1 💰   ║
║        Hero Section + Estrutura Base         ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Criando layout de alta conversão em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Criar estrutura organizada
log_info "Criando estrutura organizada..."
mkdir -p "$THEME_PATH"/assets/css/{components,layouts,pages}

# CSS de botões de alta conversão
log_info "Criando sistema de botões de conversão..."
cat > "$THEME_PATH/assets/css/components/buttons.css" << 'EOF'
/* VancouverTec - Botões de Alta Conversão */
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 1rem 2rem;
  font-family: var(--vt-font-primary);
  font-size: 1rem;
  font-weight: 700;
  text-decoration: none;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
  min-height: 52px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}

.btn::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
  transition: left 0.6s;
}

.btn:hover::before {
  left: 100%;
}

.btn-primary {
  background: linear-gradient(135deg, #0066CC 0%, #0052A3 100%);
  color: white;
}

.btn-primary:hover {
  background: linear-gradient(135deg, #0052A3 0%, #004080 100%);
  transform: translateY(-3px);
  box-shadow: 0 8px 25px rgba(0, 102, 204, 0.4);
  color: white;
}

.btn-success {
  background: linear-gradient(135deg, #10B981 0%, #059669 100%);
  color: white;
  animation: pulse-green 2s infinite;
}

.btn-success:hover {
  background: linear-gradient(135deg, #059669 0%, #047857 100%);
  transform: translateY(-3px);
  color: white;
}

.btn-large {
  padding: 1.25rem 2.5rem;
  font-size: 1.125rem;
  min-height: 60px;
}

@keyframes pulse-green {
  0% { box-shadow: 0 4px 15px rgba(16, 185, 129, 0.4); }
  50% { box-shadow: 0 4px 25px rgba(16, 185, 129, 0.6); }
  100% { box-shadow: 0 4px 15px rgba(16, 185, 129, 0.4); }
}
EOF

# CSS do Hero Section impactante
log_info "Criando hero section de alta conversão..."
cat > "$THEME_PATH/assets/css/layouts/hero.css" << 'EOF'
/* VancouverTec - Hero Section Alta Conversão */
.hero-section {
  position: relative;
  background: linear-gradient(135deg, #0066CC 0%, #6366F1 100%);
  color: white;
  padding: 6rem 0;
  overflow: hidden;
  min-height: 80vh;
  display: flex;
  align-items: center;
}

.hero-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: 
    radial-gradient(circle at 20% 80%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
    radial-gradient(circle at 80% 20%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
  animation: heroFloat 6s ease-in-out infinite;
}

@keyframes heroFloat {
  0%, 100% { transform: translateY(0px); }
  50% { transform: translateY(-10px); }
}

.hero-content {
  position: relative;
  z-index: 2;
  max-width: 800px;
  margin: 0 auto;
  text-align: center;
}

.hero-badge {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  background: rgba(255, 255, 255, 0.15);
  backdrop-filter: blur(10px);
  border-radius: 50px;
  padding: 0.75rem 1.5rem;
  margin-bottom: 2rem;
  font-weight: 600;
  animation: fadeInUp 1s ease-out;
}

.hero-title {
  font-size: clamp(2.5rem, 6vw, 4rem);
  font-weight: 800;
  line-height: 1.1;
  margin-bottom: 1.5rem;
  animation: fadeInUp 1s ease-out 0.2s both;
}

.hero-title .highlight {
  background: linear-gradient(135deg, #F59E0B, #EF4444);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero-subtitle {
  font-size: clamp(1.25rem, 3vw, 1.75rem);
  font-weight: 600;
  margin-bottom: 1rem;
  animation: fadeInUp 1s ease-out 0.4s both;
}

.hero-description {
  font-size: clamp(1rem, 2vw, 1.25rem);
  line-height: 1.6;
  margin-bottom: 3rem;
  opacity: 0.9;
  animation: fadeInUp 1s ease-out 0.6s both;
}

.hero-stats {
  display: flex;
  justify-content: center;
  gap: 3rem;
  margin-bottom: 3rem;
  animation: fadeInUp 1s ease-out 0.8s both;
}

.stat-item {
  text-align: center;
}

.stat-number {
  display: block;
  font-size: 2.5rem;
  font-weight: 800;
  color: #F59E0B;
  line-height: 1;
}

.stat-label {
  font-size: 0.875rem;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  opacity: 0.8;
}

.hero-actions {
  display: flex;
  gap: 1.5rem;
  justify-content: center;
  margin-bottom: 3rem;
  animation: fadeInUp 1s ease-out 1s both;
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@media (max-width: 768px) {
  .hero-section {
    padding: 4rem 0;
    min-height: 70vh;
  }
  
  .hero-stats {
    gap: 1.5rem;
  }
  
  .hero-actions {
    flex-direction: column;
    align-items: center;
  }
}
EOF

# front-page.php de alta conversão
log_info "Criando front-page.php impactante..."
cat > "$THEME_PATH/front-page.php" << 'EOF'
<?php
/**
 * Front Page - Layout de Alta Conversão VancouverTec Store
 */

get_header(); ?>

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

<!-- Placeholder para próximas seções -->
<div style="padding: 2rem 0; text-align: center; background: #f9f9f9;">
    <div class="container">
        <h3>Próximas seções serão criadas na Parte 2...</h3>
        <p>Produtos, depoimentos, garantias e muito mais!</p>
    </div>
</div>

<?php get_footer(); ?>
EOF

# Atualizar functions.php para incluir os novos CSS
log_info "Atualizando functions.php..."
sed -i '/wp_enqueue_style.*vt-style/a\    wp_enqueue_style('"'"'vt-buttons'"'"', VT_THEME_URI . '"'"'/assets/css/components/buttons.css'"'"', ['"'"'vt-style'"'"'], VT_THEME_VERSION);\n    wp_enqueue_style('"'"'vt-hero'"'"', VT_THEME_URI . '"'"'/assets/css/layouts/hero.css'"'"', ['"'"'vt-buttons'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"

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
echo -e "║    💰 PARTE 1 CRIADA COM SUCESSO! 💰         ║"
echo -e "║      Hero Section de Alta Conversão          ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Hero section impactante criado"
log_success "✅ Sistema de botões de conversão"
log_success "✅ Estrutura organizada em componentes"
log_success "✅ Animações e efeitos visuais"

echo -e "\n${YELLOW}🎯 TESTE AGORA:${NC}"
echo -e "• Frontend: http://localhost:8080"
echo -e "• Veja o hero section azul impactante"
echo -e "• Botões com animações e efeitos"

echo -e "\n${BLUE}📁 Estrutura Criada:${NC}"
echo -e "• assets/css/components/buttons.css"
echo -e "• assets/css/layouts/hero.css"
echo -e "• front-page.php com hero de conversão"

echo -e "\n${PURPLE}📋 PRÓXIMO PASSO:${NC}"
log_warning "Digite 'continuar' para Parte 2:"
log_info "• Seção de produtos de alta conversão"
log_info "• Seção de depoimentos e garantias"
log_info "• Call-to-action final"

exit 0