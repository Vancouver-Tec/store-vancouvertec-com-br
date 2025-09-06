</main>

<footer id="colophon" class="site-footer">
    <div class="container">
        <div class="footer-content">
            <div class="footer-info">
                <p>&copy; <?php echo date('Y'); ?> <?php bloginfo('name'); ?>. 
                <?php _e('Soluções Digitais para o seu Negócio', 'vancouvertec'); ?></p>
            </div>
            
            <nav class="footer-navigation">
                <?php 
                wp_nav_menu([
                    'theme_location' => 'footer',
                    'fallback_cb' => false
                ]); 
                ?>
            </nav>
        </div>
    </div>
</footer>

<?php wp_footer(); ?>
</body>
</html>
