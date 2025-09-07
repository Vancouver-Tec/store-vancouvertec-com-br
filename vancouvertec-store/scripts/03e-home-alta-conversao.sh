#!/bin/bash

# ===========================================
# VancouverTec Store - Home Alta Conversão
# Script: 03e-home-alta-conversao.sh
# Versão: 1.0.0 - Design Impactante para Vendas
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
THEME_PATH="wp-content/themes/vancouvertec-store"
PROJECT_PATH="/home/$(whoami)/vancouvertec/store-vancouvertec-com-br/vancouvertec-store"

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║    💰 HOME ALTA CONVERSÃO + HEADER/FOOTER 💰  ║
║      Design Impactante para Vendas          ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar se tema existe
if [[ ! -d "$PROJECT_PATH/$THEME_PATH" ]]; then
    log_error "Tema não encontrado! Execute os scripts anteriores primeiro."
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Criando design de alta conversão em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    log_warning "Parando servidor para atualizações..."
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Atualizar header.php com design profissional
log_info "Criando header.php profissional..."
cat > "$THEME_PATH/header.php" << 'EOF'
<!DOCTYPE html>
<html <?php language_attributes(); ?> class="no-js">
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
    <link rel="profile" href="https://gmpg.org/xfn/11">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Poppins:wght@400;600;700;800&display=swap" rel="stylesheet">
    
    <?php wp_head(); ?>
</head>

<body <?php body_class('vt-loading'); ?>>
<?php wp_body_open(); ?>

<!-- Announcement Bar -->
<div class="announcement-bar">
    <div class="container">
        <div class="announcement-content">
            <span class="announcement-icon">🔥</span>
            <span class="announcement-text">
                <strong>OFERTA LIMITADA:</strong> 50% OFF em todos os produtos digitais até o final do mês!
            </span>
            <a href="<?php echo class_exists('WooCommerce') ? get_permalink(wc_get_page_id('shop')) : '#'; ?>" class="announcement-cta">
                Aproveitar Agora
            </a>
        </div>
    </div>
</div>

<!-- Header Principal -->
<header id="masthead" class="site-header professional-header" role="banner">
    <div class="container">
        <div class="header-content">
            <!-- Logo/Branding -->
            <div class="site-branding">
                <?php if (has_custom_logo()) : ?>
                    <div class="site-logo">
                        <?php the_custom_logo(); ?>
                    </div>
                <?php else : ?>
                    <div class="logo-wrapper">
                        <h1 class="site-title">
                            <a href="<?php echo esc_url(home_url('/')); ?>" rel="home">
                                <span class="logo-icon">🚀</span>
                                <span class="logo-text">VancouverTec</span>
                                <span class="logo-subtitle">Store</span>
                            </a>
                        </h1>
                    </div>
                <?php endif; ?>
            </div>
            
            <!-- Navigation -->
            <nav id="site-navigation" class="main-navigation" role="navigation">
                <button class="menu-toggle mobile-menu-btn" aria-controls="primary-menu" aria-expanded="false">
                    <span class="hamburger">
                        <span></span>
                        <span></span>
                        <span></span>
                    </span>
                    <span class="menu-text">Menu</span>
                </button>
                
                <div class="nav-menu-wrapper">
                    <?php
                    wp_nav_menu([
                        'theme_location' => 'primary',
                        'menu_id' => 'primary-menu',
                        'menu_class' => 'nav-menu',
                        'container' => false,
                        'fallback_cb' => false,
                    ]);
                    ?>
                    
                    <!-- Mobile CTA -->
                    <div class="mobile-cta">
                        <a href="<?php echo esc_url(home_url('/contato')); ?>" class="btn btn-primary">
                            Fale Conosco
                        </a>
                    </div>
                </div>
            </nav>
            
            <!-- Header Actions -->
            <div class="header-actions">
                <!-- Search -->
                <div class="header-search">
                    <button class="search-toggle" aria-expanded="false" aria-controls="header-search-form">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                            <path d="M21 21L16.514 16.506M19 10.5C19 15.194 15.194 19 10.5 19C5.806 19 2 15.194 2 10.5C2 5.806 5.806 2 10.5 2C15.194 2 19 5.806 19 10.5Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </button>
                    <div id="header-search-form" class="search-form-wrapper" hidden>
                        <?php get_search_form(); ?>
                    </div>
                </div>
                
                <!-- Cart (WooCommerce) -->
                <?php if (class_exists('WooCommerce')) : ?>
                    <div class="header-cart">
                        <a href="<?php echo wc_get_cart_url(); ?>" class="cart-toggle">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                                <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.4 5.1 16.4H17M17 13V17C17 18.1 17.9 19 19 19C20.1 19 21 18.1 21 17C21 15.9 20.1 15 19 15C17.9 15 17 15.9 17 17ZM9 19C10.1 19 11 18.1 11 17C11 15.9 10.1 15 9 15C7.9 15 7 15.9 7 17C7 18.1 7.9 19 9 19Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <span class="cart-count"><?php echo WC()->cart->get_cart_contents_count(); ?></span>
                            <span class="cart-total"><?php echo WC()->cart->get_cart_total(); ?></span>
                        </a>
                    </div>
                <?php endif; ?>
                
                <!-- CTA Button -->
                <div class="header-cta">
                    <a href="<?php echo esc_url(home_url('/contato')); ?>" class="btn btn-primary header-cta-btn">
                        <span>Fale Conosco</span>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                            <path d="M5 12H19M19 12L12 5M19 12L12 19" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>

