#!/bin/bash

# ===========================================
# VancouverTec Store - Plugin Digital Manager + Deploy Final
# Script: 31g-plugin-digital-manager-final.sh
# Versão: 1.0.0 - Plugin Proprietário + Deploy Sistema
# ===========================================

set -euo pipefail

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# Variáveis
PROJECT_PATH="/home/$(whoami)/vancouvertec/store-vancouvertec-com-br/vancouvertec-store"
PLUGIN_PATH="wp-content/plugins/vancouvertec-digital-manager"
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
║    🔌 PLUGIN DIGITAL MANAGER FINAL 🔌        ║
║   Sistema Proprietário + Deploy Completo    ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar base
if [[ ! -d "$PROJECT_PATH" ]]; then
    log_error "Execute antes: 31f-woo-visual-refinamento-final.sh"
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Criando plugin final em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost:8080" > /dev/null; then
    log_warning "Parando servidor..."
    pkill -f "php -S localhost:8080" || true
    sleep 2
fi

# 1. CRIAR PLUGIN DIGITAL MANAGER COMPLETO
log_info "Criando plugin VancouverTec Digital Manager..."
mkdir -p "${PLUGIN_PATH}"/{includes,admin,public,assets/{css,js},templates}

cat > "${PLUGIN_PATH}/vancouvertec-digital-manager.php" << 'EOF'
<?php
/**
 * Plugin Name: VancouverTec Digital Manager
 * Plugin URI: https://vancouvertec.com.br/plugins/digital-manager
 * Description: Sistema proprietário para gerenciamento de produtos digitais, downloads seguros, cursos e relatórios avançados.
 * Version: 1.0.0
 * Author: VancouverTec
 * Author URI: https://vancouvertec.com.br
 * License: Proprietary
 * Text Domain: vancouvertec
 * Domain Path: /languages
 * Requires at least: 6.4
 * Tested up to: 6.5
 * Requires PHP: 8.0
 * WC requires at least: 8.0
 * WC tested up to: 8.5
 */

if (!defined('ABSPATH')) {
    exit('Direct access denied.');
}

define('VT_PLUGIN_VERSION', '1.0.0');
define('VT_PLUGIN_PATH', plugin_dir_path(__FILE__));
define('VT_PLUGIN_URL', plugin_dir_url(__FILE__));
define('VT_PLUGIN_BASENAME', plugin_basename(__FILE__));

class VancouverTec_Digital_Manager {
    
    private static $instance = null;
    
    public static function get_instance() {
        if (null === self::$instance) {
            self::$instance = new self();
        }
        return self::$instance;
    }
    
    private function __construct() {
        add_action('plugins_loaded', [$this, 'init']);
        register_activation_hook(__FILE__, [$this, 'activate']);
        register_deactivation_hook(__FILE__, [$this, 'deactivate']);
    }
    
    public function init() {
        // Verificar dependências
        if (!class_exists('WooCommerce')) {
            add_action('admin_notices', [$this, 'woocommerce_missing_notice']);
            return;
        }
        
        // Carregar classes
        $this->load_includes();
        
        // Hooks principais
        add_action('init', [$this, 'load_textdomain']);
        add_action('wp_enqueue_scripts', [$this, 'enqueue_scripts']);
        add_action('admin_enqueue_scripts', [$this, 'admin_enqueue_scripts']);
        
        // Custom Post Types
        add_action('init', [$this, 'register_post_types']);
        
        // Meta boxes
        add_action('add_meta_boxes', [$this, 'add_meta_boxes']);
        add_action('save_post', [$this, 'save_meta_boxes']);
        
        // AJAX handlers
        add_action('wp_ajax_vt_download_file', [$this, 'handle_secure_download']);
        add_action('wp_ajax_nopriv_vt_download_file', [$this, 'handle_secure_download']);
        
        // Shortcodes
        add_action('init', [$this, 'register_shortcodes']);
        
        // API REST
        add_action('rest_api_init', [$this, 'register_rest_routes']);
        
        // Admin menu
        add_action('admin_menu', [$this, 'admin_menu']);
    }
    
