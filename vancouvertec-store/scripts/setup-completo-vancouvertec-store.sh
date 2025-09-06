#!/bin/bash

# ===========================================
# VancouverTec Store - Setup Completo
# Script: setup-completo-vancouvertec-store.sh
# Versão: 2.0.0 - Script Unificado
# ===========================================

set -euo pipefail

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Variáveis do projeto
PROJECT_NAME="vancouvertec-store"
THEME_NAME="vancouvertec-store"
PLUGIN_NAME="vancouvertec-digital-manager"
TEXT_DOMAIN="vancouvertec"
VERSION="1.0.0"
DB_LOCAL_NAME="vt_store_db"
DB_LOCAL_USER="root"
DB_LOCAL_PASS="12345678"
DB_LOCAL_HOST="127.0.0.1"
WORDPRESS_URL="https://wordpress.org/latest.zip"

# Função para log colorido
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Função de cleanup em caso de erro
cleanup() {
    [[ -f "latest.zip" ]] && rm -f latest.zip
    [[ -d "wordpress" ]] && rm -rf wordpress
}
trap cleanup ERR EXIT

# Banner do projeto
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║          VancouverTec Store Builder          ║
║        🚀 Setup Completo Unificado 🚀        ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificações de dependências
log_info "Verificando dependências do sistema..."

# Verificar MySQL
if ! command -v mysql &> /dev/null; then
    log_error "MySQL não encontrado! Instale MySQL/MariaDB primeiro."
    exit 1
fi

# Verificar conexão MySQL
if ! mysqladmin ping -h"$DB_LOCAL_HOST" -u"$DB_LOCAL_USER" -p"$DB_LOCAL_PASS" &> /dev/null; then
    log_error "MySQL não conecta! Verifique: Host=$DB_LOCAL_HOST User=$DB_LOCAL_USER Pass=$DB_LOCAL_PASS"
    exit 1
fi

# Verificar wget ou curl
if ! command -v wget &> /dev/null && ! command -v curl &> /dev/null; then
    log_error "wget ou curl não encontrados!"
    exit 1
fi

# Verificar unzip
if ! command -v unzip &> /dev/null; then
    log_error "unzip não encontrado!"
    exit 1
fi

log_success "Dependências verificadas!"

# Verificar/criar estrutura do projeto
if [[ -d "$PROJECT_NAME" ]]; then
    log_warning "Diretório '$PROJECT_NAME' já existe!"
    read -p "Deseja sobrescrever? (s/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        log_error "Operação cancelada."
        exit 1
    fi
    mv "$PROJECT_NAME" "${PROJECT_NAME}-backup-$(date +%Y%m%d-%H%M%S)"
    log_success "Backup criado!"
fi

log_info "Criando estrutura completa do projeto..."

# Criar diretório principal
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# Criar estrutura WordPress completa
mkdir -p wp-content/{themes,plugins,mu-plugins,uploads}
mkdir -p wp-content/themes/$THEME_NAME/{inc,template-parts,woocommerce,assets/{css,js,images,fonts},languages}
mkdir -p wp-content/plugins/$PLUGIN_NAME/{includes,admin,public,assets/{css,js,images},languages}
mkdir -p {scripts,config,docs,backups}

log_success "Estrutura de diretórios criada!"

# Marcar wp-content como customizado
touch wp-content/.vt-custom

# Baixar WordPress core
log_info "Baixando WordPress core..."
if command -v wget &> /dev/null; then
    wget -q --show-progress "$WORDPRESS_URL" -O latest.zip
else
    curl -L "$WORDPRESS_URL" -o latest.zip
fi
log_success "WordPress baixado!"

# Extrair WordPress
log_info "Extraindo WordPress..."
unzip -q latest.zip

# Integrar WordPress core preservando wp-content
log_info "Integrando WordPress core..."
find wordpress -maxdepth 1 -not -name wp-content -not -name wordpress -exec cp -r {} . \; 2>/dev/null || true
rm -rf wordpress latest.zip

# Remover wp-content padrão do WordPress
[[ -d "wp-content" ]] && [[ ! -f "wp-content/.vt-custom" ]] && rm -rf wp-content

log_success "WordPress integrado com estrutura customizada!"

# Configurar banco de dados
log_info "Configurando banco de dados..."
mysql -h"$DB_LOCAL_HOST" -u"$DB_LOCAL_USER" -p"$DB_LOCAL_PASS" -e "CREATE DATABASE IF NOT EXISTS \`$DB_LOCAL_NAME\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" 2>/dev/null

