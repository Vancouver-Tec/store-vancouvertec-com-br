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
