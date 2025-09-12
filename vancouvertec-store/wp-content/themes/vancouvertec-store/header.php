<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#0066CC">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <?php wp_head(); ?>
</head>

<body <?php body_class('vt-body'); ?>>
<?php wp_body_open(); ?>

<!-- Header VancouverTec -->
<header class="vt-header" role="banner">
    <div class="vt-header-top">
        <div class="container">
            <div class="vt-header-top-content">
                <div class="vt-header-info">
                    <span>📞 (11) 9 9999-9999</span>
                    <span>✉️ contato@vancouvertec.com.br</span>
                </div>
                <div class="vt-header-links">
                    <?php if (is_user_logged_in()): ?>
                        <a href="<?php echo esc_url(wc_get_account_endpoint_url('dashboard')); ?>">👤 Minha Conta</a>
                        <a href="<?php echo wp_logout_url(home_url()); ?>">🚪 Sair</a>
                    <?php else: ?>
                        <a href="<?php echo esc_url(wc_get_page_permalink('myaccount')); ?>">👤 Login</a>
                        <a href="<?php echo esc_url(wc_get_page_permalink('myaccount')); ?>">📝 Cadastro</a>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>
    
    <div class="vt-header-main">
        <div class="container">
            <div class="vt-header-content">
                
                <!-- Logo -->
                <div class="vt-brand">
                    <a href="<?php echo esc_url(home_url('/')); ?>" class="vt-logo">
                        🚀 <span class="vt-logo-text">VancouverTec</span>
                        <span class="vt-logo-sub">Store</span>
                    </a>
                </div>
                
                <!-- Navigation -->
                <nav class="vt-nav vt-desktop-nav" role="navigation">
                    <ul class="vt-nav-list">
                        <li><a href="<?php echo esc_url(home_url('/')); ?>">🏠 Início</a></li>
                        <?php if (class_exists('WooCommerce')): ?>
                        <li class="vt-dropdown">
                            <a href="<?php echo esc_url(wc_get_page_permalink('shop')); ?>">🛍️ Produtos</a>
                            <ul class="vt-dropdown-menu">
                                <li><a href="#">💻 Sites WordPress</a></li>
                                <li><a href="#">🏪 Lojas Virtuais</a></li>
                                <li><a href="#">📱 Apps Mobile</a></li>
                                <li><a href="#">🌐 Sistemas Web</a></li>
                                <li><a href="#">📚 Cursos Online</a></li>
                            </ul>
                        </li>
                        <?php endif; ?>
                        <li><a href="#">💡 Soluções</a></li>
                        <li><a href="#">📞 Contato</a></li>
                    </ul>
                </nav>
                
                <!-- Header Actions -->
                <div class="vt-header-actions">
                    
                    <!-- Search -->
                    <div class="vt-search">
                        <form role="search" method="get" action="<?php echo esc_url(home_url('/')); ?>">
                            <input type="search" placeholder="🔍 Buscar produtos..." value="<?php echo get_search_query(); ?>" name="s" />
                            <button type="submit">🔍</button>
                        </form>
                    </div>
                    
                    <!-- Wishlist -->
                    <a href="#" class="vt-wishlist" title="Lista de Desejos">
                        ❤️ <span class="vt-wishlist-count">0</span>
                    </a>
                    
                    <!-- Cart -->
                    <?php if (class_exists('WooCommerce')): ?>
                    <a href="<?php echo esc_url(wc_get_cart_url()); ?>" class="vt-cart-trigger">
                        🛒 <span class="vt-cart-count"><?php echo WC()->cart->get_cart_contents_count(); ?></span>
                        <span class="vt-cart-total"><?php echo WC()->cart->get_cart_subtotal(); ?></span>
                    </a>
                    <?php endif; ?>
                    
                    <!-- Mobile Toggle -->
                    <button class="vt-mobile-toggle" aria-label="Menu Mobile">
                        ☰
                    </button>
                </div>
                
            </div>
        </div>
    </div>
</header>

<!-- Promo Banner -->
<div class="vt-promo-banner">
    <div class="container">
        <div class="vt-promo-content">
            <span class="vt-promo-icon">🔥</span>
            <span class="vt-promo-text">
                <strong>OFERTA LIMITADA:</strong> 50% OFF em todos os produtos digitais!
            </span>
            <a href="<?php echo esc_url(wc_get_page_permalink('shop')); ?>" class="vt-promo-cta">
                Aproveitar Agora
            </a>
        </div>
    </div>
</div>

<main class="vt-main-content" role="main">
