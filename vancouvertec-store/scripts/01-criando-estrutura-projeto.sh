#!/bin/bash

# ===========================================
# VancouverTec Store - Criação da Estrutura
# Script: 01-criando-estrutura-projeto.sh
# Versão: 1.0.0
# ===========================================

set -euo pipefail

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variáveis do projeto
PROJECT_NAME="vancouvertec-store"
THEME_NAME="vancouvertec-store"
PLUGIN_NAME="vancouvertec-digital-manager"
TEXT_DOMAIN="vancouvertec"
VERSION="1.0.0"

# Função para log colorido
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Função de cleanup em caso de erro
cleanup() {
    if [[ -d "$PROJECT_NAME" ]]; then
        log_warning "Limpando arquivos em caso de erro..."
        rm -rf "$PROJECT_NAME"
    fi
}

# Trap para cleanup
trap cleanup ERR

# Banner do projeto
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║          VancouverTec Store Builder          ║
║     🚀 Criando Estrutura do Projeto 🚀      ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificações iniciais
log_info "Iniciando verificações de ambiente..."

# Verificar se já existe
if [[ -d "$PROJECT_NAME" ]]; then
    log_warning "Diretório '$PROJECT_NAME' já existe!"
    read -p "Deseja sobrescrever? (s/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        log_error "Operação cancelada pelo usuário."
        exit 1
    fi
    log_info "Criando backup do diretório existente..."
    mv "$PROJECT_NAME" "${PROJECT_NAME}-backup-$(date +%Y%m%d-%H%M%S)"
    log_success "Backup criado com sucesso!"
fi

# Verificar permissões
if [[ ! -w "." ]]; then
    log_error "Sem permissão de escrita no diretório atual!"
    exit 1
fi

log_success "Verificações concluídas!"

# Criar estrutura principal
log_info "Criando estrutura de diretórios..."

# Diretório base do projeto
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Estrutura WordPress
mkdir -p wp-content/{themes,plugins,mu-plugins}
mkdir -p wp-content/themes/$THEME_NAME/{inc,template-parts,woocommerce,assets/{css,js,images,fonts},languages}
mkdir -p wp-content/plugins/$PLUGIN_NAME/{includes,admin,public,assets/{css,js,images},languages}

# Estrutura de suporte
mkdir -p {scripts,config,docs,backups}

log_success "Estrutura de diretórios criada!"

# Criar arquivo style.css do tema
log_info "Criando arquivo style.css do tema..."
cat > "wp-content/themes/$THEME_NAME/style.css" << EOF
/*
Theme Name: VancouverTec Store
Description: Tema premium para loja de produtos digitais da VancouverTec. Performance 99+, SEO avançado e design moderno.
Author: VancouverTec
Version: $VERSION
Requires at least: 6.4
Tested up to: 6.5
Requires PHP: 8.0
License: Proprietary
License URI: https://vancouvertec.com.br/license
Text Domain: $TEXT_DOMAIN
Domain Path: /languages
Tags: woocommerce, e-commerce, digital-products, responsive, performance
*/

:root {
  /* VancouverTec Color Palette */
  --vt-blue-600: #0066CC;
  --vt-blue-700: #0052A3;
  --vt-indigo-500: #6366F1;
  --vt-success-500: #10B981;
  --vt-neutral-100: #F5F5F5;
  --vt-neutral-800: #1F2937;
  
  /* Typography */
  --vt-font-primary: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  --vt-font-secondary: 'Poppins', sans-serif;
  
  /* Spacing */
  --vt-space-xs: 0.5rem;
  --vt-space-sm: 1rem;
  --vt-space-md: 1.5rem;
  --vt-space-lg: 2rem;
  --vt-space-xl: 3rem;
  
  /* Border Radius */
  --vt-radius-sm: 0.375rem;
  --vt-radius-md: 0.5rem;
  --vt-radius-lg: 0.75rem;
}

/* Reset and Base Styles */
* {
  box-sizing: border-box;
}

body {
  font-family: var(--vt-font-primary);
  line-height: 1.6;
  color: var(--vt-neutral-800);
  background-color: #ffffff;
  margin: 0;
  padding: 0;
}

