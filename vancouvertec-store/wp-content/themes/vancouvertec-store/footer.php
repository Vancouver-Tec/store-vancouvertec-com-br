</main>

<footer class="vt-footer" role="contentinfo">
    <div class="vt-footer-content">
        <div class="container">
            
            <div class="vt-footer-top">
                
                <div class="vt-footer-section vt-footer-brand">
                    <div class="vt-footer-logo">
                        🚀 <span class="vt-logo-text">VancouverTec</span>
                        <span class="vt-logo-sub">Store</span>
                    </div>
                    <p class="vt-footer-description">
                        Soluções digitais para o seu negócio. Sistemas, sites, aplicativos, automação e cursos para empresas que querem crescer.
                    </p>
                    
                    <div class="vt-social-links">
                        <a href="#" class="vt-social-link" title="Instagram">📷</a>
                        <a href="#" class="vt-social-link" title="LinkedIn">💼</a>
                        <a href="#" class="vt-social-link" title="WhatsApp">💬</a>
                        <a href="#" class="vt-social-link" title="Email">✉️</a>
                    </div>
                </div>
                
                <div class="vt-footer-section">
                    <h4 class="vt-footer-title">Produtos</h4>
                    <ul class="vt-footer-links">
                        <li><a href="#">💻 Sites WordPress</a></li>
                        <li><a href="#">🏪 Lojas Virtuais</a></li>
                        <li><a href="#">📱 Apps Mobile</a></li>
                        <li><a href="#">🌐 Sistemas Web</a></li>
                        <li><a href="#">📚 Cursos Online</a></li>
                    </ul>
                </div>
                
                <div class="vt-footer-section">
                    <h4 class="vt-footer-title">Empresa</h4>
                    <ul class="vt-footer-links">
                        <li><a href="#">🏢 Sobre Nós</a></li>
                        <li><a href="#">💼 Portfólio</a></li>
                        <li><a href="#">📞 Contato</a></li>
                        <li><a href="#">📝 Blog</a></li>
                        <li><a href="#">💼 Trabalhe Conosco</a></li>
                    </ul>
                </div>
                
                <div class="vt-footer-section">
                    <h4 class="vt-footer-title">Suporte</h4>
                    <ul class="vt-footer-contact">
                        <li>📞 (11) 9 9999-9999</li>
                        <li>✉️ suporte@vancouvertec.com.br</li>
                        <li>🕒 Seg-Sex 9h às 18h</li>
                        <li>🎯 Atendimento Premium 24/7</li>
                    </ul>
                    
                    <div class="vt-footer-newsletter">
                        <h5>📧 Newsletter</h5>
                        <form class="vt-newsletter-form">
                            <input type="email" placeholder="Seu email..." />
                            <button type="submit">✈️</button>
                        </form>
                    </div>
                </div>
                
            </div>
            
        </div>
    </div>
    
    <div class="vt-footer-bottom">
        <div class="container">
            <div class="vt-footer-bottom-content">
                
                <div class="vt-footer-copy">
                    <p>&copy; <?php echo date('Y'); ?> VancouverTec Store. Todos os direitos reservados.</p>
                    <div class="vt-footer-legal">
                        <a href="#">📋 Termos de Uso</a>
                        <a href="#">🔒 Política de Privacidade</a>
                        <a href="#">💳 Política de Pagamento</a>
                    </div>
                </div>
                
                <div class="vt-footer-badges">
                    <div class="vt-badge-item">🔒 <span>SSL Seguro</span></div>
                    <div class="vt-badge-item">⚡ <span>Entrega Imediata</span></div>
                    <div class="vt-badge-item">🎯 <span>Suporte 24h</span></div>
                    <div class="vt-badge-item">🚀 <span>Performance 99+</span></div>
                </div>
                
            </div>
        </div>
    </div>
</footer>

<!-- Mobile Menu -->
<div class="vt-mobile-overlay"></div>
<div class="vt-mobile-menu">
    <div class="vt-mobile-header">
        <div class="vt-mobile-logo">🚀 VancouverTec Store</div>
        <button class="vt-mobile-close">&times;</button>
    </div>
    
    <nav class="vt-mobile-nav">
        <ul class="vt-mobile-nav-list">
            <li><a href="<?php echo esc_url(home_url('/')); ?>">🏠 Início</a></li>
            <li><a href="<?php echo esc_url(wc_get_page_permalink('shop')); ?>">🛍️ Produtos</a></li>
            <li><a href="#">💡 Soluções</a></li>
            <li><a href="#">📞 Contato</a></li>
            <li><a href="<?php echo esc_url(wc_get_page_permalink('myaccount')); ?>">👤 Minha Conta</a></li>
            <li><a href="<?php echo esc_url(wc_get_cart_url()); ?>">🛒 Carrinho</a></li>
        </ul>
    </nav>
</div>

<?php wp_footer(); ?>

</body>
</html>
