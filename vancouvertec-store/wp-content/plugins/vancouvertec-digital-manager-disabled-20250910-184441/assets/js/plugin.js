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
