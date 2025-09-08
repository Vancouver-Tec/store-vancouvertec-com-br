#!/bin/bash

# ===========================================
# VancouverTec Store - JavaScript Interativo PARTE 2
# Script: 08b-javascript-interativo.sh
# Versão: 1.0.0 - JavaScript + AJAX para os botões
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
║    ⚡ JAVASCRIPT INTERATIVO - PARTE 2 ⚡     ║
║       AJAX + Contadores + Funcionalidades    ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

cd "$PROJECT_PATH"
log_info "Adicionando JavaScript em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Criar JavaScript para os botões
log_info "Criando JavaScript para botões interativos..."
cat > "$THEME_PATH/assets/js/header-buttons.js" << 'EOF'
/**
 * VancouverTec Store - Header Buttons Interactive
 * Funcionalidades: Carrinho, Wishlist, User Menu, Busca
 */

document.addEventListener('DOMContentLoaded', function() {
    
    // ===== CONTADOR DO CARRINHO (AJAX) =====
    function updateCartCount() {
        if (typeof vt_ajax !== 'undefined') {
            fetch(vt_ajax.ajax_url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({
                    action: 'vt_get_cart_count',
                    nonce: vt_ajax.nonce
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Atualizar todos os contadores do carrinho
                    const cartCounts = document.querySelectorAll('.cart-count, .mobile-count');
                    cartCounts.forEach(count => {
                        if (count.closest('.cart-link') || count.closest('[href*="cart"]')) {
                            count.textContent = data.data;
                            
                            // Animação quando muda
                            count.style.transform = 'scale(1.2)';
                            setTimeout(() => {
                                count.style.transform = 'scale(1)';
                            }, 200);
                        }
                    });
                    
                    // Adicionar classe se tem itens
                    const cartLinks = document.querySelectorAll('.cart-link, [href*="cart"]');
                    cartLinks.forEach(link => {
                        if (data.data > 0) {
                            link.classList.add('has-items');
                        } else {
                            link.classList.remove('has-items');
                        }
                    });
                }
            })
            .catch(error => console.log('Erro ao atualizar carrinho:', error));
        }
    }

    // ===== WISHLIST (LOCAL STORAGE) =====
    function updateWishlistCount() {
        const wishlist = JSON.parse(localStorage.getItem('vt_wishlist') || '[]');
        const count = wishlist.length;
        
        // Atualizar contadores
        const wishlistCounts = document.querySelectorAll('.wishlist-count, .mobile-count');
        wishlistCounts.forEach(counter => {
            if (counter.closest('.wishlist-link') || counter.closest('[href*="wishlist"]')) {
                counter.textContent = count;
                
                // Animação
                counter.style.transform = 'scale(1.2)';
                setTimeout(() => {
                    counter.style.transform = 'scale(1)';
                }, 200);
            }
        });
        
        // Adicionar classe se tem itens
        const wishlistLinks = document.querySelectorAll('.wishlist-link, [href*="wishlist"]');
        wishlistLinks.forEach(link => {
            if (count > 0) {
                link.classList.add('has-items');
            } else {
                link.classList.remove('has-items');
            }
        });
    }

    // ===== BUSCA MODAL =====
    function initSearch() {
        const searchToggle = document.querySelector('.search-toggle');
        if (!searchToggle) return;

        searchToggle.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Criar modal de busca
            const modal = document.createElement('div');
            modal.className = 'search-modal';
            modal.innerHTML = `
                <div class="search-modal-content">
                    <div class="search-modal-header">
                        <h3>🔍 Buscar Produtos</h3>
                        <button class="search-modal-close">&times;</button>
                    </div>
                    <div class="search-modal-body">
                        <input type="text" class="search-modal-input" placeholder="Digite o que você procura..." autofocus>
                        <div class="search-suggestions">
                            <div class="suggestion-item">💻 Sites WordPress</div>
                            <div class="suggestion-item">🛒 Lojas Virtuais</div>
                            <div class="suggestion-item">📱 Aplicativos Mobile</div>
                            <div class="suggestion-item">⚙️ Sistemas Web</div>
                        </div>
                    </div>
                </div>
            `;
            
            document.body.appendChild(modal);
            
            // Event listeners do modal
            const closeBtn = modal.querySelector('.search-modal-close');
            const searchInput = modal.querySelector('.search-modal-input');
            const suggestions = modal.querySelectorAll('.suggestion-item');
            
            closeBtn.addEventListener('click', () => {
                document.body.removeChild(modal);
            });
            
            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    document.body.removeChild(modal);
                }
            });
            
            searchInput.addEventListener('keypress', (e) => {
                if (e.key === 'Enter' && searchInput.value.trim()) {
                    window.location.href = '/?s=' + encodeURIComponent(searchInput.value);
                }
            });
            
            suggestions.forEach(item => {
                item.addEventListener('click', () => {
                    const term = item.textContent.split(' ').slice(1).join(' ');
                    window.location.href = '/?s=' + encodeURIComponent(term);
                });
            });
        });
    }

    // ===== USER DROPDOWN =====
    function initUserDropdown() {
        const userToggle = document.querySelector('.user-toggle');
        const userDropdown = document.querySelector('.user-dropdown');
        
        if (!userToggle || !userDropdown) return;

        userToggle.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            
            userDropdown.classList.toggle('show');
            
            // Rotacionar seta
            const arrow = userToggle.querySelector('.dropdown-arrow');
            if (arrow) {
                arrow.style.transform = userDropdown.classList.contains('show') 
                    ? 'rotate(180deg)' 
                    : 'rotate(0deg)';
            }
        });

        // Fechar ao clicar fora
        document.addEventListener('click', function(e) {
            if (!userToggle.contains(e.target) && !userDropdown.contains(e.target)) {
                userDropdown.classList.remove('show');
                const arrow = userToggle.querySelector('.dropdown-arrow');
                if (arrow) arrow.style.transform = 'rotate(0deg)';
            }
        });
    }

    // ===== ADICIONAR AO CARRINHO (Interceptar) =====
    function interceptAddToCart() {
        // Interceptar adições ao carrinho para atualizar contador
        document.addEventListener('click', function(e) {
            if (e.target.matches('.add_to_cart_button') || 
                e.target.closest('.add_to_cart_button')) {
                
                setTimeout(() => {
                    updateCartCount();
                }, 1000); // Delay para WooCommerce processar
            }
        });
    }

    // ===== WISHLIST - Adicionar/Remover =====
    function initWishlistActions() {
        document.addEventListener('click', function(e) {
            if (e.target.matches('.add-to-wishlist') || 
                e.target.closest('.add-to-wishlist')) {
                
                e.preventDefault();
                const button = e.target.closest('.add-to-wishlist');
                const productId = button.dataset.productId;
                
                if (!productId) return;
                
                let wishlist = JSON.parse(localStorage.getItem('vt_wishlist') || '[]');
                
                if (wishlist.includes(productId)) {
                    // Remover da wishlist
                    wishlist = wishlist.filter(id => id !== productId);
                    button.classList.remove('in-wishlist');
                    button.innerHTML = '🤍 Adicionar aos Favoritos';
                } else {
                    // Adicionar à wishlist
                    wishlist.push(productId);
                    button.classList.add('in-wishlist');
                    button.innerHTML = '❤️ Nos Favoritos';
                }
                
                localStorage.setItem('vt_wishlist', JSON.stringify(wishlist));
                updateWishlistCount();
            }
        });
    }

    // ===== TOOLTIPS =====
    function initTooltips() {
        const tooltipElements = document.querySelectorAll('[title]');
        
        tooltipElements.forEach(element => {
            element.addEventListener('mouseenter', function() {
                const tooltip = document.createElement('div');
                tooltip.className = 'vt-tooltip';
                tooltip.textContent = this.getAttribute('title');
                
                document.body.appendChild(tooltip);
                
                // Posicionar tooltip
                const rect = this.getBoundingClientRect();
                tooltip.style.left = (rect.left + rect.width / 2) + 'px';
                tooltip.style.top = (rect.bottom + 10) + 'px';
                
                this.removeAttribute('title');
                this._originalTitle = tooltip.textContent;
            });
            
            element.addEventListener('mouseleave', function() {
                const tooltip = document.querySelector('.vt-tooltip');
                if (tooltip) {
                    tooltip.remove();
                }
                if (this._originalTitle) {
                    this.setAttribute('title', this._originalTitle);
                }
            });
        });
    }

    // ===== INICIALIZAR TUDO =====
    updateCartCount();
    updateWishlistCount();
    initSearch();
    initUserDropdown();
    interceptAddToCart();
    initWishlistActions();
    initTooltips();

    // ===== ATUALIZAR PERIODICAMENTE =====
    setInterval(updateCartCount, 30000); // A cada 30 segundos
    setInterval(updateWishlistCount, 5000); // A cada 5 segundos

    // ===== EVENTOS ESPECIAIS =====
    
    // Atualizar quando voltar para a aba
    document.addEventListener('visibilitychange', function() {
        if (!document.hidden) {
            updateCartCount();
            updateWishlistCount();
        }
    });

    // Atualizar quando redimensionar (mobile/desktop)
    window.addEventListener('resize', function() {
        setTimeout(() => {
            updateCartCount();
            updateWishlistCount();
        }, 500);
    });

    console.log('🚀 VancouverTec Store - Header Buttons initialized!');
});
EOF