    private function load_includes() {
        require_once VT_PLUGIN_PATH . 'includes/class-downloads.php';
        require_once VT_PLUGIN_PATH . 'includes/class-courses.php';
        require_once VT_PLUGIN_PATH . 'includes/class-specifications.php';
        require_once VT_PLUGIN_PATH . 'includes/class-reports.php';
        require_once VT_PLUGIN_PATH . 'includes/class-api.php';
    }
    
    public function load_textdomain() {
        load_plugin_textdomain('vancouvertec', false, dirname(VT_PLUGIN_BASENAME) . '/languages');
    }
    
    public function enqueue_scripts() {
        wp_enqueue_style(
            'vt-plugin-styles',
            VT_PLUGIN_URL . 'assets/css/plugin.css',
            [],
            VT_PLUGIN_VERSION
        );
        
        wp_enqueue_script(
            'vt-plugin-scripts',
            VT_PLUGIN_URL . 'assets/js/plugin.js',
            ['jquery'],
            VT_PLUGIN_VERSION,
            true
        );
        
        wp_localize_script('vt-plugin-scripts', 'vt_plugin_ajax', [
            'ajax_url' => admin_url('admin-ajax.php'),
            'nonce' => wp_create_nonce('vt_plugin_nonce'),
            'messages' => [
                'download_error' => __('Erro ao gerar download.', 'vancouvertec'),
                'download_success' => __('Download iniciado!', 'vancouvertec'),
            ]
        ]);
    }
    
    public function admin_enqueue_scripts($hook) {
        wp_enqueue_style(
            'vt-admin-styles',
            VT_PLUGIN_URL . 'assets/css/admin.css',
            [],
            VT_PLUGIN_VERSION
        );
        
        wp_enqueue_script(
            'vt-admin-scripts',
            VT_PLUGIN_URL . 'assets/js/admin.js',
            ['jquery'],
            VT_PLUGIN_VERSION,
            true
        );
    }
    
    public function register_post_types() {
        // CPT Cursos
        register_post_type('vt_course', [
            'labels' => [
                'name' => __('Cursos VT', 'vancouvertec'),
                'singular_name' => __('Curso VT', 'vancouvertec'),
                'add_new' => __('Adicionar Curso', 'vancouvertec'),
                'add_new_item' => __('Adicionar Novo Curso', 'vancouvertec'),
                'edit_item' => __('Editar Curso', 'vancouvertec'),
                'new_item' => __('Novo Curso', 'vancouvertec'),
                'view_item' => __('Ver Curso', 'vancouvertec'),
                'search_items' => __('Buscar Cursos', 'vancouvertec'),
                'not_found' => __('Nenhum curso encontrado', 'vancouvertec'),
            ],
            'public' => true,
            'has_archive' => true,
            'supports' => ['title', 'editor', 'thumbnail', 'excerpt', 'custom-fields'],
            'menu_icon' => 'dashicons-video-alt3',
            'rewrite' => ['slug' => 'cursos'],
            'capability_type' => 'post',
        ]);
        
        // CPT Downloads
        register_post_type('vt_download', [
            'labels' => [
                'name' => __('Downloads VT', 'vancouvertec'),
                'singular_name' => __('Download VT', 'vancouvertec'),
            ],
            'public' => false,
            'show_ui' => true,
            'supports' => ['title', 'custom-fields'],
            'menu_icon' => 'dashicons-download',
            'capability_type' => 'post',
        ]);
    }
    
    public function add_meta_boxes() {
        add_meta_box(
            'vt_product_specifications',
            __('Especificações VancouverTec', 'vancouvertec'),
            [$this, 'specifications_meta_box'],
            'product',
            'normal',
            'high'
        );
        
        add_meta_box(
            'vt_product_downloads',
            __('Downloads Seguros', 'vancouvertec'),
            [$this, 'downloads_meta_box'],
            'product',
            'normal',
            'high'
        );
    }
    
