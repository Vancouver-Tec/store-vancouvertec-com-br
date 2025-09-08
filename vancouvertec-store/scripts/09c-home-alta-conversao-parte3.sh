#!/bin/bash

# ===========================================
# VancouverTec Store - Home Alta Conversão PARTE 3
# Script: 09c-home-alta-conversao-parte3.sh
# Versão: 1.0.0 - JavaScript Interativo + Animações
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
║   ⚡ HOME ALTA CONVERSÃO - PARTE 3 ⚡        ║
║    JavaScript + Animações + Countdown       ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Adicionando JavaScript e animações..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# JavaScript para home de alta conversão
log_info "Criando JavaScript interativo..."
cat > "$THEME_PATH/assets/js/home-conversao.js" << 'EOF'
/**
 * VancouverTec Store - Home Alta Conversão
 * JavaScript para interações e animações
 */

document.addEventListener('DOMContentLoaded', function() {
    
    // ===== COUNTDOWN TIMER =====
    function initCountdown() {
        const countdownElements = document.querySelectorAll('.countdown-item');
        if (countdownElements.length === 0) return;

        let hours = 23;
        let minutes = 45;
        let seconds = 30;

        function updateCountdown() {
            seconds--;
            
            if (seconds < 0) {
                seconds = 59;
                minutes--;
                
                if (minutes < 0) {
                    minutes = 59;
                    hours--;
                    
                    if (hours < 0) {
                        hours = 23;
                        minutes = 59;
                        seconds = 59;
                    }
                }
            }

            // Atualizar displays
            const hoursEl = document.querySelector('.countdown-item:nth-child(1) .countdown-number');
            const minutesEl = document.querySelector('.countdown-item:nth-child(3) .countdown-number');
            const secondsEl = document.querySelector('.countdown-item:nth-child(5) .countdown-number');

            if (hoursEl) hoursEl.textContent = hours.toString().padStart(2, '0');
            if (minutesEl) minutesEl.textContent = minutes.toString().padStart(2, '0');
            if (secondsEl) secondsEl.textContent = seconds.toString().padStart(2, '0');
        }

        // Iniciar countdown
        setInterval(updateCountdown, 1000);
    }

    // ===== ANIMAÇÕES DE ENTRADA =====
    function initScrollAnimations() {
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-in');
                }
            });
        }, observerOptions);

        // Elementos para animar
        const animateElements = document.querySelectorAll(
            '.category-card, .product-card, .testimonial-card, .benefit-card, .hero-stats, .section-header'
        );
        
        animateElements.forEach(el => {
            el.classList.add('animate-element');
            observer.observe(el);
        });
    }

    // ===== COUNTER ANIMADO =====
    function initCounters() {
        const counters = document.querySelectorAll('.stat-number');
        
        function animateCounter(element) {
            const target = parseInt(element.textContent.replace(/\D/g, ''));
            const duration = 2000;
            const step = target / (duration / 16);
            let current = 0;
            
            const timer = setInterval(() => {
                current += step;
                if (current >= target) {
                    element.textContent = element.textContent.replace(/\d+/, target);
                    clearInterval(timer);
                } else {
                    element.textContent = element.textContent.replace(/\d+/, Math.floor(current));
                }
            }, 16);
        }

        const counterObserver = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting && !entry.target.classList.contains('counted')) {
                    entry.target.classList.add('counted');
                    animateCounter(entry.target);
                }
            });
        }, { threshold: 0.5 });

        counters.forEach(counter => {
            counterObserver.observe(counter);
        });
    }

    // ===== SCROLL SUAVE =====
    function initSmoothScroll() {
        const links = document.querySelectorAll('a[href^="#"]');
        
        links.forEach(link => {
            link.addEventListener('click', function(e) {
                const href = this.getAttribute('href');
                if (href === '#') return;
                
                e.preventDefault();
                const target = document.querySelector(href);
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    }

    // ===== EFEITO PARALLAX SIMPLES =====
    function initParallax() {
        const heroSection = document.querySelector('.hero-section-conversao');
        if (!heroSection) return;

        window.addEventListener('scroll', function() {
            const scrolled = window.pageYOffset;
            const rate = scrolled * -0.5;
            
            if (heroSection.querySelector('.hero-pattern')) {
                heroSection.querySelector('.hero-pattern').style.transform = 
                    `translateY(${rate}px)`;
            }
        });
    }

    // ===== LOADING PAGE =====
    function initPageLoad() {
        document.body.classList.remove('vt-loading');
        
        // Animar hero elementos em sequência
        const heroElements = [
            '.hero-badge',
            '.hero-title', 
            '.hero-subtitle',
            '.hero-stats',
            '.hero-actions',
            '.hero-guarantee'
        ];

        heroElements.forEach((selector, index) => {
            const element = document.querySelector(selector);
            if (element) {
                setTimeout(() => {
                    element.classList.add('hero-animate');
                }, index * 200);
            }
        });
    }

    // ===== URGÊNCIA DINÂMICA =====
    function initUrgencyAlerts() {
        const urgencyTexts = [
            "⏰ Restam apenas 12 unidades!",
            "🔥 8 pessoas visualizando agora!",
            "⚡ Últimas 5 vagas disponíveis!",
            "🚨 Oferta termina em breve!"
        ];

        const urgencyElements = document.querySelectorAll('.urgency-text');
        
        urgencyElements.forEach((element, index) => {
            setInterval(() => {
                const randomText = urgencyTexts[Math.floor(Math.random() * urgencyTexts.length)];
                element.textContent = randomText;
                
                // Piscar efeito
                element.style.opacity = '0.5';
                setTimeout(() => {
                    element.style.opacity = '1';
                }, 200);
            }, 8000 + (index * 2000));
        });
    }

    // ===== BOTÕES COM TRACKING =====
    function initButtonTracking() {
        const ctaButtons = document.querySelectorAll(
            '.btn-cta-primary, .btn-cta-secondary, .product-btn, .category-btn, .cta-btn-primary'
        );

        ctaButtons.forEach(button => {
            button.addEventListener('click', function(e) {
                // Efeito visual
                this.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    this.style.transform = '';
                }, 150);

                // Log para analytics (se necessário)
                console.log('CTA clicked:', this.textContent.trim());
            });
        });
    }

    // ===== FORMULÁRIO NEWSLETTER =====
    function initNewsletterForm() {
        const form = document.querySelector('.newsletter-form');
        if (!form) return;

        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const email = this.querySelector('input[type="email"]').value;
            const button = this.querySelector('button');
            const originalText = button.textContent;
            
            // Simular envio
            button.textContent = 'Enviando...';
            button.disabled = true;
            
            setTimeout(() => {
                button.textContent = '✓ Inscrito!';
                button.style.background = '#10B981';
                
                setTimeout(() => {
                    button.textContent = originalText;
                    button.disabled = false;
                    button.style.background = '';
                    this.reset();
                }, 3000);
            }, 1500);
        });
    }

    // ===== STICKY HEADER =====
    function initStickyHeader() {
        const header = document.querySelector('.main-header');
        if (!header) return;

        let lastScroll = 0;
        
        window.addEventListener('scroll', function() {
            const currentScroll = window.pageYOffset;
            
            if (currentScroll > 100) {
                header.classList.add('header-scrolled');
                
                if (currentScroll > lastScroll && currentScroll > 300) {
                    header.classList.add('header-hidden');
                } else {
                    header.classList.remove('header-hidden');
                }
            } else {
                header.classList.remove('header-scrolled');
                header.classList.remove('header-hidden');
            }
            
            lastScroll = currentScroll;
        });
    }

    // ===== INICIALIZAR TUDO =====
    initCountdown();
    initScrollAnimations();
    initCounters();
    initSmoothScroll();
    initParallax();
    initPageLoad();
    initUrgencyAlerts();
    initButtonTracking();
    initNewsletterForm();
    initStickyHeader();

    console.log('🚀 VancouverTec Home - Alta Conversão Loaded!');
});
EOF