/* VancouverTec Store Specific Styles */
.vt-primary-color { color: var(--vt-blue-600); }
.vt-success-color { color: var(--vt-success-500); }
.vt-bg-primary { background-color: var(--vt-blue-600); }
.vt-bg-success { background-color: var(--vt-success-500); }
EOF

log_success "Arquivo style.css criado!"

# Criar functions.php do tema
log_info "Criando functions.php do tema..."
cat > "wp-content/themes/$THEME_NAME/functions.php" << 'EOF'
<?php
/**
 * VancouverTec Store Theme Functions
 * 
 * @package VancouverTec_Store
 * @version 1.0.0
 */

// Prevent direct access
if (!defined('ABSPATH')) {
    exit;
}

// Theme constants
define('VT_THEME_VERSION', '1.0.0');
define('VT_THEME_DIR', get_template_directory());
define('VT_THEME_URI', get_template_directory_uri());

/**
 * Theme Setup
 */
function vt_theme_setup() {
    // Add theme support
    add_theme_support('post-thumbnails');
    add_theme_support('title-tag');
    add_theme_support('custom-logo');
    add_theme_support('html5', array('search-form', 'comment-form', 'comment-list', 'gallery', 'caption'));
    add_theme_support('customize-selective-refresh-widgets');
    
    // WooCommerce support
    add_theme_support('woocommerce');
    add_theme_support('wc-product-gallery-zoom');
    add_theme_support('wc-product-gallery-lightbox');
    add_theme_support('wc-product-gallery-slider');
    
    // Menus
    register_nav_menus(array(
        'primary' => __('Primary Menu', 'vancouvertec'),
        'footer' => __('Footer Menu', 'vancouvertec'),
    ));
    
    // Load text domain
    load_theme_textdomain('vancouvertec', VT_THEME_DIR . '/languages');
}
add_action('after_setup_theme', 'vt_theme_setup');

/**
 * Enqueue Scripts and Styles
 */
function vt_enqueue_assets() {
    // Styles
    wp_enqueue_style('vt-style', VT_THEME_URI . '/style.css', array(), VT_THEME_VERSION);
    wp_enqueue_style('vt-main', VT_THEME_URI . '/assets/css/main.css', array('vt-style'), VT_THEME_VERSION);
    
    // Scripts
    wp_enqueue_script('vt-main', VT_THEME_URI . '/assets/js/main.js', array('jquery'), VT_THEME_VERSION, true);
    
    // Localize script
    wp_localize_script('vt-main', 'vt_ajax', array(
        'ajax_url' => admin_url('admin-ajax.php'),
        'nonce' => wp_create_nonce('vt_nonce'),
    ));
}
add_action('wp_enqueue_scripts', 'vt_enqueue_assets');

/**
 * Include theme files
 */
require_once VT_THEME_DIR . '/inc/customizer.php';
require_once VT_THEME_DIR . '/inc/woocommerce.php';

/**
 * Performance optimizations
 */
