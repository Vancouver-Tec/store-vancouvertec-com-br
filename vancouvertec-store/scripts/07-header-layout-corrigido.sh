#!/bin/bash

# ===========================================
# VancouverTec Store - Header Layout CORRIGIDO
# Script: 07-header-layout-corrigido.sh
# Versão: 1.0.0 - Corrige problemas do 06d
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
║      🔧 HEADER LAYOUT CORRIGIDO 🔧           ║
║  Baseado no repositório GitHub Vancouver-Tec ║
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

# Verificar estrutura
if [[ ! -d "$THEME_PATH" ]]; then
    log_error "Tema não encontrado!"
    exit 1
fi

mkdir -p "$THEME_PATH/assets/css/layouts"
mkdir -p "$THEME_PATH/assets/js"

# HEADER.PHP CORRIGIDO (baseado no repositório)
log_info "Criando header.php CORRIGIDO..."
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

# CSS HEADER LAYOUT CORRIGIDO
log_info "Criando CSS header layout corrigido..."
cat > "$THEME_PATH/assets/css/layouts/header.css" << 'EOF'
/* Header Layout VancouverTec Store - CORRIGIDO */

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

/* Dropdown - Vai para BAIXO */
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
  font-weight: 500;
  font-size: 0.875rem;
}

.search-toggle:hover,
.wishlist-link:hover,
.cart-link:hover,
.user-toggle:hover,
.login-link:hover {
  background: var(--vt-blue-600, #0066CC);
  color: white;
  border-color: var(--vt-blue-600, #0066CC);
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
  transition: all 0.3s ease;
  font-size: 0.875rem;
}

.user-dropdown a:hover {
  background: #F3F4F6;
  color: var(--vt-blue-600, #0066CC);
}

/* Botões */
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

.btn-primary {
  background: var(--vt-blue-600, #0066CC);
}

.btn-primary:hover {
  background: var(--vt-blue-700, #0052A3);
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
  padding: 2rem;
  z-index: 999;
  border-top: 1px solid #E5E7EB;
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
  border: 1px solid #E5E7EB;
  border-radius: 8px;
  color: #374151;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.3s ease;
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
  padding: 0.75rem 1rem;
  color: #6B7280;
  text-decoration: none;
  border-radius: 6px;
  transition: all 0.3s ease;
  margin-bottom: 0.25rem;
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
  padding: 1rem;
  font-weight: 700;
  margin-top: 1rem;
}

/* Responsive */
@media (max-width: 1024px) {
  .header-cta {
    display: none;
  }
  
  .nav-menu {
    gap: 1rem;
  }
  
  .header-actions {
    gap: 0.5rem;
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
  
  .announcement-content {
    flex-direction: column;
    gap: 0.5rem;
  }
  
  .announcement-bar {
    padding: 1rem 0;
  }
}

@media (max-width: 480px) {
  .header-wrapper {
    padding: 0.75rem 0;
  }
  
  .header-actions {
    gap: 0.25rem;
  }
  
  .wishlist-link,
  .cart-link,
  .user-toggle,
  .login-link {
    padding: 0.5rem;
  }
  
  .wishlist-link span,
  .cart-link span,
  .user-toggle span,
  .login-link span {
    display: none;
  }
}
EOF

# JavaScript para interações mobile
log_info "Criando JavaScript para mobile..."
cat > "$THEME_PATH/assets/js/header-mobile.js" << 'EOF'
// Header Mobile VancouverTec Store
document.addEventListener('DOMContentLoaded', function() {
    const mobileToggle = document.querySelector('.mobile-menu-toggle');
    const mobileMenu = document.querySelector('.mobile-menu');
    const mobileDropdowns = document.querySelectorAll('.mobile-dropdown-toggle');
    const userToggle = document.querySelector('.user-toggle');
    const userDropdown = document.querySelector('.user-dropdown');

    // Mobile menu toggle
    if (mobileToggle && mobileMenu) {
        mobileToggle.addEventListener('click', function() {
            mobileToggle.classList.toggle('active');
            mobileMenu.classList.toggle('active');
        });
    }

    // Mobile dropdown toggles
    mobileDropdowns.forEach(function(toggle) {
        toggle.addEventListener('click', function() {
            const submenu = toggle.nextElementSibling;
            const arrow = toggle.querySelector('.mobile-arrow');
            
            if (submenu) {
                submenu.classList.toggle('active');
                arrow.textContent = submenu.classList.contains('active') ? '-' : '+';
            }
        });
    });

    // User dropdown (desktop)
    if (userToggle && userDropdown) {
        userToggle.addEventListener('click', function(e) {
            e.preventDefault();
            userDropdown.classList.toggle('show');
        });

        // Fechar ao clicar fora
        document.addEventListener('click', function(e) {
            if (!userToggle.contains(e.target) && !userDropdown.contains(e.target)) {
                userDropdown.classList.remove('show');
            }
        });
    }

    // Fechar mobile menu ao redimensionar
    window.addEventListener('resize', function() {
        if (window.innerWidth > 768) {
            mobileMenu.classList.remove('active');
            mobileToggle.classList.remove('active');
        }
    });
});
EOF

# Atualizar functions.php para carregar novo CSS e JS
log_info "Atualizando functions.php..."
if ! grep -q "header.css" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_style.*vt-style/a\    wp_enqueue_style('"'"'vt-header'"'"', VT_THEME_URI . '"'"'/assets/css/layouts/header.css'"'"', ['"'"'vt-style'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"
fi

if ! grep -q "header-mobile.js" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_script.*vt-main/a\    wp_enqueue_script('"'"'vt-header-mobile'"'"', VT_THEME_URI . '"'"'/assets/js/header-mobile.js'"'"', ['"'"'jquery'"'"'], VT_THEME_VERSION, true);' "$THEME_PATH/functions.php"
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
echo -e "║        ✅ HEADER LAYOUT CORRIGIDO! ✅        ║"
echo -e "║  Baseado no repositório GitHub Vancouver-Tec ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Layout header baseado no repositório GitHub"
log_success "✅ Dropdowns funcionais (vão para baixo)"
log_success "✅"