#!/bin/bash

# ===========================================
# VancouverTec Store - Corrigir Botões Desktop DIRETO
# Script: 08d-corrigir-botoes-desktop.sh
# Versão: 1.0.0 - Adiciona botões NO DESKTOP
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
║  🔧 CORRIGIR BOTÕES DESKTOP - DIRETO 🔧      ║
║      Adicionar botões no header desktop      ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Corrigindo botões desktop em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Backup
cp "$THEME_PATH/header.php" "$THEME_PATH/header.php.backup.$(date +%s)"

# REESCREVER HEADER.PHP COM OS BOTÕES NO LUGAR CORRETO
log_info "Reescrevendo header.php com botões no desktop..."
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
            
            <!-- Header Actions COM OS 3 BOTÕES FORÇADOS -->
            <div class="header-actions">
                <!-- Busca -->
                <button class="search-toggle header-btn" aria-label="Buscar" title="Buscar">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M21 21L16.514 16.506M19 10.5C19 15.194 15.194 19 10.5 19C5.806 19 2 15.194 2 10.5C2 5.806 5.806 2 10.5 2C15.194 2 19 5.806 19 10.5Z" stroke="currentColor" stroke-width="2"/>
                    </svg>
                    <span class="btn-text">Buscar</span>
                </button>
                
                <!-- 1. WISHLIST - FORÇADO NO DESKTOP -->
                <a href="/wishlist" class="wishlist-link header-btn desktop-btn" aria-label="Lista de Desejos" title="Favoritos">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M20.84 4.61A5.5 5.5 0 0 0 12 5.67 5.5 5.5 0 0 0 3.16 4.61C1.13 6.64 1.13 9.89 3.16 11.92L12 21.23l8.84-9.31c2.03-2.03 2.03-5.28 0-7.31z" stroke="currentColor" stroke-width="2"/>
                    </svg>
                    <span class="btn-text">Favoritos</span>
                    <span class="wishlist-count">0</span>
                </a>
                
                <!-- 2. CARRINHO - FORÇADO NO DESKTOP -->
                <?php if (class_exists('WooCommerce')) : ?>
                <a href="<?php echo wc_get_cart_url(); ?>" class="cart-link header-btn desktop-btn" aria-label="Carrinho" title="Carrinho">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.4 5.1 16.4H17M17 13V17A4 4 0 1 1 9 17M9 19A2 2 0 1 0 9 15 2 2 0 0 0 9 19Z" stroke="currentColor" stroke-width="2"/>
                    </svg>
                    <span class="btn-text">Carrinho</span>
                    <span class="cart-count"><?php echo WC()->cart->get_cart_contents_count(); ?></span>
                </a>
                <?php endif; ?>
                
                <!-- 3. LOGIN/ADMIN - FORÇADO NO DESKTOP -->
                <?php if (is_user_logged_in()) : ?>
                    <div class="user-menu desktop-btn">
                        <button class="user-toggle header-btn" aria-label="Minha Conta" title="Conta">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                                <path d="M20 21V19A4 4 0 0 0 16 15H8A4 4 0 0 0 4 19V21M16 7A4 4 0 1 1 8 7 4 4 0 0 1 16 7Z" stroke="currentColor" stroke-width="2"/>
                            </svg>
                            <span class="btn-text"><?php echo current_user_can('manage_options') ? 'Admin' : 'Conta'; ?></span>
                            <span class="dropdown-arrow">▼</span>
                        </button>
                        <div class="user-dropdown">
                            <?php if (class_exists('WooCommerce')) : ?>
                                <a href="<?php echo get_permalink(wc_get_page_id('myaccount')); ?>">📋 Minha Conta</a>
                                <a href="<?php echo get_permalink(wc_get_page_id('myaccount')); ?>orders/">📦 Pedidos</a>
                            <?php endif; ?>
                            <?php if (current_user_can('manage_options')) : ?>
                                <a href="<?php echo admin_url(); ?>">⚙️ Admin</a>
                                <a href="<?php echo admin_url('edit.php?post_type=product'); ?>">🛒 Produtos</a>
                            <?php endif; ?>
                            <a href="<?php echo wp_logout_url(home_url()); ?>">🚪 Sair</a>
                        </div>
                    </div>
                <?php else : ?>
                    <a href="<?php echo wp_login_url(home_url()); ?>" class="login-link header-btn desktop-btn" title="Entrar">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                            <path d="M15 3H19A2 2 0 0 1 21 5V19A2 2 0 0 1 19 21H15M10 17L15 12L10 7M15 12H3" stroke="currentColor" stroke-width="2"/>
                        </svg>
                        <span class="btn-text">Entrar</span>
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
        <div class="mobile-header-actions">
            <div class="mobile-actions-row">
                <a href="/wishlist" class="mobile-action-btn">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                        <path d="M20.84 4.61A5.5 5.5 0 0 0 12 5.67 5.5 5.5 0 0 0 3.16 4.61C1.13 6.64 1.13 9.89 3.16 11.92L12 21.23l8.84-9.31c2.03-2.03 2.03-5.28 0-7.31z" stroke="currentColor" stroke-width="2"/>
                    </svg>
                    <span>Favoritos</span>
                    <span class="mobile-count">0</span>
                </a>
                
                <?php if (class_exists('WooCommerce')) : ?>
                <a href="<?php echo wc_get_cart_url(); ?>" class="mobile-action-btn">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                        <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.4 5.1 16.4H17M17 13V17A4 4 0 1 1 9 17M9 19A2 2 0 1 0 9 15 2 2 0 0 0 9 19Z" stroke="currentColor" stroke-width="2"/>
                    </svg>
                    <span>Carrinho</span>
                    <span class="mobile-count"><?php echo WC()->cart->get_cart_contents_count(); ?></span>
                </a>
                <?php endif; ?>
                
                <?php if (is_user_logged_in()) : ?>
                    <a href="<?php echo current_user_can('manage_options') ? admin_url() : get_permalink(wc_get_page_id('myaccount')); ?>" class="mobile-action-btn">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                            <path d="M20 21V19A4 4 0 0 0 16 15H8A4 4 0 0 0 4 19V21M16 7A4 4 0 1 1 8 7 4 4 0 0 1 16 7Z" stroke="currentColor" stroke-width="2"/>
                        </svg>
                        <span><?php echo current_user_can('manage_options') ? 'Admin' : 'Conta'; ?></span>
                    </a>
                <?php else : ?>
                    <a href="<?php echo wp_login_url(home_url()); ?>" class="mobile-action-btn">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
                            <path d="M15 3H19A2 2 0 0 1 21 5V19A2 2 0 0 1 19 21H15M10 17L15 12L10 7M15 12H3" stroke="currentColor" stroke-width="2"/>
                        </svg>
                        <span>Entrar</span>
                    </a>
                <?php endif; ?>
            </div>
        </div>
        
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