function vt_performance_optimizations() {
    // Remove unnecessary scripts
    wp_deregister_script('wp-embed');
    
    // Optimize jQuery loading
    if (!is_admin() && !is_customize_preview()) {
        wp_deregister_script('jquery');
        wp_register_script('jquery', 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js', false, '3.6.0', true);
        wp_enqueue_script('jquery');
    }
}
add_action('wp_enqueue_scripts', 'vt_performance_optimizations');
EOF

log_success "Arquivo functions.php criado!"

# Criar index.php do tema
log_info "Criando index.php do tema..."
cat > "wp-content/themes/$THEME_NAME/index.php" << 'EOF'
<?php
/**
 * Main Template File
 *
 * @package VancouverTec_Store
 */

get_header(); ?>

<main id="primary" class="site-main" role="main">
    <div class="container">
        <?php if (have_posts()) : ?>
            <div class="posts-grid">
                <?php while (have_posts()) : the_post(); ?>
                    <article id="post-<?php the_ID(); ?>" <?php post_class('post-card'); ?>>
                        <?php if (has_post_thumbnail()) : ?>
                            <div class="post-thumbnail">
                                <a href="<?php the_permalink(); ?>">
                                    <?php the_post_thumbnail('medium'); ?>
                                </a>
                            </div>
                        <?php endif; ?>
                        
                        <div class="post-content">
                            <h2 class="post-title">
                                <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
                            </h2>
                            
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
            
        <?php else : ?>
            <div class="no-posts">
                <h1><?php _e('Nothing Found', 'vancouvertec'); ?></h1>
                <p><?php _e('It looks like nothing was found at this location.', 'vancouvertec'); ?></p>
            </div>
        <?php endif; ?>
    </div>
</main>

<?php get_footer();
EOF

log_success "Arquivo index.php criado!"

# Criar arquivo principal do plugin
log_info "Criando arquivo principal do plugin..."
cat > "wp-content/plugins/$PLUGIN_NAME/$PLUGIN_NAME.php" << 'EOF'
<?php
/**
 * Plugin Name: VancouverTec Digital Manager
 * Plugin URI: https://store.vancouvertec.com.br
 * Description: Plugin proprietário para gerenciamento de produtos digitais, cursos e downloads seguros da VancouverTec Store.
 * Version: 1.0.0
 * Author: VancouverTec
 * Author URI: https://vancouvertec.com.br
 * License: Proprietary
 * License URI: https://vancouvertec.com.br/license
 * Text Domain: vancouvertec
 * Domain Path: /languages
 * Requires at least: 6.4
 * Tested up to: 6.5
 * Requires PHP: 8.0
 * Network: false
 *
 * @package VancouverTec_Digital_Manager
 */

// Prevent direct access
if (!defined('ABSPATH')) {
    exit;
}

// Plugin constants
define('VT_PLUGIN_VERSION', '1.0.0');
define('VT_PLUGIN_FILE', __FILE__);
define('VT_PLUGIN_DIR', plugin_dir_path(__FILE__));
define('VT_PLUGIN_URL', plugin_dir_url(__FILE__));
define('VT_PLUGIN_BASENAME', plugin_basename(__FILE__));

/**
 * Main Plugin Class
 */
final class VancouverTec_Digital_Manager {
    
    /**
     * Plugin instance
     */
    private static $instance = null;
    
    /**
     * Get plugin instance
     */
    public static function get_instance() {
        if (null === self::$instance) {
            self::$instance = new self();
        }
        return self::$instance;
    }
    
    /**
     * Constructor
     */
    private function __construct() {
        $this->init();
    }
    
    /**
     * Initialize plugin
     */
    private function init() {
        // Load plugin files
        $this->includes();
        
        // Hooks
        register_activation_hook(VT_PLUGIN_FILE, array($this, 'activate'));
        register_deactivation_hook(VT_PLUGIN_FILE, array($this, 'deactivate'));
        
        add_action('plugins_loaded', array($this, 'load_textdomain'));
        add_action('init', array($this, 'init_plugin'));
    }
    
    /**
     * Include required files
     */
    private function includes() {
        require_once VT_PLUGIN_DIR . 'includes/class-core.php';
        require_once VT_PLUGIN_DIR . 'includes/class-downloads.php';
        require_once VT_PLUGIN_DIR . 'includes/class-courses.php';
        require_once VT_PLUGIN_DIR . 'admin/class-admin.php';
        require_once VT_PLUGIN_DIR . 'public/class-public.php';
    }
    
    /**
     * Plugin activation
     */
    public function activate() {
        // Create database tables
        $this->create_tables();
        
        // Flush rewrite rules
        flush_rewrite_rules();
    }
    
    /**
     * Plugin deactivation
     */
    public function deactivate() {
        // Flush rewrite rules
        flush_rewrite_rules();
    }
    
    /**
     * Load text domain
     */
    public function load_textdomain() {
        load_plugin_textdomain('vancouvertec', false, dirname(VT_PLUGIN_BASENAME) . '/languages');
    }
    
    /**
     * Initialize plugin components
     */
    public function init_plugin() {
        // Initialize classes
        new VT_Core();
        new VT_Admin();
        new VT_Public();
    }
    
    /**
     * Create plugin tables
     */
    private function create_tables() {
        global $wpdb;
        
        $charset_collate = $wpdb->get_charset_collate();
        
        // Downloads table
        $table_downloads = $wpdb->prefix . 'vt_downloads';
        $sql_downloads = "CREATE TABLE $table_downloads (
            id mediumint(9) NOT NULL AUTO_INCREMENT,
            user_id bigint(20) NOT NULL,
            product_id bigint(20) NOT NULL,
            download_key varchar(255) NOT NULL,
            downloads_remaining int(11) NOT NULL DEFAULT -1,
            download_count int(11) NOT NULL DEFAULT 0,
            created_at datetime DEFAULT CURRENT_TIMESTAMP,
            expires_at datetime,
            PRIMARY KEY (id),
            KEY user_id (user_id),
            KEY product_id (product_id),
            KEY download_key (download_key)
        ) $charset_collate;";
        
        // Course progress table
        $table_progress = $wpdb->prefix . 'vt_course_progress';
        $sql_progress = "CREATE TABLE $table_progress (
            id mediumint(9) NOT NULL AUTO_INCREMENT,
            user_id bigint(20) NOT NULL,
            course_id bigint(20) NOT NULL,
            lesson_id bigint(20) NOT NULL,
            completed tinyint(1) DEFAULT 0,
            completed_at datetime,
            PRIMARY KEY (id),
            KEY user_id (user_id),
            KEY course_id (course_id)
        ) $charset_collate;";
        
        require_once(ABSPATH . 'wp-admin/includes/upgrade.php');
        dbDelta($sql_downloads);
        dbDelta($sql_progress);
    }
}