<main id="main" class="site-main" role="main">
EOF

log_success "header.php profissional criado!"

# Atualizar footer.php com design impactante
log_info "Criando footer.php impactante..."
cat > "$THEME_PATH/footer.php" << 'EOF'
</main>

<!-- Footer Newsletter -->
<section class="newsletter-section">
    <div class="container">
        <div class="newsletter-content">
            <div class="newsletter-text">
                <h3 class="newsletter-title">Receba Ofertas Exclusivas</h3>
                <p class="newsletter-description">
                    Seja o primeiro a saber sobre lançamentos, promoções e conteúdos exclusivos
                </p>
            </div>
            
            <form class="newsletter-form" action="#" method="post">
                <div class="form-group">
                    <input type="email" placeholder="Seu melhor e-mail" class="newsletter-input" required>
                    <button type="submit" class="btn btn-primary newsletter-btn">
                        Quero Receber
                    </button>
                </div>
                <p class="newsletter-privacy">
                    <small>📧 Sem spam. Cancelar inscrição a qualquer momento.</small>
                </p>
            </form>
        </div>
    </div>
</section>

<!-- Footer Principal -->
<footer id="colophon" class="site-footer professional-footer" role="contentinfo">
    <div class="footer-main">
        <div class="container">
            <div class="footer-grid">
                <!-- Coluna 1: Sobre -->
                <div class="footer-column">
                    <div class="footer-brand">
                        <h3 class="footer-logo">
                            <span class="logo-icon">🚀</span>
                            VancouverTec
                        </h3>
                        <p class="footer-description">
                            Transformamos ideias em soluções digitais de sucesso. 
                            Sistemas, sites, aplicativos e cursos para empresas que querem crescer.
                        </p>
                    </div>
                    
                    <div class="footer-social">
                        <h4>Siga-nos</h4>
                        <div class="social-links">
                            <a href="#" class="social-link" title="LinkedIn">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
                                </svg>
                            </a>
                            <a href="#" class="social-link" title="Instagram">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/>
                                </svg>
                            </a>
                            <a href="#" class="social-link" title="WhatsApp">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.890-5.335 11.893-11.893A11.821 11.821 0 0020.885 3.488"/>
                                </svg>
                            </a>
                            <a href="#" class="social-link" title="YouTube">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/>
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Coluna 2: Produtos -->
                <div class="footer-column">
                    <h4 class="footer-title">Nossos Produtos</h4>
                    <ul class="footer-links">
                        <li><a href="#">Sites Institucionais</a></li>
                        <li><a href="#">Lojas Virtuais</a></li>
                        <li><a href="#">Aplicativos Mobile</a></li>
                        <li><a href="#">Sistemas Web</a></li>
                        <li><a href="#">Automação</a></li>
                        <li><a href="#">Cursos Online</a></li>
                    </ul>
                </div>
                
                <!-- Coluna 3: Suporte -->
                <div class="footer-column">
                    <h4 class="footer-title">Suporte</h4>
                    <ul class="footer-links">
                        <li><a href="#">Central de Ajuda</a></li>
                        <li><a href="#">Documentação</a></li>
                        <li><a href="#">Tutoriais</a></li>
                        <li><a href="#">FAQ</a></li>
                        <li><a href="#">Contato</a></li>
                        <li><a href="#">WhatsApp</a></li>
                    </ul>
                </div>
                
                <!-- Coluna 4: Contato -->
                <div class="footer-column">
                    <h4 class="footer-title">Fale Conosco</h4>
                    <div class="footer-contact">
                        <div class="contact-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                                <path d="M4 4H20C21.1 4 22 4.9 22 6V18C22 19.1 21.1 20 20 20H4C2.9 20 2 19.1 2 18V6C2 4.9 2.9 4 4 4Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <polyline points="22,6 12,13 2,6" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <span>contato@vancouvertec.com.br</span>
                        </div>
                        
                        <div class="contact-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                                <path d="M22 16.92V19.92C22 20.52 21.39 21 20.76 21C9.28 21 0 11.72 0 0.24C0 -0.39 0.48 -1 1.08 -1H4.08C4.68 -1 5.16 -0.52 5.16 0.08V3.08C5.16 3.68 4.68 4.16 4.08 4.16H2.16C2.16 9.36 6.64 13.84 11.84 13.84V11.92C11.84 11.32 12.32 10.84 12.92 10.84H15.92C16.52 10.84 17 11.32 17 11.92V14.92C17 15.52 16.52 16 15.92 16H13.92" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <span>+55 (11) 99999-9999</span>
                        </div>
                        
                        <div class="contact-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                                <path d="M21 10C21 17 12 23 12 23S3 17 3 10C3 5.03 7.03 1 12 1S21 5.03 21 10Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <circle cx="12" cy="10" r="3" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                            <span>São Paulo, SP - Brasil</span>
                        </div>
                    </div>
                    
                    <!-- Certificações -->
                    <div class="footer-badges">
                        <h5>Certificações</h5>
                        <div class="badges-list">
                            <span class="badge">🔒 SSL Secure</span>
                            <span class="badge">✅ ISO 9001</span>
                            <span class="badge">🏆 Google Partner</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer Bottom -->
    <div class="footer-bottom">
        <div class="container">
            <div class="footer-bottom-content">
                <div class="copyright">
                    <p>
                        &copy; <?php echo date('Y'); ?> 
                        <a href="<?php echo esc_url(home_url('/')); ?>">VancouverTec Store</a>. 
                        Todos os direitos reservados.
                    </p>
                </div>
                
                <div class="footer-legal">
                    <nav class="legal-nav">
                        <a href="<?php echo esc_url(home_url('/privacidade')); ?>">Política de Privacidade</a>
                        <a href="<?php echo esc_url(home_url('/termos')); ?>">Termos de Uso</a>
                        <a href="<?php echo esc_url(home_url('/cookies')); ?>">Cookies</a>
                    </nav>
                </div>
                
                <div class="footer-payment">
                    <span>Pagamento Seguro:</span>
                    <div class="payment-methods">
                        <span class="payment-badge">💳 Cartão</span>
                        <span class="payment-badge">🏦 PIX</span>
                        <span class="payment-badge">📄 Boleto</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>

