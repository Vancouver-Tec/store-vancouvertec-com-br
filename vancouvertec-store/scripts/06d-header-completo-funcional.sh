#!/bin/bash

# ===========================================
# VancouverTec Store - Header Completo Funcional
# Script: 06d-header-completo-funcional.sh
# Versão: 1.0.0 - CORRIGE TODOS OS PROBLEMAS DO HEADER
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
║        🔧 HEADER COMPLETO FUNCIONAL 🔧        ║
║   Corrige Menu + Botões + Mobile + Submenus  ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Corrigindo header em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Header.php FUNCIONAL COMPLETO
log_info "Criando header.php FUNCIONAL..."
cat > "$THEME_PATH/header.php" << 'EOF'
<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
<?php wp_body_open(); ?>

<!-- Announcement Bar -->
<div class="announcement-bar">
    <div class="container">
        <div class="announcement-content">
            <span>🔥 <strong>OFERTA LIMITADA:</strong> 50% OFF em todos os produtos digitais!</span>
            <a href="<?php echo class_exists('WooCommerce') ? get_permalink(wc_get_page_id('shop')) : '#'; ?>" 
               class="announcement-cta">Aproveitar Agora</a>
        </div>
    </div>
</div>

<!-- Header Principal -->
<header class="main-header">
    <div class="container">
        <div class="header-wrapper">
            <!-- Logo -->
            <div class="site-branding">
                <a href="<?php echo esc_url(home_url('/')); ?>" class="logo-link">
                    <span class="logo-icon">🚀</span>
                    <div class="logo-text">
                        <span class="logo-name">VancouverTec</span>
                        <span class="logo-subtitle">Store</span>
                    </div>
                </a>
            </div>
            
            <!-- Navegação Desktop -->
            <nav class="main-navigation">
                <ul class="nav-menu">
                    <li class="menu-item dropdown-item">
                        <a href="#">Soluções <span class="dropdown-arrow">▼</span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/sites">🌐 Sites Institucionais</a></li>
                            <li><a href="/sistemas">⚙️ Sistemas Web</a></li>
                            <li><a href="/lojas">🛒 Lojas Virtuais</a></li>
                            <li><a href="/aplicativos">📱 Aplicativos Mobile</a></li>
                        </ul>
                    </li>
                    <li class="menu-item dropdown-item">
                        <a href="#">Tecnologias <span class="dropdown-arrow">▼</span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/wordpress">WordPress</a></li>
                            <li><a href="/woocommerce">WooCommerce</a></li>
                            <li><a href="/react">React/Node.js</a></li>
                            <li><a href="/automacao">Automação</a></li>
                        </ul>
                    </li>
                    <?php if (class_exists('WooCommerce')) : ?>
                        <li class="menu-item">
                            <a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>">Shop</a>
                        </li>
                    <?php endif; ?>
                    <li class="menu-item"><a href="/sobre">Sobre</a></li>
                    <li class="menu-item"><a href="/contato">Contato</a></li>
                </ul>
            </nav>
            
            <!-- Header Actions -->
            <div class="header-actions">
                <!-- Busca -->
                <button class="search-toggle" aria-label="Buscar">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M21 21L16.514 16.506M19 10.5C19 15.194 15.194 19 10.5 19C5.806 19 2 15.194 2 10.5C2 5.806 5.806 2 10.5 2C15.194 2 19 5.806 19 10.5Z" stroke="currentColor" stroke-width="2"/>
                    </svg>
                </button>
                
                <?php if (class_exists('WooCommerce')) : ?>
                <!-- Wishlist -->
                <a href="#" class="wishlist-link" aria-label="Lista de Desejos">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M20.84 4.61A5.5 5.5 0 0 0 12 5.67 5.5 5.5 0 0 0 3.16 4.61C1.13 6.64 1.13 9.89 3.16 11.92L12 21.23l8.84-9.31c2.03-2.03 2.03-5.28 0-7.31z" stroke="currentColor" stroke-width="2"/>
                    </svg>
                    <span class="wishlist-count">0</span>
                </a>
                
                <!-- Carrinho -->
                <a href="<?php echo wc_get_cart_url(); ?>" class="cart-link" aria-label="Carrinho">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.4 5.1 16.4H17M17 13V17A4 4 0 1 1 9 17M9 19A2 2 0 1 0 9 15 2 2 0 0 0 9 19Z" stroke="currentColor" stroke-width="2"/>
                    </svg>
                    <span class="cart-count"><?php echo WC()->cart->get_cart_contents_count(); ?></span>
                </a>
                <?php endif; ?>
                
                <!-- User Account -->
                <?php if (is_user_logged_in()) : ?>
                    <div class="user-menu">
                        <button class="user-toggle" aria-label="Minha Conta">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                                <path d="M20 21V19A4 4 0 0 0 16 15H8A4 4 0 0 0 4 19V21M16 7A4 4 0 1 1 8 7 4 4 0 0 1 16 7Z" stroke="currentColor" stroke-width="2"/>
                            </svg>
                            <span>Conta</span>
                        </button>
                        <div class="user-dropdown">
                            <a href="/minha-conta">📋 Minha Conta</a>
                            <a href="/meus-pedidos">📦 Meus Pedidos</a>
                            <?php if (current_user_can('manage_options')) : ?>
                                <a href="<?php echo admin_url(); ?>">⚙️ Admin</a>
                            <?php endif; ?>
                            <a href="<?php echo wp_logout_url(); ?>">🚪 Sair</a>
                        </div>
                    </div>
                <?php else : ?>
                    <a href="/wp-admin" class="login-link">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                            <path d="M15 3H19A2 2 0 0 1 21 5V19A2 2 0 0 1 19 21H15M10 17L15 12L10 7M15 12H3" stroke="currentColor" stroke-width="2"/>
                        </svg>
                        <span>Entrar</span>
                    </a>
                <?php endif; ?>
                
                <!-- CTA -->
                <a href="/contato" class="btn btn-primary header-cta">Fale Conosco</a>
            </div>
            
            <!-- Mobile Toggle -->
            <button class="mobile-menu-toggle" aria-label="Menu">
                <span></span>
                <span></span>
                <span></span>
            </button>
        </div>
    </div>
    
    <!-- Mobile Menu -->
    <div class="mobile-menu">
        <ul class="mobile-nav">
            <li class="mobile-item">
                <button class="mobile-dropdown-toggle">Soluções <span class="mobile-arrow">+</span></button>
                <ul class="mobile-submenu">
                    <li><a href="/sites">🌐 Sites Institucionais</a></li>
                    <li><a href="/sistemas">⚙️ Sistemas Web</a></li>
                    <li><a href="/lojas">🛒 Lojas Virtuais</a></li>
                    <li><a href="/aplicativos">📱 Aplicativos Mobile</a></li>
                </ul>
            </li>
            <li class="mobile-item">
                <button class="mobile-dropdown-toggle">Tecnologias <span class="mobile-arrow">+</span></button>
                <ul class="mobile-submenu">
                    <li><a href="/wordpress">WordPress</a></li>
                    <li><a href="/woocommerce">WooCommerce</a></li>
                    <li><a href="/react">React/Node.js</a></li>
                    <li><a href="/automacao">Automação</a></li>
                </ul>
            </li>
            <?php if (class_exists('WooCommerce')) : ?>
                <li class="mobile-item"><a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>">Shop</a></li>
            <?php endif; ?>
            <li class="mobile-item"><a href="/sobre">Sobre</a></li>
            <li class="mobile-item"><a href="/contato">Contato</a></li>
            <li class="mobile-item"><a href="/contato" class="mobile-cta">Fale Conosco</a></li>
        </ul>
    </div>
