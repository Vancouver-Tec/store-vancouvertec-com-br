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
