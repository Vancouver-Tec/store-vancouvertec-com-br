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
