(function($) {
    'use strict';
    
    $(document).ready(function() {
        console.log('VancouverTec Store - Tema carregado com sucesso!');
        
        // Performance: Lazy loading
        $('img').attr('loading', 'lazy');
        
        // Smooth scroll
        $('a[href^="#"]').on('click', function(e) {
            e.preventDefault();
            const target = $(this.getAttribute('href'));
            if (target.length) {
                $('html, body').animate({
                    scrollTop: target.offset().top - 80
                }, 800);
            }
        });
    });
    
})(jQuery);
