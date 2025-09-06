(function($) {
    'use strict';
    
    const VTStore = {
        init() {
            console.log('VancouverTec Store - Tema carregado!');
            this.setupPerformance();
            this.setupLazyLoading();
        },
        
        setupPerformance() {
            // Lazy loading para imagens
            $('img').attr('loading', 'lazy');
            
            // Preload recursos críticos
            const criticalCSS = document.createElement('link');
            criticalCSS.rel = 'preload';
            criticalCSS.href = vt_ajax.theme_url + '/style.css';
            criticalCSS.as = 'style';
            document.head.appendChild(criticalCSS);
        },
        
        setupLazyLoading() {
            if ('IntersectionObserver' in window) {
                const images = document.querySelectorAll('img[data-src]');
                const imageObserver = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            const img = entry.target;
                            img.src = img.dataset.src;
                            img.removeAttribute('data-src');
                            imageObserver.unobserve(img);
                        }
                    });
                });
                images.forEach(img => imageObserver.observe(img));
            }
        }
    };
    
    $(document).ready(() => VTStore.init());
    
})(jQuery);
