<?php
/**
 * Template Name: Wishlist VancouverTec
 * Página de Lista de Desejos
 */

get_header(); ?>

<div class="vt-wishlist-page">
    <div class="container">
        <div class="page-header">
            <h1 class="page-title">Lista de Desejos</h1>
            <p class="page-subtitle">Seus produtos favoritos salvos para depois</p>
        </div>
        
        <div id="vt-wishlist-content">
            <div class="vt-wishlist-empty">
                <h3>Sua lista de desejos está vazia!</h3>
                <p>Navegue pela nossa loja e adicione produtos aos seus favoritos.</p>
                <a href="<?php echo class_exists('WooCommerce') ? get_permalink(wc_get_page_id('shop')) : '/shop'; ?>" class="button">
                    Explorar Produtos
                </a>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    loadWishlist();
    
    function loadWishlist() {
        const wishlist = JSON.parse(localStorage.getItem('vt_wishlist') || '[]');
        const container = document.getElementById('vt-wishlist-content');
        
        if (wishlist.length === 0) {
            return;
        }
        
        let html = '<div class="products" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 2rem;">';
        
        wishlist.forEach(product => {
            html += `
                <div class="product" style="background: white; border-radius: 15px; padding: 1.5rem; box-shadow: 0 4px 20px rgba(0,0,0,0.1);">
                    <h3><a href="${product.url}" style="color: #1F2937; text-decoration: none;">${product.name}</a></h3>
                    <div style="font-size: 1.25rem; font-weight: 800; color: #0066CC; margin: 1rem 0;">${product.price}</div>
                    <div style="display: flex; gap: 0.5rem;">
                        <a href="${product.url}" class="button" style="flex: 1; text-align: center;">Ver Produto</a>
                        <button onclick="removeFromWishlist(${product.id})" style="background: #EF4444; color: white; border: none; padding: 0.5rem; border-radius: 8px;">Remover</button>
                    </div>
                </div>
            `;
        });
        
        html += '</div>';
        container.innerHTML = html;
    }
    
    window.removeFromWishlist = function(productId) {
        let wishlist = JSON.parse(localStorage.getItem('vt_wishlist') || '[]');
        wishlist = wishlist.filter(item => item.id !== productId);
        localStorage.setItem('vt_wishlist', JSON.stringify(wishlist));
        loadWishlist();
    }
});
</script>

<?php get_footer(); ?>
