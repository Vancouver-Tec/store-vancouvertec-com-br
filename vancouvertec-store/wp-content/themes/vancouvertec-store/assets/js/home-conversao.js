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