<?php wp_footer(); ?>

<script>
// Enhanced loading and animations
document.documentElement.classList.remove('no-js');
document.body.classList.add('vt-loaded');

// Mobile menu enhancement
document.querySelector('.mobile-menu-btn')?.addEventListener('click', function() {
    this.classList.toggle('active');
    document.querySelector('.nav-menu-wrapper')?.classList.toggle('active');
});

// Smooth scroll enhancement
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});
</script>

</body>
</html>
EOF

log_success "footer.php impactante criado!"

# Criar CSS para header e footer profissionais
log_info "Criando CSS profissional para header/footer..."
cat > "$THEME_PATH/assets/css/professional.css" << 'EOF'
/* VancouverTec Store - Professional Header/Footer */

/* Typography Enhancement */
body {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
}

h1, h2, h3, h4, h5, h6 {
  font-family: 'Poppins', sans-serif;
}

/* Announcement Bar */
.announcement-bar {
  background: linear-gradient(90deg, var(--vt-error-500), #FF6B6B);
  color: white;
  padding: 0.75rem 0;
  font-size: 0.875rem;
  font-weight: 600;
  text-align: center;
  position: relative;
  overflow: hidden;
}

.announcement-bar::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
  animation: shimmer 3s infinite;
}

@keyframes shimmer {
  0% { left: -100%; }
  100% { left: 100%; }
}