# Testar conexão
if mysql -h"$DB_LOCAL_HOST" -u"$DB_LOCAL_USER" -p"$DB_LOCAL_PASS" "$DB_LOCAL_NAME" -e "SELECT 1;" &> /dev/null; then
    log_success "Banco '$DB_LOCAL_NAME' configurado!"
else
    log_error "Falha na conexão com banco!"
    exit 1
fi

# Criar arquivos do tema
log_info "Criando tema VancouverTec Store..."

# style.css
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
  --vt-blue-600: #0066CC;
  --vt-blue-700: #0052A3;
  --vt-indigo-500: #6366F1;
  --vt-success-500: #10B981;
  --vt-neutral-100: #F5F5F5;
  --vt-neutral-800: #1F2937;
  --vt-font-primary: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  --vt-font-secondary: 'Poppins', sans-serif;
  --vt-space-xs: 0.5rem;
  --vt-space-sm: 1rem;
  --vt-space-md: 1.5rem;
  --vt-space-lg: 2rem;
  --vt-space-xl: 3rem;
  --vt-radius-sm: 0.375rem;
  --vt-radius-md: 0.5rem;
  --vt-radius-lg: 0.75rem;
}

* { box-sizing: border-box; }
body { 
  font-family: var(--vt-font-primary);
  line-height: 1.6;
  color: var(--vt-neutral-800);
  background-color: #ffffff;
  margin: 0;
  padding: 0;
}

.vt-primary-color { color: var(--vt-blue-600); }
.vt-success-color { color: var(--vt-success-500); }
.vt-bg-primary { background-color: var(--vt-blue-600); }
.vt-bg-success { background-color: var(--vt-success-500); }
EOF

# functions.php
cat > "wp-content/themes/$THEME_NAME/functions.php" << 'EOF'
<?php
/**
 * VancouverTec Store Theme Functions
 * @package VancouverTec_Store
 * @version 1.0.0
 */

if (!defined('ABSPATH')) exit;

define('VT_THEME_VERSION', '1.0.0');
define('VT_THEME_DIR', get_template_directory());
define('VT_THEME_URI', get_template_directory_uri());

function vt_theme_setup() {
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
    
    register_nav_menus(array(
        'primary' => __('Primary Menu', 'vancouvertec'),
        'footer' => __('Footer Menu', 'vancouvertec'),
    ));
    
    load_theme_textdomain('vancouvertec', VT_THEME_DIR . '/languages');
}
add_action('after_setup_theme', 'vt_theme_setup');

function vt_enqueue_assets() {
    wp_enqueue_style('vt-style', VT_THEME_URI . '/style.css', array(), VT_THEME_VERSION);
    wp_enqueue_style('vt-main', VT_THEME_URI . '/assets/css/main.css', array('vt-style'), VT_THEME_VERSION);
    wp_enqueue_script('vt-main', VT_THEME_URI . '/assets/js/main.js', array('jquery'), VT_THEME_VERSION, true);
    wp_localize_script('vt-main', 'vt_ajax', array(
        'ajax_url' => admin_url('admin-ajax.php'),
        'nonce' => wp_create_nonce('vt_nonce'),
    ));
}
add_action('wp_enqueue_scripts', 'vt_enqueue_assets');

function vt_performance_optimizations() {
    wp_deregister_script('wp-embed');
    if (!is_admin() && !is_customize_preview()) {
        wp_deregister_script('jquery');
        wp_register_script('jquery', 'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js', false, '3.6.0', true);
        wp_enqueue_script('jquery');
    }
}
add_action('wp_enqueue_scripts', 'vt_performance_optimizations');
EOF

# index.php
cat > "wp-content/themes/$THEME_NAME/index.php" << 'EOF'
<?php
/**
 * Main Template File
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

log_success "Tema criado!"

# Criar plugin
log_info "Criando plugin VancouverTec Digital Manager..."

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
 * Text Domain: vancouvertec
 * Domain Path: /languages
 * Requires at least: 6.4
 * Tested up to: 6.5
 * Requires PHP: 8.0
 * @package VancouverTec_Digital_Manager
 */

if (!defined('ABSPATH')) exit;

define('VT_PLUGIN_VERSION', '1.0.0');
define('VT_PLUGIN_FILE', __FILE__);
define('VT_PLUGIN_DIR', plugin_dir_path(__FILE__));
define('VT_PLUGIN_URL', plugin_dir_url(__FILE__));
define('VT_PLUGIN_BASENAME', plugin_basename(__FILE__));

final class VancouverTec_Digital_Manager {
    private static $instance = null;
    
    public static function get_instance() {
        if (null === self::$instance) {
            self::$instance = new self();
        }
        return self::$instance;
    }
    
    private function __construct() {
        $this->init();
    }
    