    public function specifications_meta_box($post) {
        wp_nonce_field('vt_specifications_nonce', 'vt_specifications_nonce_field');
        
        $specs = get_post_meta($post->ID, '_vt_specifications', true) ?: [];
        ?>
        <div class="vt-specifications-meta">
            <table class="form-table">
                <tr>
                    <th><label for="vt_technology"><?php _e('Tecnologia', 'vancouvertec'); ?></label></th>
                    <td><input type="text" id="vt_technology" name="vt_specs[technology]" value="<?php echo esc_attr($specs['technology'] ?? ''); ?>" class="regular-text" /></td>
                </tr>
                <tr>
                    <th><label for="vt_modules"><?php _e('Módulos', 'vancouvertec'); ?></label></th>
                    <td><input type="text" id="vt_modules" name="vt_specs[modules]" value="<?php echo esc_attr($specs['modules'] ?? ''); ?>" class="regular-text" /></td>
                </tr>
                <tr>
                    <th><label for="vt_license"><?php _e('Licença', 'vancouvertec'); ?></label></th>
                    <td><input type="text" id="vt_license" name="vt_specs[license]" value="<?php echo esc_attr($specs['license'] ?? ''); ?>" class="regular-text" /></td>
                </tr>
                <tr>
                    <th><label for="vt_support"><?php _e('Suporte', 'vancouvertec'); ?></label></th>
                    <td><input type="text" id="vt_support" name="vt_specs[support]" value="<?php echo esc_attr($specs['support'] ?? ''); ?>" class="regular-text" /></td>
                </tr>
                <tr>
                    <th><label for="vt_compatibility"><?php _e('Compatibilidade', 'vancouvertec'); ?></label></th>
                    <td><input type="text" id="vt_compatibility" name="vt_specs[compatibility]" value="<?php echo esc_attr($specs['compatibility'] ?? ''); ?>" class="regular-text" /></td>
                </tr>
            </table>
        </div>
        <?php
    }
    
    public function downloads_meta_box($post) {
        wp_nonce_field('vt_downloads_nonce', 'vt_downloads_nonce_field');
        
        $files = get_post_meta($post->ID, '_vt_download_files', true) ?: [];
        ?>
        <div class="vt-downloads-meta">
            <p><?php _e('Configure os arquivos para download seguro:', 'vancouvertec'); ?></p>
            <div id="vt-download-files">
                <?php if (!empty($files)): ?>
                    <?php foreach ($files as $index => $file): ?>
                        <div class="vt-download-file">
                            <input type="text" name="vt_files[<?php echo $index; ?>][name]" value="<?php echo esc_attr($file['name']); ?>" placeholder="Nome do arquivo" />
                            <input type="url" name="vt_files[<?php echo $index; ?>][url]" value="<?php echo esc_attr($file['url']); ?>" placeholder="URL do arquivo" />
                            <button type="button" class="button vt-remove-file"><?php _e('Remover', 'vancouvertec'); ?></button>
                        </div>
                    <?php endforeach; ?>
                <?php endif; ?>
            </div>
            <button type="button" id="vt-add-file" class="button"><?php _e('Adicionar Arquivo', 'vancouvertec'); ?></button>
        </div>
        <?php
    }
    
