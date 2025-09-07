#!/bin/bash

# ===========================================
# VancouverTec Store - Footer Completo
# Script: 06b-footer-completo.sh
# Versão: 1.0.0 - Footer Profissional Final
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
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║          🦶 FOOTER COMPLETO FINAL 🦶          ║
║     Newsletter + Links + Social + Legal      ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Criando footer completo e corrigindo layout..."

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Footer.php COMPLETO E FINAL
log_info "Criando footer.php completo..."
cat > "$THEME_PATH/footer.php" << 'EOF'
</main>

<!-- Newsletter Section -->
<section class="newsletter-section">
    <div class="container">
        <div class="newsletter-content">
            <div class="newsletter-text">
                <h3 class="newsletter-title">Receba Ofertas Exclusivas</h3>
                <p class="newsletter-description">
                    Seja o primeiro a saber sobre lançamentos e promoções especiais
                </p>
            </div>
            
            <form class="newsletter-form" action="#" method="post">
                <div class="newsletter-input-group">
                    <input type="email" placeholder="Seu melhor e-mail" class="newsletter-input" required>
                    <button type="submit" class="newsletter-btn">
                        💎 Quero Receber
                    </button>
                </div>
                <p class="newsletter-privacy">
                    🔐 Sem spam. Cancelar inscrição a qualquer momento.
                </p>
            </form>
        </div>
    </div>
</section>

<!-- Footer Principal -->
<footer class="main-footer">
    <div class="footer-top">
        <div class="container">
            <div class="footer-grid">
                <!-- Coluna 1: Empresa -->
                <div class="footer-column">
                    <div class="footer-brand">
                        <div class="footer-logo">
                            <span class="footer-logo-icon">🚀</span>
                            <span class="footer-logo-text">VancouverTec</span>
                        </div>
                        <p class="footer-description">
                            Transformamos ideias em soluções digitais de sucesso. 
                            Desenvolvemos sistemas, sites, aplicativos e cursos para empresas que querem crescer.
                        </p>
                    </div>
                    
                    <div class="footer-social">
                        <h4>Siga-nos</h4>
                        <div class="social-links">
                            <a href="#" class="social-link linkedin" title="LinkedIn">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
                                </svg>
                            </a>
                            <a href="#" class="social-link instagram" title="Instagram">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/>
                                </svg>
                            </a>
                            <a href="#" class="social-link whatsapp" title="WhatsApp">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.890-5.335 11.893-11.893A11.821 11.821 0 0020.885 3.488"/>
                                </svg>
                            </a>
                            <a href="#" class="social-link youtube" title="YouTube">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/>
                                </svg>
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Coluna 2: Produtos -->
                <div class="footer-column">
                    <h4 class="footer-title">Nossos Produtos</h4>
                    <ul class="footer-links">
                        <li><a href="/sites">🌐 Sites Institucionais</a></li>
                        <li><a href="/lojas">🛒 Lojas Virtuais</a></li>
                        <li><a href="/aplicativos">📱 Aplicativos Mobile</a></li>
                        <li><a href="/sistemas">⚙️ Sistemas Web</a></li>
                        <li><a href="/automacao">🤖 Automação</a></li>
                        <li><a href="/cursos">📚 Cursos Online</a></li>
                    </ul>
                </div>
                
                <!-- Coluna 3: Suporte -->
                <div class="footer-column">
                    <h4 class="footer-title">Suporte</h4>
                    <ul class="footer-links">
                        <li><a href="/ajuda">❓ Central de Ajuda</a></li>
                        <li><a href="/documentacao">📖 Documentação</a></li>
                        <li><a href="/tutoriais">🎥 Tutoriais</a></li>
                        <li><a href="/faq">💬 Perguntas Frequentes</a></li>
                        <li><a href="/contato">📧 Contato</a></li>
                        <li><a href="/whatsapp">📱 WhatsApp</a></li>
                    </ul>
                </div>
                
                <!-- Coluna 4: Contato -->
                <div class="footer-column">
                    <h4 class="footer-title">Fale Conosco</h4>
                    <div class="footer-contact">
                        <div class="contact-item">
                            <span class="contact-icon">📧</span>
                            <span>contato@vancouvertec.com.br</span>
                        </div>
                        <div class="contact-item">
                            <span class="contact-icon">📞</span>
                            <span>+55 (11) 99999-9999</span>
                        </div>
                        <div class="contact-item">
                            <span class="contact-icon">📍</span>
                            <span>São Paulo, SP - Brasil</span>
                        </div>
                    </div>
                    
                    <div class="footer-certifications">
                        <h5>Certificações</h5>
                        <div class="cert-badges">
                            <span class="cert-badge">🔒 SSL Secure</span>
                            <span class="cert-badge">✅ ISO 9001</span>
                            <span class="cert-badge">🏆 Google Partner</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer Bottom -->
    <div class="footer-bottom">
        <div class="container">
            <div class="footer-bottom-content">
                <div class="copyright">
                    <p>
                        © <?php echo date('Y'); ?> 
                        <a href="<?php echo esc_url(home_url('/')); ?>">VancouverTec Store</a>. 
                        Todos os direitos reservados.
                    </p>
                </div>
                
                <nav class="legal-nav">
                    <a href="/privacidade">Privacidade</a>
                    <a href="/termos">Termos de Uso</a>
                    <a href="/cookies">Cookies</a>
                </nav>
                
                <div class="payment-methods">
                    <span class="payment-label">Pagamento:</span>
                    <span class="payment-method">💳 Cartão</span>
                    <span class="payment-method">🏦 PIX</span>
                    <span class="payment-method">📄 Boleto</span>
                </div>
            </div>
        </div>
    </div>