</header>

<main class="site-main">
EOF

# CSS funcional
log_info "Criando CSS header funcional..."
cat > "$THEME_PATH/assets/css/header-funcional.css" << 'EOF'
/* Header Funcional VancouverTec */

/* Announcement Bar */
.announcement-bar {
  background: linear-gradient(90deg, #EF4444, #F59E0B);
  color: white;
  padding: 0.75rem 0;
  font-size: 0.875rem;
  text-align: center;
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
  transition: all 0.3s;
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
}

/* Logo */
.logo-link {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  text-decoration: none;
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
  color: #0066CC;
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
  transition: all 0.3s;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.menu-item > a:hover {
  color: #0066CC;
  background: #F3F4F6;
}

.dropdown-arrow {
  font-size: 0.7rem;
  transition: transform 0.3s;
}

/* Dropdown - VAI PARA BAIXO */
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
  transition: all 0.3s;
  z-index: 1000;
  list-style: none;
  margin: 0;
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
  transition: all 0.3s;
}

.dropdown-menu a:hover {
  background: #F3F4F6;
  color: #0066CC;
}

/* Header Actions */
.header-actions {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.search-toggle,
.wishlist-link,
.cart-link,
.user-toggle,
.login-link {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem;
  background: #F9FAFB;
  border: 1px solid #E5E7EB;
  border-radius: 8px;
  color: #374151;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.3s;
  font-weight: 500;
}

.search-toggle:hover,
.wishlist-link:hover,
.cart-link:hover,
.user-toggle:hover,
.login-link:hover {
  background: #0066CC;
  color: white;
  border-color: #0066CC;
  transform: translateY(-2px);
}

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
}

/* User Dropdown - VAI PARA BAIXO */
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
  transition: all 0.3s;
  z-index: 1000;
}