.announcement-content {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: var(--vt-space-sm);
}

.announcement-icon {
  font-size: 1.2rem;
}

.announcement-cta {
  background: rgba(255, 255, 255, 0.2);
  color: white;
  padding: 0.25rem 0.75rem;
  border-radius: var(--vt-radius-full);
  text-decoration: none;
  font-weight: 700;
  transition: var(--vt-transition-fast);
  margin-left: var(--vt-space-sm);
}

.announcement-cta:hover {
  background: rgba(255, 255, 255, 0.3);
  color: white;
}

/* Professional Header */
.professional-header {
  background: rgba(255, 255, 255, 0.98);
  backdrop-filter: blur(20px);
  border-bottom: 1px solid var(--vt-neutral-200);
  box-shadow: 0 2px 20px rgba(0, 0, 0, 0.08);
  position: sticky;
  top: 0;
  z-index: 1000;
  transition: all 0.3s ease;
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 1rem 0;
  min-height: 80px;
}

/* Logo Enhancement */
.logo-wrapper {
  display: flex;
  align-items: center;
}

.site-title a {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  text-decoration: none;
  color: var(--vt-neutral-800);
  transition: var(--vt-transition-fast);
}

.logo-icon {
  font-size: 2rem;
  filter: drop-shadow(0 2px 4px rgba(0, 102, 204, 0.3));
}

.logo-text {
  font-size: 1.5rem;
  font-weight: 800;
  color: var(--vt-blue-600);
}

.logo-subtitle {
  font-size: 1rem;
  font-weight: 600;
  color: var(--vt-neutral-600);
  margin-left: -0.25rem;
}

/* Navigation Enhancement */
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

.nav-menu a {
  color: var(--vt-neutral-700);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  padding: 0.75rem 1rem;
  border-radius: var(--vt-radius-md);
  transition: all 0.3s ease;
  position: relative;
}

.nav-menu a:hover,
.nav-menu a:focus {
  color: var(--vt-blue-600);
  background: var(--vt-blue-600);
  color: white;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 102, 204, 0.3);
}

/* Mobile Menu */
.mobile-menu-btn {
  display: none;
  flex-direction: column;
  align-items: center;
  background: none;
  border: none;
  cursor: pointer;
  padding: 0.5rem;
  gap: 0.25rem;
}

.hamburger {
  display: flex;
  flex-direction: column;
  width: 24px;
  height: 18px;
  position: relative;
}

.hamburger span {
  display: block;
  width: 100%;
  height: 2px;
  background: var(--vt-neutral-700);
  border-radius: 1px;
  transition: all 0.3s ease;
  position: absolute;
}

.hamburger span:nth-child(1) { top: 0; }
.hamburger span:nth-child(2) { top: 50%; transform: translateY(-50%); }
.hamburger span:nth-child(3) { bottom: 0; }

.mobile-menu-btn.active .hamburger span:nth-child(1) {
  transform: rotate(45deg);
  top: 50%;
}

.mobile-menu-btn.active .hamburger span:nth-child(2) {
  opacity: 0;
}

.mobile-menu-btn.active .hamburger span:nth-child(3) {
  transform: rotate(-45deg);
  bottom: 50%;
}

.menu-text {
  font-size: 0.75rem;
  color: var(--vt-neutral-600);
  font-weight: 600;
}

/* Header Actions */
.header-actions {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.search-toggle,
.cart-toggle {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem;
  background: var(--vt-neutral-100);
  border: none;
  border-radius: var(--vt-radius-md);
  color: var(--vt-neutral-700);
  cursor: pointer;
  transition: all 0.3s ease;
  text-decoration: none;
  font-weight: 500;
}

.search-toggle:hover,
.cart-toggle:hover {
  background: var(--vt-blue-600);
  color: white;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 102, 204, 0.3);
}

.cart-count {
  background: var(--vt-error-500);
  color: white;
  font-size: 0.75rem;
  font-weight: 700;
  padding: 0.25rem 0.5rem;
  border-radius: var(--vt-radius-full);
  min-width: 20px;
  text-align: center;
}

