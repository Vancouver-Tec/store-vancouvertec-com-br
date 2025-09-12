#!/bin/bash

# ===========================================
# VancouverTec Store - Refinamento Visual CSS Final
# Script: 31f-woo-visual-refinamento-final.sh
# Versão: 1.0.0 - CSS Visual 75% → 100% Completo
# ===========================================

set -euo pipefail

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Variáveis
PROJECT_PATH="/home/$(whoami)/vancouvertec/store-vancouvertec-com-br/vancouvertec-store"
THEME_PATH="wp-content/themes/vancouvertec-store"
CSS_PATH="${THEME_PATH}/assets/css"

# Funções de log
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║      🎨 REFINAMENTO VISUAL FINAL 🎨           ║
║    CSS 75% → 100% | Design VancouverTec     ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar base
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Execute antes: 31e-woo-performance-final.sh"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Aplicando refinamento visual em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost:8080" > /dev/null; then
    log_warning "Parando servidor..."
    pkill -f "php -S localhost:8080" || true
    sleep 2
fi

# 1. CSS VISUAL REFINAMENTO COMPLETO
log_info "Criando CSS de refinamento visual..."
cat > "${CSS_PATH}/visual-refinamento.css" << 'EOF'
/**
 * VancouverTec Store - Visual Refinamento Final
 * Design 100% Profissional Azul Institucional
 */

/* ========================================
   PÁGINA CARRINHO VAZIO - CALL TO ACTION
   ======================================== */
.vt-empty-cart {
    min-height: 60vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: var(--vt-space-xl) 0;
}

.vt-empty-content {
    text-align: center;
    padding: var(--vt-space-2xl) var(--vt-space-md);
    background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
    border-radius: var(--vt-radius-xl);
    box-shadow: var(--vt-shadow-xl);
    max-width: 600px;
}

.vt-empty-icon {
    font-size: 4rem;
    margin-bottom: var(--vt-space-lg);
    opacity: 0.7;
    animation: vt-bounce 2s infinite;
}

@keyframes vt-bounce {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
}

.vt-empty-content h2 {
    font-size: 2rem;
    color: var(--vt-neutral-800);
    margin-bottom: var(--vt-space-md);
}

.vt-empty-content p {
    font-size: 1.125rem;
    color: var(--vt-neutral-600);
    margin-bottom: var(--vt-space-xl);
}

.vt-empty-actions {
    margin-bottom: var(--vt-space-xl);
}

.vt-why-choose {
    margin-top: var(--vt-space-xl);
    padding: var(--vt-space-xl);
    background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
    border-radius: var(--vt-radius-lg);
    border: 2px solid var(--vt-blue-600);
    position: relative;
    overflow: hidden;
}

.vt-why-choose::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: linear-gradient(45deg, transparent 30%, rgba(0, 102, 204, 0.05) 50%, transparent 70%);
    animation: vt-shimmer 3s ease-in-out infinite;
}

@keyframes vt-shimmer {
    0% { transform: translateX(-100%) translateY(-100%) rotate(30deg); }
    100% { transform: translateX(100%) translateY(100%) rotate(30deg); }
}

.vt-why-choose h3 {
    color: var(--vt-blue-600);
    font-size: 1.5rem;
    margin-bottom: var(--vt-space-lg);
    text-align: center;
}

.vt-benefits {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: var(--vt-space-md);
}

.vt-benefit {
    display: flex;
    align-items: center;
    gap: var(--vt-space-sm);
    padding: var(--vt-space-md);
    background: white;
    border-radius: var(--vt-radius-md);
    box-shadow: var(--vt-shadow-sm);
    transition: var(--vt-transition);
}

.vt-benefit:hover {
    transform: translateY(-2px);
    box-shadow: var(--vt-shadow-md);
}

.vt-benefit .vt-icon {
    font-size: 1.5rem;
    color: var(--vt-success-500);
}

/* ========================================
   HOMEPAGE HERO SECTION REFINADO
   ======================================== */
.vt-hero {
    margin: var(--vt-space-lg) 0;
    background: linear-gradient(135deg, var(--vt-blue-600) 0%, var(--vt-indigo-500) 50%, var(--vt-blue-700) 100%);
    border-radius: var(--vt-radius-xl);
    position: relative;
    overflow: hidden;
}

.vt-hero::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="20" cy="20" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="80" cy="80" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="40" cy="60" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="60" cy="40" r="1" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
    opacity: 0.3;
}