</footer>

<?php wp_footer(); ?>
</body>
</html>
EOF

# CSS do Footer
log_info "Criando CSS do footer..."
cat > "$THEME_PATH/assets/css/layouts/footer.css" << 'EOF'
/* VancouverTec - Footer Styles */

/* Newsletter Section */
.newsletter-section {
  background: linear-gradient(135deg, #0066CC 0%, #6366F1 100%);
  color: white;
  padding: 4rem 0;
}

.newsletter-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 3rem;
  align-items: center;
}

.newsletter-title {
  font-size: 2rem;
  font-weight: 700;
  margin-bottom: 1rem;
}

.newsletter-description {
  font-size: 1.1rem;
  opacity: 0.9;
}

.newsletter-input-group {
  display: flex;
  gap: 1rem;
  margin-bottom: 1rem;
}

.newsletter-input {
  flex: 1;
  padding: 1rem;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 8px;
  background: rgba(255, 255, 255, 0.1);
  color: white;
  font-size: 1rem;
  backdrop-filter: blur(10px);
}

.newsletter-input::placeholder {
  color: rgba(255, 255, 255, 0.7);
}

.newsletter-input:focus {
  outline: none;
  border-color: white;
  background: rgba(255, 255, 255, 0.2);
}

.newsletter-btn {
  padding: 1rem 2rem;
  background: white;
  color: #0066CC;
  border: none;
  border-radius: 8px;
  font-weight: 700;
  cursor: pointer;
  transition: all 0.3s ease;
  white-space: nowrap;
}

.newsletter-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(255, 255, 255, 0.3);
}

.newsletter-privacy {
  color: rgba(255, 255, 255, 0.8);
  font-size: 0.875rem;
  margin: 0;
}

/* Main Footer */
.main-footer {
  background: #1F2937;
  color: #D1D5DB;
}

.footer-top {
  padding: 4rem 0 2rem;
}

.footer-grid {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1.2fr;
  gap: 3rem;
}

.footer-brand {
  margin-bottom: 2rem;
}

.footer-logo {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-bottom: 1rem;
}

.footer-logo-icon {
  font-size: 1.5rem;
}

.footer-logo-text {
  font-size: 1.5rem;
  font-weight: 800;
  color: white;
}

.footer-description {
  line-height: 1.6;
  color: #9CA3AF;
}

