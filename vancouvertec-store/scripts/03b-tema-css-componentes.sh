#!/bin/bash

# ===========================================
# VancouverTec Store - CSS e Componentes
# Script: 03b-tema-css-componentes.sh
# Versão: 1.0.0 - CSS Avançado + Componentes
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
║       🎨 CSS Avançado + Componentes 🎨       ║
║    Design System VancouverTec Completo      ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar se tema existe
if [[ ! -d "$PROJECT_PATH/$THEME_PATH" ]]; then
    log_error "Tema não encontrado! Execute primeiro: 03x-correcao-emergencial-tema.sh"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Expandindo CSS e componentes em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    log_warning "Parando servidor para atualizações..."
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Criar CSS principal avançado
log_info "Criando main.css avançado..."
mkdir -p "$THEME_PATH/assets/css"

cat > "$THEME_PATH/assets/css/main.css" << 'EOF'
/* VancouverTec Store - Main CSS */
/* Design System Premium - Performance 99+ */

/* Hero Section */
.hero-section {
  background: linear-gradient(135deg, var(--vt-blue-600) 0%, var(--vt-indigo-500) 100%);
  color: white;
  padding: var(--vt-space-3xl) 0;
  margin-bottom: var(--vt-space-2xl);
  position: relative;
  overflow: hidden;
}

.hero-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
  pointer-events: none;
}

.hero-content {
  position: relative;
  z-index: 2;
  max-width: 800px;
  margin: 0 auto;
}

.hero-title {
  font-size: clamp(2rem, 5vw, 3.5rem);
  font-weight: 700;
  margin-bottom: var(--vt-space-sm);
  line-height: 1.2;
}

.hero-subtitle {
  font-size: clamp(1.25rem, 3vw, 1.75rem);
  font-weight: 600;
  margin-bottom: var(--vt-space-md);
  opacity: 0.95;
}

.hero-description {
  font-size: clamp(1rem, 2vw, 1.25rem);
  margin-bottom: var(--vt-space-xl);
  opacity: 0.9;
  line-height: 1.6;
}

.hero-actions {
  display: flex;
  gap: var(--vt-space-md);
  justify-content: center;
  flex-wrap: wrap;
}

.hero-actions .btn {
  min-width: 160px;
  padding: var(--vt-space-md) var(--vt-space-xl);
  font-size: 1.1rem;
}

.hero-actions .btn-secondary {
  background: rgba(255, 255, 255, 0.15);
  color: white;
  border: 2px solid rgba(255, 255, 255, 0.3);
  backdrop-filter: blur(10px);
}

.hero-actions .btn-secondary:hover {
  background: rgba(255, 255, 255, 0.25);
  border-color: rgba(255, 255, 255, 0.5);
  color: white;
}

/* Posts Grid */
.posts-section {
  margin-bottom: var(--vt-space-3xl);
}

.section-title {
  font-size: clamp(1.75rem, 4vw, 2.5rem);
  font-weight: 700;
  color: var(--vt-neutral-800);
  margin-bottom: var(--vt-space-xl);
  text-align: center;
  position: relative;
}

.section-title::after {
  content: '';
  display: block;
  width: 60px;
  height: 4px;
  background: linear-gradient(90deg, var(--vt-blue-600), var(--vt-indigo-500));
  margin: var(--vt-space-md) auto 0;
  border-radius: var(--vt-radius-full);
}

.posts-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
  gap: var(--vt-space-xl);
  margin-top: var(--vt-space-xl);
}

.post-card {
  background: white;
  border-radius: var(--vt-radius-xl);
  box-shadow: var(--vt-shadow-md);
  overflow: hidden;
  transition: var(--vt-transition-normal);
  border: 1px solid var(--vt-neutral-200);
}

.post-card:hover {
  transform: translateY(-8px);
  box-shadow: var(--vt-shadow-xl);
  border-color: var(--vt-blue-600);
}

.post-thumbnail {
  position: relative;
  overflow: hidden;
  aspect-ratio: 16/9;
}

.post-thumbnail img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: var(--vt-transition-slow);
}

.post-card:hover .post-thumbnail img {
  transform: scale(1.05);
}

.post-content {
  padding: var(--vt-space-lg);
}

.post-title {
  font-size: 1.25rem;
  font-weight: 600;
  margin-bottom: var(--vt-space-sm);
  line-height: 1.4;
}

.post-title a {
  color: var(--vt-neutral-800);
  text-decoration: none;
  transition: var(--vt-transition-fast);
}

.post-title a:hover {
  color: var(--vt-blue-600);
}

.post-meta {
  display: flex;
  align-items: center;
  gap: var(--vt-space-sm);
  font-size: 0.875rem;
  color: var(--vt-neutral-500);
  margin-bottom: var(--vt-space-md);
}