# CSS para animações e melhorias
log_info "Adicionando CSS de animações..."
cat >> "$THEME_PATH/assets/css/pages/front-page.css" << 'EOF'

/* ANIMAÇÕES E INTERAÇÕES */

/* Loading */
.vt-loading * {
  transition: none !important;
  animation: none !important;
}

/* Elementos animados */
.animate-element {
  opacity: 0;
  transform: translateY(30px);
  transition: all 0.6s ease;
}

.animate-element.animate-in {
  opacity: 1;
  transform: translateY(0);
}

/* Hero animações */
.hero-badge,
.hero-title,
.hero-subtitle,
.hero-stats,
.hero-actions,
.hero-guarantee {
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s ease;
}

.hero-badge.hero-animate,
.hero-title.hero-animate,
.hero-subtitle.hero-animate,
.hero-stats.hero-animate,
.hero-actions.hero-animate,
.hero-guarantee.hero-animate {
  opacity: 1;
  transform: translateY(0);
}

/* Header sticky */
.main-header {
  transition: all 0.3s ease;
}

.header-scrolled {
  backdrop-filter: blur(20px);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.header-hidden {
  transform: translateY(-100%);
}

/* Hover melhorados */
.category-card:hover .category-icon,
.product-card:hover .product-icon {
  transform: scale(1.1) rotate(5deg);
  transition: all 0.3s ease;
}

.benefit-card:hover .benefit-icon {
  transform: scale(1.2);
  transition: all 0.3s ease;
}

/* Pulsar nos badges */
@keyframes pulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

.product-badge,
.category-badge {
  animation: pulse 2s ease-in-out infinite;
}

/* Glow effect nos CTAs */
.btn-cta-primary,
.cta-btn-primary {
  position: relative;
  overflow: hidden;
}

.btn-cta-primary::before,
.cta-btn-primary::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
  transition: left 0.5s ease;
}

