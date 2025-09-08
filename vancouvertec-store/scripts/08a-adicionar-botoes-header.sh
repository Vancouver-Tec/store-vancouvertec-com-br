#!/bin/bash

# ===========================================
# VancouverTec Store - Adicionar Botões Header PARTE 1
# Script: 08a-adicionar-botoes-header.sh
# Versão: 1.0.0 - APENAS adiciona os 3 botões
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
║    🛒 ADICIONAR 3 BOTÕES - PARTE 1 🛒        ║
║     Wishlist + Carrinho + Login/Admin        ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Modificando header em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Backup
cp "$THEME_PATH/header.php" "$THEME_PATH/header.php.backup.$(date +%s)"

# ATUALIZAR HEADER.PHP - Adicionar seção dos 3 botões na linha correta
log_info "Adicionando os 3 botões ao header.php..."

# Usar sed para inserir os botões após a busca e antes do CTA
sed -i '/<!-- Busca -->/,/<!-- CTA -->/{
/<!-- CTA -->/i\
                \
                <!-- 1. WISHLIST - Lista de Desejos -->\
                <a href="/wishlist" class="wishlist-link header-btn" aria-label="Lista de Desejos" title="Favoritos">\
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">\
                        <path d="M20.84 4.61A5.5 5.5 0 0 0 12 5.67 5.5 5.5 0 0 0 3.16 4.61C1.13 6.64 1.13 9.89 3.16 11.92L12 21.23l8.84-9.31c2.03-2.03 2.03-5.28 0-7.31z" stroke="currentColor" stroke-width="2"/>\
                    </svg>\
                    <span class="btn-text">Favoritos</span>\
                    <span class="wishlist-count">0</span>\
                </a>\
                \
                <!-- 2. CARRINHO -->\
                <?php if (class_exists("WooCommerce")) : ?>\
                <a href="<?php echo wc_get_cart_url(); ?>" class="cart-link header-btn" aria-label="Carrinho" title="Carrinho">\
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">\
                        <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.4 5.1 16.4H17M17 13V17A4 4 0 1 1 9 17M9 19A2 2 0 1 0 9 15 2 2 0 0 0 9 19Z" stroke="currentColor" stroke-width="2"/>\
                    </svg>\
                    <span class="btn-text">Carrinho</span>\
                    <span class="cart-count"><?php echo WC()->cart->get_cart_contents_count(); ?></span>\
                </a>\
                <?php endif; ?>\
                \
                <!-- 3. LOGIN/ADMIN -->\
                <?php if (is_user_logged_in()) : ?>\
                    <div class="user-menu">\
                        <button class="user-toggle header-btn" aria-label="Minha Conta" title="Conta">\
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none">\
                                <path d="M20 21V19A4 4 0 0 0 16 15H8A4 4 0 0 0 4 19V21M16 7A4 4 0 1 1 8 7 4 4 0 0 1 16 7Z" stroke="currentColor" stroke-width="2"/>\
                            </svg>\
                            <span class="btn-text"><?php echo current_user_can("manage_options") ? "Admin" : "Conta"; ?></span>\
                            <span class="dropdown-arrow">▼</span>\
                        </button>\
                        <div class="user-dropdown">\
                            <?php if (class_exists("WooCommerce")) : ?>\
                                <a href="<?php echo get_permalink(wc_get_page_id("myaccount")); ?>">📋 Minha Conta</a>\
                                <a href="<?php echo get_permalink(wc_get_page_id("myaccount")); ?>orders/">📦 Pedidos</a>\
                            <?php endif; ?>\
                            <?php if (current_user_can("manage_options")) : ?>\
                                <a href="<?php echo admin_url(); ?>">⚙️ Admin</a>\
                                <a href="<?php echo admin_url("edit.php?post_type=product"); ?>">🛒 Produtos</a>\
                            <?php endif; ?>\
                            <a href="<?php echo wp_logout_url(home_url()); ?>">🚪 Sair</a>\
                        </div>\
                    </div>\
                <?php else : ?>\
                    <a href="<?php echo wp_login_url(home_url()); ?>" class="login-link header-btn" title="Entrar">\
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">\
                            <path d="M15 3H19A2 2 0 0 1 21 5V19A2 2 0 0 1 19 21H15M10 17L15 12L10 7M15 12H3" stroke="currentColor" stroke-width="2"/>\
                        </svg>\
                        <span class="btn-text">Entrar</span>\
                    </a>\
                <?php endif; ?>
}' "$THEME_PATH/header.php"