.post-excerpt {
  color: var(--vt-neutral-600);
  line-height: 1.6;
  margin-bottom: var(--vt-space-md);
}

.read-more {
  color: var(--vt-blue-600);
  text-decoration: none;
  font-weight: 600;
  font-size: 0.875rem;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  transition: var(--vt-transition-fast);
}

.read-more:hover {
  color: var(--vt-blue-700);
  text-decoration: underline;
}

/* Cards e Componentes */
.card {
  background: white;
  border-radius: var(--vt-radius-lg);
  box-shadow: var(--vt-shadow-md);
  overflow: hidden;
  transition: var(--vt-transition-normal);
}

.card:hover {
  box-shadow: var(--vt-shadow-xl);
  transform: translateY(-2px);
}

.card-header {
  padding: var(--vt-space-lg);
  border-bottom: 1px solid var(--vt-neutral-200);
}

.card-body {
  padding: var(--vt-space-lg);
}

.card-footer {
  padding: var(--vt-space-lg);
  border-top: 1px solid var(--vt-neutral-200);
  background: var(--vt-neutral-50);
}

/* Badges */
.badge {
  display: inline-flex;
  align-items: center;
  padding: 0.25rem 0.75rem;
  font-size: 0.75rem;
  font-weight: 600;
  border-radius: var(--vt-radius-full);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.badge-primary {
  background: var(--vt-blue-600);
  color: white;
}

.badge-success {
  background: var(--vt-success-500);
  color: white;
}

.badge-warning {
  background: var(--vt-warning-500);
  color: white;
}

.badge-secondary {
  background: var(--vt-neutral-200);
  color: var(--vt-neutral-700);
}

/* Forms */
.form-group {
  margin-bottom: var(--vt-space-md);
}

.form-label {
  display: block;
  font-weight: 600;
  margin-bottom: var(--vt-space-xs);
  color: var(--vt-neutral-700);
}

.form-control {
  width: 100%;
  padding: var(--vt-space-sm);
  border: 2px solid var(--vt-neutral-300);
  border-radius: var(--vt-radius-md);
  font-size: 1rem;
  transition: var(--vt-transition-fast);
  background: white;
}

.form-control:focus {
  outline: none;
  border-color: var(--vt-blue-600);
  box-shadow: 0 0 0 3px rgba(0, 102, 204, 0.1);
}

.form-control::placeholder {
  color: var(--vt-neutral-400);
}

/* Search Form */
.search-form {
  display: flex;
  gap: var(--vt-space-xs);
  max-width: 400px;
}

.search-field {
  flex: 1;
}

.search-submit {
  padding: var(--vt-space-sm) var(--vt-space-md);
  background: var(--vt-blue-600);
  color: white;
  border: none;
  border-radius: var(--vt-radius-md);
  cursor: pointer;
  transition: var(--vt-transition-fast);
}

.search-submit:hover {
  background: var(--vt-blue-700);
}

/* Navigation Pagination */
.navigation {
  margin: var(--vt-space-2xl) 0;
  text-align: center;
}

.page-numbers {
  display: inline-flex;
  gap: var(--vt-space-xs);
  align-items: center;
}

.page-numbers a,
.page-numbers span {
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 44px;
  height: 44px;
  padding: 0 var(--vt-space-sm);
  border: 2px solid var(--vt-neutral-300);
  border-radius: var(--vt-radius-md);
  text-decoration: none;
  color: var(--vt-neutral-700);
  font-weight: 600;
  transition: var(--vt-transition-fast);
}

.page-numbers a:hover {
  border-color: var(--vt-blue-600);
  color: var(--vt-blue-600);
}

.page-numbers .current {
  background: var(--vt-blue-600);
  border-color: var(--vt-blue-600);
  color: white;
}

/* Widgets */
.widget {
  margin-bottom: var(--vt-space-xl);
}

.widget-title {
  font-size: 1.25rem;
  font-weight: 700;
  color: var(--vt-neutral-800);
  margin-bottom: var(--vt-space-md);
  padding-bottom: var(--vt-space-sm);
  border-bottom: 2px solid var(--vt-blue-600);
}

.widget ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.widget li {
  margin-bottom: var(--vt-space-sm);
}

.widget a {
  color: var(--vt-neutral-600);
  text-decoration: none;
  transition: var(--vt-transition-fast);
}

.widget a:hover {
  color: var(--vt-blue-600);
}

/* Footer Widgets */
.footer-widgets {
  padding: var(--vt-space-2xl) 0;
  border-bottom: 1px solid var(--vt-neutral-700);
}

.footer-widget-area {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: var(--vt-space-xl);
}

.footer-widget .widget-title {
  color: var(--vt-neutral-200);
  border-bottom-color: var(--vt-blue-600);
}

.footer-widget a {
  color: var(--vt-neutral-400);
}

.footer-widget a:hover {
  color: var(--vt-neutral-200);
}

/* Accessibility */
.skip-link {
  position: absolute;
  left: -9999px;
  z-index: 999999;
  padding: var(--vt-space-sm) var(--vt-space-md);
  background: var(--vt-neutral-900);
  color: white;
  text-decoration: none;
}

.skip-link:focus {
  left: 0;
  top: 0;
}

/* Loading States */
.loading {
  position: relative;
  pointer-events: none;
}

.loading::after {
  content: '';
  position: absolute;
  top: 50%;
  left: 50%;
  width: 20px;
  height: 20px;
  margin: -10px 0 0 -10px;
  border: 2px solid var(--vt-neutral-300);
  border-top-color: var(--vt-blue-600);
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

/* Mobile Optimizations */
@media (max-width: 768px) {
  .hero-section {
    padding: var(--vt-space-2xl) 0;
  }
  
  .hero-actions {
    flex-direction: column;
    align-items: center;
  }
  
  .hero-actions .btn {
    width: 100%;
    max-width: 280px;
  }
  
  .posts-grid {
    grid-template-columns: 1fr;
    gap: var(--vt-space-lg);
  }
  
  .footer-widget-area {
    grid-template-columns: 1fr;
    gap: var(--vt-space-lg);
  }
}

/* Performance */
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}

/* Print Styles */
@media print {
  .hero-section,
  .footer-widgets,
  .navigation {
    display: none !important;
  }
  
  .post-card {
    box-shadow: none;
    border: 1px solid #ccc;
    page-break-inside: avoid;
  }
}
EOF

log_success "main.css avançado criado!"

# Criar JavaScript melhorado
log_info "Melhorando main.js..."
cat > "$THEME_PATH/assets/js/main.js" << 'EOF'
(function($) {
    'use strict';
    
    const VTStore = {
        init() {
            console.log('VancouverTec Store - Inicializando...');
            this.setupPerformance();
            this.setupNavigation();
            this.setupSearch();
            this.setupAnimations();
            this.setupAccessibility();
        },
        
        setupPerformance() {
            // Lazy loading para imagens
            $('img').attr('loading', 'lazy');
            
            // Preload critical resources
            const criticalResources = [
                vt_ajax.theme_url + '/assets/css/main.css'
            ];
            
            criticalResources.forEach(resource => {
                const link = document.createElement('link');
                link.rel = 'preload';
                link.href = resource;
                link.as = 'style';
                document.head.appendChild(link);
            });
            
            // Remove loading class when ready
            $(document).ready(() => {
                $('body').removeClass('vt-loading').addClass('vt-loaded');
            });
        },
        
        setupNavigation() {
            // Mobile menu toggle
            $('.menu-toggle').on('click', function() {
                const $nav = $('#site-navigation');
                const isExpanded = $(this).attr('aria-expanded') === 'true';
                
                $(this).attr('aria-expanded', !isExpanded);
                $nav.toggleClass('nav-open');
            });
            
            // Smooth scroll for anchor links
            $('a[href^="#"]').on('click', function(e) {
                const target = $(this.getAttribute('href'));
                if (target.length) {
                    e.preventDefault();
                    $('html, body').animate({
                        scrollTop: target.offset().top - 80
                    }, 800);
                }
            });
        },
        
        setupSearch() {
            // Search toggle
            $('.search-toggle').on('click', function() {
                const $wrapper = $('#header-search-form');
                const isExpanded = $(this).attr('aria-expanded') === 'true';
                
                $(this).attr('aria-expanded', !isExpanded);
                $wrapper.toggle();
                
                if (!isExpanded) {
                    $wrapper.find('input').focus();
                }
            });
            
            // Close search on outside click
            $(document).on('click', function(e) {
                if (!$(e.target).closest('.header-search').length) {
                    $('#header-search-form').hide();
                    $('.search-toggle').attr('aria-expanded', 'false');
                }
            });
        },
        
        setupAnimations() {
            // Intersection Observer for animations
            if ('IntersectionObserver' in window) {
                const observer = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            entry.target.classList.add('vt-animate-in');
                            observer.unobserve(entry.target);
                        }
                    });
                }, {
                    threshold: 0.1,
                    rootMargin: '0px 0px -50px 0px'
                });
                
                // Observe cards for animation
                $('.post-card, .card').each(function() {
                    observer.observe(this);
                });
            }
            
            // Hover effects for cards
            $('.post-card').on('mouseenter', function() {
                $(this).addClass('hover-active');
            }).on('mouseleave', function() {
                $(this).removeClass('hover-active');
            });
        },
        
        setupAccessibility() {
            // Focus management
            $('a, button, input, textarea, select').on('focus', function() {
                $(this).addClass('focus-visible');
            }).on('blur', function() {
                $(this).removeClass('focus-visible');
            });
            
            // Skip link functionality
            $('.skip-link').on('click', function(e) {
                const target = $(this.getAttribute('href'));
                if (target.length) {
                    e.preventDefault();
                    target.attr('tabindex', '-1').focus();
                }
            });
            
            // Keyboard navigation for menus
            $('.main-navigation a').on('keydown', function(e) {
                if (e.key === 'Escape') {
                    $('.menu-toggle').focus();
                    $('#site-navigation').removeClass('nav-open');
                }
            });
        },
        
        // AJAX utilities
        ajaxCall(action, data, callback) {
            $.ajax({
                url: vt_ajax.ajax_url,
                type: 'POST',
                data: {
                    action: action,
                    nonce: vt_ajax.nonce,
                    ...data
                },
                beforeSend: () => {
                    this.showLoading();
                },
                success: (response) => {
                    this.hideLoading();
                    if (callback) callback(response);
                },
                error: (xhr, status, error) => {
                    this.hideLoading();
                    console.error('AJAX Error:', error);
                }
            });
        },
        
        showLoading() {
            $('body').addClass('vt-loading-state');
        },
        
        hideLoading() {
            $('body').removeClass('vt-loading-state');
        }
    };
    
    // Initialize when DOM is ready
    $(document).ready(() => {
        VTStore.init();
    });
    
    // Expose to global scope for other scripts
    window.VTStore = VTStore;
    
})(jQuery);
EOF

