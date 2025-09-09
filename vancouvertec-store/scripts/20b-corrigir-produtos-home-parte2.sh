#!/bin/bash

# ===========================================
# VancouverTec Store - Corrigir Produtos na Home PARTE 2
# Script: 20b-corrigir-produtos-home-parte2.sh
# Versão: 1.0.0 - CSS Avançado + Override WooCommerce
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
║    🎨 CSS AVANÇADO PRODUTOS - PARTE 2 🎨     ║
║        Override WooCommerce + Responsive     ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Criando CSS avançado para produtos home..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# CSS AVANÇADO PRODUTOS HOME
log_info "Criando CSS produtos home corrigido..."
cat > "$THEME_PATH/assets/css/components/woocommerce-home-fixed.css" << 'EOF'
/* VancouverTec Store - Produtos Home CORRIGIDOS */

/* SEÇÃO PRODUTOS HOME */
.real-products-section {
  padding: 5rem 0;
  background: linear-gradient(135deg, #F8FAFC 0%, #E2E8F0 100%);
  position: relative;
}

.real-products-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: url('data:image/svg+xml,<svg width="60" height="60" viewBox="0 0 60 60" xmlns="http://www.w3.org/2000/svg"><g fill="none" fill-rule="evenodd"><g fill="%230066CC" fill-opacity="0.03"><circle cx="7" cy="7" r="2"/></g></svg>') repeat;
  pointer-events: none;
}

/* GRID PRODUTOS CORRIGIDO */
.woo-products-grid-fixed {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
  gap: 2rem;
  margin: 3rem 0;
  position: relative;
  z-index: 2;
}