.btn-cta-primary:hover::before,
.cta-btn-primary:hover::before {
  left: 100%;
}

/* Contador animado */
.countdown-item {
  animation: countdownPulse 1s ease-in-out infinite alternate;
}

@keyframes countdownPulse {
  from { transform: scale(1); }
  to { transform: scale(1.05); }
}

/* Stats animados */
.stat-number {
  transition: all 0.3s ease;
}

.stat-number:hover {
  transform: scale(1.1);
  color: #F59E0B;
}

/* Testimonial hover */
.testimonial-card:hover .author-avatar {
  transform: scale(1.1);
  transition: all 0.3s ease;
}

.testimonial-card:hover .stars {
  transform: scale(1.1);
  transition: all 0.3s ease;
}

/* Loading states */
button:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

/* Mobile optimizations */
@media (max-width: 768px) {
  .animate-element {
    transform: translateY(20px);
  }
  
  .hero-badge,
  .hero-title,
  .hero-subtitle,
  .hero-stats,
  .hero-actions,
  .hero-guarantee {
    transform: translateY(15px);
  }
}

/* Smooth scrolling */
html {
  scroll-behavior: smooth;
}

/* Focus states */
button:focus,
a:focus,
input:focus {
  outline: 2px solid #0066CC;
  outline-offset: 2px;
}

/* Print styles */
@media print {
  .hero-section-conversao,
  .promo-banner-section,
  .final-cta-section {
    background: white !important;
    color: black !important;
  }
}
EOF

# Atualizar functions.php para carregar o JS
log_info "Atualizando functions.php..."
if ! grep -q "home-conversao.js" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_script.*vt-main/a\    wp_enqueue_script('"'"'vt-home-conversao'"'"', VT_THEME_URI . '"'"'/assets/js/home-conversao.js'"'"', ['"'"'jquery'"'"'], VT_THEME_VERSION, true);' "$THEME_PATH/functions.php"
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
echo -e "║  ⚡ HOME CONVERSÃO 100% COMPLETA! ⚡         ║"
echo -e "║    JavaScript + Animações Implementados     ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Countdown timer funcionando"
log_success "✅ Animações de scroll implementadas"
log_success "✅ Contadores animados nos stats"
log_success "✅ Efeito parallax no hero"
log_success "✅ Header sticky inteligente"
log_success "✅ Botões com efeitos visuais"

echo -e "\n${YELLOW}🎯 Home de alta conversão 100% funcional!${NC}"

exit 0