log_success "main.js melhorado criado!"

# Criar CSS adicional para animações
log_info "Criando animations.css..."
cat > "$THEME_PATH/assets/css/animations.css" << 'EOF'
/* VancouverTec Store - Animations */

/* Fade in animation */
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

.vt-animate-in {
  animation: fadeInUp 0.6s ease-out;
}

/* Loading states */
.vt-loading-state {
  cursor: wait;
}

.vt-loading-state * {
  pointer-events: none;
}

/* Focus states */
.focus-visible {
  outline: 2px solid var(--vt-blue-600) !important;
  outline-offset: 2px !important;
}

/* Hover states */
.hover-active {
  transform: translateY(-4px);
  box-shadow: var(--vt-shadow-xl);
}

/* Mobile navigation */
.nav-open {
  display: block !important;
}

@media (max-width: 768px) {
  .main-navigation ul {
    display: none;
    flex-direction: column;
    position: absolute;
    top: 100%;
    left: 0;
    right: 0;
    background: white;
    box-shadow: var(--vt-shadow-lg);
    padding: var(--vt-space-md);
    border-radius: 0 0 var(--vt-radius-lg) var(--vt-radius-lg);
  }
  
  .nav-open ul {
    display: flex;
  }
}
EOF

log_success "animations.css criado!"