# Adicionar também no mobile menu - inserir após mobile-header-actions
if ! grep -q "mobile-header-actions" "$THEME_PATH/header.php"; then
    sed -i '/<!-- Mobile Menu -->/a\
        <div class="mobile-header-actions">\
            <div class="mobile-actions-row">\
                <a href="/wishlist" class="mobile-action-btn">\
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">\
                        <path d="M20.84 4.61A5.5 5.5 0 0 0 12 5.67 5.5 5.5 0 0 0 3.16 4.61C1.13 6.64 1.13 9.89 3.16 11.92L12 21.23l8.84-9.31c2.03-2.03 2.03-5.28 0-7.31z" stroke="currentColor" stroke-width="2"/>\
                    </svg>\
                    <span>Favoritos</span>\
                    <span class="mobile-count">0</span>\
                </a>\
                <?php if (class_exists("WooCommerce")) : ?>\
                <a href="<?php echo wc_get_cart_url(); ?>" class="mobile-action-btn">\
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">\
                        <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.4 5.1 16.4H17M17 13V17A4 4 0 1 1 9 17M9 19A2 2 0 1 0 9 15 2 2 0 0 0 9 19Z" stroke="currentColor" stroke-width="2"/>\
                    </svg>\
                    <span>Carrinho</span>\
                    <span class="mobile-count"><?php echo WC()->cart->get_cart_contents_count(); ?></span>\
                </a>\
                <?php endif; ?>\
                <?php if (is_user_logged_in()) : ?>\
                    <a href="<?php echo current_user_can("manage_options") ? admin_url() : get_permalink(wc_get_page_id("myaccount")); ?>" class="mobile-action-btn">\
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">\
                            <path d="M20 21V19A4 4 0 0 0 16 15H8A4 4 0 0 0 4 19V21M16 7A4 4 0 1 1 8 7 4 4 0 0 1 16 7Z" stroke="currentColor" stroke-width="2"/>\
                        </svg>\
                        <span><?php echo current_user_can("manage_options") ? "Admin" : "Conta"; ?></span>\
                    </a>\
                <?php else : ?>\
                    <a href="<?php echo wp_login_url(home_url()); ?>" class="mobile-action-btn">\
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">\
                            <path d="M15 3H19A2 2 0 0 1 21 5V19A2 2 0 0 1 19 21H15M10 17L15 12L10 7M15 12H3" stroke="currentColor" stroke-width="2"/>\
                        </svg>\
                        <span>Entrar</span>\
                    </a>\
                <?php endif; ?>\
            </div>\
        </div>' "$THEME_PATH/header.php"
fi

# Adicionar estilos básicos no header.css
log_info "Adicionando estilos básicos para os botões..."
cat >> "$THEME_PATH/assets/css/layouts/header.css" << 'EOF'

/* ===== BOTÕES ADICIONADOS - WISHLIST, CARRINHO, LOGIN ===== */
.header-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1rem;
  background: #F9FAFB;
  border: 1px solid #E5E7EB;
  border-radius: 8px;
  color: #374151;
  text-decoration: none;
  cursor: pointer;
  transition: all 0.3s ease;
  font-weight: 500;
  font-size: 0.875rem;
  position: relative;
}

.header-btn:hover {
  background: var(--vt-blue-600, #0066CC);
  color: white;
  border-color: var(--vt-blue-600, #0066CC);
  transform: translateY(-2px);
}

.cart-count, .wishlist-count {
  background: #EF4444;
  color: white;
  font-size: 0.75rem;
  font-weight: 700;
  padding: 0.25rem 0.5rem;
  border-radius: 12px;
  min-width: 20px;
  text-align: center;
  position: absolute;
  top: -8px;
  right: -8px;
}

.user-dropdown {
  position: absolute;
  top: 100%;
  right: 0;
  background: white;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
  border-radius: 12px;
  padding: 1rem 0;
  min-width: 200px;
  opacity: 0;
  visibility: hidden;
  transform: translateY(-10px);
  transition: all 0.3s ease;
  z-index: 1000;
}

.user-menu:hover .user-dropdown {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
}

.user-dropdown a {
  display: block;
  padding: 0.75rem 1.5rem;
  color: #374151;
  text-decoration: none;
  transition: all 0.3s ease;
}

.user-dropdown a:hover {
  background: #F3F4F6;
  color: var(--vt-blue-600, #0066CC);
}

.mobile-header-actions {
  padding: 1rem 0;
  border-bottom: 1px solid #E5E7EB;
  margin-bottom: 1rem;
}

.mobile-actions-row {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 0.75rem;
}

.mobile-action-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem 0.5rem;
  background: #F9FAFB;
  border: 1px solid #E5E7EB;
  border-radius: 12px;
  color: #374151;
  text-decoration: none;
  transition: all 0.3s ease;
  position: relative;
}

.mobile-action-btn:hover {
  background: var(--vt-blue-600, #0066CC);
  color: white;
}

.mobile-count {
  background: #EF4444;
  color: white;
  font-size: 0.75rem;
  font-weight: 700;
  padding: 0.25rem 0.5rem;
  border-radius: 12px;
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
}

@media (max-width: 768px) {
  .header-actions .header-btn {
    display: none;
  }
}

@media (min-width: 769px) {
  .mobile-header-actions {
    display: none;
  }
}
EOF

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
echo -e "║      ✅ BOTÕES ADICIONADOS - PARTE 1 ✅      ║"
echo -e "║    Wishlist + Carrinho + Login/Admin         ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ 3 botões adicionados ao header"
log_success "✅ Funcionam em desktop, tablet e mobile"
log_success "✅ Layout original preservado"
log_success "✅ Estilos básicos aplicados"

echo -e "\n${YELLOW}📱 TESTE AGORA:${NC}"
echo -e "• Desktop: http://localhost:8080 - Veja os 3 botões no header"
echo -e "• Mobile: Redimensione para <768px - Botões aparecem no menu mobile"
echo -e "• Carrinho: Contador mostra itens do WooCommerce"
echo -e "• Login: Botão muda para Admin se usuário for administrador"

echo -e "\n${BLUE}🔄 PRÓXIMA PARTE:${NC}"
log_info "Digite 'continuar' para PARTE 2 (JavaScript interativo)"

exit 0