<?php
/**
 * VancouverTec Store - Custom PHP Router
 * Corrige URLs do WordPress admin para servidor built-in
 */

$request_uri = $_SERVER['REQUEST_URI'];
$parsed_url = parse_url($request_uri);
$path = $parsed_url['path'];

// Log para debug
error_log("Router VT: " . $request_uri);

// Redirecionar URLs do admin sem /wp-admin/
if (preg_match('/^\/([a-z-]+\.php)/', $path, $matches)) {
    $file = $matches[1];
    $admin_files = [
        'themes.php', 'plugins.php', 'options-general.php', 
        'users.php', 'tools.php', 'upload.php', 'edit.php',
        'post-new.php', 'edit-tags.php', 'nav-menus.php',
        'customize.php', 'widgets.php', 'options-writing.php',
        'options-reading.php', 'options-discussion.php',
        'options-media.php', 'options-permalink.php'
    ];
    
    if (in_array($file, $admin_files)) {
        $redirect_url = '/wp-admin/' . $file;
        if (!empty($parsed_url['query'])) {
            $redirect_url .= '?' . $parsed_url['query'];
        }
        
        header("Location: $redirect_url", true, 302);
        error_log("Router VT: Redirecionando $path para $redirect_url");
        exit;
    }
}

// Arquivos estáticos
if (preg_match('/\.(css|js|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$/', $path)) {
    $file_path = __DIR__ . $path;
    if (file_exists($file_path)) {
        $mime_types = [
            'css' => 'text/css',
            'js' => 'application/javascript',
            'png' => 'image/png',
            'jpg' => 'image/jpeg',
            'jpeg' => 'image/jpeg',
            'gif' => 'image/gif',
            'ico' => 'image/x-icon',
            'svg' => 'image/svg+xml',
            'woff' => 'font/woff',
            'woff2' => 'font/woff2',
            'ttf' => 'font/ttf',
            'eot' => 'application/vnd.ms-fontobject'
        ];
        
        $extension = pathinfo($file_path, PATHINFO_EXTENSION);
        if (isset($mime_types[$extension])) {
            header('Content-Type: ' . $mime_types[$extension]);
        }
        
        readfile($file_path);
        return false;
    }
}

// Verificar se é arquivo PHP válido
$file_path = __DIR__ . $path;
if ($path !== '/' && file_exists($file_path) && pathinfo($file_path, PATHINFO_EXTENSION) === 'php') {
    return false; // Deixar o PHP processar
}

// Tudo o mais vai para o WordPress
if (!file_exists(__DIR__ . '/index.php')) {
    http_response_code(404);
    echo '404 - WordPress index.php não encontrado';
    return false;
}

// Deixar WordPress processar
return false;
