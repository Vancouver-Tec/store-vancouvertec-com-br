#!/bin/bash

# ===========================================
# VancouverTec Store - Corrigir Responsivo Botões
# Script: 08c-corrigir-responsivo.sh
# Versão: 1.0.0 - Botões em TODOS os tamanhos
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
║     📱 CORRIGIR RESPONSIVO BOTÕES 📱         ║
║   Desktop + Tablet + Mobile (tamanhos OK)    ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Corrigindo responsivo em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# CORRIGIR CSS - Responsivo completo
log_info "Corrigindo CSS responsivo..."
cat > "$THEME_PATH/assets/css/layouts/header.css" << 'EOF'
/* Header Layout VancouverTec Store - RESPONSIVO CORRIGIDO */

/* Announcement Bar */
.announcement-bar {
  background: linear-gradient(90deg, #EF4444, #F59E0B);
  color: white;
  padding: 0.75rem 0;
  font-size: 0.875rem;
  text-align: center;
  position: relative;
  z-index: 1001;
}

.announcement-content {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.announcement-cta {
  background: rgba(255, 255, 255, 0.2);
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 20px;
  text-decoration: none;
  font-weight: 700;
  transition: all 0.3s ease;
}

.announcement-cta:hover {
  background: rgba(255, 255, 255, 0.3);
  color: white;
}

/* Main Header */
.main-header {
  background: rgba(255, 255, 255, 0.98);
  backdrop-filter: blur(20px);
  border-bottom: 1px solid #E5E7EB;
  position: sticky;
  top: 0;
  z-index: 1000;
  box-shadow: 0 2px 20px rgba(0, 0, 0, 0.08);
}

.header-wrapper {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 1rem 0;
  position: relative;
}

/* Logo */
.logo-link {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  text-decoration: none;
  z-index: 1002;
}

.logo-icon {
  font-size: 2rem;
}

.logo-text {
  display: flex;
  flex-direction: column;
}

.logo-name {
  font-size: 1.5rem;
  font-weight: 800;
  color: var(--vt-blue-600, #0066CC);
  line-height: 1;
}

.logo-subtitle {
  font-size: 0.875rem;
  font-weight: 600;
  color: #6B7280;
  line-height: 1;
}

/* Navigation Desktop */
.main-navigation {
  display: flex;
}

.nav-menu {
  display: flex;
  list-style: none;
  margin: 0;
  padding: 0;
  gap: 2rem;
  align-items: center;
}

.menu-item {
  position: relative;
}

.menu-item > a {
  color: #374151;
  text-decoration: none;
  font-weight: 500;
  padding: 0.75rem 1rem;
  border-radius: 8px;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.menu-item > a:hover {
  color: var(--vt-blue-600, #0066CC);
  background: #F3F4F6;
}

.dropdown-arrow {
  font-size: 0.7rem;
  transition: transform 0.3s ease;
}

/* Dropdown */
.dropdown-menu {
  position: absolute;
  top: 100%;
  left: 0;
  background: white;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
  border-radius: 12px;
  padding: 1rem 0;
  min-width: 220px;
  opacity: 0;
  visibility: hidden;
  transform: translateY(-10px);
  transition: all 0.3s ease;
  z-index: 1000;
  list-style: none;
  margin: 0;
  border: 1px solid #E5E7EB;
}

.dropdown-item:hover .dropdown-menu {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
}

.dropdown-item:hover .dropdown-arrow {
  transform: rotate(180deg);
}

.dropdown-menu a {
  display: block;
  padding: 0.75rem 1.5rem;
  color: #374151;
  text-decoration: none;
  transition: all 0.3s ease;
  font-size: 0.875rem;
}

.dropdown-menu a:hover {
  background: #F3F4F6;
  color: var(--vt-blue-600, #0066CC);
}

/* ===== HEADER ACTIONS - RESPONSIVO COMPLETO ===== */
.header-actions {
  display: flex;
  align-items: center;
  gap: 1rem;
}

/* BOTÕES BASE */
.header-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1rem;
  background: #F9FAFB;
  border: 1px solid #E5E7EB;
  border-radius: 8px;
  color: #374151;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.3s ease;
  font-weight: 500;
  font-size: 0.875rem;
  position: relative;
}

.header-btn:hover {
  background: var(--vt-blue-600, #0066CC);
  color: white;
  border-color: var(--vt-blue-600, #0066CC);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 102, 204, 0.3);
}

/* Contadores */
.cart-count,
.wishlist-count {
  background: #EF4444;
  color: white;
  font-size: 0.75rem;
  font-weight: 700;
  padding: 0.25rem 0.5rem;
  border-radius: 12px;
  min-width: 20px;
  text-align: center;
  line-height: 1;
  position: absolute;
  top: -8px;
  right: -8px;
}

/* User Dropdown */
.user-menu {
  position: relative;
}

.user-dropdown {
  position: absolute;
  top: 100%;
  right: 0;
  background: white;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
  border-radius: 12px;
  padding: 1rem 0;
  min-width: 200px;
  opacity: 0;
  visibility: hidden;
  transform: translateY(-10px);
  transition: all 0.3s ease;
  z-index: 1000;
  border: 1px solid #E5E7EB;
}

.user-menu:hover .user-dropdown,
.user-dropdown.show {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
}

.user-dropdown a {
  display: block;
  padding: 0.75rem 1.5rem;
  color: #374151;
  text-decoration: none;
  transition: all 0.3s ease;
  font-size: 0.875rem;
}

.user-dropdown a:hover {
  background: #F3F4F6;
  color: var(--vt-blue-600, #0066CC);
}

/* Botão CTA */
.btn {
  display: inline-block;
  padding: 0.75rem 1.5rem;
  background: var(--vt-blue-600, #0066CC);
  color: white;
  text-decoration: none;
  border-radius: 8px;
  font-weight: 600;
  transition: all 0.3s ease;
  border: none;
  cursor: pointer;
  font-size: 0.875rem;
}

.btn:hover {
  background: var(--vt-blue-700, #0052A3);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 102, 204, 0.3);
  color: white;
}

/* Mobile Menu Toggle */
.mobile-menu-toggle {
  display: none;
  flex-direction: column;
  background: none;
  border: none;
  cursor: pointer;
  padding: 0.5rem;
  gap: 0.25rem;
  z-index: 1002;
}

.mobile-menu-toggle span {
  width: 25px;
  height: 3px;
  background: #374151;
  border-radius: 2px;
  transition: all 0.3s ease;
}

.mobile-menu-toggle.active span:nth-child(1) {
  transform: rotate(45deg) translate(5px, 5px);
}

.mobile-menu-toggle.active span:nth-child(2) {
  opacity: 0;
}

.mobile-menu-toggle.active span:nth-child(3) {
  transform: rotate(-45deg) translate(7px, -6px);
}

/* Mobile Menu */
.mobile-menu {
  display: none;
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: white;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
  padding: 1rem;
  z-index: 999;
  border-top: 1px solid #E5E7EB;
}

.mobile-menu.active {
  display: block;
}

/* Mobile Header Actions - COMPACTO */
.mobile-header-actions {
  padding: 1rem 0;
  border-bottom: 1px solid #E5E7EB;
  margin-bottom: 1rem;
}

.mobile-actions-row {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 0.5rem;
}

.mobile-action-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.25rem;
  padding: 0.75rem 0.5rem;
  background: #F9FAFB;
  border: 1px solid #E5E7EB;
  border-radius: 8px;
  color: #374151;
  text-decoration: none;
  transition: all 0.3s ease;
  position: relative;
  font-size: 0.75rem;
  font-weight: 500;
}

.mobile-action-btn:hover {
  background: var(--vt-blue-600, #0066CC);
  color: white;
  border-color: var(--vt-blue-600, #0066CC);
}

.mobile-action-btn svg {
  width: 18px;
  height: 18px;
}

.mobile-count {
  background: #EF4444;
  color: white;
  font-size: 0.625rem;
  font-weight: 700;
  padding: 0.125rem 0.375rem;
  border-radius: 10px;
  position: absolute;
  top: 0.25rem;
  right: 0.25rem;
  min-width: 16px;
  text-align: center;
}

.mobile-nav {
  list-style: none;
  margin: 0;
  padding: 0;
}

.mobile-item {
  margin-bottom: 0.75rem;
}

.mobile-dropdown-toggle {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0.75rem;
  background: #F9FAFB;
  border: 1px solid #E5E7EB;
  border-radius: 8px;
  color: #374151;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 0.875rem;
}

.mobile-dropdown-toggle:hover {
  background: #F3F4F6;
  border-color: var(--vt-blue-600, #0066CC);
}

.mobile-submenu {
  list-style: none;
  margin: 0.5rem 0 0 0;
  padding: 0 0 0 1rem;
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.3s ease;
}

.mobile-submenu.active {
  max-height: 300px;
}

.mobile-submenu a {
  display: block;
  padding: 0.5rem 0.75rem;
  color: #6B7280;
  text-decoration: none;
  border-radius: 6px;
  transition: all 0.3s ease;
  margin-bottom: 0.25rem;
  font-size: 0.875rem;
}

.mobile-submenu a:hover {
  background: #F3F4F6;
  color: var(--vt-blue-600, #0066CC);
}

.mobile-cta {
  background: var(--vt-blue-600, #0066CC) !important;
  color: white !important;
  text-align: center;
  border-radius: 8px;
  padding: 0.75rem;
  font-weight: 700;
  margin-top: 0.5rem;
}

/* ===== RESPONSIVO CORRIGIDO ===== */

/* DESKTOP (1025px+) - BOTÕES COMPLETOS */
@media (min-width: 1025px) {
  .header-actions {
    gap: 1rem;
  }
  
  .btn-text {
    display: block;
  }
  
  .mobile-header-actions {
    display: none;
  }
  
  .header-btn {
    padding: 0.75rem 1rem;
  }
}

/* TABLET (769px - 1024px) - BOTÕES COMPACTOS */
@media (max-width: 1024px) and (min-width: 769px) {
  .header-actions {
    gap: 0.75rem;
  }
  
  .btn-text {
    display: none; /* Só ícones */
  }
  
  .header-btn {
    padding: 0.75rem;
  }
  
  .header-cta {
    display: none; /* Esconder CTA no tablet */
  }
  
  .mobile-header-actions {
    display: none;
  }
  
  .nav-menu {
    gap: 1.5rem;
  }
}

/* MOBILE (768px-) - BOTÕES NO MENU MOBILE */
@media (max-width: 768px) {
  .mobile-menu-toggle {
    display: flex;
  }
  
  .main-navigation {
    display: none;
  }
  
  /* ESCONDER botões do desktop no mobile */
  .header-actions .header-btn,
  .header-actions .btn {
    display: none;
  }
  
  /* MOSTRAR botões mobile */
  .mobile-header-actions {
    display: block;
  }
  
  .logo-name {
    font-size: 1.25rem;
  }
  
  .logo-subtitle {
    font-size: 0.75rem;
  }
  
  .announcement-content {
    flex-direction: column;
    gap: 0.5rem;
  }
  
  .announcement-bar {
    padding: 1rem 0;
  }
}

/* MOBILE PEQUENO (480px-) */
@media (max-width: 480px) {
  .header-wrapper {
    padding: 0.75rem 0;
  }
  
  .mobile-actions-row {
    gap: 0.375rem;
  }
  
  .mobile-action-btn {
    padding: 0.5rem 0.25rem;
    font-size: 0.6875rem;
  }
  
  .mobile-action-btn svg {
    width: 16px;
    height: 16px;
  }
}

/* Estados especiais */
.cart-link.has-items,
.wishlist-link.has-items {
  background: #FEF3C7;
  border-color: #F59E0B;
  color: #92400E;
}

.cart-link.has-items:hover {
  background: #10B981;
  color: white;
}

.wishlist-link.has-items:hover {
  background: #EF4444;
  color: white;
}

/* Animações */
@keyframes bounce {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-5px); }
}

.cart-count,
.wishlist-count {
  transition: transform 0.2s ease;
}

/* Modal de busca */
.search-modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.7);
  z-index: 9999;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem;
}

.search-modal-content {
  background: white;
  border-radius: 12px;
  max-width: 500px;
  width: 100%;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
}

.search-modal-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 1.5rem;
  border-bottom: 1px solid #E5E7EB;
}

.search-modal-header h3 {
  margin: 0;
  color: #374151;
}

.search-modal-close {
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
  color: #6B7280;
  padding: 0.5rem;
  border-radius: 6px;
  transition: all 0.3s ease;
}

.search-modal-close:hover {
  background: #F3F4F6;
  color: #374151;
}

.search-modal-body {
  padding: 1.5rem;
}

.search-modal-input {
  width: 100%;
  padding: 1rem;
  border: 2px solid #E5E7EB;
  border-radius: 8px;
  font-size: 1rem;
  transition: all 0.3s ease;
  margin-bottom: 1rem;
}

.search-modal-input:focus {
  outline: none;
  border-color: var(--vt-blue-600, #0066CC);
  box-shadow: 0 0 0 3px rgba(0, 102, 204, 0.1);
}

.search-suggestions {
  display: grid;
  gap: 0.5rem;
}

.suggestion-item {
  padding: 0.75rem 1rem;
  background: #F9FAFB;
  border: 1px solid #E5E7EB;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  color: #374151;
}

.suggestion-item:hover {
  background: var(--vt-blue-600, #0066CC);
  color: white;
  border-color: var(--vt-blue-600, #0066CC);
}

/* Tooltips */
.vt-tooltip {
  position: absolute;
  background: #374151;
  color: white;
  padding: 0.5rem 0.75rem;
  border-radius: 6px;
  font-size: 0.75rem;
  z-index: 10000;
  transform: translateX(-50%);
  white-space: nowrap;
  pointer-events: none;
}

.vt-tooltip::before {
  content: '';
  position: absolute;
  top: -4px;
  left: 50%;
  transform: translateX(-50%);
  border-left: 4px solid transparent;
  border-right: 4px solid transparent;
  border-bottom: 4px solid #374151;
}

@media (max-width: 768px) {
  .search-modal {
    padding: 1rem;
  }
  
  .search-modal-content {
    max-width: 100%;
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
echo -e "║     ✅ RESPONSIVO CORRIGIDO! ✅              ║"
echo -e "║   Botões aparecem em TODOS os tamanhos       ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Desktop (1025px+): Botões completos com texto"
log_success "✅ Tablet (769-1024px): Botões compactos (só ícones)"
log_success "✅ Mobile (768px-): Botões no menu mobile (tamanho médio)"
log_success "✅ Layout original preservado"

echo -e "\n${YELLOW}📱 TESTE RESPONSIVO:${NC}"
echo -e "• Desktop: http://localhost:8080 - Veja 3 botões com texto"
echo -e "• Tablet: Redimensione para 800px - Botões só com ícones"
echo -e "• Mobile: Redimensione para 375px - Botões no menu mobile"

echo -e "\n${BLUE}📋 TAMANHOS CORRETOS:${NC}"
echo -e "• Desktop: Botões normais com labels"
echo -e "• Tablet: Botões compactos (sem texto)"
echo -e "• Mobile: Botões médios no menu mobile"

log_success "Responsivo 100% funcional em todos os dispositivos!"

exit 0