/* CARD PRODUTO HOME */
.woo-product-card-home {
  background: white;
  border-radius: 20px;
  overflow: hidden;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  position: relative;
  border: 2px solid transparent;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.woo-product-card-home:hover {
  transform: translateY(-12px) scale(1.02);
  box-shadow: 0 20px 60px rgba(0, 102, 204, 0.2);
  border-color: var(--vt-blue-600);
}

.woo-product-card-home.on-sale {
  border-color: #F59E0B;
}

/* BADGE OFERTA */
.sale-badge-home {
  position: absolute;
  top: 1rem;
  right: 1rem;
  background: linear-gradient(135deg, #EF4444, #DC2626);
  color: white;
  padding: 0.75rem 1rem;
  border-radius: 25px;
  font-size: 0.75rem;
  font-weight: 800;
  z-index: 10;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  box-shadow: 0 4px 20px rgba(239, 68, 68, 0.4);
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

/* IMAGEM PRODUTO */
.woo-product-image-home {
  position: relative;
  height: 240px;
  overflow: hidden;
  background: linear-gradient(135deg, #F8FAFC, #E2E8F0);
  display: flex;
  align-items: center;
  justify-content: center;
}

.woo-product-image-home a {
  display: block;
  width: 100%;
  height: 100%;
  overflow: hidden;
}

.product-thumb-home {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.4s ease;
}

.woo-product-card-home:hover .product-thumb-home {
  transform: scale(1.15);
}

.no-image-home {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
  text-align: center;
  color: #94A3B8;
}

.no-image-home .product-icon {
  font-size: 4rem;
  margin-bottom: 1rem;
  opacity: 0.7;
}

.no-image-home .product-placeholder {
  font-size: 1rem;
  font-weight: 600;
  color: #64748B;
}

/* OVERLAY HOVER */
.product-overlay-home {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(transparent, rgba(0, 0, 0, 0.95));
  padding: 3rem 1.5rem 1.5rem;
  display: flex;
  gap: 0.75rem;
  transform: translateY(100%);
  transition: transform 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.woo-product-card-home:hover .product-overlay-home {
  transform: translateY(0);
}

.add-to-cart-home,
.view-product-home {
  flex: 1;
  padding: 0.875rem 1rem;
  color: white;
  text-decoration: none;
  border-radius: 10px;
  font-weight: 700;
  font-size: 0.875rem;
  text-align: center;
  transition: all 0.3s ease;
  border: 2px solid transparent;
  position: relative;
  overflow: hidden;
}

.add-to-cart-home {
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500));
  border-color: var(--vt-blue-600);
}

.view-product-home {
  background: rgba(255, 255, 255, 0.2);
  border-color: rgba(255, 255, 255, 0.3);
  backdrop-filter: blur(10px);
}

.add-to-cart-home:hover {
  background: linear-gradient(135deg, var(--vt-blue-700), #4F46E5);
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(0, 102, 204, 0.4);
  color: white;
}

.view-product-home:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
  color: white;
}

/* CONTEÚDO PRODUTO */
.woo-product-content-home {
  padding: 2rem;
  flex: 1;
  display: flex;
  flex-direction: column;
  position: relative;
  z-index: 2;
}

.woo-product-title-home {
  margin-bottom: 1rem;
  flex-shrink: 0;
}

.woo-product-title-home a {
  color: #1F2937;
  text-decoration: none;
  font-size: 1.25rem;
  font-weight: 800;
  line-height: 1.3;
  transition: color 0.3s ease;
  display: block;
}

.woo-product-title-home a:hover {
  color: var(--vt-blue-600);
}

.woo-product-excerpt-home {
  color: #6B7280;
  line-height: 1.6;
  margin-bottom: 1.5rem;
  font-size: 0.9rem;
  flex: 1;
}

.woo-product-price-home {
  margin-bottom: 1rem;
  flex-shrink: 0;
}

.woo-product-price-home .price {
  font-size: 1.5rem;
  font-weight: 900;
  color: var(--vt-blue-600);
}

.woo-product-price-home .price .amount {
  font-weight: 900;
}

.woo-product-price-home del {
  color: #9CA3AF;
  margin-right: 0.5rem;
  font-size: 1.125rem;
}

.woo-product-price-home ins {
  text-decoration: none;
  color: #EF4444;
  font-weight: 900;
}

.woo-product-rating-home {
  margin-bottom: 1rem;
  flex-shrink: 0;
}

.woo-product-rating-home .star-rating {
  color: #F59E0B;
  font-size: 1rem;
}

.no-rating {
  color: #E5E7EB;
  font-size: 0.875rem;
  opacity: 0.7;
}

.woo-product-meta-home {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
  flex-shrink: 0;
}

.meta-tag {
  background: #F3F4F6;
  color: #6B7280;
  padding: 0.25rem 0.75rem;
  border-radius: 15px;
  font-size: 0.75rem;
  font-weight: 600;
  border: 1px solid #E5E7EB;
}

.meta-tag.digital {
  background: linear-gradient(135deg, #DBEAFE, #BFDBFE);
  color: var(--vt-blue-700);
  border-color: #93C5FD;
}

.meta-tag.download {
  background: linear-gradient(135deg, #D1FAE5, #A7F3D0);
  color: #047857;
  border-color: #A7F3D0;
}

.meta-tag.featured {
  background: linear-gradient(135deg, #FEF3C7, #FDE68A);
  color: #92400E;
  border-color: #FDE68A;
}

/* CTA PRODUTOS */
.products-cta-home {
  text-align: center;
  margin-top: 4rem;
  position: relative;
  z-index: 2;
}

.view-all-products-btn-home {
  display: inline-block;
  padding: 1.25rem 3rem;
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500));
  color: white;
  text-decoration: none;
  border-radius: 50px;
  font-weight: 800;
  font-size: 1.125rem;
  transition: all 0.4s ease;
  box-shadow: 0 8px 32px rgba(0, 102, 204, 0.3);
  border: 2px solid transparent;
  position: relative;
  overflow: hidden;
}

.view-all-products-btn-home::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
  transition: left 0.6s;
}

.view-all-products-btn-home:hover::before {
  left: 100%;
}

.view-all-products-btn-home:hover {
  background: linear-gradient(135deg, var(--vt-blue-700), #4F46E5);
  transform: translateY(-4px);
  box-shadow: 0 12px 40px rgba(0, 102, 204, 0.4);
  color: white;
}

/* ESTADOS VAZIOS */
.no-products-home,
.woocommerce-not-active-home {
  grid-column: 1 / -1;
  text-align: center;
  padding: 4rem 2rem;
}

.empty-state-home {
  max-width: 500px;
  margin: 0 auto;
  background: white;
  padding: 3rem;
  border-radius: 20px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
}

.empty-icon-home {
  font-size: 5rem;
  margin-bottom: 2rem;
  opacity: 0.7;
}

.empty-state-home h3 {
  font-size: 1.75rem;
  font-weight: 800;
  color: #1F2937;
  margin-bottom: 1rem;
}

.empty-state-home p {
  color: #6B7280;
  margin-bottom: 2rem;
  line-height: 1.6;
  font-size: 1.125rem;
}

.btn-add-product-home {
  display: inline-block;
  padding: 1rem 2rem;
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500));
  color: white;
  text-decoration: none;
  border-radius: 12px;
  font-weight: 700;
  transition: all 0.3s ease;
}

.btn-add-product-home:hover {
  background: linear-gradient(135deg, var(--vt-blue-700), #4F46E5);
  transform: translateY(-2px);
  color: white;
}

/* RESPONSIVE */
@media (max-width: 1024px) {
  .woo-products-grid-fixed {
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 1.5rem;
  }
  
  .woo-product-image-home {
    height: 200px;
  }
}

@media (max-width: 768px) {
  .real-products-section {
    padding: 3rem 0;
  }
  
  .woo-products-grid-fixed {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
  
  .product-overlay-home {
    position: static;
    background: none;
    padding: 1rem 0 0;
    transform: none;
    flex-direction: column;
  }
  
  .add-to-cart-home,
  .view-product-home {
    background: var(--vt-blue-600) !important;
    color: white !important;
    border-color: var(--vt-blue-600) !important;
  }
  
  .woo-product-content-home {
    padding: 1.5rem;
  }
}

@media (max-width: 480px) {
  .woo-product-content-home {
    padding: 1rem;
  }
  
  .empty-state-home {
    padding: 2rem 1rem;
  }
  
  .view-all-products-btn-home {
    padding: 1rem 2rem;
    font-size: 1rem;
  }
}

/* OVERRIDE WOOCOMMERCE FORÇADO */
.woocommerce .button,
.woocommerce button.button,
.woocommerce input.button,
.woocommerce #respond input#submit,
.add-to-cart-home.button {
  background: var(--vt-blue-600) !important;
  color: white !important;
  border: 1px solid var(--vt-blue-600) !important;
  border-radius: 10px !important;
  font-weight: 700 !important;
  transition: all 0.3s ease !important;
  text-transform: none !important;
}

.woocommerce .button:hover,
.woocommerce button.button:hover,
.woocommerce input.button:hover,
.add-to-cart-home.button:hover {
  background: var(--vt-blue-700) !important;
  border-color: var(--vt-blue-700) !important;
  color: white !important;
  transform: translateY(-2px) !important;
}
EOF

# Atualizar functions.php
log_info "Atualizando functions.php..."
if ! grep -q "woocommerce-home-fixed.css" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_style.*vt-woo-home/a\    wp_enqueue_style('"'"'vt-woo-home-fixed'"'"', VT_THEME_URI . '"'"'/assets/css/components/woocommerce-home-fixed.css'"'"', ['"'"'vt-woo-home'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"
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
echo -e "║  ✅ CSS PRODUTOS HOME CORRIGIDO - PARTE 2! ✅ ║"
echo -e "║    Override WooCommerce + Responsive          ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ CSS avançado com animações criado"
log_success "✅ Override completo dos estilos WooCommerce"
log_success "✅ Design responsivo para todos dispositivos"
log_success "✅ Hover effects e transições suaves"
log_success "✅ Cores VancouverTec aplicadas forçadamente"

echo -e "\n${BLUE}Teste agora: http://localhost:8080${NC}"
echo -e "Os produtos devem aparecer com o layout VancouverTec!"

exit 0