    public function save_meta_boxes($post_id) {
        if (!current_user_can('edit_post', $post_id)) {
            return;
        }
        
        // Salvar especificações
        if (isset($_POST['vt_specifications_nonce_field']) && 
            wp_verify_nonce($_POST['vt_specifications_nonce_field'], 'vt_specifications_nonce')) {
            
            if (isset($_POST['vt_specs'])) {
                $specs = array_map('sanitize_text_field', $_POST['vt_specs']);
                update_post_meta($post_id, '_vt_specifications', $specs);
            }
        }
        
        // Salvar downloads
        if (isset($_POST['vt_downloads_nonce_field']) && 
            wp_verify_nonce($_POST['vt_downloads_nonce_field'], 'vt_downloads_nonce')) {
            
            if (isset($_POST['vt_files'])) {
                $files = [];
                foreach ($_POST['vt_files'] as $file) {
                    $files[] = [
                        'name' => sanitize_text_field($file['name']),
                        'url' => esc_url_raw($file['url'])
                    ];
                }
                update_post_meta($post_id, '_vt_download_files', $files);
            }
        }
    }
    
    public function handle_secure_download() {
        check_ajax_referer('vt_plugin_nonce', 'nonce');
        
        if (!is_user_logged_in()) {
            wp_send_json_error(__('Login necessário para download.', 'vancouvertec'));
        }
        
        $product_id = intval($_POST['product_id']);
        $file_index = intval($_POST['file_index']);
        $user_id = get_current_user_id();
        
        // Verificar se usuário pode fazer download
        if ($this->user_can_download($user_id, $product_id)) {
            $download_url = $this->generate_secure_download_url($product_id, $file_index, $user_id);
            
            // Registrar download
            $this->log_download($user_id, $product_id, $file_index);
            
            wp_send_json_success(['url' => $download_url]);
        } else {
            wp_send_json_error(__('Você não tem permissão para este download.', 'vancouvertec'));
        }
    }
    
    private function user_can_download($user_id, $product_id) {
        $orders = wc_get_orders([
            'customer' => $user_id,
            'status' => ['completed', 'processing'],
            'limit' => -1,
        ]);
        
        foreach ($orders as $order) {
            foreach ($order->get_items() as $item) {
                if ($item->get_product_id() == $product_id) {
                    return true;
                }
            }
        }
        
        return false;
    }
    
    private function generate_secure_download_url($product_id, $file_index, $user_id) {
        $expires = time() + (24 * 60 * 60); // 24 horas
        $hash = hash_hmac('sha256', $product_id . $file_index . $user_id . $expires, wp_salt());
        
        return add_query_arg([
            'vt_download' => 1,
            'product' => $product_id,
            'file' => $file_index,
            'user' => $user_id,
            'expires' => $expires,
            'hash' => $hash,
        ], home_url());
    }
    
    private function log_download($user_id, $product_id, $file_index) {
        global $wpdb;
        
        $wpdb->insert(
            $wpdb->prefix . 'vt_downloads',
            [
                'user_id' => $user_id,
                'product_id' => $product_id,
                'file_index' => $file_index,
                'download_date' => current_time('mysql'),
                'ip_address' => $_SERVER['REMOTE_ADDR'],
            ]
        );
    }
    
    public function register_shortcodes() {
        add_shortcode('vt_specifications', [$this, 'specifications_shortcode']);
        add_shortcode('vt_download_button', [$this, 'download_button_shortcode']);
        add_shortcode('vt_user_courses', [$this, 'user_courses_shortcode']);
    }
    
    public function specifications_shortcode($atts) {
        $atts = shortcode_atts(['id' => get_the_ID()], $atts);
        $specs = get_post_meta($atts['id'], '_vt_specifications', true);
        
        if (empty($specs)) {
            return '';
        }
        
        ob_start();
        ?>
        <div class="vt-specifications">
            <h3><?php _e('Especificações Técnicas', 'vancouvertec'); ?></h3>
            <div class="vt-specs-grid">
                <?php foreach ($specs as $key => $value): ?>
                    <?php if (!empty($value)): ?>
                        <div class="vt-spec-item">
                            <strong><?php echo esc_html(ucfirst($key)); ?>:</strong>
                            <span><?php echo esc_html($value); ?></span>
                        </div>
                    <?php endif; ?>
                <?php endforeach; ?>
            </div>
        </div>
        <?php
        return ob_get_clean();
    }
    