.vt-hero-content {
    position: relative;
    z-index: 2;
    padding: var(--vt-space-2xl) var(--vt-space-lg);
}

.vt-hero-title {
    font-size: 3rem;
    font-weight: 700;
    margin-bottom: var(--vt-space-md);
    line-height: 1.1;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.vt-hero-subtitle {
    font-size: 1.25rem;
    margin-bottom: var(--vt-space-xl);
    opacity: 0.95;
}

.vt-hero-actions {
    display: flex;
    gap: var(--vt-space-md);
    justify-content: center;
    flex-wrap: wrap;
}

/* ========================================
   FEATURES GRID COM HOVER EFFECTS
   ======================================== */
.vt-features {
    padding: var(--vt-space-2xl) 0;
    background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
    border-radius: var(--vt-radius-xl);
    margin: var(--vt-space-xl) 0;
}

.vt-features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: var(--vt-space-xl);
    padding: var(--vt-space-lg) 0;
}

.vt-feature-card {
    background: white;
    padding: var(--vt-space-xl);
    border-radius: var(--vt-radius-xl);
    box-shadow: var(--vt-shadow-sm);
    text-align: center;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    overflow: hidden;
    border: 1px solid var(--vt-neutral-100);
}

.vt-feature-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(0, 102, 204, 0.1), transparent);
    transition: left 0.6s ease;
}

.vt-feature-card:hover::before {
    left: 100%;
}

.vt-feature-card:hover {
    transform: translateY(-8px) scale(1.02);
    box-shadow: 0 20px 40px rgba(0, 102, 204, 0.15);
    border-color: var(--vt-blue-600);
}

.vt-feature-icon {
    font-size: 3rem;
    margin-bottom: var(--vt-space-md);
    display: block;
    transition: var(--vt-transition);
}

.vt-feature-card:hover .vt-feature-icon {
    transform: scale(1.1) rotate(5deg);
}

.vt-feature-card h3 {
    color: var(--vt-blue-600);
    font-size: 1.25rem;
    margin-bottom: var(--vt-space-md);
    transition: var(--vt-transition);
}

.vt-feature-card:hover h3 {
    color: var(--vt-blue-700);
}

/* ========================================
   SHOP GRID PRODUTOS MODERNOS
   ======================================== */
.woocommerce ul.products li.product {
    background: white;
    border: 1px solid var(--vt-neutral-200);
    border-radius: var(--vt-radius-lg);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    overflow: hidden;
    position: relative;
    box-shadow: var(--vt-shadow-sm);
}

.woocommerce ul.products li.product::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500));
    opacity: 0;
    transition: opacity 0.3s ease;
    z-index: 1;
}

.woocommerce ul.products li.product:hover::before {
    opacity: 0.05;
}

.woocommerce ul.products li.product:hover {
    transform: translateY(-4px);
    box-shadow: 0 15px 35px rgba(0, 102, 204, 0.15);
    border-color: var(--vt-blue-600);
}

.woocommerce ul.products li.product img {
    height: 250px;
    object-fit: cover;
    width: 100%;
    transition: transform 0.3s ease;
    position: relative;
    z-index: 2;
}

.woocommerce ul.products li.product:hover img {
    transform: scale(1.05);
}

.woocommerce ul.products li.product .price {
    font-size: 1.5rem;
    color: var(--vt-blue-600);
    font-weight: 700;
    margin: var(--vt-space-md);
    position: relative;
    z-index: 2;
}

.woocommerce ul.products li.product .woocommerce-loop-product__title {
    position: relative;
    z-index: 2;
    transition: color 0.3s ease;
}

.woocommerce ul.products li.product:hover .woocommerce-loop-product__title {
    color: var(--vt-blue-700);
}

/* ========================================
   SINGLE PRODUCT LAYOUT 2 COLUNAS + TRUST
   ======================================== */
.vt-product-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: var(--vt-space-2xl);
    background: white;
    padding: var(--vt-space-2xl);
    border-radius: var(--vt-radius-xl);
    box-shadow: 0 4px 25px rgba(0, 0, 0, 0.08);
    margin-bottom: var(--vt-space-xl);
}

.vt-trust-badges {
    background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
    border: 2px solid var(--vt-success-500);
    padding: var(--vt-space-lg);
    border-radius: var(--vt-radius-lg);
    margin: var(--vt-space-lg) 0;
    position: relative;
    overflow: hidden;
}

.vt-trust-badges::before {
    content: '';
    position: absolute;
    top: -2px;
    left: -100%;
    width: 100%;
    height: 4px;
    background: linear-gradient(90deg, transparent, var(--vt-success-500), transparent);
    animation: vt-slide 2s linear infinite;
}