// Initialize plugin
VancouverTec_Digital_Manager::get_instance();
EOF

log_success "Arquivo principal do plugin criado!"

# Criar arquivos de assets básicos
log_info "Criando arquivos de assets básicos..."

# CSS principal do tema
cat > "wp-content/themes/$THEME_NAME/assets/css/main.css" << 'EOF'
/* VancouverTec Store - Main Styles */
.container { max-width: 1200px; margin: 0 auto; padding: 0 1rem; }
.btn-primary { background: var(--vt-blue-600); color: white; padding: 0.75rem 1.5rem; border: none; border-radius: var(--vt-radius-md); }
.btn-primary:hover { background: var(--vt-blue-700); }
EOF

# JavaScript principal do tema  
cat > "wp-content/themes/$THEME_NAME/assets/js/main.js" << 'EOF'
(function($) {
    'use strict';
    
    // VancouverTec Store Main JS
    $(document).ready(function() {
        console.log('VancouverTec Store initialized');
        
        // Performance optimization
        $('img').attr('loading', 'lazy');
    });
    
})(jQuery);
EOF

# CSS do plugin
cat > "wp-content/plugins/$PLUGIN_NAME/assets/css/admin.css" << 'EOF'
/* VancouverTec Digital Manager - Admin Styles */
.vt-admin-panel { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
EOF

log_success "Arquivos de assets criados!"

# Definir permissões
log_info "Configurando permissões de arquivos..."
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;
chmod +x ../scripts/ 2>/dev/null || true

log_success "Permissões configuradas!"

# Criar arquivo de documentação básica
log_info "Criando documentação básica..."
cat > "docs/INSTALACAO.md" << EOF
# Instalação VancouverTec Store

## Próximos Passos

1. Execute: \`chmod +x ../scripts/02-configurando-ambiente.sh && ../scripts/02-configurando-ambiente.sh\`
2. Configure o banco de dados
3. Execute o deploy para VPS

## Estrutura Criada

- ✅ Tema WordPress completo
- ✅ Plugin proprietário
- ✅ Estrutura de assets
- ✅ Configurações de desenvolvimento

Versão: $VERSION
Data: $(date)
EOF

log_success "Documentação criada!"

# Relatório final
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║            🎉 SUCESSO! 🎉                    ║"
echo -e "║     Estrutura do projeto criada!            ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "Projeto: $PROJECT_NAME"
log_success "Tema: $THEME_NAME"
log_success "Plugin: $PLUGIN_NAME"
log_success "Versão: $VERSION"

echo -e "\n${CYAN}📁 Estrutura criada:${NC}"
echo "├── wp-content/"
echo "│   ├── themes/$THEME_NAME/"
echo "│   ├── plugins/$PLUGIN_NAME/"
echo "│   └── mu-plugins/"
echo "├── scripts/"
echo "├── config/"
echo "├── docs/"
echo "└── backups/"

echo -e "\n${YELLOW}🚀 Próximo passo:${NC}"
echo "chmod +x ../scripts/02-configurando-ambiente.sh && ../scripts/02-configurando-ambiente.sh"

echo -e "\n${PURPLE}⏱️  Tempo de execução: $(date)${NC}"
log_success "Script 01 concluído com sucesso!"

exit 0