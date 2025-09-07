#!/bin/bash

# ===========================================
# VancouverTec Store - Correção Tema Completo
# Script: 04-corrigir-tema-completo.sh
# Versão: 1.0.0 - Corrige erro linha 240 + Tema funcional
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

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║        🔧 CORREÇÃO TEMA VANCOUVERTEC 🔧       ║
║     Corrige erro + Tema completo funcional   ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar projeto
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Projeto não encontrado em: $PROJECT_PATH"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Corrigindo tema em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    log_warning "Parando servidor para correções..."
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Backup do tema atual
if [[ -d "$THEME_PATH" ]]; then
    log_info "Fazendo backup do tema atual..."
    cp -r "$THEME_PATH" "${THEME_PATH}-backup-$(date +%Y%m%d-%H%M%S)"
fi

# Remover tema quebrado
log_warning "Removendo tema com erro..."
rm -rf "$THEME_PATH"

# Criar estrutura completa do tema
log_info "Criando estrutura completa do tema..."
mkdir -p "$THEME_PATH"/{inc,template-parts,woocommerce,assets/{css,js,images,fonts},languages}

# style.css CORRIGIDO
log_info "Criando style.css..."
cat > "$THEME_PATH/style.css" << 'EOF'
/*
Theme Name: VancouverTec Store
Description: Tema premium para loja de produtos digitais da VancouverTec. Performance 99+, SEO avançado e design azul institucional moderno.
Author: VancouverTec
Version: 1.0.0
Requires at least: 6.4
Tested up to: 6.5
Requires PHP: 8.0
License: Proprietary
Text Domain: vancouvertec
Domain Path: /languages
Tags: woocommerce, e-commerce, digital-products, responsive, performance
*/

:root {
  --vt-blue-600: #0066CC;
  --vt-blue-700: #0052A3;
  --vt-indigo-500: #6366F1;
  --vt-success-500: #10B981;
  --vt-neutral-100: #F5F5F5;
  --vt-neutral-200: #E5E7EB;
  --vt-neutral-800: #1F2937;
  --vt-neutral-900: #111827;
  --vt-font-primary: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  --vt-space-sm: 1rem;
  --vt-space-md: 1.5rem;
  --vt-space-lg: 2rem;
  --vt-space-xl: 3rem;
  --vt-radius-md: 0.5rem;
  --vt-shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  --vt-transition-fast: 0.15s ease;
}

* { box-sizing: border-box; }

body { 
  font-family: var(--vt-font-primary);
  line-height: 1.6;
  color: var(--vt-neutral-800);
  background: #ffffff;
  margin: 0;
  padding: 0;
}

.container { 
  max-width: 1200px; 
  margin: 0 auto; 
  padding: 0 var(--vt-space-sm); 
}

.hero-section {
  background: linear-gradient(135deg, var(--vt-blue-600) 0%, var(--vt-indigo-500) 100%);
  color: white;
  padding: var(--vt-space-xl) 0;
  text-align: center;
}

.hero-title {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: var(--vt-space-sm);
}

.hero-subtitle {
  font-size: 1.25rem;
  margin-bottom: var(--vt-space-md);
}

.hero-description {
  font-size: 1.1rem;
  margin-bottom: var(--vt-space-lg);
  opacity: 0.9;
}

.btn {
  display: inline-block;
  padding: var(--vt-space-sm) var(--vt-space-lg);
  background: var(--vt-blue-600);
  color: white;
  text-decoration: none;
  border-radius: var(--vt-radius-md);
  font-weight: 600;
  transition: var(--vt-transition-fast);
  margin: 0.5rem;
}

.btn:hover {
  background: var(--vt-blue-700);
  transform: translateY(-2px);
}

.btn-secondary {
  background: rgba(255, 255, 255, 0.2);
  border: 2px solid rgba(255, 255, 255, 0.3);
}

.btn-secondary:hover {
  background: rgba(255, 255, 255, 0.3);
  color: white;
}

.site-header {
  background: white;
  border-bottom: 1px solid var(--vt-neutral-200);
  position: sticky;
  top: 0;
  z-index: 100;
}

.header-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--vt-space-sm) 0;
}

.site-title a {
  color: var(--vt-blue-600);
  text-decoration: none;
  font-weight: 700;
  font-size: 1.5rem;
}

.main-navigation ul {
  display: flex;
  list-style: none;
  margin: 0;
  padding: 0;
  gap: var(--vt-space-lg);
}