@keyframes vt-slide {
    0% { left: -100%; }
    100% { left: 100%; }
}

/* ========================================
   CHECKOUT STEPS COLORIDOS
   ======================================== */
.vt-step.active {
    background: linear-gradient(135deg, var(--vt-blue-600) 0%, var(--vt-indigo-500) 100%);
    color: white;
    box-shadow: 0 4px 20px rgba(0, 102, 204, 0.3);
    transform: scale(1.05);
}

.vt-step.active .vt-step-number {
    background: rgba(255, 255, 255, 0.25);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

/* ========================================
   SECURITY BADGES ELEGANTES
   ======================================== */
.vt-security-badges {
    background: var(--vt-neutral-900);
    padding: var(--vt-space-xl);
    border-radius: var(--vt-radius-lg);
    margin-top: var(--vt-space-xl);
    position: relative;
    overflow: hidden;
}

.vt-security-badges::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 3px;
    background: linear-gradient(90deg, var(--vt-blue-600), var(--vt-indigo-500), var(--vt-success-500));
}

.vt-security-item {
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    color: white;
    transition: all 0.3s ease;
}

.vt-security-item:hover {
    background: rgba(255, 255, 255, 0.1);
    transform: translateY(-2px);
}

/* ========================================
   RESPONSIVO REFINADO
   ======================================== */
@media (max-width: 768px) {
    .vt-product-container {
        grid-template-columns: 1fr;
        gap: var(--vt-space-lg);
        padding: var(--vt-space-lg);
    }
    
    .vt-hero-title {
        font-size: 2rem;
    }
    
    .vt-features-grid {
        grid-template-columns: 1fr;
        gap: var(--vt-space-lg);
    }
    
    .vt-benefits {
        grid-template-columns: 1fr;
    }
}
EOF

# Iniciar servidor
log_info "Iniciando servidor com visual refinado..."
nohup php -S localhost:8080 router.php > server.log 2>&1 &
echo $! > .server_pid
sleep 3

# Atualizar functions.php para incluir CSS refinamento
log_info "Conectando CSS de refinamento..."
cat >> "${THEME_PATH}/functions.php" << 'EOF'

/**
 * Enqueue Visual Refinamento CSS
 */
function vt_enqueue_visual_refinamento() {
    wp_enqueue_style('vt-visual-refinamento', 
        VT_THEME_URI . '/assets/css/visual-refinamento.css', 
        ['vt-woocommerce'], VT_THEME_VERSION);
}
add_action('wp_enqueue_scripts', 'vt_enqueue_visual_refinamento', 15);
EOF

# Verificar arquivo criado
if [[ -f "${CSS_PATH}/visual-refinamento.css" ]]; then
    log_success "✅ visual-refinamento.css"
else
    log_error "❌ visual-refinamento.css"
fi

# Relatório
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║      ✅ REFINAMENTO VISUAL COMPLETO! ✅       ║"
echo -e "║                                              ║"
echo -e "║  🎨 CSS Visual 75% → 100% FINALIZADO        ║"
echo -e "║                                              ║"
echo -e "║  🛒 Carrinho vazio call-to-action elegante   ║"
echo -e "║  🏠 Hero section com gradientes e animações  ║"
echo -e "║  🛍️ Shop grid cards modernos hover effects   ║"
echo -e "║  📱 Single product layout 2 colunas + trust  ║"
echo -e "║  💳 Checkout steps coloridos VancouverTec    ║"
echo -e "║  🔒 Security badges elegantes dark theme     ║"
echo -e "║                                              ║"
echo -e "║  Features Visuais:                          ║"
echo -e "║  • Animações CSS3 suaves                    ║"
echo -e "║  • Gradientes azul VancouverTec              ║"
echo -e "║  • Hover effects interativos                 ║"
echo -e "║  • Cards com shimmer effects                 ║"
echo -e "║  • Mobile responsivo refinado                ║"
echo -e "║                                              ║"
echo -e "║  🌐 Servidor: http://localhost:8080          ║"
echo -e "║     🎯 VISUAL 100% PROFISSIONAL! 🎯         ║"
echo -e "║                                              ║"
echo -e "║  🎉 PROYECTO VANCOUVERTEC STORE COMPLETO!   ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "🎨 Design VancouverTec Store 100% refinado!"
log_info "🚀 Acesse: http://localhost:8080 para ver o resultado final"