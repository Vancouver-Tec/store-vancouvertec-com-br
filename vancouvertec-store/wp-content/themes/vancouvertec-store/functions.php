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
    wp_enqueue_style('vt-variables', VT_THEME_URI . '/assets/css/variables.css', [], VT_THEME_VERSION);
    wp_enqueue_style('vt-front-page', VT_THEME_URI . '/assets/css/pages/front-page.css', ['vt-style'], VT_THEME_VERSION);
    wp_enqueue_style('vt-variables', VT_THEME_URI . '/assets/css/variables.css', [], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-home', VT_THEME_URI . '/assets/css/components/woocommerce-home.css', ['vt-front-page'], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-home-fixed', VT_THEME_URI . '/assets/css/components/woocommerce-home-fixed.css', ['vt-woo-home'], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-pages', VT_THEME_URI . '/assets/css/components/woocommerce-pages.css', ['vt-woo-home'], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-home-fixed', VT_THEME_URI . '/assets/css/components/woocommerce-home-fixed.css', ['vt-woo-home'], VT_THEME_VERSION);
    wp_enqueue_style('vt-header', VT_THEME_URI . '/assets/css/layouts/header.css', ['vt-style'], VT_THEME_VERSION);
    wp_enqueue_style('vt-variables', VT_THEME_URI . '/assets/css/variables.css', [], VT_THEME_VERSION);
    wp_enqueue_style('vt-front-page', VT_THEME_URI . '/assets/css/pages/front-page.css', ['vt-style'], VT_THEME_VERSION);
    wp_enqueue_style('vt-variables', VT_THEME_URI . '/assets/css/variables.css', [], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-home', VT_THEME_URI . '/assets/css/components/woocommerce-home.css', ['vt-front-page'], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-home-fixed', VT_THEME_URI . '/assets/css/components/woocommerce-home-fixed.css', ['vt-woo-home'], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-pages', VT_THEME_URI . '/assets/css/components/woocommerce-pages.css', ['vt-woo-home'], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-home-fixed', VT_THEME_URI . '/assets/css/components/woocommerce-home-fixed.css', ['vt-woo-home'], VT_THEME_VERSION);
    wp_enqueue_style('vt-header-botoes', VT_THEME_URI . '/assets/css/layouts/header-botoes-forcados.css', ['vt-header'], VT_THEME_VERSION);
    wp_enqueue_style('vt-footer', VT_THEME_URI . '/assets/css/layouts/footer.css', ['vt-header'], VT_THEME_VERSION);
    wp_enqueue_style('vt-header-botoes', VT_THEME_URI . '/assets/css/layouts/header-botoes-forcados.css', ['vt-header'], VT_THEME_VERSION);
    wp_enqueue_style('vt-responsive', VT_THEME_URI . '/assets/css/responsive.css', ['vt-footer'], VT_THEME_VERSION);
    wp_enqueue_style('vt-buttons', VT_THEME_URI . '/assets/css/components/buttons.css', ['vt-style'], VT_THEME_VERSION);
    wp_enqueue_style('vt-variables', VT_THEME_URI . '/assets/css/variables.css', [], VT_THEME_VERSION);
    wp_enqueue_style('vt-front-page', VT_THEME_URI . '/assets/css/pages/front-page.css', ['vt-style'], VT_THEME_VERSION);
    wp_enqueue_style('vt-variables', VT_THEME_URI . '/assets/css/variables.css', [], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-home', VT_THEME_URI . '/assets/css/components/woocommerce-home.css', ['vt-front-page'], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-home-fixed', VT_THEME_URI . '/assets/css/components/woocommerce-home-fixed.css', ['vt-woo-home'], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-pages', VT_THEME_URI . '/assets/css/components/woocommerce-pages.css', ['vt-woo-home'], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-home-fixed', VT_THEME_URI . '/assets/css/components/woocommerce-home-fixed.css', ['vt-woo-home'], VT_THEME_VERSION);
    wp_enqueue_style('vt-header', VT_THEME_URI . '/assets/css/layouts/header.css', ['vt-style'], VT_THEME_VERSION);
    wp_enqueue_style('vt-variables', VT_THEME_URI . '/assets/css/variables.css', [], VT_THEME_VERSION);
    wp_enqueue_style('vt-front-page', VT_THEME_URI . '/assets/css/pages/front-page.css', ['vt-style'], VT_THEME_VERSION);
    wp_enqueue_style('vt-variables', VT_THEME_URI . '/assets/css/variables.css', [], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-home', VT_THEME_URI . '/assets/css/components/woocommerce-home.css', ['vt-front-page'], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-home-fixed', VT_THEME_URI . '/assets/css/components/woocommerce-home-fixed.css', ['vt-woo-home'], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-pages', VT_THEME_URI . '/assets/css/components/woocommerce-pages.css', ['vt-woo-home'], VT_THEME_VERSION);
    wp_enqueue_style('vt-woo-home-fixed', VT_THEME_URI . '/assets/css/components/woocommerce-home-fixed.css', ['vt-woo-home'], VT_THEME_VERSION);
    wp_enqueue_style('vt-header-botoes', VT_THEME_URI . '/assets/css/layouts/header-botoes-forcados.css', ['vt-header'], VT_THEME_VERSION);
    wp_enqueue_style('vt-footer', VT_THEME_URI . '/assets/css/layouts/footer.css', ['vt-header'], VT_THEME_VERSION);
    wp_enqueue_style('vt-header-botoes', VT_THEME_URI . '/assets/css/layouts/header-botoes-forcados.css', ['vt-header'], VT_THEME_VERSION);
    wp_enqueue_style('vt-responsive', VT_THEME_URI . '/assets/css/responsive.css', ['vt-footer'], VT_THEME_VERSION);
    wp_enqueue_style('vt-hero', VT_THEME_URI . '/assets/css/layouts/hero.css', ['vt-buttons'], VT_THEME_VERSION);
    wp_enqueue_style('vt-products', VT_THEME_URI . '/assets/css/components/products.css', ['vt-hero'], VT_THEME_VERSION);
    wp_enqueue_style('vt-testimonials', VT_THEME_URI . '/assets/css/components/testimonials.css', ['vt-products'], VT_THEME_VERSION);
    wp_enqueue_style('vt-cta', VT_THEME_URI . '/assets/css/components/cta.css', ['vt-testimonials'], VT_THEME_VERSION);
    wp_enqueue_script('vt-main', VT_THEME_URI . '/assets/js/main.js', ['jquery'], VT_THEME_VERSION, true);
    wp_enqueue_script('vt-home-conversao', VT_THEME_URI . '/assets/js/home-conversao.js', ['jquery'], VT_THEME_VERSION, true);
    wp_enqueue_script('vt-header-mobile', VT_THEME_URI . '/assets/js/header-mobile.js', ['jquery'], VT_THEME_VERSION, true);
    wp_enqueue_script('vt-mobile', VT_THEME_URI . '/assets/js/mobile.js', ['vt-main'], VT_THEME_VERSION, true);
    wp_enqueue_script('vt-home-conversao', VT_THEME_URI . '/assets/js/home-conversao.js', ['jquery'], VT_THEME_VERSION, true);
    wp_enqueue_script('vt-header-mobile', VT_THEME_URI . '/assets/js/header-mobile.js', ['jquery'], VT_THEME_VERSION, true);
    
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

// ===== AJAX FUNCTIONS =====

// Contador do carrinho
function vt_get_cart_count() {
    check_ajax_referer('vt_nonce', 'nonce');
    
    if (class_exists('WooCommerce')) {
        $count = WC()->cart->get_cart_contents_count();
        wp_send_json_success($count);
    } else {
        wp_send_json_success(0);
    }
}
add_action('wp_ajax_vt_get_cart_count', 'vt_get_cart_count');
add_action('wp_ajax_nopriv_vt_get_cart_count', 'vt_get_cart_count');

// Atualizar fragmentos do carrinho
function vt_cart_fragments($fragments) {
    if (class_exists('WooCommerce')) {
        $count = WC()->cart->get_cart_contents_count();
        $fragments['.cart-count'] = '<span class="cart-count">' . $count . '</span>';
        $fragments['.mobile-count'] = '<span class="mobile-count">' . $count . '</span>';
    }
    return $fragments;
}
add_filter('woocommerce_add_to_cart_fragments', 'vt_cart_fragments');

// Enqueue do novo script
function vt_enqueue_header_buttons() {
    wp_enqueue_script(
        'vt-header-buttons', 
        VT_THEME_URI . '/assets/js/header-buttons.js', 
        ['jquery'], 
        VT_THEME_VERSION, 
        true
    );
}
add_action('wp_enqueue_scripts', 'vt_enqueue_header_buttons');

// ===== WOOCOMMERCE INTEGRATION =====

// Suporte ao WooCommerce
add_theme_support('woocommerce');
add_theme_support('wc-product-gallery-zoom');
add_theme_support('wc-product-gallery-lightbox');
add_theme_support('wc-product-gallery-slider');

// Enqueue WooCommerce styles
function vt_woocommerce_styles() {
    if (class_exists('WooCommerce')) {
        wp_enqueue_style('vt-woocommerce', VT_THEME_URI . '/assets/css/components/woocommerce.css', ['vt-style'], VT_THEME_VERSION);
    wp_enqueue_style('vt-variables', VT_THEME_URI . '/assets/css/variables.css', [], VT_THEME_VERSION);
        wp_enqueue_style('vt-woocommerce-templates', VT_THEME_URI . '/assets/css/components/woocommerce-templates.css', ['vt-woocommerce'], VT_THEME_VERSION);
    wp_enqueue_style('vt-woocommerce-templates-vt', VT_THEME_URI . '/assets/css/components/woocommerce-templates-vt.css', ['vt-woocommerce-templates'], VT_THEME_VERSION);
    wp_enqueue_style('vt-woocommerce-shop-templates', VT_THEME_URI . '/assets/css/components/woocommerce-shop-templates.css', ['vt-woocommerce-templates-vt'], VT_THEME_VERSION);
    }
}
add_action('wp_enqueue_scripts', 'vt_woocommerce_styles');

// Configurar produtos por página e colunas
function vt_woocommerce_loop_columns() { return 3; }
add_filter('loop_shop_columns', 'vt_woocommerce_loop_columns');

function vt_woocommerce_products_per_page() { return 12; }
add_filter('loop_shop_per_page', 'vt_woocommerce_products_per_page', 20);

// Remover breadcrumbs padrão WooCommerce (usar do tema)
remove_action('woocommerce_before_main_content', 'woocommerce_breadcrumb', 20);

// Configurar páginas WooCommerce automaticamente
function vt_setup_woocommerce_pages() {
    if (class_exists('WooCommerce')) {
        $pages = array(
            'woocommerce_shop_page_id' => 'Shop',
            'woocommerce_cart_page_id' => 'Carrinho',
            'woocommerce_checkout_page_id' => 'Checkout',
            'woocommerce_myaccount_page_id' => 'Minha Conta'
        );

        foreach ($pages as $option => $title) {
            $page_id = get_option($option);
            if (!$page_id || !get_post($page_id)) {
                $page_id = wp_insert_post(array(
                    'post_title' => $title,
                    'post_content' => '',
                    'post_status' => 'publish',
                    'post_type' => 'page',
                    'post_name' => sanitize_title($title)
                ));
                update_option($option, $page_id);
            }
        }
    }
}
add_action('init', 'vt_setup_woocommerce_pages');

// ===== FORÇAR TEMPLATES WOOCOMMERCE =====

// Forçar template para página Cart
function vt_disable_elementor_woocommerce($post_id) {
    if (is_cart() || is_checkout() || is_account_page() || is_shop()) {
        return false;
    }
    return $post_id;
}
add_filter('elementor/frontend/builder_content_display', 'vt_disable_elementor_woocommerce');

// Remover conteúdo de página para WooCommerce
function vt_remove_woocommerce_page_content() {
    if (is_cart() || is_checkout() || is_account_page()) {
        remove_filter('the_content', 'wpautop');
        add_filter('the_content', function($content) {
            if (is_cart() || is_checkout() || is_account_page()) {
                return '';
            }
            return $content;
        }, 999);
    }
}
add_action('wp', 'vt_remove_woocommerce_page_content');

// Debug: Verificar qual template está sendo usado
function vt_debug_template() {
    if (current_user_can('manage_options') && isset($_GET['debug_template'])) {
        global $template;
        echo '<div style="background: red; color: white; padding: 10px; position: fixed; top: 0; left: 0; z-index: 9999;">Template: ' . $template . '</div>';
    }
}
add_action('wp_footer', 'vt_debug_template');

// ===== SHORTCODES CUSTOMIZADOS =====

// Shortcode Cart customizado
function vt_custom_cart_shortcode() {
    if (!function_exists('WC')) {
        return '<p>WooCommerce não está ativo.</p>';
    }
    
    ob_start();
    
    if (WC()->cart->is_empty()) {
        echo '<div class="vt-empty-cart">';
        echo '<h3>Seu carrinho está vazio</h3>';
        echo '<p>Adicione alguns produtos incríveis ao seu carrinho!</p>';
        echo '<a href="' . get_permalink(wc_get_page_id('shop')) . '" class="button">Ir às Compras</a>';
        echo '</div>';
    } else {
        // Incluir template do cart
        $template = locate_template('woocommerce/cart/cart.php');
        if ($template) {
            include $template;
        } else {
            wc_get_template('cart/cart.php');
        }
    }
    
    return ob_get_clean();
}
add_shortcode('vt_cart', 'vt_custom_cart_shortcode');

// Shortcode Checkout customizado
function vt_custom_checkout_shortcode() {
    if (!function_exists('WC')) {
        return '<p>WooCommerce não está ativo.</p>';
    }
    
    ob_start();
    
    // Incluir template do checkout
    $template = locate_template('woocommerce/checkout/form-checkout.php');
    if ($template) {
        global $woocommerce;
        $checkout = WC()->checkout();
        if (!$checkout) {
            return '<p>Erro no checkout.</p>';
        }
        include $template;
    } else {
        echo do_shortcode('[woocommerce_checkout]');
    }
    
    return ob_get_clean();
}
add_shortcode('vt_checkout', 'vt_custom_checkout_shortcode');


// ===== WOOCOMMERCE VANCOUVERTEC COMPLETE - PARTE 1 =====

/**
 * Carregar CSS completo para páginas WooCommerce
 */
function vt_woocommerce_complete_styles() {
    if (is_woocommerce() || is_cart() || is_checkout() || is_account_page()) {
        wp_enqueue_style(
            'vt-woocommerce-complete', 
            VT_THEME_URI . '/assets/css/components/woocommerce-vancouvertec-complete.css', 
            [], 
            VT_THEME_VERSION . '-' . time(),
            'all'
        );
        
        // CSS inline crítico
        wp_add_inline_style('vt-woocommerce-complete', '
            body.woocommerce,
            body.woocommerce-page {
                background: #F3F4F6 !important;
                min-height: 100vh !important;
            }
            .site-content {
                padding-top: 2rem !important;
                padding-bottom: 2rem !important;
            }
        ');
    }
}
add_action('wp_enqueue_scripts', 'vt_woocommerce_complete_styles', 999);

/**
 * Adicionar classes específicas ao body
 */
function vt_woocommerce_body_classes($classes) {
    if (is_woocommerce() || is_cart() || is_checkout() || is_account_page()) {
        $classes[] = 'vt-woocommerce-complete';
        $classes[] = 'vt-layout-vancouvertec';
        
        if (is_cart()) {
            $classes[] = 'vt-cart-page';
        }
        if (is_checkout()) {
            $classes[] = 'vt-checkout-page';
        }
        if (is_account_page()) {
            $classes[] = 'vt-account-page';
        }
    }
    return $classes;
}
add_filter('body_class', 'vt_woocommerce_body_classes');

/**
 * Customizar mensagens WooCommerce
 */
function vt_woocommerce_custom_messages() {
    // Mensagem carrinho vazio
    add_filter('wc_empty_cart_message', function($message) {
        return '<div class="vt-empty-cart-message">🛒 <strong>Seu carrinho está vazio!</strong><br>Que tal adicionar alguns produtos incríveis?</div>';
    });
    
    // Mensagem produto adicionado
    add_filter('wc_add_to_cart_message_html', function($message, $products) {
        return '<div class="vt-cart-success">✅ <strong>Produto adicionado com sucesso!</strong> ' . $message . '</div>';
    }, 10, 2);
}
add_action('init', 'vt_woocommerce_custom_messages');

/**
 * Customizar títulos das páginas
 */
function vt_woocommerce_custom_page_titles($title) {
    if (is_cart()) {
        return '🛒 Carrinho de Compras - VancouverTec';
    }
    if (is_checkout()) {
        return '💳 Finalizar Compra - VancouverTec';
    }
    if (is_account_page()) {
        return '👤 Minha Conta - VancouverTec';
    }
    return $title;
}
add_filter('woocommerce_page_title', 'vt_woocommerce_custom_page_titles');

/**
 * Adicionar JavaScript para melhorias UX
 */
function vt_woocommerce_scripts() {
    if (is_woocommerce() || is_cart() || is_checkout() || is_account_page()) {
        wp_add_inline_script('jquery', '
            jQuery(document).ready(function($) {
                // Smooth focus nos campos
                $(".form-row input, .form-row select, .form-row textarea").on("focus", function() {
                    $(this).closest(".form-row").addClass("focused");
                }).on("blur", function() {
                    $(this).closest(".form-row").removeClass("focused");
                });
                
                // Loading nos botões
                $(".button").on("click", function() {
                    if (!$(this).hasClass("no-loading")) {
                        $(this).addClass("loading").append(" <span class=\'spinner\'>⏳</span>");
                    }
                });
            });
        ');
    }
}
add_action('wp_enqueue_scripts', 'vt_woocommerce_scripts');

/**
 * Adicionar botão Wishlist aos produtos
 */
function vt_add_wishlist_button() {
    global $product;
    if (!$product) return;
    
    $product_id = $product->get_id();
    $product_name = $product->get_name();
    $product_image = get_the_post_thumbnail_url($product_id, 'medium');
    $product_price = $product->get_price_html();
    $product_url = get_permalink($product_id);
    
    echo '<button class="vt-wishlist-btn" onclick="toggleWishlist(' . $product_id . ', \'' . esc_js($product_name) . '\', \'' . esc_url($product_image) . '\', \'' . esc_js($product_price) . '\', \'' . esc_url($product_url) . '\')">';
    echo '<span class="heart-icon">🤍</span>';
    echo '<span class="wishlist-text">Favoritar</span>';
    echo '</button>';
}
add_action('woocommerce_single_product_summary', 'vt_add_wishlist_button', 35);

/**
 * Adicionar JavaScript Wishlist
 */
function vt_wishlist_scripts() {
    if (is_woocommerce() || is_shop() || is_product() || is_page_template('page-wishlist.php')) {
        wp_add_inline_script('jquery', '
            window.toggleWishlist = function(id, name, image, price, url) {
                let wishlist = JSON.parse(localStorage.getItem("vt_wishlist") || "[]");
                const existingIndex = wishlist.findIndex(item => item.id === id);
                const btn = event.target.closest(".vt-wishlist-btn");
                const heartIcon = btn.querySelector(".heart-icon");
                const textEl = btn.querySelector(".wishlist-text");
                
                if (existingIndex > -1) {
                    // Remover dos favoritos
                    wishlist.splice(existingIndex, 1);
                    btn.classList.remove("active");
                    heartIcon.textContent = "🤍";
                    textEl.textContent = "Favoritar";
                } else {
                    // Adicionar aos favoritos
                    wishlist.push({id, name, image, price, url});
                    btn.classList.add("active");
                    heartIcon.textContent = "❤️";
                    textEl.textContent = "Favoritado";
                }
                
                localStorage.setItem("vt_wishlist", JSON.stringify(wishlist));
                updateWishlistCount();
            }
            
            function updateWishlistCount() {
                const wishlist = JSON.parse(localStorage.getItem("vt_wishlist") || "[]");
                jQuery(".wishlist-count").text(wishlist.length).toggle(wishlist.length > 0);
            }
            
            jQuery(document).ready(function($) {
                // Inicializar estado dos botões
                const wishlist = JSON.parse(localStorage.getItem("vt_wishlist") || "[]");
                
                $(".vt-wishlist-btn").each(function() {
                    const btn = $(this);
                    const onclick = btn.attr("onclick");
                    if (onclick) {
                        const match = onclick.match(/toggleWishlist\((\d+)/);
                        if (match) {
                            const productId = parseInt(match[1]);
                            const isInWishlist = wishlist.some(item => item.id === productId);
                            
                            if (isInWishlist) {
                                btn.addClass("active");
                                btn.find(".heart-icon").text("❤️");
                                btn.find(".wishlist-text").text("Favoritado");
                            }
                        }
                    }
                });
                
                updateWishlistCount();
            });
        ');
    }
}
add_action('wp_enqueue_scripts', 'vt_wishlist_scripts');
