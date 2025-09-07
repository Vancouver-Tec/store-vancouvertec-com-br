#!/bin/bash

# ===========================================
# VancouverTec Store - Header Profissional
# Script: 06a-header-profissional.sh
# Versão: 1.0.0 - Header com Menu + Submenu + Ações
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
║          🔝 HEADER PROFISSIONAL 🔝           ║
║    Menu + Submenu + Carrinho + Login         ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Criando header profissional..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Header.php PROFISSIONAL
log_info "Criando header.php profissional..."
cat > "$THEME_PATH/header.php" << 'EOF'
<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
<?php wp_body_open(); ?>

<!-- Announcement Bar -->
<div class="announcement-bar">
    <div class="container">
        <div class="announcement-content">
            <span class="announcement-icon">🔥</span>
            <span class="announcement-text">
                <strong>OFERTA LIMITADA:</strong> 50% OFF em todos os produtos digitais!
            </span>
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
                    <div class="logo">
                        <span class="logo-icon">🚀</span>
                        <div class="logo-text">
                            <span class="logo-name">VancouverTec</span>
                            <span class="logo-subtitle">Store</span>
                        </div>
                    </div>
                </a>
            </div>
            
            <!-- Navegação Principal -->
            <nav class="main-navigation">
                <ul class="nav-menu">
                    <li class="menu-item has-dropdown">
                        <a href="#">Soluções</a>
                        <ul class="submenu">
                            <li><a href="/sites">🌐 Sites Institucionais</a></li>
                            <li><a href="/sistemas">⚙️ Sistemas Web</a></li>
                            <li><a href="/lojas">🛒 Lojas Virtuais</a></li>
                            <li><a href="/aplicativos">📱 Aplicativos Mobile</a></li>
                        </ul>
                    </li>
                    <li class="menu-item has-dropdown">
                        <a href="#">Tecnologias</a>
                        <ul class="submenu">
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
                    <li class="menu-item">
                        <a href="/sobre">Sobre</a>
                    </li>
                    <li class="menu-item">
                        <a href="/contato">Contato</a>
                    </li>
                </ul>
            </nav>
            
            <!-- Header Actions -->
            <div class="header-actions">
                <!-- Busca -->
                <div class="search-wrapper">
                    <button class="search-toggle" aria-label="Buscar">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                            <path d="M21 21L16.514 16.506M19 10.5C19 15.194 15.194 19 10.5 19C5.806 19 2 15.194 2 10.5C2 5.806 5.806 2 10.5 2C15.194 2 19 5.806 19 10.5Z" stroke="currentColor" stroke-width="2"/>
                        </svg>
                    </button>
                </div>
                
                <?php if (class_exists('WooCommerce')) : ?>
                <!-- Wishlist -->
                <div class="wishlist-wrapper">
                    <a href="#" class="wishlist-link" aria-label="Lista de Desejos">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                            <path d="M20.84 4.61C20.3292 4.099 19.7228 3.69364 19.0554 3.41708C18.3879 3.14052 17.6725 2.99817 16.95 2.99817C16.2275 2.99817 15.5121 3.14052 14.8446 3.41708C14.1772 3.69364 13.5708 4.099 13.06 4.61L12 5.67L10.94 4.61C9.9083 3.5783 8.50903 2.9987 7.05 2.9987C5.59096 2.9987 4.19169 3.5783 3.16 4.61C2.1283 5.6417 1.5487 7.04097 1.5487 8.5C1.5487 9.95903 2.1283 11.3583 3.16 12.39L12 21.23L20.84 12.39C21.351 11.8792 21.7563 11.2728 22.0329 10.6053C22.3095 9.93789 22.4518 9.22248 22.4518 8.5C22.4518 7.77752 22.3095 7.06211 22.0329 6.39467C21.7563 5.72723 21.351 5.1208 20.84 4.61V4.61Z" stroke="currentColor" stroke-width="2"/>
                        </svg>
                        <span class="wishlist-count">0</span>
                    </a>
                </div>
                
                <!-- Carrinho -->
                <div class="cart-wrapper">
                    <a href="<?php echo wc_get_cart_url(); ?>" class="cart-link" aria-label="Carrinho">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                            <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.4 5.1 16.4H17M17 13V17C17 18.1 17.9 19 19 19C20.1 19 21 18.1 21 17C21 15.9 20.1 15 19 15C17.9 15 17 15.9 17 17ZM9 19C10.1 19 11 18.1 11 17C11 15.9 10.1 15 9 15C7.9 15 7 15.9 7 17C7 18.1 7.9 19 9 19Z" stroke="currentColor" stroke-width="2"/>
                        </svg>
                        <span class="cart-count"><?php echo WC()->cart->get_cart_contents_count(); ?></span>
                        <span class="cart-total"><?php echo WC()->cart->get_cart_total(); ?></span>
                    </a>
                </div>
                <?php endif; ?>
                
                <!-- User Account -->
                <div class="account-wrapper">
                    <?php if (is_user_logged_in()) : ?>
                        <div class="user-menu">
                            <button class="user-toggle" aria-label="Minha Conta">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                                    <path d="M20 21V19C20 16.7909 18.2091 15 16 15H8C5.79086 15 4 16.7909 4 19V21M16 7C16 9.20914 14.2091 11 12 11C9.79086 11 8 9.20914 8 7C8 4.79086 9.79086 3 12 3C14.2091 3 16 4.79086 16 7Z" stroke="currentColor" stroke-width="2"/>
                                </svg>
                                <span>Minha Conta</span>
                            </button>
                            <div class="user-dropdown">
                                <a href="/minha-conta">📋 Minha Conta</a>
                                <a href="/meus-pedidos">📦 Meus Pedidos</a>
                                <?php if (current_user_can('manage_options')) : ?>
                                    <a href="<?php echo admin_url(); ?>">⚙️ Painel Admin</a>
                                <?php endif; ?>
                                <a href="<?php echo wp_logout_url(); ?>">🚪 Sair</a>
                            </div>
                        </div>
                    <?php else : ?>
                        <a href="/login" class="login-link">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                                <path d="M15 3H19C19.5304 3 20.0391 3.21071 20.4142 3.58579C20.7893 3.96086 21 4.46957 21 5V19C21 19.5304 20.7893 20.0391 20.4142 20.4142C20.0391 20.7893 19.5304 21 19 21H15M10 17L15 12L10 7M15 12H3" stroke="currentColor" stroke-width="2"/>
                            </svg>
                            <span>Entrar</span>
                        </a>
                    <?php endif; ?>
                </div>
                
                <!-- CTA Button -->
                <div class="header-cta">
                    <a href="/contato" class="btn btn-primary">
                        Fale Conosco
                    </a>
                </div>
            </div>
            
            <!-- Mobile Menu Toggle -->
            <button class="mobile-menu-toggle" aria-label="Menu Mobile">
                <span></span>
                <span></span>
                <span></span>
            </button>
        </div>
    </div>