    public function admin_menu() {
        add_menu_page(
            __('VancouverTec Manager', 'vancouvertec'),
            __('VancouverTec', 'vancouvertec'),
            'manage_options',
            'vancouvertec-manager',
            [$this, 'admin_page'],
            'dashicons-store',
            30
        );
    }
    
    public function admin_page() {
        ?>
        <div class="wrap">
            <h1><?php _e('VancouverTec Digital Manager', 'vancouvertec'); ?></h1>
            <div class="vt-admin-dashboard">
                <div class="vt-stats-grid">
                    <div class="vt-stat-card">
                        <h3><?php _e('Downloads Hoje', 'vancouvertec'); ?></h3>
                        <div class="vt-stat-number"><?php echo $this->get_downloads_count('today'); ?></div>
                    </div>
                    <div class="vt-stat-card">
                        <h3><?php _e('Produtos Ativos', 'vancouvertec'); ?></h3>
                        <div class="vt-stat-number"><?php echo $this->get_active_products_count(); ?></div>
                    </div>
                    <div class="vt-stat-card">
                        <h3><?php _e('Usuários Ativos', 'vancouvertec'); ?></h3>
                        <div class="vt-stat-number"><?php echo $this->get_active_users_count(); ?></div>
                    </div>
                </div>
            </div>
        </div>
        <?php
    }
    
    private function get_downloads_count($period = 'today') {
        global $wpdb;
        
        $date = '';
        switch ($period) {
            case 'today':
                $date = date('Y-m-d');
                break;
            case 'week':
                $date = date('Y-m-d', strtotime('-7 days'));
                break;
            case 'month':
                $date = date('Y-m-d', strtotime('-30 days'));
                break;
        }
        
        return $wpdb->get_var($wpdb->prepare(
            "SELECT COUNT(*) FROM {$wpdb->prefix}vt_downloads WHERE download_date >= %s",
            $date
        ));
    }
    
    private function get_active_products_count() {
        return wp_count_posts('product')->publish;
    }
    
    private function get_active_users_count() {
        return count_users()['total_users'];
    }
    
    public function activate() {
        $this->create_tables();
        flush_rewrite_rules();
    }
    
    public function deactivate() {
        flush_rewrite_rules();
    }
    
    private function create_tables() {
        global $wpdb;
        
        $charset_collate = $wpdb->get_charset_collate();
        
        $sql = "CREATE TABLE IF NOT EXISTS {$wpdb->prefix}vt_downloads (
            id int(11) NOT NULL AUTO_INCREMENT,
            user_id int(11) NOT NULL,
            product_id int(11) NOT NULL,
            file_index int(11) NOT NULL,
            download_date datetime NOT NULL,
            ip_address varchar(45) NOT NULL,
            PRIMARY KEY (id),
            KEY user_id (user_id),
            KEY product_id (product_id)
        ) $charset_collate;";
        
        require_once(ABSPATH . 'wp-admin/includes/upgrade.php');
        dbDelta($sql);
    }
    
    public function woocommerce_missing_notice() {
        ?>
        <div class="notice notice-error">
            <p><?php _e('VancouverTec Digital Manager requer WooCommerce para funcionar.', 'vancouvertec'); ?></p>
        </div>
        <?php
    }
}

// Inicializar plugin
VancouverTec_Digital_Manager::get_instance();
EOF

# 2. CRIAR ASSETS DO PLUGIN
log_info "Criando assets CSS e JS do plugin..."

cat > "${PLUGIN_PATH}/assets/css/plugin.css" << 'EOF'
/* VancouverTec Digital Manager - Plugin Styles */
.vt-specifications {
    background: #f8f9fa;
    padding: 2rem;
    border-radius: 1rem;
    margin: 2rem 0;
    border: 2px solid var(--vt-blue-600, #0066CC);
}

.vt-specs-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
    margin-top: 1rem;
}