.cart-total {
  font-weight: 700;
  color: var(--vt-blue-600);
}

/* Header CTA */
.header-cta-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500));
  color: white;
  text-decoration: none;
  border-radius: var(--vt-radius-md);
  font-weight: 600;
  transition: all 0.3s ease;
  box-shadow: 0 2px 8px rgba(0, 102, 204, 0.3);
}

.header-cta-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(0, 102, 204, 0.4);
  color: white;
}

/* Newsletter Section */
.newsletter-section {
  background: linear-gradient(135deg, var(--vt-blue-600), var(--vt-indigo-500));
  color: white;
  padding: 3rem 0;
  margin-top: 4rem;
}

.newsletter-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
  align-items: center;
}

.newsletter-title {
  font-size: 2rem;
  font-weight: 700;
  margin-bottom: 1rem;
}

.newsletter-description {
  font-size: 1.1rem;
  opacity: 0.9;
}

.newsletter-form .form-group {
  display: flex;
  gap: 1rem;
  margin-bottom: 1rem;
}

.newsletter-input {
  flex: 1;
  padding: 1rem;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: var(--vt-radius-md);
  background: rgba(255, 255, 255, 0.1);
  color: white;
  font-size: 1rem;
  backdrop-filter: blur(10px);
}

.newsletter-input::placeholder {
  color: rgba(255, 255, 255, 0.7);
}

.newsletter-input:focus {
  outline: none;
  border-color: white;
  background: rgba(255, 255, 255, 0.2);
}

.newsletter-btn {
  padding: 1rem 2rem;
  background: white;
  color: var(--vt-blue-600);
  border: none;
  border-radius: var(--vt-radius-md);
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s ease;
  white-space: nowrap;
}

.newsletter-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(255, 255, 255, 0.3);
}

.newsletter-privacy {
  color: rgba(255, 255, 255, 0.8);
  margin: 0;
}

/* Professional Footer */
.professional-footer {
  background: var(--vt-neutral-900);
  color: var(--vt-neutral-300);
}

.footer-main {
  padding: 4rem 0 2rem;
}

.footer-grid {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1.5fr;
  gap: 3rem;
}

.footer-brand {
  margin-bottom: 2rem;
}

