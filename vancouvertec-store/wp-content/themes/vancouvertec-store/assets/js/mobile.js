(function() {
    'use strict';
    
    // Mobile menu toggle
    document.addEventListener('DOMContentLoaded', function() {
        const mobileToggle = document.querySelector('.mobile-menu-toggle');
        const navigation = document.querySelector('.main-navigation');
        
        if (mobileToggle && navigation) {
            mobileToggle.addEventListener('click', function() {
                this.classList.toggle('active');
                navigation.classList.toggle('nav-open');
            });
        }
        
        // Close mobile menu on outside click
        document.addEventListener('click', function(e) {
            if (!e.target.closest('.main-navigation') && !e.target.closest('.mobile-menu-toggle')) {
                if (mobileToggle) mobileToggle.classList.remove('active');
                if (navigation) navigation.classList.remove('nav-open');
            }
        });
        
        // Smooth scrolling for mobile
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
    });
    
})();