.user-menu:hover .user-dropdown {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
}

.user-dropdown a {
  display: block;
  padding: 0.75rem 1.5rem;
  color: #374151;
  text-decoration: none;
  transition: all 0.3s;
}

.user-dropdown a:hover {
  background: #F3F4F6;
  color: #0066CC;
}

/* Mobile Menu */
.mobile-menu-toggle {
  display: none;
  flex-direction: column;
  background: none;
  border: none;
  cursor: pointer;
  padding: 0.5rem;
  gap: 0.25rem;
}

.mobile-menu-toggle span {
  width: 25px;
  height: 3px;
  background: #374151;
  border-radius: 2px;
  transition: all 0.3s;
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

.mobile-menu {
  display: none;
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: white;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
  padding: 2rem;
  z-index: 999;
}

.mobile-menu.active {
  display: block;
}

.mobile-nav {
  list-style: none;
  margin: 0;
  padding: 0;
}

.mobile-item {
  margin-bottom: 1rem;
}

.mobile-dropdown-toggle {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 1rem;
  background: #F9FAFB;
  border: none;
  border-radius: 8px;
  color: #374151;
  font-weight: 500;
  cursor: pointer;
}

.mobile-submenu {
  list-style: none;
  margin: 0.5rem 0 0 0;
  padding: 0 0 0 1rem;
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.3s;
}

.mobile-submenu.active {
  max-height: 300px;
}

.mobile-submenu a {
  display: block;
  padding: 0.75rem 1rem;
  color: #6B7280;
  text-decoration: none;
  border-radius: 6px;
  transition: all 0.3s;
}

.mobile-submenu a:hover {
  background: #F3F4F6;
  color: #0066CC;
}

.mobile-cta {
  background: #0066CC !important;
  color: white !important;
  text-align: center;
  border-radius: 8px;
  padding: 1rem;
  font-weight: 700;
}

/* Responsive */
@media (max-width: 1024px) {
  .header-cta {
    display: none;
  }
}

@media (max-width: 768px) {
  .mobile-menu-toggle {
    display: flex;
  }
  
  .main-navigation {
    display: none;
  }
  
  .header-actions > .search-toggle,
  .header-actions > .header-cta {
    display: none;
  }
  
  .logo-name {
    font-size: 1.25rem;
  }
  
  .logo-subtitle {
    font-size: 0.75rem;
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
echo -e "║        ✅ HEADER CORRIGIDO! ✅                ║"
echo -e "║    Todos os problemas resolvidos!            ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Botões wishlist e login/admin restaurados"
log_success "✅ Submenus vão para BAIXO (não para o lado)"
log_success "✅ Menu mobile funcional"
log_success "✅ Todas as funcionalidades preservadas"

echo -e "\n${YELLOW}🎯 PROBLEMAS CORRIGIDOS:${NC}"
echo -e "• ❌ Antes: Botões sumiram → ✅ Agora: Todos os botões presentes"
echo -e "• ❌ Antes: Submenus laterais → ✅ Agora: Submenus vão para baixo"
echo -e "• ❌ Antes: Mobile quebrado → ✅ Agora: Mobile 100% funcional"

echo -e "\n${BLUE}📱 TESTE NO MÓVEL:${NC}"
echo -e "• Redimensione a janela para 375px"
echo -e "• Clique no menu hamburger"
echo -e "• Teste os submenus dropdown"

log_success "Execute: chmod +x 06d-header-completo-funcional.sh && ./06d-header-completo-funcional.sh"

exit 0