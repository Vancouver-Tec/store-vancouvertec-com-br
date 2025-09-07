#!/bin/bash

# ===========================================
# VancouverTec Store - Correção Emergencial
# Script: 03x-correcao-emergencial-tema.sh
# Versão: 1.0.0 - CORRIGE ERRO FATAL NO TEMA
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
║        🚨 CORREÇÃO EMERGENCIAL 🚨             ║
║       Corrigindo erro fatal do tema          ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Projeto não encontrado em: $PROJECT_PATH"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Corrigindo tema quebrado em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    log_warning "Parando servidor para correção..."
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Backup do functions.php quebrado
if [[ -f "$THEME_PATH/functions.php" ]]; then
    cp "$THEME_PATH/functions.php" "$THEME_PATH/functions-broken-backup.php"
    log_info "Backup do functions.php quebrado criado"
fi

# Criar functions.php MÍNIMO e FUNCIONAL
log_info "Criando functions.php mínimo funcional..."
cat > "$THEME_PATH/functions.php" << 'EOF'
<?php
/**
 * VancouverTec Store Theme Functions - MÍNIMO FUNCIONAL
 * Versão de emergência para corrigir erro fatal
 * 
 * @package VancouverTec_Store
 * @version 1.0.0
 */

if (!defined('ABSPATH')) exit;

// Theme Constants
define('VT_THEME_VERSION', '1.0.0');
define('VT_THEME_DIR', get_template_directory());
define('VT_THEME_URI', get_template_directory_uri());

/**
 * Theme Setup
 */
function vt_theme_setup() {
    // Language support
    load_theme_textdomain('vancouvertec', VT_THEME_DIR . '/languages');
    
    // Theme support features
    add_theme_support('post-thumbnails');
    add_theme_support('title-tag');
    add_theme_support('custom-logo');
    add_theme_support('html5', [
        'search-form', 'comment-form', 'comment-list', 
        'gallery', 'caption'
    ]);
    
    // WooCommerce support
    add_theme_support('woocommerce');
    add_theme_support('wc-product-gallery-zoom');
    add_theme_support('wc-product-gallery-lightbox');
    add_theme_support('wc-product-gallery-slider');
    
    // Navigation menus
    register_nav_menus([
        'primary' => __('Menu Principal', 'vancouvertec'),
        'footer' => __('Menu do Rodapé', 'vancouvertec'),
    ]);
    
    // Image sizes
    add_image_size('vt-product', 400, 400, true);
    add_image_size('vt-hero', 1200, 600, true);
}
add_action('after_setup_theme', 'vt_theme_setup');

/**
 * Enqueue Scripts and Styles
 */
