#!/bin/bash

# ===========================================
# VancouverTec Store - WooCommerce Extras + Visual Completo
# Script: 31d-woo-extras-wishlist.sh
# Versão: 1.0.0 - Header/Footer + Visual VancouverTec
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
PROJECT_PATH="/home/$(whoami)/vancouvertec/store-vancouvertec-com-br/vancouvertec-store"
THEME_PATH="wp-content/themes/vancouvertec-store"

# Funções de log
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║    🎨 Visual VancouverTec Completo 🎨        ║
║     Header + Footer + Design Final          ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar base
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Execute antes: 31c-woo-responsive-mobile.sh"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Criando visual completo em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost:8080" > /dev/null; then
    log_warning "Parando servidor..."
    pkill -f "php -S localhost:8080" || true
    sleep 2
fi

# 1. CRIAR HEADER.PHP COM DESIGN VANCOUVERTEC
log_info "Criando header.php com design VancouverTec..."
cat > "${THEME_PATH}/header.php" << 'EOF'
<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#0066CC">
    
    <?php wp_head(); ?>
    
    <!-- VancouverTec Critical CSS -->
    <style>
    .vt-header{background:#0066CC;color:#fff;padding:1rem 0;box-shadow:0 2px 10px rgba(0,0,0,0.1)}
    .vt-header-content{display:flex;justify-content:space-between;align-items:center;max-width:1200px;margin:0 auto;padding:0 1rem}
    .vt-logo{font-size:1.5rem;font-weight:700;color:#fff;text-decoration:none}
    .vt-nav ul{display:flex;list-style:none;margin:0;padding:0;gap:2rem}
    .vt-nav a{color:#fff;text-decoration:none;font-weight:500;transition:opacity 0.2s}
    .vt-nav a:hover{opacity:0.8}
    .vt-cart-icon{position:relative;color:#fff;font-size:1.25rem}
    .vt-cart-count{position:absolute;top:-8px;right:-8px;background:#10B981;border-radius:50%;width:20px;height:20px;display:flex;align-items:center;justify-content:center;font-size:0.75rem;font-weight:700}
    @media (max-width: 768px){.vt-nav{display:none}}
    </style>
</head>

<body <?php body_class('vt-body'); ?>>
<?php wp_body_open(); ?>

<header class="vt-header" role="banner">
    <div class="vt-header-content container">
        
        <div class="vt-brand">
            <?php if (has_custom_logo()): ?>
                <?php the_custom_logo(); ?>
            <?php else: ?>
                <a href="<?php echo esc_url(home_url('/')); ?>" class="vt-logo">
                    🚀 <?php bloginfo('name'); ?>
                </a>
            <?php endif; ?>
        </div>
        
        <nav class="vt-nav vt-desktop-nav" role="navigation">
            <?php
            wp_nav_menu([
                'theme_location' => 'primary',
                'menu_class' => 'vt-nav-list',
                'container' => false,
                'fallback_cb' => function() {
                    echo '<ul class="vt-nav-list">';
                    echo '<li><a href="' . esc_url(home_url('/')) . '">Início</a></li>';
                    if (class_exists('WooCommerce')) {
                        echo '<li><a href="' . esc_url(wc_get_page_permalink('shop')) . '">Loja</a></li>';
                        echo '<li><a href="' . esc_url(wc_get_page_permalink('myaccount')) . '">Minha Conta</a></li>';
                    }
                    echo '</ul>';
                }
            ]);
            ?>
        </nav>
        
        <div class="vt-header-actions">
            
            <?php if (class_exists('WooCommerce')): ?>
            <a href="<?php echo esc_url(wc_get_cart_url()); ?>" class="vt-cart-icon">
                🛒
                <span class="vt-cart-count"><?php echo WC()->cart->get_cart_contents_count(); ?></span>
            </a>
            <?php endif; ?>
            
            <button class="vt-mobile-toggle" aria-label="Menu">
                ☰
            </button>
        </div>
        
    </div>
</header>

<!-- Oferta Banner -->
<div class="vt-promo-banner">
    <div class="container">
        <p class="vt-promo-text">
            🔥 <strong>OFERTA LIMITADA:</strong> 50% OFF em todos os produtos digitais! 
            <a href="<?php echo esc_url(wc_get_page_permalink('shop')); ?>" class="vt-promo-link">
                Aproveitar Agora
            </a>
        </p>
    </div>
</div>

<main class="vt-main-content" role="main">
EOF

# 2. CRIAR FOOTER.PHP COM DESIGN VANCOUVERTEC
log_info "Criando footer.php com design VancouverTec..."
cat > "${THEME_PATH}/footer.php" << 'EOF'
</main>

<footer class="vt-footer" role="contentinfo">
    <div class="container">
        
        <div class="vt-footer-content">
            
            <div class="vt-footer-section vt-footer-brand">
                <h3 class="vt-footer-title">
                    🚀 <?php bloginfo('name'); ?>
                </h3>
                <p class="vt-footer-description">
                    <?php 
                    $description = get_bloginfo('description');
                    echo $description ? esc_html($description) : 'Soluções digitais para o seu negócio. Sistemas, sites, aplicativos e automação para empresas que querem crescer.';
                    ?>
                </p>
                
                <div class="vt-social-links">
                    <a href="#" class="vt-social-link" aria-label="Instagram">📷</a>
                    <a href="#" class="vt-social-link" aria-label="LinkedIn">💼</a>
                    <a href="#" class="vt-social-link" aria-label="WhatsApp">💬</a>
                </div>
            </div>
            
            <div class="vt-footer-section">
                <h4 class="vt-footer-title">Soluções</h4>
                <ul class="vt-footer-links">
                    <li><a href="#">🌐 Sites Institucionais</a></li>
                    <li><a href="#">💻 Sistemas Web</a></li>
                    <li><a href="#">🛒 Lojas Virtuais</a></li>
                    <li><a href="#">📱 Aplicativos Mobile</a></li>
                    <li><a href="#">📄 Documentos</a></li>
                </ul>
            </div>
            
            <div class="vt-footer-section">
                <h4 class="vt-footer-title">Tecnologias</h4>
                <ul class="vt-footer-links">
                    <li><a href="#">WordPress</a></li>
                    <li><a href="#">WooCommerce</a></li>
                    <li><a href="#">React/Node.js</a></li>
                    <li><a href="#">PHP/Laravel</a></li>
                </ul>
            </div>
            
            <div class="vt-footer-section">
                <h4 class="vt-footer-title">Contato</h4>
                <ul class="vt-footer-contact">
                    <li>📞 (11) 9 9999-9999</li>
                    <li>✉️ contato@vancouvertec.com.br</li>
                    <li>🕒 Seg-Sex 9h às 18h</li>
                    <li>🎯 Suporte 24/7</li>
                </ul>
            </div>
            
        </div>
        
        <div class="vt-footer-bottom">
            <div class="vt-footer-copy">
                <p>&copy; <?php echo date('Y'); ?> VancouverTec. Todos os direitos reservados.</p>
            </div>
            
            <div class="vt-footer-badges">
                <div class="vt-badge-item">🔒 SSL Seguro</div>
                <div class="vt-badge-item">⚡ Entrega Imediata</div>
                <div class="vt-badge-item">🎯 Suporte Premium</div>
            </div>
        </div>
        
    </div>
</footer>

<!-- Mobile Menu Overlay -->
<div class="vt-mobile-overlay"></div>
<div class="vt-mobile-menu">
    <div class="vt-mobile-header">
        <span class="vt-mobile-logo">🚀 <?php bloginfo('name'); ?></span>
        <button class="vt-mobile-close">&times;</button>
    </div>
    
    <nav class="vt-mobile-nav">
        <?php
        wp_nav_menu([
            'theme_location' => 'mobile',
            'menu_class' => 'vt-mobile-nav-list',
            'container' => false,
            'fallback_cb' => function() {
                echo '<ul class="vt-mobile-nav-list">';
                echo '<li><a href="' . esc_url(home_url('/')) . '">🏠 Início</a></li>';
                if (class_exists('WooCommerce')) {
                    echo '<li><a href="' . esc_url(wc_get_page_permalink('shop')) . '">🛒 Loja</a></li>';
                    echo '<li><a href="' . esc_url(wc_get_page_permalink('myaccount')) . '">👤 Minha Conta</a></li>';
                    echo '<li><a href="' . esc_url(wc_get_cart_url()) . '">🛍️ Carrinho</a></li>';
                }
                echo '</ul>';
            }
        ]);
        ?>
    </nav>
</div>

<?php wp_footer(); ?>

<!-- CSS Footer Inline -->
<style>
.vt-promo-banner{background:linear-gradient(135deg,#F59E0B,#EF4444);color:#fff;padding:0.75rem 0;text-align:center}
.vt-promo-text{margin:0;font-size:0.875rem}
.vt-promo-link{color:#fff;font-weight:700;text-decoration:underline}
.vt-footer{background:#1F2937;color:#fff;padding:3rem 0 1rem;margin-top:4rem}
.vt-footer-content{display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:2rem;margin-bottom:2rem}
.vt-footer-section h3,.vt-footer-section h4{color:#0066CC;margin-bottom:1rem;font-size:1.125rem}
.vt-footer-links{list-style:none;padding:0;margin:0}
.vt-footer-links a{color:#D1D5DB;text-decoration:none;transition:color 0.2s}
.vt-footer-links a:hover{color:#0066CC}
.vt-footer-contact{list-style:none;padding:0;margin:0;color:#D1D5DB}
.vt-social-links{display:flex;gap:1rem;margin-top:1rem}
.vt-social-link{font-size:1.5rem;text-decoration:none;transition:transform 0.2s}
.vt-social-link:hover{transform:scale(1.2)}
.vt-footer-bottom{display:flex;justify-content:space-between;align-items:center;border-top:1px solid #374151;padding-top:1rem;flex-wrap:wrap;gap:1rem}
.vt-footer-badges{display:flex;gap:1rem;flex-wrap:wrap}
.vt-badge-item{background:#0066CC;color:#fff;padding:0.25rem 0.75rem;border-radius:1rem;font-size:0.75rem;font-weight:600}
.vt-mobile-menu{position:fixed;top:0;left:-100%;width:280px;height:100vh;background:#fff;box-shadow:0 0 50px rgba(0,0,0,0.3);transition:left 0.3s;z-index:9999;overflow-y:auto}
.vt-mobile-menu.active{left:0}
.vt-mobile-overlay{position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.5);opacity:0;visibility:hidden;transition:all 0.3s;z-index:9998}
.vt-mobile-overlay.active{opacity:1;visibility:visible}
.vt-mobile-header{display:flex;justify-content:space-between;align-items:center;padding:1rem;border-bottom:1px solid #E5E7EB}
.vt-mobile-logo{font-weight:700;color:#0066CC}
.vt-mobile-close{background:none;border:none;font-size:2rem;color:#666;cursor:pointer}
.vt-mobile-nav-list{list-style:none;padding:0;margin:0}
.vt-mobile-nav-list a{display:block;padding:1rem;color:#333;text-decoration:none;border-bottom:1px solid #F3F4F6}
.vt-mobile-nav-list a:hover{background:#F9FAFB;color:#0066CC}
@media (max-width: 768px){.vt-footer-content{grid-template-columns:1fr;text-align:center}.vt-footer-bottom{flex-direction:column;text-align:center}}
</style>

</body>
</html>
EOF

# 3. CRIAR INDEX.PHP PRINCIPAL
log_info "Criando index.php principal..."
cat > "${THEME_PATH}/index.php" << 'EOF'
<?php
/**
 * VancouverTec Store - Main Index
 */

get_header(); ?>

<div class="vt-home-page">
    <div class="container">
        
        <!-- Hero Section -->
        <section class="vt-hero">
            <div class="vt-hero-content">
                <h1 class="vt-hero-title">
                    VancouverTec Store – Soluções Digitais para o seu Negócio
                </h1>
                <p class="vt-hero-subtitle">
                    Sistemas, Sites, Aplicativos, Automação e Cursos para empresas que querem crescer
                </p>
                <div class="vt-hero-actions">
                    <?php if (class_exists('WooCommerce')): ?>
                    <a href="<?php echo esc_url(wc_get_page_permalink('shop')); ?>" class="button btn-primary btn-large">
                        🛒 Ver Produtos
                    </a>
                    <?php endif; ?>
                    <a href="#sobre" class="button btn-outline">
                        Saiba Mais
                    </a>
                </div>
            </div>
        </section>
        
        <!-- Features Section -->
        <section class="vt-features">
            <h2 class="vt-section-title">Por que escolher a VancouverTec?</h2>
            <div class="vt-features-grid">
                <div class="vt-feature-card">
                    <div class="vt-feature-icon">⚡</div>
                    <h3>Download Imediato</h3>
                    <p>Receba seus produtos digitais na hora, sem espera.</p>
                </div>
                <div class="vt-feature-card">
                    <div class="vt-feature-icon">🎯</div>
                    <h3>Suporte Especializado</h3>
                    <p>Equipe técnica pronta para te ajudar 24/7.</p>
                </div>
                <div class="vt-feature-card">
                    <div class="vt-feature-icon">🔒</div>
                    <h3>100% Seguro</h3>
                    <p>Pagamento protegido e dados criptografados.</p>
                </div>
                <div class="vt-feature-card">
                    <div class="vt-feature-icon">🚀</div>
                    <h3>Performance 99+</h3>
                    <p>Produtos otimizados para máxima performance.</p>
                </div>
            </div>
        </section>
        
        <?php if (class_exists('WooCommerce')): ?>
        <!-- Featured Products -->
        <section class="vt-featured-products">
            <h2 class="vt-section-title">Produtos em Destaque</h2>
            <?php
            echo do_shortcode('[featured_products limit="4" columns="4"]');
            ?>
        </section>
        <?php endif; ?>
        
    </div>
</div>

<!-- CSS Inline para Hero -->
<style>
.vt-hero{text-align:center;padding:4rem 0;background:linear-gradient(135deg,#0066CC 0%,#6366F1 100%);color:#fff;border-radius:1rem;margin:2rem 0}
.vt-hero-title{font-size:3rem;font-weight:700;margin-bottom:1rem;line-height:1.2}
.vt-hero-subtitle{font-size:1.25rem;margin-bottom:2rem;opacity:0.9}
.vt-hero-actions{display:flex;gap:1rem;justify-content:center;flex-wrap:wrap}
.btn-large{padding:1rem 2rem;font-size:1.125rem}
.btn-outline{background:transparent;border:2px solid #fff;color:#fff}
.btn-outline:hover{background:#fff;color:#0066CC}
.vt-section-title{font-size:2rem;text-align:center;margin-bottom:3rem;color:#0066CC}
.vt-features{padding:4rem 0}
.vt-features-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:2rem}
.vt-feature-card{background:#fff;padding:2rem;border-radius:1rem;box-shadow:0 4px 6px rgba(0,0,0,0.1);text-align:center;transition:transform 0.3s}
.vt-feature-card:hover{transform:translateY(-4px)}
.vt-feature-icon{font-size:3rem;margin-bottom:1rem}
.vt-feature-card h3{color:#0066CC;margin-bottom:1rem}
.vt-featured-products{padding:2rem 0}
@media (max-width: 768px){.vt-hero-title{font-size:2rem}.vt-hero-actions{flex-direction:column;align-items:center}.vt-features-grid{grid-template-columns:1fr}}
</style>

<?php get_footer(); ?>
EOF

# 4. ATUALIZAR FUNCTIONS.PHP PARA CONECTAR TUDO
log_info "Conectando todos os assets no functions.php..."
cat >> "${THEME_PATH}/functions.php" << 'EOF'

/**
 * Conectar todos os assets VancouverTec
 */
function vt_enqueue_all_assets() {
    // CSS Principal
    wp_enqueue_style('vt-style', VT_THEME_URI . '/style.css', [], VT_THEME_VERSION);
    
    // CSS WooCommerce
    wp_enqueue_style('vt-woocommerce', 
        VT_THEME_URI . '/assets/css/woocommerce/woocommerce.css', 
        ['vt-style'], VT_THEME_VERSION);
    
    // CSS Mobile
    if (wp_is_mobile()) {
        wp_enqueue_style('vt-mobile', 
            VT_THEME_URI . '/assets/css/mobile.css', 
            ['vt-woocommerce'], VT_THEME_VERSION);
    }
    
    // JavaScript
    wp_enqueue_script('vt-main', 
        VT_THEME_URI . '/assets/js/main.js', 
        ['jquery'], VT_THEME_VERSION, true);
    
    if (wp_is_mobile()) {
        wp_enqueue_script('vt-mobile', 
            VT_THEME_URI . '/assets/js/mobile.js', 
            ['vt-main'], VT_THEME_VERSION, true);
    }
}
add_action('wp_enqueue_scripts', 'vt_enqueue_all_assets', 5);

/**
 * Ativar tema automaticamente
 */
function vt_activate_theme() {
    if (get_option('stylesheet') !== 'vancouvertec-store') {
        switch_theme('vancouvertec-store');
        
        // Definir páginas padrão WooCommerce
        if (class_exists('WooCommerce')) {
            WC_Install::create_pages();
        }
    }
}
add_action('init', 'vt_activate_theme');

/**
 * Customizer VancouverTec
 */
function vt_customize_register($wp_customize) {
    // Seção VancouverTec
    $wp_customize->add_section('vt_options', [
        'title' => __('VancouverTec Store', 'vancouvertec'),
        'priority' => 30,
    ]);
    
    // Cor primária
    $wp_customize->add_setting('vt_primary_color', [
        'default' => '#0066CC',
        'sanitize_callback' => 'sanitize_hex_color',
    ]);
    
    $wp_customize->add_control(new WP_Customize_Color_Control($wp_customize, 'vt_primary_color', [
        'label' => __('Cor Primária VancouverTec', 'vancouvertec'),
        'section' => 'vt_options',
    ]));
}
add_action('customize_register', 'vt_customize_register');

/**
 * CSS customizado do Customizer
 */
function vt_customizer_css() {
    $primary_color = get_theme_mod('vt_primary_color', '#0066CC');
    ?>
    <style type="text/css">
        :root {
            --vt-blue-600: <?php echo $primary_color; ?>;
        }
    </style>
    <?php
}
add_action('wp_head', 'vt_customizer_css');
EOF

# Iniciar servidor
log_info "Iniciando servidor com visual completo..."
nohup php -S localhost:8080 router.php > server.log 2>&1 &
echo $! > .server_pid
sleep 3

# Verificar arquivos criados
created_files=(
    "${THEME_PATH}/header.php"
    "${THEME_PATH}/footer.php"
    "${THEME_PATH}/index.php"
)

for file in "${created_files[@]}"; do
    if [[ -f "$file" ]]; then
        log_success "✅ $(basename "$file")"
    else
        log_error "❌ $(basename "$file")"
    fi
done

# Relatório
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║       ✅ VISUAL VANCOUVERTEC COMPLETO! ✅     ║"
echo -e "║                                              ║"
echo -e "║  🎨 Header azul VancouverTec                 ║"
echo -e "║  🎯 Footer com links e contatos              ║"
echo -e "║  🏠 Homepage com hero section                ║"
echo -e "║  📱 Menu mobile hambúrguer                   ║"
echo -e "║  🎨 CSS completo conectado                   ║"
echo -e "║  ⚡ JavaScript otimizado ativo               ║"
echo -e "║                                              ║"
echo -e "║  Visual Features:                            ║"
echo -e "║  • Design azul institucional                 ║"
echo -e "║  • Gradientes e animações                    ║"
echo -e "║  • Cards com hover effects                   ║"
echo -e "║  • Layout responsivo completo                ║"
echo -e "║  • Promo banner dinâmico                     ║"
echo -e "║                                              ║"
echo -e "║  🌐 Servidor: http://localhost:8080          ║"
echo -e "║     👆 AGORA O VISUAL ESTÁ AZUL! 👆         ║"
echo -e "║                                              ║"
echo -e "║  ➡️  Final: 31e-woo-performance-final.sh     ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_info "Execute o script final:"
echo -e "${BLUE}chmod +x 31e-woo-performance-final.sh && ./31e-woo-performance-final.sh${NC}"

log_warning "🎉 AGORA RECARREGUE A PÁGINA! O visual azul VancouverTec deve aparecer!"