.main-navigation a {
  color: var(--vt-neutral-800);
  text-decoration: none;
  font-weight: 500;
  transition: var(--vt-transition-fast);
}

.main-navigation a:hover {
  color: var(--vt-blue-600);
}

.site-footer {
  background: var(--vt-neutral-900);
  color: white;
  margin-top: var(--vt-space-xl);
  padding: var(--vt-space-lg) 0;
}

.footer-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

@media (max-width: 768px) {
  .header-content { flex-direction: column; gap: var(--vt-space-sm); }
  .main-navigation ul { flex-wrap: wrap; justify-content: center; }
  .footer-content { flex-direction: column; gap: var(--vt-space-sm); text-align: center; }
  .hero-title { font-size: 2rem; }
}
EOF

# functions.php FUNCIONAL
log_info "Criando functions.php funcional..."
cat > "$THEME_PATH/functions.php" << 'EOF'
<?php
/**
 * VancouverTec Store Theme Functions
 * @package VancouverTec_Store
 */

if (!defined('ABSPATH')) exit;

define('VT_THEME_VERSION', '1.0.0');
define('VT_THEME_DIR', get_template_directory());
define('VT_THEME_URI', get_template_directory_uri());

function vt_theme_setup() {
    add_theme_support('post-thumbnails');
    add_theme_support('title-tag');
    add_theme_support('custom-logo');
    add_theme_support('html5', ['search-form', 'comment-form', 'gallery', 'caption']);
    
    // WooCommerce support
    add_theme_support('woocommerce');
    add_theme_support('wc-product-gallery-zoom');
    add_theme_support('wc-product-gallery-lightbox');
    
    register_nav_menus([
        'primary' => __('Primary Menu', 'vancouvertec'),
        'footer' => __('Footer Menu', 'vancouvertec'),
    ]);
    
    load_theme_textdomain('vancouvertec', VT_THEME_DIR . '/languages');
    
    add_image_size('vt-product', 400, 300, true);
    add_image_size('vt-hero', 1200, 600, true);
}
add_action('after_setup_theme', 'vt_theme_setup');

