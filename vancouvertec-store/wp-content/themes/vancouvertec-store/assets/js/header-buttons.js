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