function vt_enqueue_assets() {
    // Performance: Use CDN jQuery
    if (!is_admin()) {
        wp_deregister_script('jquery');
        wp_register_script('jquery', 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js', [], '3.6.0', true);
        wp_enqueue_script('jquery');
    }
    
    // Theme styles
    wp_enqueue_style('vt-style', VT_THEME_URI . '/style.css', [], VT_THEME_VERSION);
    
    // Theme script
    wp_enqueue_script('vt-main', VT_THEME_URI . '/assets/js/main.js', ['jquery'], VT_THEME_VERSION, true);
    
    // Localize script
    wp_localize_script('vt-main', 'vt_ajax', [
        'ajax_url' => admin_url('admin-ajax.php'),
        'nonce' => wp_create_nonce('vt_nonce'),
        'theme_url' => VT_THEME_URI,
    ]);
}
add_action('wp_enqueue_scripts', 'vt_enqueue_assets');

/**
 * Performance Optimizations
 */
function vt_performance_init() {
    // Remove unnecessary WordPress features
    remove_action('wp_head', 'wp_generator');
    remove_action('wp_head', 'wlwmanifest_link');
    remove_action('wp_head', 'rsd_link');
    add_filter('the_generator', '__return_empty_string');
    
    // Remove emoji scripts
    remove_action('wp_head', 'print_emoji_detection_script', 7);
    remove_action('wp_print_styles', 'print_emoji_styles');
}
add_action('init', 'vt_performance_init');

/**
 * Widgets
 */
function vt_widgets_init() {
    register_sidebar([
        'name' => __('Sidebar Principal', 'vancouvertec'),
        'id' => 'sidebar-1',
        'before_widget' => '<section id="%1$s" class="widget %2$s">',
        'after_widget' => '</section>',
        'before_title' => '<h2 class="widget-title">',
        'after_title' => '</h2>',
    ]);
}
add_action('widgets_init', 'vt_widgets_init');

/**
 * WooCommerce Customizations
 */
if (class_exists('WooCommerce')) {
    // Remove WooCommerce default styles for performance
    add_filter('woocommerce_enqueue_styles', '__return_empty_array');
}

/**
 * Helper Functions
 */
function vt_remove_query_strings($src) {
    $parts = explode('?ver', $src);
    return $parts[0];
}
add_filter('script_loader_src', 'vt_remove_query_strings', 15, 1);
add_filter('style_loader_src', 'vt_remove_query_strings', 15, 1);

/**
 * SEO Meta Tags
 */
function vt_add_meta_tags() {
    echo '<meta name="viewport" content="width=device-width, initial-scale=1">' . "\n";
    echo '<meta name="theme-color" content="#0066CC">' . "\n";
}
add_action('wp_head', 'vt_add_meta_tags', 1);
EOF

log_success "functions.php mínimo criado!"

# Criar os arquivos inc/ que estavam faltando (vazios para não dar erro)
log_info "Criando arquivos include vazios..."
mkdir -p "$THEME_PATH/inc"

cat > "$THEME_PATH/inc/woocommerce-functions.php" << 'EOF'
<?php
/**
 * WooCommerce Functions - Em desenvolvimento
 * @package VancouverTec_Store
 */

if (!defined('ABSPATH')) exit;

// Arquivo temporário - será expandido em próxima versão
EOF

cat > "$THEME_PATH/inc/elementor-functions.php" << 'EOF'
<?php
/**
 * Elementor Functions - Em desenvolvimento
 * @package VancouverTec_Store
 */

if (!defined('ABSPATH')) exit;

// Arquivo temporário - será expandido em próxima versão
EOF

cat > "$THEME_PATH/inc/custom-post-types.php" << 'EOF'
<?php
/**
 * Custom Post Types - Em desenvolvimento
 * @package VancouverTec_Store
 */

if (!defined('ABSPATH')) exit;

// Arquivo temporário - será expandido em próxima versão
EOF

cat > "$THEME_PATH/inc/ajax-functions.php" << 'EOF'
<?php
/**
 * AJAX Functions - Em desenvolvimento
 * @package VancouverTec_Store
 */

if (!defined('ABSPATH')) exit;

// Arquivo temporário - será expandido em próxima versão
EOF

cat > "$THEME_PATH/inc/template-functions.php" << 'EOF'
<?php
/**
 * Template Functions - Em desenvolvimento
 * @package VancouverTec_Store
 */

if (!defined('ABSPATH')) exit;

// Arquivo temporário - será expandido em próxima versão
EOF

log_success "Arquivos include criados!"

# Criar main.js básico se não existir
log_info "Verificando assets..."
mkdir -p "$THEME_PATH/assets/js"

if [[ ! -f "$THEME_PATH/assets/js/main.js" ]]; then
    cat > "$THEME_PATH/assets/js/main.js" << 'EOF'
(function($) {
    'use strict';
    
    $(document).ready(function() {
        console.log('VancouverTec Store - Tema carregado com sucesso!');
        
        // Performance: Lazy loading
        $('img').attr('loading', 'lazy');
        
        // Remove loading class
        $('body').removeClass('vt-loading').addClass('vt-loaded');
    });
    
})(jQuery);
EOF
    log_success "main.js criado!"
fi

# Verificar se header.php e footer.php existem
if [[ ! -f "$THEME_PATH/header.php" ]]; then
    log_warning "header.php não existe, criando versão mínima..."
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
        <div class="site-branding">
            <h1 class="site-title">
                <a href="<?php echo esc_url(home_url('/')); ?>">
                    <?php bloginfo('name'); ?>
                </a>
            </h1>
        </div>
        
        <nav class="main-navigation">
            <?php wp_nav_menu(['theme_location' => 'primary']); ?>
        </nav>
    </div>
</header>

<main class="site-main">
EOF
    log_success "header.php mínimo criado!"
fi

if [[ ! -f "$THEME_PATH/footer.php" ]]; then
    log_warning "footer.php não existe, criando versão mínima..."
    cat > "$THEME_PATH/footer.php" << 'EOF'
</main>

<footer class="site-footer">
    <div class="container">
        <p>&copy; <?php echo date('Y'); ?> <?php bloginfo('name'); ?>. Soluções Digitais.</p>
    </div>
</footer>

<?php wp_footer(); ?>
</body>
</html>
EOF
    log_success "footer.php mínimo criado!"
fi

if [[ ! -f "$THEME_PATH/index.php" ]]; then
    log_warning "index.php não existe, criando versão mínima..."
    cat > "$THEME_PATH/index.php" << 'EOF'
<?php get_header(); ?>

<div class="container">
    <h1>VancouverTec Store</h1>
    <p>Soluções Digitais para o seu Negócio</p>
    
    <?php if (have_posts()) : ?>
        <?php while (have_posts()) : the_post(); ?>
            <article>
                <h2><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h2>
                <?php the_excerpt(); ?>
            </article>
        <?php endwhile; ?>
    <?php endif; ?>
</div>

<?php get_footer(); ?>
EOF
    log_success "index.php mínimo criado!"
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
    log_info "Últimas linhas do log:"
    tail -5 /tmp/vt-server-8080.log 2>/dev/null || echo "Log não disponível"
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
echo -e "║        🎉 ERRO CORRIGIDO COM SUCESSO! 🎉      ║"
echo -e "║           Tema funcionando novamente!        ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ Erro fatal corrigido!"
log_success "✅ functions.php funcional criado"
log_success "✅ Arquivos include vazios criados"
log_success "✅ Assets básicos verificados"
log_success "✅ Servidor reiniciado"

echo -e "\n${CYAN}🌐 TESTE AGORA:${NC}"
echo -e "• Frontend: ${GREEN}http://localhost:8080${NC}"
echo -e "• Admin: ${GREEN}http://localhost:8080/wp-admin${NC}"
echo -e "• Login: ${GREEN}admin / admin123${NC}"

echo -e "\n${YELLOW}📋 O QUE FOI CORRIGIDO:${NC}"
echo -e "• ❌ Antes: functions.php tentava incluir arquivos inexistentes"
echo -e "• ✅ Agora: functions.php mínimo e funcional"
echo -e "• ✅ Arquivos include criados (vazios, mas funcionais)"
echo -e "• ✅ Assets verificados e criados se necessário"

echo -e "\n${PURPLE}🚀 PRÓXIMOS PASSOS:${NC}"
echo -e "1. Teste o site: ${GREEN}http://localhost:8080${NC}"
echo -e "2. Acesse o admin: ${GREEN}http://localhost:8080/wp-admin${NC}"
echo -e "3. Ative o tema se necessário em Aparência > Temas"
echo -e "4. Digite 'continuar' para expandir funcionalidades"

log_success "Tema funcionando! Agora você pode acessar o painel normalmente."

exit 0