# CORRIGIR CSS - FORÇAR EXIBIÇÃO DOS BOTÕES
log_info "Corrigindo CSS para FORÇAR botões no desktop..."
cat > "$THEME_PATH/assets/css/layouts/header-botoes-forcados.css" << 'EOF'
/* BOTÕES FORÇADOS - APARECEM EM DESKTOP E TABLET */

.header-actions {
  display: flex !important;
  align-items: center;
  gap: 1rem;
}

.header-btn {
  display: flex !important;
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

.desktop-btn {
  display: flex !important;
}

.header-btn:hover {
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
  position: absolute;
  top: -8px;
  right: -8px;
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

/* DESKTOP (1025px+) - BOTÕES COMPLETOS FORÇADOS */
@media (min-width: 1025px) {
  .header-actions {
    gap: 1rem;
  }
  
  .btn-text {
    display: block !important;
  }
  
  .mobile-header-actions {
    display: none !important;
  }
  
  .desktop-btn {
    display: flex !important;
  }
  
  .header-btn {
    padding: 0.75rem 1rem;
  }
}

/* TABLET (769px - 1024px) - BOTÕES COMPACTOS FORÇADOS */
@media (max-width: 1024px) and (min-width: 769px) {
  .header-actions {
    gap: 0.75rem;
  }
  
  .btn-text {
    display: none !important;
  }
  
  .desktop-btn {
    display: flex !important;
  }
  
  .header-btn {
    padding: 0.75rem;
  }
  
  .header-cta {
    display: none;
  }
  
  .mobile-header-actions {
    display: none !important;
  }
}

/* MOBILE (768px-) - ESCONDER DESKTOP, MOSTRAR MOBILE */
@media (max-width: 768px) {
  .mobile-menu-toggle {
    display: flex;
  }
  
  .main-navigation {
    display: none;
  }
  
  .header-actions .header-btn,
  .header-actions .btn {
    display: none !important;
  }
  
  .desktop-btn {
    display: none !important;
  }
  
  .mobile-header-actions {
    display: block !important;
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
}

/* Estados especiais */
.cart-link.has-items,
.wishlist-link.has-items {
  background: #FEF3C7 !important;
  border-color: #F59E0B !important;
  color: #92400E !important;
}

.cart-link.has-items:hover {
  background: #10B981 !important;
  color: white !important;
}

.wishlist-link.has-items:hover {
  background: #EF4444 !important;
  color: white !important;
}
EOF

# Adicionar novo CSS no functions.php
log_info "Carregando CSS dos botões forçados..."
if ! grep -q "header-botoes-forcados.css" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_style.*vt-header/a\    wp_enqueue_style('"'"'vt-header-botoes'"'"', VT_THEME_URI . '"'"'/assets/css/layouts/header-botoes-forcados.css'"'"', ['"'"'vt-header'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"
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
echo -e "║   ✅ BOTÕES FORÇADOS NO DESKTOP/TABLET! ✅   ║"
echo -e "║      Agora aparecem em TODOS os tamanhos     ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Desktop: Botões completos FORÇADOS com !important"
log_success "✅ Tablet: Botões compactos FORÇADOS (só ícones)"
log_success "✅ Mobile: Botões no menu mobile (funcionando)"
log_success "✅ CSS com !important para garantir exibição"

echo -e "\n${YELLOW}📱 TESTE AGORA:${NC}"
echo -e "• Desktop: http://localhost:8080 - DEVE ver 3 botões com texto"
echo -e "• Tablet: 800px - DEVE ver 3 botões só com ícones"  
echo -e "• Mobile: 375px - DEVE ver 3 botões no menu mobile"

echo -e "\n${BLUE}🔧 TÉCNICA USADA:${NC}"
echo -e "• Classe .desktop-btn para forçar exibição"
echo -e "• CSS com !important para sobrescrever"
echo -e "• Botões adicionados diretamente no HTML"

log_success "Agora os botões DEVEM aparecer no desktop e tablet!"

exit 0