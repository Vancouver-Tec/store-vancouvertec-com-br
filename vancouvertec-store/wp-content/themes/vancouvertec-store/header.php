<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
<?php wp_body_open(); ?>

<!-- Announcement Bar -->
<div class="announcement-bar">
    <div class="container">
        <div class="announcement-content">
            <span>🔥 <strong>OFERTA LIMITADA:</strong> 50% OFF em todos os produtos digitais!</span>
            <a href="<?php echo class_exists('WooCommerce') ? get_permalink(wc_get_page_id('shop')) : '#'; ?>" 
               class="announcement-cta">Aproveitar Agora</a>
        </div>
    </div>
</div>

<!-- Header Principal -->
<header class="main-header">
    <div class="container">
        <div class="header-wrapper">
            <!-- Logo -->
            <div class="site-branding">
                <a href="<?php echo esc_url(home_url('/')); ?>" class="logo-link">
                    <span class="logo-icon">🚀</span>
                    <div class="logo-text">
                        <span class="logo-name">VancouverTec</span>
                        <span class="logo-subtitle">Store</span>
                    </div>
                </a>
            </div>
            
            <!-- Navegação Desktop -->
            <nav class="main-navigation">
                <ul class="nav-menu">
                    <li class="menu-item dropdown-item">
                        <a href="#">Soluções <span class="dropdown-arrow">▼</span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/sites">🌐 Sites Institucionais</a></li>
                            <li><a href="/sistemas">⚙️ Sistemas Web</a></li>
                            <li><a href="/lojas">🛒 Lojas Virtuais</a></li>
                            <li><a href="/aplicativos">📱 Aplicativos Mobile</a></li>
                        </ul>
                    </li>
                    <li class="menu-item dropdown-item">
                        <a href="#">Tecnologias <span class="dropdown-arrow">▼</span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/wordpress">WordPress</a></li>
                            <li><a href="/woocommerce">WooCommerce</a></li>
                            <li><a href="/react">React/Node.js</a></li>
                            <li><a href="/automacao">Automação</a></li>
                        </ul>
                    </li>
                    <?php if (class_exists('WooCommerce')) : ?>
                        <li class="menu-item">
                            <a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>">Shop</a>
                        </li>
                    <?php endif; ?>
                    <li class="menu-item"><a href="/sobre">Sobre</a></li>
                    <li class="menu-item"><a href="/contato">Contato</a></li>
                </ul>
            </nav>
            
            <!-- Header Actions -->
            <div class="header-actions">
                <!-- Busca -->
                <button class="search-toggle" aria-label="Buscar">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M21 21L16.514 16.506M19 10.5C19 15.194 15.194 19 10.5 19C5.806 19 2 15.194 2 10.5C2 5.806 5.806 2 10.5 2C15.194 2 19 5.806 19 10.5Z" stroke="currentColor" stroke-width="2"/>
                    </svg>
                </button>
                
                <?php if (class_exists('WooCommerce')) : ?>
                <!-- Wishlist -->
                <a href="#" class="wishlist-link" aria-label="Lista de Desejos">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M20.84 4.61A5.5 5.5 0 0 0 12 5.67 5.5 5.5 0 0 0 3.16 4.61C1.13 6.64 1.13 9.89 3.16 11.92L12 21.23l8.84-9.31c2.03-2.03 2.03-5.28 0-7.31z" stroke="currentColor" stroke-width="2"/>
                    </svg>
                    <span class="wishlist-count">0</span>
                </a>
                
                <!-- Carrinho -->
                <a href="<?php echo wc_get_cart_url(); ?>" class="cart-link" aria-label="Carrinho">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                        <path d="M3 3H5L5.4 5M7 13H17L21 5H5.4M7 13L5.4 5M7 13L4.7 15.3C4.3 15.7 4.6 16.4 5.1 16.4H17M17 13V17A4 4 0 1 1 9 17M9 19A2 2 0 1 0 9 15 2 2 0 0 0 9 19Z" stroke="currentColor" stroke-width="2"/>
                    </svg>
                    <span class="cart-count"><?php echo WC()->cart->get_cart_contents_count(); ?></span>
                </a>
                <?php endif; ?>
                
                <!-- User Account -->
                <?php if (is_user_logged_in()) : ?>
                    <div class="user-menu">
                        <button class="user-toggle" aria-label="Minha Conta">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                                <path d="M20 21V19A4 4 0 0 0 16 15H8A4 4 0 0 0 4 19V21M16 7A4 4 0 1 1 8 7 4 4 0 0 1 16 7Z" stroke="currentColor" stroke-width="2"/>
                            </svg>
                            <span>Conta</span>
                        </button>
                        <div class="user-dropdown">
                            <a href="/minha-conta">📋 Minha Conta</a>
                            <a href="/meus-pedidos">📦 Meus Pedidos</a>
                            <?php if (current_user_can('manage_options')) : ?>
                                <a href="<?php echo admin_url(); ?>">⚙️ Admin</a>
                            <?php endif; ?>
                            <a href="<?php echo wp_logout_url(); ?>">🚪 Sair</a>
                        </div>
                    </div>
                <?php else : ?>
                    <a href="/wp-admin" class="login-link">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                            <path d="M15 3H19A2 2 0 0 1 21 5V19A2 2 0 0 1 19 21H15M10 17L15 12L10 7M15 12H3" stroke="currentColor" stroke-width="2"/>
                        </svg>
                        <span>Entrar</span>
                    </a>
                <?php endif; ?>
                
                <!-- CTA -->
                <a href="/contato" class="btn btn-primary header-cta">Fale Conosco</a>
            </div>
            
            <!-- Mobile Toggle -->
            <button class="mobile-menu-toggle" aria-label="Menu">
                <span></span>
                <span></span>
                <span></span>
            </button>
        </div>
    </div>
    
    <!-- Mobile Menu -->
    <div class="mobile-menu">
        <ul class="mobile-nav">
            <li class="mobile-item">
                <button class="mobile-dropdown-toggle">Soluções <span class="mobile-arrow">+</span></button>
                <ul class="mobile-submenu">
                    <li><a href="/sites">🌐 Sites Institucionais</a></li>
                    <li><a href="/sistemas">⚙️ Sistemas Web</a></li>
                    <li><a href="/lojas">🛒 Lojas Virtuais</a></li>
                    <li><a href="/aplicativos">📱 Aplicativos Mobile</a></li>
                </ul>
            </li>
            <li class="mobile-item">
                <button class="mobile-dropdown-toggle">Tecnologias <span class="mobile-arrow">+</span></button>
                <ul class="mobile-submenu">
                    <li><a href="/wordpress">WordPress</a></li>
                    <li><a href="/woocommerce">WooCommerce</a></li>
                    <li><a href="/react">React/Node.js</a></li>
                    <li><a href="/automacao">Automação</a></li>
                </ul>
            </li>
            <?php if (class_exists('WooCommerce')) : ?>
                <li class="mobile-item"><a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>">Shop</a></li>
            <?php endif; ?>
            <li class="mobile-item"><a href="/sobre">Sobre</a></li>
            <li class="mobile-item"><a href="/contato">Contato</a></li>
            <li class="mobile-item"><a href="/contato" class="mobile-cta">Fale Conosco</a></li>
        </ul>
    </div>
</header>

<main class="site-main">