# Atualizar functions.php para incluir novos assets
log_info "Atualizando functions.php..."
sed -i '/wp_enqueue_style.*vt-style/a\    wp_enqueue_style('"'"'vt-main'"'"', VT_THEME_URI . '"'"'/assets/css/main.css'"'"', ['"'"'vt-style'"'"'], VT_THEME_VERSION);\n    wp_enqueue_style('"'"'vt-animations'"'"', VT_THEME_URI . '"'"'/assets/css/animations.css'"'"', ['"'"'vt-main'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"

log_success "functions.php atualizado!"

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
echo -e "║      ✅ CSS AVANÇADO CRIADO COM SUCESSO! ✅   ║"
echo -e "║        Design System Profissional           ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ main.css com design system completo"
log_success "✅ JavaScript interativo melhorado"
log_success "✅ Animações e transições suaves"
log_success "✅ Componentes reutilizáveis"
log_success "✅ Responsivo mobile-first"

echo -e "\n${CYAN}🎨 Novos Recursos Visuais:${NC}"
echo -e "• Hero section com gradiente e padrão"
echo -e "• Cards com hover effects e sombras"
echo -e "• Grid responsivo para posts"
echo -e "• Componentes: badges, forms, navegação"
echo -e "• Animações de entrada suaves"
echo -e "• Estados de loading e foco"

echo -e "\n${YELLOW}📱 Funcionalidades JavaScript:${NC}"
echo -e "• Menu mobile responsivo"
echo -e "• Busca toggle com foco"
echo -e "• Scroll suave para âncoras"
echo -e "• Intersection Observer para animações"
echo -e "• Gerenciamento de acessibilidade"
echo -e "• Utilities AJAX prontas"

echo -e "\n${PURPLE}🌐 Teste Agora:${NC}"
echo -e "• Frontend: http://localhost:8080"
echo -e "• Veja o hero section azul"
echo -e "• Teste responsividade"
echo -e "• Verifique animações"

log_success "Design system VancouverTec implementado!"
log_success "Digite 'continuar' para criar templates específicos"

exit 0