.footer-logo {
  font-size: 1.5rem;
  font-weight: 800;
  color: white;
  margin-bottom: 1rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.footer-description {
  line-height: 1.6;
  color: var(--vt-neutral-400);
}

.footer-title {
  color: white;
  font-weight: 700;
  margin-bottom: 1.5rem;
  font-size: 1.125rem;
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-links li {
  margin-bottom: 0.75rem;
}

.footer-links a {
  color: var(--vt-neutral-400);
  text-decoration: none;
  transition: var(--vt-transition-fast);
}

.footer-links a:hover {
  color: white;
  padding-left: 0.5rem;
}

/* Social Links */
.footer-social h4 {
  color: white;
  font-weight: 600;
  margin-bottom: 1rem;
  font-size: 1rem;
}

.social-links {
  display: flex;
  gap: 1rem;
}

.social-link {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  background: var(--vt-neutral-800);
  color: var(--vt-neutral-400);
  border-radius: var(--vt-radius-md);
  transition: all 0.3s ease;
  text-decoration: none;
}

.social-link:hover {
  background: var(--vt-blue-600);
  color: white;
  transform: translateY(-2px);
}

/* Contact Info */
.footer-contact {
  margin-bottom: 2rem;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-bottom: 1rem;
  color: var(--vt-neutral-400);
}

.contact-item svg {
  color: var(--vt-blue-600);
}

/* Footer Badges */
.footer-badges h5 {
  color: white;
  font-weight: 600;
  margin-bottom: 1rem;
  font-size: 0.875rem;
}

.badges-list {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.badge {
  display: inline-block;
  background: var(--vt-neutral-800);
  color: var(--vt-neutral-300);
  padding: 0.25rem 0.75rem;
  border-radius: var(--vt-radius-sm);
  font-size: 0.75rem;
  font-weight: 600;
}

/* Footer Bottom */
.footer-bottom {
  border-top: 1px solid var(--vt-neutral-800);
  padding: 2rem 0;
}

.footer-bottom-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 1rem;
}

.copyright p {
  margin: 0;
  color: var(--vt-neutral-500);
}

.copyright a {
  color: var(--vt-blue-600);
  text-decoration: none;
}

.legal-nav {
  display: flex;
  gap: 2rem;
}

.legal-nav a {
  color: var(--vt-neutral-500);
  text-decoration: none;
  font-size: 0.875rem;
  transition: var(--vt-transition-fast);
}

.legal-nav a:hover {
  color: white;
}

.payment-methods {
  display: flex;
  gap: 0.5rem;
  align-items: center;
}

.payment-badge {
  background: var(--vt-neutral-800);
  color: var(--vt-neutral-300);
  padding: 0.25rem 0.5rem;
  border-radius: var(--vt-radius-sm);
  font-size: 0.75rem;
  font-weight: 600;
}

/* Responsive Design */
@media (max-width: 768px) {
  .announcement-content {
    flex-direction: column;
    gap: 0.5rem;
  }
  
  .announcement-cta {
    margin-left: 0;
  }
  
  .header-content {
    padding: 0.75rem 0;
  }
  
  .mobile-menu-btn {
    display: flex;
  }
  
  .nav-menu-wrapper {
    display: none;
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    background: white;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    border-radius: 0 0 1rem 1rem;
    padding: 2rem;
  }
  
  .nav-menu-wrapper.active {
    display: block;
  }
  
  .nav-menu {
    flex-direction: column;
    gap: 1rem;
  }
  
  .mobile-cta {
    margin-top: 2rem;
    padding-top: 2rem;
    border-top: 1px solid var(--vt-neutral-200);
  }
  
  .header-actions {
    gap: 0.5rem;
  }
  
  .header-cta {
    display: none;
  }
  
  .newsletter-content {
    grid-template-columns: 1fr;
    gap: 2rem;
    text-align: center;
  }
  
  .newsletter-form .form-group {
    flex-direction: column;
  }
  
  .footer-grid {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .footer-bottom-content {
    flex-direction: column;
    text-align: center;
  }
  
  .legal-nav {
    flex-wrap: wrap;
    justify-content: center;
  }
}

@media (max-width: 480px) {
  .logo-text {
    font-size: 1.25rem;
  }
  
  .logo-subtitle {
    font-size: 0.875rem;
  }
  
  .newsletter-title {
    font-size: 1.5rem;
  }
  
  .social-links {
    justify-content: center;
  }
  
  .payment-methods {
    flex-wrap: wrap;
    justify-content: center;
  }
}
EOF

# Atualizar functions.php para incluir o CSS profissional
log_info "Atualizando functions.php para incluir CSS profissional..."
sed -i '/wp_enqueue_style.*vt-home/a\    \n    \/\/ Professional header\/footer CSS\n    wp_enqueue_style('"'"'vt-professional'"'"', VT_THEME_URI . '"'"'/assets/css/professional.css'"'"', ['"'"'vt-main'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"

# Atualizar a home page com design mais impactante
log_info "Atualizando front-page.php com design de alta conversão..."
cat > "$THEME_PATH/front-page.php" << 'EOF'
<?php
/**
 * Front Page Template - Home Page Alta Conversão VancouverTec Store
 * 
 * @package VancouverTec_Store
 */

get_header(); ?>

<!-- Hero Section Impactante -->
<section class="hero-section-enhanced">
    <div class="hero-background">
        <div class="hero-pattern"></div>
        <div class="hero-gradient"></div>
    </div>
    
    <div class="container">
        <div class="hero-content-enhanced">
            <div class="hero-badge">
                <span class="badge-icon">🚀</span>
                <span>Mais de 500 projetos entregues</span>
            </div>
            
            <h1 class="hero-title-enhanced">
                Transforme sua <span class="highlight">Ideia</span> em um 
                <span class="highlight-gradient">Negócio Digital</span> de Sucesso
            </h1>
            
            <p class="hero-description-enhanced">
                Desenvolvemos <strong>sistemas, sites, aplicativos e automações</strong> que fazem sua empresa 
                <span class="text-success">faturar mais</span> e conquistar novos clientes no digital.
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
            
            <div class="hero-actions-enhanced">
                <?php if (class_exists('WooCommerce')) : ?>
                    <a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>" class="btn btn-primary btn-hero">
                        <span>Ver Nossos Produtos</span>
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                            <path d="M7 17L17 7M17 7H7M17 7V17" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </a>
                <?php endif; ?>
                
                <a href="<?php echo esc_url(home_url('/contato')); ?>" class="btn btn-secondary btn-hero">
                    <span>Fale com Especialista</span>
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M22 16.92V19.92C22 20.52 21.39 21 20.76 21C9.28 21 0 11.72 0 0.24C0 -0.39 0.48 -1 1.08 -1H4.08" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </a>
            </div>
            
            <div class="hero-trust">
                <p class="trust-text">Empresas que confiam na VancouverTec:</p>
                <div class="trust-logos">
                    <span class="trust-logo">🏢 TechCorp</span>
                    <span class="trust-logo">🏭 InnovaLabs</span>
                    <span class="trust-logo">💼 StartupXYZ</span>
                    <span class="trust-logo">🚀 FutureCode</span>
                </div>
            </div>
        </div>
    </div>
</section>

<?php if (class_exists('WooCommerce')) : ?>

<!-- Produtos em Destaque com Design Impactante -->
<section class="featured-products-enhanced">
    <div class="container">
        <div class="section-header-enhanced">
            <div class="section-badge">
                <span>🏆 Mais Vendidos</span>
            </div>
            <h2 class="section-title-enhanced">
                Produtos que <span class="highlight-gradient">Transformam Negócios</span>
            </h2>
            <p class="section-description-enhanced">
                Soluções testadas e aprovadas por centenas de empresas que já aumentaram seu faturamento
            </p>
        </div>
        
        <div class="products-grid-enhanced">
            <?php
            $featured_products = wc_get_featured_product_ids();
            if (empty($featured_products)) {
                $args = [
                    'post_type' => 'product',
                    'posts_per_page' => 6,
                    'post_status' => 'publish',
                    'meta_query' => [
                        [
                            'key' => '_visibility',
                            'value' => ['catalog', 'visible'],
                            'compare' => 'IN'
                        ]
                    ]
                ];
                $products = get_posts($args);
            } else {
                $args = [
                    'post_type' => 'product',
                    'posts_per_page' => 6,
                    'post__in' => $featured_products,
                    'post_status' => 'publish'
                ];
                $products = get_posts($args);
            }
            
            if ($products) :
                foreach ($products as $product_post) :
                    $product = wc_get_product($product_post->ID);
                    if (!$product) continue;
                    ?>
                    <div class="product-card-enhanced">
                        <div class="product-badges">
                            <?php if ($product->is_on_sale()) : ?>
                                <span class="product-badge sale-badge">
                                    <span class="badge-icon">🔥</span>
                                    <span>OFERTA</span>
                                </span>
                            <?php endif; ?>
                            
                            <?php if (in_array($product->get_id(), $featured_products)) : ?>
                                <span class="product-badge featured-badge">
                                    <span class="badge-icon">⭐</span>
                                    <span>DESTAQUE</span>
                                </span>
                            <?php endif; ?>
                        </div>
                        
                        <div class="product-image-enhanced">
                            <a href="<?php echo get_permalink($product->get_id()); ?>">
                                <?php echo $product->get_image('vt-product', ['loading' => 'lazy']); ?>
                            </a>
                            <div class="product-overlay">
                                <a href="<?php echo get_permalink($product->get_id()); ?>" class="quick-view-btn">
                                    Ver Detalhes
                                </a>
                            </div>
                        </div>
                        
                        <div class="product-content-enhanced">
                            <h3 class="product-title-enhanced">
                                <a href="<?php echo get_permalink($product->get_id()); ?>">
                                    <?php echo $product->get_name(); ?>
                                </a>
                            </h3>
                            
                            <div class="product-excerpt-enhanced">
                                <?php echo wp_trim_words($product->get_short_description(), 12); ?>
                            </div>
                            
                            <div class="product-features">
                                <span class="feature-item">✅ Suporte incluído</span>
                                <span class="feature-item">✅ Atualizações grátis</span>
                                <span class="feature-item">✅ Garantia 30 dias</span>
                            </div>
                            
                            <div class="product-price-enhanced">
                                <?php if ($product->is_on_sale()) : ?>
                                    <span class="price-old"><?php echo wc_price($product->get_regular_price()); ?></span>
                                <?php endif; ?>
                                <span class="price-current"><?php echo $product->get_price_html(); ?></span>
                                <?php if ($product->is_on_sale()) : ?>
                                    <span class="discount-percent">
                                        <?php 
                                        $regular = (float) $product->get_regular_price();
                                        $sale = (float) $product->get_sale_price();
                                        if ($regular > 0 && $sale > 0) {
                                            $discount = round((($regular - $sale) / $regular) * 100);
                                            echo "-{$discount}%";
                                        }
                                        ?>
                                    </span>
                                <?php endif; ?>
                            </div>
                            
                            <div class="product-actions-enhanced">
                                <?php if ($product->is_purchasable()) : ?>
                                    <button class="btn btn-primary btn-add-cart" 
                                            data-product-id="<?php echo $product->get_id(); ?>">
                                        <span class="btn-text">Adicionar ao Carrinho</span>
                                        <span class="btn-icon">🛒</span>
                                    </button>
                                <?php endif; ?>
                                
                                <a href="<?php echo get_permalink($product->get_id()); ?>" 
                                   class="btn btn-outline btn-details">
                                    Mais Detalhes
                                </a>
                            </div>
                        </div>
                    </div>
                    <?php
                endforeach;
                wp_reset_postdata();
            else : ?>
                <div class="no-products-enhanced">
                    <div class="no-products-icon">📦</div>
                    <h3>Em Breve: Produtos Incríveis!</h3>
                    <p>Estamos preparando soluções digitais que vão revolucionar seu negócio.</p>
                    <?php if (current_user_can('manage_woocommerce')) : ?>
                        <a href="<?php echo admin_url('post-new.php?post_type=product'); ?>" class="btn btn-primary">
                            Cadastrar Primeiro Produto
                        </a>
                    <?php endif; ?>
                </div>
            <?php endif; ?>
        </div>
        
        <?php if ($products) : ?>
            <div class="section-footer-enhanced">
                <a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>" class="btn btn-primary btn-large btn-shop">
                    <span>Ver Todos os Produtos</span>
                    <span class="btn-badge">+<?php echo count($products); ?> produtos</span>
                </a>
            </div>
        <?php endif; ?>
    </div>
</section>

<?php endif; // End WooCommerce check ?>

<!-- Continua com as outras seções já criadas anteriormente -->
<?php include(locate_template('template-parts/home-sections.php')); ?>

<?php get_footer(); ?>
EOF

log_success "front-page.php impactante criado!"

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
echo -e "║    💰 HOME ALTA CONVERSÃO CRIADA! 💰          ║"
echo -e "║       Design Profissional e Impactante      ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Header profissional com announcement bar"
log_success "✅ Footer impactante com newsletter e social"
log_success "✅ Home page de alta conversão criada"
log_success "✅ Design que convence e gera vendas"
log_success "✅ CSS profissional para header/footer"

echo -e "\n${CYAN}🎯 Recursos de Conversão Adicionados:${NC}"
echo -e "• Announcement bar com oferta urgente"
echo -e "• Hero section com stats e social proof"
echo -e "• Produtos com badges, ofertas e urgência"
echo -e "• CTAs impactantes e persuasivos"
echo -e "• Footer com newsletter e certificações"
echo -e "• Design que gera confiança e credibilidade"

echo -e "\n${YELLOW}💎 Elementos de Alta Conversão:${NC}"
echo -e "• Social proof (500+ projetos, 99% satisfação)"
echo -e "• Urgência (ofertas limitadas, badges)"
echo -e "• Credibilidade (certificações, garantias)"
echo -e "• CTAs claros e chamativos"
echo -e "• Design profissional e moderno"
echo -e "• Elementos visuais que geram confiança"

echo -e "\n${PURPLE}🚀 Teste Agora:${NC}"
echo -e "• Home: http://localhost:8080"
echo -e "• Veja o announcement bar no topo"
echo -e "• Hero section com stats impactantes"
echo -e "• Produtos com design de venda"
echo -e "• Footer profissional completo"

log_success "Design de alta conversão implementado!"
log_success "Agora sua home tem 'cara de venda' profissional!"

exit 0