</header>

<main class="site-main">
EOF

# CSS para o Header
log_info "Criando CSS do header..."
cat > "$THEME_PATH/assets/css/layouts/header.css" << 'EOF'
/* VancouverTec - Header Styles */

/* Announcement Bar */
.announcement-bar {
  background: linear-gradient(90deg, #EF4444, #F59E0B);
  color: white;
  padding: 0.75rem 0;
  font-size: 0.875rem;
  font-weight: 600;
  text-align: center;
  animation: pulse 2s infinite;
}

.announcement-content {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
}

.announcement-cta {
  background: rgba(255, 255, 255, 0.2);
  color: white;
  padding: 0.25rem 0.75rem;
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
  min-height: 80px;
}

/* Logo */
.logo-link {
  text-decoration: none;
}

.logo {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.logo-icon {
  font-size: 2rem;
  filter: drop-shadow(0 2px 4px rgba(0, 102, 204, 0.3));
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

/* Navigation */
.main-navigation {
  display: flex;
  align-items: center;
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
  font-size: 0.95rem;
  padding: 0.75rem 1rem;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.menu-item > a:hover,
.menu-item.dropdown-open > a {
  color: #0066CC;
  background: #F3F4F6;
}

/* Submenu */
.submenu {
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
  border: 1px solid #E5E7EB;
}

.has-dropdown:hover .submenu,
.has-dropdown.dropdown-open .submenu {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
}

.submenu li {
  list-style: none;
}

.submenu a {
  display: block;
  padding: 0.75rem 1.5rem;
  color: #374151;
  text-decoration: none;
  font-size: 0.875rem;
  transition: all 0.3s ease;
}

.submenu a:hover {
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
  transition: all 0.3s ease;
  font-size: 0.875rem;
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
  box-shadow: 0 4px 12px rgba(0, 102, 204, 0.3);
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
  line-height: 1;
}

.cart-total {
  font-weight: 700;
  color: #059669;
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
  font-size: 0.875rem;
  transition: all 0.3s ease;
}

.user-dropdown a:hover {
  background: #F3F4F6;
  color: #0066CC;
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

/* Responsive */
@media (max-width: 1024px) {
  .header-actions .btn {
    display: none;
  }
  
  .nav-menu {
    gap: 1rem;
  }
}

@media (max-width: 768px) {
  .mobile-menu-toggle {
    display: flex;
  }
  
  .main-navigation {
    display: none;
  }
  
  .header-actions > *:not(.account-wrapper):not(.cart-wrapper) {
    display: none;
  }
}
EOF

# Atualizar functions.php
log_info "Atualizando functions.php..."
if ! grep -q "header.css" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_style.*vt-style/a\    wp_enqueue_style('"'"'vt-header'"'"', VT_THEME_URI . '"'"'/assets/css/layouts/header.css'"'"', ['"'"'vt-style'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"
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
echo -e "║         ✅ HEADER PROFISSIONAL CRIADO! ✅     ║"
echo -e "║      Menu + Submenu + Carrinho + Login       ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Announcement bar com oferta"
log_success "✅ Logo VancouverTec profissional"
log_success "✅ Menu com submenus dropdown"
log_success "✅ Botões: busca, wishlist, carrinho"
log_success "✅ Sistema de login/conta"
log_success "✅ Menu mobile responsivo"

echo -e "\n${YELLOW}🎯 TESTE AGORA:${NC}"
echo -e "• Frontend: http://localhost:8080"
echo -e "• Veja o header profissional com menu"
echo -e "• Teste os submenus dropdown"

echo -e "\n${PURPLE}📋 PRÓXIMO PASSO:${NC}"
log_warning "Digite 'continuar' para criar o Footer Impactante"

exit 0