    private function init() {
        register_activation_hook(VT_PLUGIN_FILE, array($this, 'activate'));
        register_deactivation_hook(VT_PLUGIN_FILE, array($this, 'deactivate'));
        add_action('plugins_loaded', array($this, 'load_textdomain'));
        add_action('init', array($this, 'init_plugin'));
    }
    
    public function activate() {
        $this->create_tables();
        flush_rewrite_rules();
    }
    
    public function deactivate() {
        flush_rewrite_rules();
    }
    
    public function load_textdomain() {
        load_plugin_textdomain('vancouvertec', false, dirname(VT_PLUGIN_BASENAME) . '/languages');
    }
    
    public function init_plugin() {
        // Plugin initialization logic here
    }
    
    private function create_tables() {
        global $wpdb;
        $charset_collate = $wpdb->get_charset_collate();
        
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

VancouverTec_Digital_Manager::get_instance();
EOF

log_success "Plugin criado!"

# Criar arquivos de assets
log_info "Criando arquivos de assets..."

cat > "wp-content/themes/$THEME_NAME/assets/css/main.css" << 'EOF'
/* VancouverTec Store - Main Styles */
.container { max-width: 1200px; margin: 0 auto; padding: 0 1rem; }
.btn-primary { background: var(--vt-blue-600); color: white; padding: 0.75rem 1.5rem; border: none; border-radius: var(--vt-radius-md); }
.btn-primary:hover { background: var(--vt-blue-700); }
EOF

cat > "wp-content/themes/$THEME_NAME/assets/js/main.js" << 'EOF'
(function($) {
    'use strict';
    $(document).ready(function() {
        console.log('VancouverTec Store initialized');
        $('img').attr('loading', 'lazy');
    });
})(jQuery);
EOF

cat > "wp-content/plugins/$PLUGIN_NAME/assets/css/admin.css" << 'EOF'
/* VancouverTec Digital Manager - Admin Styles */
.vt-admin-panel { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
EOF

log_success "Assets criados!"

# Gerar salts de segurança
log_info "Gerando chaves de segurança..."
SALTS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)

# Criar wp-config.php
log_info "Criando wp-config.php..."
cat > wp-config.php << EOF
<?php
/**
 * VancouverTec Store - WordPress Configuration
 * Environment: Local/Production Auto-Switch
 * Generated: $(date)
 */

define('VT_ENV', 'local');

if (VT_ENV === 'local') {
    define('DB_NAME', '$DB_LOCAL_NAME');
    define('DB_USER', '$DB_LOCAL_USER');
    define('DB_PASSWORD', '$DB_LOCAL_PASS');
    define('DB_HOST', '$DB_LOCAL_HOST');
    define('WP_DEBUG', true);
    define('WP_DEBUG_LOG', true);
    define('WP_DEBUG_DISPLAY', false);
    define('SCRIPT_DEBUG', true);
} else {
    define('DB_NAME', 'vancouvertec-store');
    define('DB_USER', 'vancouvertec-store');
    define('DB_PASSWORD', 'VeNWJAL1JCOQr2h2ohw5');
    define('DB_HOST', '127.0.0.1:3306');
    define('WP_DEBUG', false);
    define('WP_DEBUG_LOG', false);
    define('WP_DEBUG_DISPLAY', false);
    define('SCRIPT_DEBUG', false);
}

define('DB_CHARSET', 'utf8mb4');
define('DB_COLLATE', '');

$SALTS

\$table_prefix = 'vt_';

define('VT_STORE_VERSION', '1.0.0');
define('VT_STORE_URL', VT_ENV === 'local' ? 'http://localhost/vancouvertec-store' : 'https://store.vancouvertec.com.br');
define('VT_API_ENDPOINT', '/wp-json/vt/v1');

define('AUTOMATIC_UPDATER_DISABLED', true);
define('WP_AUTO_UPDATE_CORE', false);
define('DISALLOW_FILE_EDIT', true);
define('WP_POST_REVISIONS', 3);
define('AUTOSAVE_INTERVAL', 300);
define('WP_CACHE', true);
define('COMPRESS_CSS', true);
define('COMPRESS_SCRIPTS', true);
define('ENFORCE_GZIP', true);
define('WP_MEMORY_LIMIT', '512M');
define('WP_MAX_MEMORY_LIMIT', '512M');
define('DISALLOW_UNFILTERED_HTML', true);
define('ALLOW_UNFILTERED_UPLOADS', false);

if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

require_once ABSPATH . 'wp-settings.php';
EOF

log_success "wp-config.php criado!"

# Criar .htaccess otimizado
cat > .htaccess << 'EOF'
# VancouverTec Store - .htaccess Optimized
<IfModule mod_headers.c>
    Header always set X-Content-Type-Options "nosniff"
    Header always set X-Frame-Options "SAMEORIGIN"  
    Header always set X-XSS-Protection "1; mode=block"
    Header always set Referrer-Policy "strict-origin-when-cross-origin"
    Header always set Permissions-Policy "geolocation=(), microphone=(), camera=()"
</IfModule>

<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>

<IfModule mod_expires.c>
ExpiresActive On
ExpiresByType text/css "access plus 1 year"
ExpiresByType application/javascript "access plus 1 year"
ExpiresByType image/png "access plus 1 year"
ExpiresByType image/jpg "access plus 1 year"
ExpiresByType image/jpeg "access plus 1 year"
ExpiresByType image/gif "access plus 1 year"
ExpiresByType image/svg+xml "access plus 1 year"
ExpiresByType application/pdf "access plus 1 month"
ExpiresByType text/html "access plus 1 hour"
</IfModule>

<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/css
    AddOutputFilterByType DEFLATE application/javascript
    AddOutputFilterByType DEFLATE text/html
    AddOutputFilterByType DEFLATE application/json
</IfModule>

<FilesMatch "(wp-config\.php|\.htaccess|\.htpasswd)">
    Order deny,allow
    Deny from all
</FilesMatch>

<Files xmlrpc.php>
    Order deny,allow
    Deny from all
</Files>

Options -Indexes
EOF

log_success ".htaccess criado!"

# Criar script de setup WordPress
cat > ../setup-wordpress.sh << 'EOF'
#!/bin/bash
echo "🚀 Configurando WordPress VancouverTec Store..."
cd vancouvertec-store

if command -v wp &> /dev/null; then
    echo "📦 Instalando via WP-CLI..."
    wp core install \
        --url="http://localhost/vancouvertec-store" \
        --title="VancouverTec Store" \
        --admin_user="admin" \
        --admin_password="admin123" \
        --admin_email="admin@vancouvertec.com.br" \
        --skip-email
    
    wp theme activate vancouvertec-store
    wp plugin activate vancouvertec-digital-manager
    
    echo "✅ WordPress configurado!"
    echo "🌐 URL: http://localhost/vancouvertec-store"
    echo "👤 Admin: admin / admin123"
else
    echo "⚠️  Configure manualmente em: http://localhost/vancouvertec-store"
fi
EOF

chmod +x ../setup-wordpress.sh

# Configurar permissões
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;
chmod 600 wp-config.php

# Testar conexão final
php -r "
try {
    \$mysqli = new mysqli('$DB_LOCAL_HOST', '$DB_LOCAL_USER', '$DB_LOCAL_PASS', '$DB_LOCAL_NAME');
    if (\$mysqli->connect_error) throw new Exception(\$mysqli->connect_error);
    echo 'OK';
    \$mysqli->close();
} catch (Exception \$e) {
    echo 'ERRO: ' . \$e->getMessage();
    exit(1);
}
" >/dev/null

log_success "Teste de conexão aprovado!"

# Relatório final
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║     🎉 VANCOUVERTEC STORE CONFIGURADO! 🎉    ║"
echo -e "║           Pronto para usar!                  ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ WordPress Core: Instalado"
log_success "✅ Tema: vancouvertec-store (criado)"
log_success "✅ Plugin: vancouvertec-digital-manager (criado)"
log_success "✅ Banco: $DB_LOCAL_NAME (configurado)"
log_success "✅ wp-config.php: VT_ENV=local"
log_success "✅ Assets: CSS/JS prontos"
log_success "✅ .htaccess: Performance otimizada"

echo -e "\n${CYAN}📁 Estrutura Final:${NC}"
echo "├── wp-admin/ wp-includes/ index.php"
echo "├── wp-content/"
echo "│   ├── themes/vancouvertec-store/"
echo "│   └── plugins/vancouvertec-digital-manager/"
echo "├── wp-config.php"
echo "└── .htaccess"

echo -e "\n${YELLOW}🚀 Próximos Passos:${NC}"
echo "1. Configure servidor web apontando para: $(pwd)"
echo "2. Execute: ../setup-wordpress.sh"
echo "3. Acesse: http://localhost/vancouvertec-store"

echo -e "\n${PURPLE}💾 Credenciais:${NC}"
echo "Banco: $DB_LOCAL_HOST/$DB_LOCAL_NAME"
echo "User: $DB_LOCAL_USER"

echo -e "\n${GREEN}🎯 Setup completo em um único script!${NC}"
log_success "Todos os problemas resolvidos automaticamente!"

exit 0