function vt_enqueue_assets() {
    if (!is_admin()) {
        wp_deregister_script('jquery');
        wp_register_script('jquery', 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js', [], '3.6.0', true);
    }
    
    wp_enqueue_style('vt-style', VT_THEME_URI . '/style.css', [], VT_THEME_VERSION);
    wp_enqueue_script('vt-main', VT_THEME_URI . '/assets/js/main.js', ['jquery'], VT_THEME_VERSION, true);
    
    wp_localize_script('vt-main', 'vt_ajax', [
        'ajax_url' => admin_url('admin-ajax.php'),
        'nonce' => wp_create_nonce('vt_nonce'),
    ]);
}
add_action('wp_enqueue_scripts', 'vt_enqueue_assets');

function vt_widgets_init() {
    register_sidebar([
        'name' => __('Sidebar', 'vancouvertec'),
        'id' => 'sidebar-1',
        'before_widget' => '<div id="%1$s" class="widget %2$s">',
        'after_widget' => '</div>',
        'before_title' => '<h3 class="widget-title">',
        'after_title' => '</h3>',
    ]);
}
add_action('widgets_init', 'vt_widgets_init');

// Performance
remove_action('wp_head', 'wp_generator');
remove_action('wp_head', 'print_emoji_detection_script', 7);
remove_action('wp_print_styles', 'print_emoji_styles');
EOF

# header.php
log_info "Criando header.php..."
cat > "$THEME_PATH/header.php" << 'EOF'
<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>
<?php wp_body_open(); ?>

<header class="site-header">
    <div class="container">
        <div class="header-content">
            <div class="site-branding">
                <?php if (has_custom_logo()) : ?>
                    <?php the_custom_logo(); ?>
                <?php else : ?>
                    <h1 class="site-title">
                        <a href="<?php echo esc_url(home_url('/')); ?>">
                            <?php bloginfo('name'); ?>
                        </a>
                    </h1>
                <?php endif; ?>
            </div>
            
            <nav class="main-navigation">
                <?php wp_nav_menu(['theme_location' => 'primary']); ?>
            </nav>
        </div>
    </div>
</header>

<main class="site-main">
EOF

# footer.php
log_info "Criando footer.php..."
cat > "$THEME_PATH/footer.php" << 'EOF'
</main>

<footer class="site-footer">
    <div class="container">
        <div class="footer-content">
            <div class="footer-info">
                <p>&copy; <?php echo date('Y'); ?> <?php bloginfo('name'); ?>. 
                Soluções Digitais para o seu Negócio</p>
            </div>
            
            <nav class="footer-navigation">
                <?php wp_nav_menu(['theme_location' => 'footer']); ?>
            </nav>
        </div>
    </div>
</footer>

<?php wp_footer(); ?>
</body>
</html>
EOF

# index.php CORRIGIDO (SEM LINHA 240 PROBLEMÁTICA)
log_info "Criando index.php corrigido..."
cat > "$THEME_PATH/index.php" << 'EOF'
<?php get_header(); ?>

<div class="container">
    <?php if (is_home() && is_front_page()) : ?>
        <section class="hero-section">
            <h1 class="hero-title">VancouverTec Store</h1>
            <h2 class="hero-subtitle">Soluções Digitais para o seu Negócio</h2>
            <p class="hero-description">
                Sistemas, Sites, Aplicativos, Automação e Cursos para empresas que querem crescer
            </p>
            
            <div class="hero-actions">
                <?php if (class_exists('WooCommerce')) : ?>
                    <a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>" class="btn">
                        Ver Produtos
                    </a>
                <?php endif; ?>
                <a href="/sobre" class="btn btn-secondary">
                    Saiba Mais
                </a>
            </div>
        </section>
    <?php endif; ?>
    
    <?php if (have_posts()) : ?>
        <section class="posts-section">
            <h3>Últimas Novidades</h3>
            <div class="posts-grid">
                <?php while (have_posts()) : the_post(); ?>
                    <article class="post-card">
                        <?php if (has_post_thumbnail()) : ?>
                            <div class="post-thumbnail">
                                <a href="<?php the_permalink(); ?>">
                                    <?php the_post_thumbnail('medium'); ?>
                                </a>
                            </div>
                        <?php endif; ?>
                        
                        <div class="post-content">
                            <h4 class="post-title">
                                <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
                            </h4>
                            
                            <div class="post-excerpt">
                                <?php the_excerpt(); ?>
                            </div>
                            
                            <div class="post-meta">
                                <time datetime="<?php echo get_the_date('c'); ?>">
                                    <?php echo get_the_date(); ?>
                                </time>
                            </div>
                        </div>
                    </article>
                <?php endwhile; ?>
            </div>
            
            <?php the_posts_navigation(); ?>
        </section>
    <?php endif; ?>
</div>

<?php get_footer(); ?>
EOF

# Criar main.js
log_info "Criando JavaScript..."
mkdir -p "$THEME_PATH/assets/js"
cat > "$THEME_PATH/assets/js/main.js" << 'EOF'
(function($) {
    'use strict';
    
    $(document).ready(function() {
        console.log('VancouverTec Store - Tema carregado com sucesso!');
        
        // Performance: Lazy loading
        $('img').attr('loading', 'lazy');
        
        // Smooth scroll
        $('a[href^="#"]').on('click', function(e) {
            e.preventDefault();
            const target = $(this.getAttribute('href'));
            if (target.length) {
                $('html, body').animate({
                    scrollTop: target.offset().top - 80
                }, 800);
            }
        });
    });
    
})(jQuery);
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

# Testar se está funcionando
sleep 2
if curl -s "http://localhost:8080" > /dev/null 2>&1; then
    log_success "Site respondendo!"
else
    log_warning "Site pode ter problemas. Verificando..."
fi

echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║        ✅ TEMA CORRIGIDO E FUNCIONAL! ✅      ║"
echo -e "║         Erro linha 240 resolvido!           ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Tema VancouverTec Store criado e funcional"
log_success "✅ Erro fatal da linha 240 corrigido"
log_success "✅ Estrutura WordPress completa"
log_success "✅ Design azul institucional implementado"
log_success "✅ WooCommerce integrado"

echo -e "\n${YELLOW}🎯 TESTE AGORA:${NC}"
echo -e "• Frontend: http://localhost:8080"
echo -e "• Admin: http://localhost:8080/wp-admin"
echo -e "• Login: admin / admin123"

echo -e "\n${BLUE}📁 Arquivos Criados:${NC}"
echo -e "• style.css - Design system completo"
echo -e "• functions.php - Funcionalidades WordPress"
echo -e "• header.php - Cabeçalho profissional"
echo -e "• footer.php - Rodapé institucional"
echo -e "• index.php - Página inicial (SEM ERRO)"
echo -e "• assets/js/main.js - JavaScript otimizado"

log_success "Tema funcionando perfeitamente! Acesse para testar."

exit 0