<?php
/**
 * Plugin Name: VancouverTec Digital Manager
 * Description: Sistema simples para produtos digitais VancouverTec
 * Version: 1.0.0
 * Author: VancouverTec
 * Text Domain: vancouvertec
 */

if (!defined('ABSPATH')) {
    exit;
}

class VancouverTec_Simple_Manager {
    
    public function __construct() {
        add_action('init', [$this, 'init']);
    }
    
    public function init() {
        // Verificar WooCommerce
        if (!class_exists('WooCommerce')) {
            return;
        }
        
        // Hooks básicos
        add_action('add_meta_boxes', [$this, 'add_specifications_meta_box']);
        add_action('save_post', [$this, 'save_specifications']);
        add_shortcode('vt_specifications', [$this, 'specifications_shortcode']);
    }
    
    public function add_specifications_meta_box() {
        add_meta_box(
            'vt_specifications',
            'Especificações VancouverTec',
            [$this, 'specifications_meta_box'],
            'product',
            'normal',
            'high'
        );
    }
    
    public function specifications_meta_box($post) {
        wp_nonce_field('vt_specs_nonce', 'vt_specs_nonce_field');
        
        $technology = get_post_meta($post->ID, '_vt_technology', true);
        $modules = get_post_meta($post->ID, '_vt_modules', true);
        $license = get_post_meta($post->ID, '_vt_license', true);
        $support = get_post_meta($post->ID, '_vt_support', true);
        ?>
        <table class="form-table">
            <tr>
                <th><label for="vt_technology">Tecnologia</label></th>
                <td><input type="text" id="vt_technology" name="vt_technology" value="<?php echo esc_attr($technology); ?>" class="regular-text" /></td>
            </tr>
            <tr>
                <th><label for="vt_modules">Módulos</label></th>
                <td><input type="text" id="vt_modules" name="vt_modules" value="<?php echo esc_attr($modules); ?>" class="regular-text" /></td>
            </tr>
            <tr>
                <th><label for="vt_license">Licença</label></th>
                <td><input type="text" id="vt_license" name="vt_license" value="<?php echo esc_attr($license); ?>" class="regular-text" /></td>
            </tr>
            <tr>
                <th><label for="vt_support">Suporte</label></th>
                <td><input type="text" id="vt_support" name="vt_support" value="<?php echo esc_attr($support); ?>" class="regular-text" /></td>
            </tr>
        </table>
        <?php
    }
    
    public function save_specifications($post_id) {
        if (!isset($_POST['vt_specs_nonce_field']) || 
            !wp_verify_nonce($_POST['vt_specs_nonce_field'], 'vt_specs_nonce')) {
            return;
        }
        
        if (!current_user_can('edit_post', $post_id)) {
            return;
        }
        
        $fields = ['vt_technology', 'vt_modules', 'vt_license', 'vt_support'];
        
        foreach ($fields as $field) {
            if (isset($_POST[$field])) {
                update_post_meta($post_id, '_' . $field, sanitize_text_field($_POST[$field]));
            }
        }
    }
    
    public function specifications_shortcode($atts) {
        $atts = shortcode_atts(['id' => get_the_ID()], $atts);
        
        $technology = get_post_meta($atts['id'], '_vt_technology', true);
        $modules = get_post_meta($atts['id'], '_vt_modules', true);
        $license = get_post_meta($atts['id'], '_vt_license', true);
        $support = get_post_meta($atts['id'], '_vt_support', true);
        
        ob_start();
        ?>
        <div class="vt-specifications">
            <h3>Especificações Técnicas</h3>
            <div class="vt-specs-grid">
                <?php if ($technology): ?>
                <div class="vt-spec-item">
                    <strong>🔧 Tecnologia:</strong> <?php echo esc_html($technology); ?>
                </div>
                <?php endif; ?>
                
                <?php if ($modules): ?>
                <div class="vt-spec-item">
                    <strong>📦 Módulos:</strong> <?php echo esc_html($modules); ?>
                </div>
                <?php endif; ?>
                
                <?php if ($license): ?>
                <div class="vt-spec-item">
                    <strong>📜 Licença:</strong> <?php echo esc_html($license); ?>
                </div>
                <?php endif; ?>
                
                <?php if ($support): ?>
                <div class="vt-spec-item">
                    <strong>🎯 Suporte:</strong> <?php echo esc_html($support); ?>
                </div>
                <?php endif; ?>
            </div>
        </div>
        <?php
        return ob_get_clean();
    }
}

new VancouverTec_Simple_Manager();
