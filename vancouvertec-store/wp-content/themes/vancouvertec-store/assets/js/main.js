/**
 * VancouverTec Store - Main JavaScript
 * WooCommerce + Performance Optimization
 */

(function($) {
    'use strict';
    
    const VTWooCommerce = {
        init() {
            console.log('VancouverTec WooCommerce initialized');
            this.setupAjaxCart();
            this.setupProductGallery();
            this.setupPerformance();
            this.setupAccessibility();
        },
        
        setupAjaxCart() {
            // AJAX add to cart
            $('body').on('added_to_cart', function(event, fragments, cart_hash, $button) {
                console.log('Product added to cart');
                $button.removeClass('loading');
                
                // Show success message
                const message = $('<div class="vt-cart-success">Produto adicionado ao carrinho!</div>');
                $button.after(message);
                setTimeout(() => message.fadeOut(), 3000);
            });
            
            // Loading state
            $(document).on('click', '.ajax_add_to_cart', function() {
                $(this).addClass('loading');
            });
        },
        
        setupProductGallery() {
            // Lazy loading para imagens
            if ('IntersectionObserver' in window) {
                const imageObserver = new IntersectionObserver((entries, observer) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            const img = entry.target;
                            img.src = img.dataset.src;
                            img.classList.remove('lazy');
                            img.classList.add('loaded');
                            imageObserver.unobserve(img);
                        }
                    });
                });
                
                document.querySelectorAll('img[data-src]').forEach(img => {
                    imageObserver.observe(img);
                });
            }
        },
        
        setupPerformance() {
            // Preload critical resources
            const preloadCSS = (href) => {
                const link = document.createElement('link');
                link.rel = 'preload';
                link.href = href;
                link.as = 'style';
                link.onload = function() {
                    this.onload = null;
                    this.rel = 'stylesheet';
                };
                document.head.appendChild(link);
            };
            
            // Performance monitoring
            if ('performance' in window) {
                window.addEventListener('load', () => {
                    const perfData = performance.timing;
                    const loadTime = perfData.loadEventEnd - perfData.navigationStart;
                    console.log('VT WooCommerce Page Load Time:', loadTime + 'ms');
                });
            }
        },
        
        setupAccessibility() {
            // Adicionar ARIA labels para botões
            $('.ajax_add_to_cart').attr('aria-label', 'Adicionar produto ao carrinho');
            
            // Focus management
            $(document).on('wc_fragments_refreshed', function() {
                $('.cart-contents').attr('aria-live', 'polite');
            });
        }
    };
    
    // Initialize when DOM is ready
    $(document).ready(() => VTWooCommerce.init());
    
    // Initialize when WooCommerce is ready
    $(document.body).on('wc_fragments_refreshed wc_fragments_loaded', () => {
        VTWooCommerce.setupAjaxCart();
    });
    
})(jQuery);