# Adicionar CSS para modal de busca e outros elementos
log_info "Adicionando CSS para elementos interativos..."
cat >> "$THEME_PATH/assets/css/layouts/header.css" << 'EOF'

/* ===== ELEMENTOS INTERATIVOS ===== */

/* Estados dos botões */
.cart-link.has-items,
.wishlist-link.has-items {
  background: #FEF3C7;
  border-color: #F59E0B;
  color: #92400E;
}

.cart-link.has-items:hover {
  background: #10B981;
  color: white;
}

.wishlist-link.has-items:hover {
  background: #EF4444;
  color: white;
}

/* Modal de busca */
.search-modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.7);
  z-index: 9999;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem;
}

.search-modal-content {
  background: white;
  border-radius: 12px;
  max-width: 500px;
  width: 100%;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
}

.search-modal-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 1.5rem;
  border-bottom: 1px solid #E5E7EB;
}

.search-modal-header h3 {
  margin: 0;
  color: #374151;
}

.search-modal-close {
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
  color: #6B7280;
  padding: 0.5rem;
  border-radius: 6px;
  transition: all 0.3s ease;
}

.search-modal-close:hover {
  background: #F3F4F6;
  color: #374151;
}

.search-modal-body {
  padding: 1.5rem;
}

.search-modal-input {
  width: 100%;
  padding: 1rem;
  border: 2px solid #E5E7EB;
  border-radius: 8px;
  font-size: 1rem;
  transition: all 0.3s ease;
  margin-bottom: 1rem;
}

