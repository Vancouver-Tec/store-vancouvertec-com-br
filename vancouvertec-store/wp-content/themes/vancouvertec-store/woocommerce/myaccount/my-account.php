<?php
/**
 * VancouverTec Store - My Account
 */

if (!defined('ABSPATH')) exit;

wc_print_notices(); ?>

<div class="vt-my-account">
    <div class="container">
        
        <div class="vt-account-header">
            <h1><?php esc_html_e('Minha Conta', 'vancouvertec'); ?></h1>
            <p class="vt-account-subtitle">
                <?php 
                $user = wp_get_current_user();
                printf(esc_html__('Bem-vindo, %s!', 'vancouvertec'), $user->display_name); 
                ?>
            </p>
        </div>

        <div class="vt-account-content">
            
            <div class="vt-account-navigation">
                <?php do_action('woocommerce_account_navigation'); ?>
            </div>

            <div class="vt-account-main">
                <div class="woocommerce-MyAccount-content">
                    <?php do_action('woocommerce_account_content'); ?>
                </div>
            </div>

        </div>

    </div>
</div>