.footer-title {
  color: white;
  font-weight: 700;
  margin-bottom: 1.5rem;
  font-size: 1.125rem;
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-links li {
  margin-bottom: 0.75rem;
}

.footer-links a {
  color: #9CA3AF;
  text-decoration: none;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.footer-links a:hover {
  color: white;
  padding-left: 0.5rem;
}

/* Social Links */
.footer-social h4 {
  color: white;
  font-weight: 600;
  margin-bottom: 1rem;
  font-size: 1rem;
}

.social-links {
  display: flex;
  gap: 1rem;
}

.social-link {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  background: #374151;
  color: #9CA3AF;
  border-radius: 8px;
  transition: all 0.3s ease;
  text-decoration: none;
}

.social-link:hover {
  transform: translateY(-2px);
  color: white;
}

.social-link.linkedin:hover { background: #0A66C2; }
.social-link.instagram:hover { background: #E4405F; }
.social-link.whatsapp:hover { background: #25D366; }
.social-link.youtube:hover { background: #FF0000; }

/* Contact Info */
.footer-contact {
  margin-bottom: 2rem;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-bottom: 1rem;
  color: #9CA3AF;
}

.contact-icon {
  font-size: 1.25rem;
}

/* Certifications */
.footer-certifications h5 {
  color: white;
  font-weight: 600;
  margin-bottom: 1rem;
  font-size: 0.875rem;
}

.cert-badges {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.cert-badge {
  display: inline-block;
  background: #374151;
  color: #D1D5DB;
  padding: 0.25rem 0.75rem;
  border-radius: 4px;
  font-size: 0.75rem;
  font-weight: 600;
}

/* Footer Bottom */
.footer-bottom {
  border-top: 1px solid #374151;
  padding: 2rem 0;
}

.footer-bottom-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 1rem;
}

.copyright p {
  margin: 0;
  color: #6B7280;
}

.copyright a {
  color: #0066CC;
  text-decoration: none;
}

.legal-nav {
  display: flex;
  gap: 2rem;
}

.legal-nav a {
  color: #6B7280;
  text-decoration: none;
  font-size: 0.875rem;
  transition: color 0.3s ease;
}

.legal-nav a:hover {
  color: white;
}

.payment-methods {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.payment-label {
  color: #6B7280;
  font-size: 0.875rem;
}

.payment-method {
  background: #374151;
  color: #D1D5DB;
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  font-size: 0.75rem;
  font-weight: 600;
}

/* Responsive */
@media (max-width: 1024px) {
  .footer-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 2rem;
  }
}

@media (max-width: 768px) {
  .newsletter-content {
    grid-template-columns: 1fr;
    gap: 2rem;
    text-align: center;
  }
  
  .newsletter-input-group {
    flex-direction: column;
  }
  
  .footer-grid {
    grid-template-columns: 1fr;
    gap: 2rem;
  }
  
  .footer-bottom-content {
    flex-direction: column;
    text-align: center;
  }
  
  .legal-nav {
    flex-wrap: wrap;
    justify-content: center;
  }
  
  .payment-methods {
    flex-wrap: wrap;
    justify-content: center;
  }
}
EOF

# Atualizar functions.php
log_info "Atualizando functions.php..."
if ! grep -q "footer.css" "$THEME_PATH/functions.php"; then
    sed -i '/wp_enqueue_style.*vt-header/a\    wp_enqueue_style('"'"'vt-footer'"'"', VT_THEME_URI . '"'"'/assets/css/layouts/footer.css'"'"', ['"'"'vt-header'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"
fi

# Corrigir front-page.php (remover footer duplicado)
log_info "Corrigindo front-page.php..."
# Remove tudo após a última seção CTA até o final do arquivo
sed -i '/^<section class="cta-section">/,/^<\/section>$/!b; /^<\/section>$/q' "$THEME_PATH/front-page.php"
# Adiciona apenas a chamada do footer
echo "" >> "$THEME_PATH/front-page.php"
echo "<?php get_footer(); ?>" >> "$THEME_PATH/front-page.php"

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
echo -e "║          ✅ FOOTER COMPLETO CRIADO! ✅        ║"
echo -e "║        Layout corrigido e organizado         ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Footer completo com newsletter"
log_success "✅ 4 colunas organizadas + social links"
log_success "✅ Seção legal + métodos de pagamento"
log_success "✅ Layout corrigido - footer sempre no final"
log_success "✅ CSS responsivo completo"

echo -e "\n${YELLOW}🎯 TESTE AGORA:${NC}"
echo -e "• Frontend: http://localhost:8080"
echo -e "• Footer agora está no final correto"
echo -e "• Newsletter azul + footer escuro"

echo -e "\n${PURPLE}📋 PRÓXIMO PASSO:${NC}"
log_warning "Digite 'continuar' para criar seções específicas:"
log_info "07a - Seção produtos destaque"
log_info "07b - Seção depoimentos"
log_info "07c - Seção por que escolher"

exit 0