.search-modal-input:focus {
  outline: none;
  border-color: var(--vt-blue-600, #0066CC);
  box-shadow: 0 0 0 3px rgba(0, 102, 204, 0.1);
}

.search-suggestions {
  display: grid;
  gap: 0.5rem;
}

.suggestion-item {
  padding: 0.75rem 1rem;
  background: #F9FAFB;
  border: 1px solid #E5E7EB;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  color: #374151;
}

.suggestion-item:hover {
  background: var(--vt-blue-600, #0066CC);
  color: white;
  border-color: var(--vt-blue-600, #0066CC);
}

/* User dropdown melhorado */
.user-dropdown.show {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
}

/* Tooltips */
.vt-tooltip {
  position: absolute;
  background: #374151;
  color: white;
  padding: 0.5rem 0.75rem;
  border-radius: 6px;
  font-size: 0.75rem;
  z-index: 10000;
  transform: translateX(-50%);
  white-space: nowrap;
  pointer-events: none;
}

.vt-tooltip::before {
  content: '';
  position: absolute;
  top: -4px;
  left: 50%;
  transform: translateX(-50%);
  border-left: 4px solid transparent;
  border-right: 4px solid transparent;
  border-bottom: 4px solid #374151;
}

/* Animações */
@keyframes pulse {
  0%, 100% { transform: scale(1); }
  50% { transform: scale(1.05); }
}

.cart-count, .wishlist-count {
  transition: transform 0.2s ease;
}

.cart-count:hover, .wishlist-count:hover {
  animation: pulse 0.5s ease-in-out;
}

/* Responsivo para modal */
@media (max-width: 768px) {
  .search-modal {
    padding: 1rem;
  }
  
  .search-modal-content {
    max-width: 100%;
  }
}
EOF

# Adicionar funções AJAX no functions.php
log_info "Adicionando funções AJAX no functions.php..."
if ! grep -q "vt_get_cart_count" "$THEME_PATH/functions.php"; then
    cat >> "$THEME_PATH/functions.php" << 'EOF'

// ===== AJAX FUNCTIONS =====

// Contador do carrinho
function vt_get_cart_count() {
    check_ajax_referer('vt_nonce', 'nonce');
    
    if (class_exists('WooCommerce')) {
        $count = WC()->cart->get_cart_contents_count();
        wp_send_json_success($count);
    } else {
        wp_send_json_success(0);
    }
}
add_action('wp_ajax_vt_get_cart_count', 'vt_get_cart_count');
add_action('wp_ajax_nopriv_vt_get_cart_count', 'vt_get_cart_count');

// Atualizar fragmentos do carrinho
function vt_cart_fragments($fragments) {
    if (class_exists('WooCommerce')) {
        $count = WC()->cart->get_cart_contents_count();
        $fragments['.cart-count'] = '<span class="cart-count">' . $count . '</span>';
        $fragments['.mobile-count'] = '<span class="mobile-count">' . $count . '</span>';
    }
    return $fragments;
}
add_filter('woocommerce_add_to_cart_fragments', 'vt_cart_fragments');

// Enqueue do novo script
function vt_enqueue_header_buttons() {
    wp_enqueue_script(
        'vt-header-buttons', 
        VT_THEME_URI . '/assets/js/header-buttons.js', 
        ['jquery'], 
        VT_THEME_VERSION, 
        true
    );
}
add_action('wp_enqueue_scripts', 'vt_enqueue_header_buttons');
EOF
fi

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
echo -e "║    ✅ JAVASCRIPT INTERATIVO ADICIONADO! ✅   ║"
echo -e "║         Todas as funcionalidades ativas      ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ JavaScript interativo implementado"
log_success "✅ AJAX para contador do carrinho"
log_success "✅ Wishlist com localStorage"
log_success "✅ Modal de busca funcional"
log_success "✅ Dropdown do usuário interativo"
log_success "✅ Tooltips informativos"

echo -e "\n${YELLOW}🎯 FUNCIONALIDADES ATIVAS:${NC}"
echo -e "• 🔍 Busca: Clique no ícone de busca - Modal com sugestões"
echo -e "• 🛒 Carrinho: Contador atualiza automaticamente via AJAX"
echo -e "• ❤️ Wishlist: Armazena favoritos no navegador"
echo -e "• 👤 User Menu: Dropdown inteligente (Admin/Cliente)"
echo -e "• 📱 Mobile: Todos os botões funcionam perfeitamente"

echo -e "\n${BLUE}📋 TESTE COMPLETO:${NC}"
echo -e "• Clique na busca para ver o modal"
echo -e "• Teste o dropdown do usuário"
echo -e "• Verifique contadores em mobile/desktop"
echo -e "• Todos os botões respondem com animações"

log_success "Header 100% funcional e interativo!"

exit 0