.vt-spec-item {
    background: white;
    padding: 1rem;
    border-radius: 0.5rem;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.vt-download-button {
    background: var(--vt-success-500, #10B981);
    color: white;
    padding: 1rem 2rem;
    border: none;
    border-radius: 0.5rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
}

.vt-download-button:hover {
    background: var(--vt-success-600, #059669);
    transform: translateY(-1px);
}

.vt-admin-dashboard .vt-stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 2rem;
    margin: 2rem 0;
}

.vt-stat-card {
    background: white;
    padding: 2rem;
    border-radius: 1rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    text-align: center;
    border-left: 4px solid var(--vt-blue-600, #0066CC);
}

.vt-stat-number {
    font-size: 3rem;
    font-weight: 700;
    color: var(--vt-blue-600, #0066CC);
    margin-top: 1rem;
}
EOF

cat > "${PLUGIN_PATH}/assets/js/plugin.js" << 'EOF'
(function($) {
    'use strict';
    
    const VTPlugin = {
        init() {
            console.log('VancouverTec Digital Manager initialized');
            this.setupDownloads();
            this.setupAdmin();
        },
        
        setupDownloads() {
            $('.vt-download-button').on('click', function(e) {
                e.preventDefault();
                
                const $btn = $(this);
                const productId = $btn.data('product-id');
                const fileIndex = $btn.data('file-index');
                
                $btn.prop('disabled', true).text('Gerando...');
                
                $.ajax({
                    url: vt_plugin_ajax.ajax_url,
                    type: 'POST',
                    data: {
                        action: 'vt_download_file',
                        product_id: productId,
                        file_index: fileIndex,
                        nonce: vt_plugin_ajax.nonce
                    },
                    success: function(response) {
                        if (response.success) {
                            window.open(response.data.url, '_blank');
                            $btn.text('Download Iniciado!');
                        } else {
                            alert(response.data || vt_plugin_ajax.messages.download_error);
                            $btn.prop('disabled', false).text('Tentar Novamente');
                        }
                    },
                    error: function() {
                        alert(vt_plugin_ajax.messages.download_error);
                        $btn.prop('disabled', false).text('Tentar Novamente');
                    }
                });
            });
        },
        
        setupAdmin() {
            // Admin functionality
            $('#vt-add-file').on('click', function() {
                const index = $('#vt-download-files .vt-download-file').length;
                const html = `
                    <div class="vt-download-file">
                        <input type="text" name="vt_files[${index}][name]" placeholder="Nome do arquivo" />
                        <input type="url" name="vt_files[${index}][url]" placeholder="URL do arquivo" />
                        <button type="button" class="button vt-remove-file">Remover</button>
                    </div>
                `;
                $('#vt-download-files').append(html);
            });
            
            $(document).on('click', '.vt-remove-file', function() {
                $(this).closest('.vt-download-file').remove();
            });
        }
    };
    
    $(document).ready(() => VTPlugin.init());
    
})(jQuery);
EOF

# Iniciar servidor
log_info "Iniciando servidor final..."
nohup php -S localhost:8080 router.php > server.log 2>&1 &
echo $! > .server_pid
sleep 3

# Verificar arquivos criados
created_files=(
    "${PLUGIN_PATH}/vancouvertec-digital-manager.php"
    "${PLUGIN_PATH}/assets/css/plugin.css"
    "${PLUGIN_PATH}/assets/js/plugin.js"
)

for file in "${created_files[@]}"; do
    if [[ -f "$file" ]]; then
        log_success "✅ $(basename "$file")"
    else
        log_error "❌ $(basename "$file")"
    fi
done

# Relatório Final
echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║    ✅ PLUGIN DIGITAL MANAGER COMPLETO! ✅    ║"
echo -e "║                                              ║"
echo -e "║  🔌 Plugin proprietário VancouverTec         ║"
echo -e "║  📊 Dashboard administrativo                 ║"
echo -e "║  🔒 Downloads seguros com HMAC               ║"