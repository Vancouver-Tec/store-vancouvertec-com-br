#!/bin/bash

# ===========================================
# VancouverTec Store - Templates Específicos
# Script: 03c-tema-templates-especificos.sh
# Versão: 1.0.0 - Templates WordPress Completos
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
THEME_PATH="wp-content/themes/vancouvertec-store"
PROJECT_PATH="/home/$(whoami)/vancouvertec/store-vancouvertec-com-br/vancouvertec-store"

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Banner
echo -e "${PURPLE}"
cat << "EOF"
╔══════════════════════════════════════════════╗
║      📄 Templates WordPress Específicos 📄   ║
║    single.php | page.php | sidebar.php      ║
╚══════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar se tema existe
if [[ ! -d "$PROJECT_PATH/$THEME_PATH" ]]; then
    log_error "Tema não encontrado! Execute os scripts anteriores primeiro."
    exit 1
fi

cd "$PROJECT_PATH"
log_info "Criando templates específicos em: $(pwd)"

# Parar servidor
if pgrep -f "php -S localhost" > /dev/null; then
    log_warning "Parando servidor para atualizações..."
    pkill -f "php -S localhost" || true
    sleep 2
fi

# Criar single.php (posts individuais)
log_info "Criando single.php..."
cat > "$THEME_PATH/single.php" << 'EOF'
<?php
/**
 * Single Post Template
 * 
 * @package VancouverTec_Store
 */

get_header(); ?>

<div class="container">
    <div class="content-area">
        <main id="main" class="site-main">
            <?php while (have_posts()) : the_post(); ?>
                <article id="post-<?php the_ID(); ?>" <?php post_class('single-post'); ?>>
                    
                    <!-- Post Header -->
                    <header class="entry-header">
                        <?php if (has_post_thumbnail()) : ?>
                            <div class="post-thumbnail">
                                <?php the_post_thumbnail('vt-hero', ['loading' => 'eager']); ?>
                            </div>
                        <?php endif; ?>
                        
                        <div class="entry-meta">
                            <div class="meta-info">
                                <time datetime="<?php echo get_the_date('c'); ?>" class="published">
                                    <?php echo get_the_date(); ?>
                                </time>
                                
                                <?php if (has_category()) : ?>
                                    <span class="categories">
                                        <?php _e('em', 'vancouvertec'); ?> <?php the_category(', '); ?>
                                    </span>
                                <?php endif; ?>
                                
                                <?php if (has_tag()) : ?>
                                    <div class="tags">
                                        <?php the_tags('<span class="tags-label">' . __('Tags:', 'vancouvertec') . '</span> ', ', '); ?>
                                    </div>
                                <?php endif; ?>
                            </div>
                        </div>
                        
                        <h1 class="entry-title"><?php the_title(); ?></h1>
                        
                        <?php if (has_excerpt()) : ?>
                            <div class="entry-excerpt">
                                <?php the_excerpt(); ?>
                            </div>
                        <?php endif; ?>
                    </header>
                    
                    <!-- Post Content -->
                    <div class="entry-content">
                        <?php
                        the_content();
                        
                        wp_link_pages([
                            'before' => '<div class="page-links">' . __('Páginas:', 'vancouvertec'),
                            'after' => '</div>',
                            'pagelink' => '<span class="page-number">%</span>',
                        ]);
                        ?>
                    </div>
                    
                    <!-- Post Footer -->
                    <footer class="entry-footer">
                        <?php if (has_tag()) : ?>
                            <div class="post-tags">
                                <?php the_tags('<div class="tags-wrapper"><span class="tags-label">' . __('Tags:', 'vancouvertec') . '</span>', '', '</div>'); ?>
                            </div>
                        <?php endif; ?>
                        
                        <!-- Author Bio -->
                        <?php if (get_the_author_meta('description')) : ?>
                            <div class="author-bio">
                                <div class="author-avatar">
                                    <?php echo get_avatar(get_the_author_meta('ID'), 64); ?>
                                </div>
                                <div class="author-info">
                                    <h3 class="author-name">
                                        <?php _e('Sobre', 'vancouvertec'); ?> <?php the_author(); ?>
                                    </h3>
                                    <p class="author-description">
                                        <?php echo get_the_author_meta('description'); ?>
                                    </p>
                                </div>
                            </div>
                        <?php endif; ?>
                        
                        <!-- Social Share -->
                        <div class="social-share">
                            <h4><?php _e('Compartilhe este post:', 'vancouvertec'); ?></h4>
                            <div class="share-buttons">
                                <a href="https://twitter.com/intent/tweet?url=<?php echo urlencode(get_permalink()); ?>&text=<?php echo urlencode(get_the_title()); ?>" 
                                   target="_blank" rel="noopener" class="share-btn twitter">
                                    <?php _e('Twitter', 'vancouvertec'); ?>
                                </a>
                                <a href="https://www.facebook.com/sharer/sharer.php?u=<?php echo urlencode(get_permalink()); ?>" 
                                   target="_blank" rel="noopener" class="share-btn facebook">
                                    <?php _e('Facebook', 'vancouvertec'); ?>
                                </a>
                                <a href="https://www.linkedin.com/sharing/share-offsite/?url=<?php echo urlencode(get_permalink()); ?>" 
                                   target="_blank" rel="noopener" class="share-btn linkedin">
                                    <?php _e('LinkedIn', 'vancouvertec'); ?>
                                </a>
                                <a href="https://api.whatsapp.com/send?text=<?php echo urlencode(get_the_title() . ' ' . get_permalink()); ?>" 
                                   target="_blank" rel="noopener" class="share-btn whatsapp">
                                    <?php _e('WhatsApp', 'vancouvertec'); ?>
                                </a>
                            </div>
                        </div>
                    </footer>
                </article>
                
                <!-- Post Navigation -->
                <nav class="post-navigation">
                    <div class="nav-links">
                        <?php
                        $prev_post = get_previous_post();
                        $next_post = get_next_post();
                        ?>
                        
                        <?php if ($prev_post) : ?>
                            <div class="nav-previous">
                                <a href="<?php echo get_permalink($prev_post); ?>" rel="prev">
                                    <span class="nav-subtitle"><?php _e('Post Anterior', 'vancouvertec'); ?></span>
                                    <span class="nav-title"><?php echo get_the_title($prev_post); ?></span>
                                </a>
                            </div>
                        <?php endif; ?>
                        
                        <?php if ($next_post) : ?>
                            <div class="nav-next">
                                <a href="<?php echo get_permalink($next_post); ?>" rel="next">
                                    <span class="nav-subtitle"><?php _e('Próximo Post', 'vancouvertec'); ?></span>
                                    <span class="nav-title"><?php echo get_the_title($next_post); ?></span>
                                </a>
                            </div>
                        <?php endif; ?>
                    </div>
                </nav>
                
                <!-- Related Posts -->
                <?php
                $related_posts = get_posts([
                    'category__in' => wp_get_post_categories(get_the_ID()),
                    'numberposts' => 3,
                    'post__not_in' => [get_the_ID()],
                    'orderby' => 'rand'
                ]);
                
                if ($related_posts) : ?>
                    <section class="related-posts">
                        <h3 class="section-title"><?php _e('Posts Relacionados', 'vancouvertec'); ?></h3>
                        <div class="related-posts-grid">
                            <?php foreach ($related_posts as $post) : setup_postdata($post); ?>
                                <article class="related-post">
                                    <?php if (has_post_thumbnail()) : ?>
                                        <div class="post-thumbnail">
                                            <a href="<?php the_permalink(); ?>">
                                                <?php the_post_thumbnail('vt-card', ['loading' => 'lazy']); ?>
                                            </a>
                                        </div>
                                    <?php endif; ?>
                                    
                                    <div class="post-content">
                                        <h4 class="post-title">
                                            <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
                                        </h4>
                                        <p class="post-excerpt"><?php echo wp_trim_words(get_the_excerpt(), 15); ?></p>
                                        <time datetime="<?php echo get_the_date('c'); ?>"><?php echo get_the_date(); ?></time>
                                    </div>
                                </article>
                            <?php endforeach; wp_reset_postdata(); ?>
                        </div>
                    </section>
                <?php endif; ?>
                
                <!-- Comments -->
                <?php
                if (comments_open() || get_comments_number()) :
                    comments_template();
                endif;
                ?>
                
            <?php endwhile; ?>
        </main>
    </div>
    
    <?php get_sidebar(); ?>
</div>

<?php get_footer(); ?>
EOF

log_success "single.php criado!"

# Criar page.php (páginas estáticas)
log_info "Criando page.php..."
cat > "$THEME_PATH/page.php" << 'EOF'
<?php
/**
 * Page Template
 * 
 * @package VancouverTec_Store
 */

get_header(); ?>

<div class="container">
    <div class="content-area">
        <main id="main" class="site-main">
            <?php while (have_posts()) : the_post(); ?>
                <article id="page-<?php the_ID(); ?>" <?php post_class('single-page'); ?>>
                    
                    <!-- Page Header -->
                    <header class="entry-header">
                        <?php if (has_post_thumbnail()) : ?>
                            <div class="page-thumbnail">
                                <?php the_post_thumbnail('vt-hero', ['loading' => 'eager']); ?>
                            </div>
                        <?php endif; ?>
                        
                        <h1 class="entry-title"><?php the_title(); ?></h1>
                        
                        <?php if (has_excerpt()) : ?>
                            <div class="entry-excerpt">
                                <?php the_excerpt(); ?>
                            </div>
                        <?php endif; ?>
                    </header>
                    
                    <!-- Page Content -->
                    <div class="entry-content">
                        <?php
                        the_content();
                        
                        wp_link_pages([
                            'before' => '<div class="page-links">' . __('Páginas:', 'vancouvertec'),
                            'after' => '</div>',
                            'pagelink' => '<span class="page-number">%</span>',
                        ]);
                        ?>
                    </div>
                    
                    <!-- Page Footer -->
                    <footer class="entry-footer">
                        <?php
                        edit_post_link(
                            __('Editar página', 'vancouvertec'),
                            '<span class="edit-link">',
                            '</span>'
                        );
                        ?>
                    </footer>
                </article>
                
                <!-- Comments for pages (if enabled) -->
                <?php
                if (comments_open() || get_comments_number()) :
                    comments_template();
                endif;
                ?>
                
            <?php endwhile; ?>
        </main>
    </div>
    
    <?php get_sidebar(); ?>
</div>

<?php get_footer(); ?>
EOF

log_success "page.php criado!"

# Criar sidebar.php
log_info "Criando sidebar.php..."
cat > "$THEME_PATH/sidebar.php" << 'EOF'
<?php
/**
 * Sidebar Template
 * 
 * @package VancouverTec_Store
 */

if (!is_active_sidebar('sidebar-1')) {
    return;
}
?>

<aside id="secondary" class="widget-area sidebar" role="complementary">
    <div class="sidebar-content">
        <?php dynamic_sidebar('sidebar-1'); ?>
        
        <!-- Default widgets if no widgets are assigned -->
        <?php if (!is_active_sidebar('sidebar-1')) : ?>
            
            <!-- Search Widget -->
            <section class="widget widget_search">
                <h2 class="widget-title"><?php _e('Pesquisar', 'vancouvertec'); ?></h2>
                <?php get_search_form(); ?>
            </section>
            
            <!-- Recent Posts Widget -->
            <section class="widget widget_recent_entries">
                <h2 class="widget-title"><?php _e('Posts Recentes', 'vancouvertec'); ?></h2>
                <ul>
                    <?php
                    $recent_posts = wp_get_recent_posts([
                        'numberposts' => 5,
                        'post_status' => 'publish'
                    ]);
                    
                    foreach ($recent_posts as $post) : ?>
                        <li>
                            <a href="<?php echo get_permalink($post['ID']); ?>">
                                <?php echo esc_html($post['post_title']); ?>
                            </a>
                            <span class="post-date"><?php echo get_the_date('d/m/Y', $post['ID']); ?></span>
                        </li>
                    <?php endforeach; wp_reset_query(); ?>
                </ul>
            </section>
            
            <!-- Categories Widget -->
            <?php if (has_nav_menu('categories') || get_categories()) : ?>
                <section class="widget widget_categories">
                    <h2 class="widget-title"><?php _e('Categorias', 'vancouvertec'); ?></h2>
                    <ul>
                        <?php wp_list_categories([
                            'orderby' => 'name',
                            'show_count' => true,
                            'title_li' => '',
                        ]); ?>
                    </ul>
                </section>
            <?php endif; ?>
            
            <!-- Archives Widget -->
            <section class="widget widget_archive">
                <h2 class="widget-title"><?php _e('Arquivo', 'vancouvertec'); ?></h2>
                <ul>
                    <?php wp_get_archives([
                        'type' => 'monthly',
                        'show_post_count' => true
                    ]); ?>
                </ul>
            </section>
            
            <!-- About Widget -->
            <section class="widget widget_text">
                <h2 class="widget-title"><?php _e('Sobre a VancouverTec', 'vancouvertec'); ?></h2>
                <div class="textwidget">
                    <p><?php _e('Desenvolvemos soluções digitais inovadoras para empresas que querem crescer. Sistemas, sites, aplicativos e cursos de alta qualidade.', 'vancouvertec'); ?></p>
                    <p>
                        <a href="<?php echo esc_url(home_url('/sobre')); ?>" class="btn btn-primary btn-sm">
                            <?php _e('Saiba Mais', 'vancouvertec'); ?>
                        </a>
                    </p>
                </div>
            </section>
            
        <?php endif; ?>
    </div>
</aside>
EOF

log_success "sidebar.php criado!"

# Criar searchform.php (formulário de busca personalizado)
log_info "Criando searchform.php..."
cat > "$THEME_PATH/searchform.php" << 'EOF'
<?php
/**
 * Search Form Template
 * 
 * @package VancouverTec_Store
 */
?>

<form role="search" method="get" class="search-form" action="<?php echo esc_url(home_url('/')); ?>">
    <label for="search-field-<?php echo uniqid(); ?>" class="sr-only">
        <?php _e('Pesquisar por:', 'vancouvertec'); ?>
    </label>
    <div class="search-input-wrapper">
        <input 
            type="search" 
            id="search-field-<?php echo uniqid(); ?>"
            class="search-field form-control" 
            placeholder="<?php _e('Digite sua busca...', 'vancouvertec'); ?>" 
            value="<?php echo get_search_query(); ?>" 
            name="s" 
            required
        />
        <button type="submit" class="search-submit">
            <span class="sr-only"><?php _e('Pesquisar', 'vancouvertec'); ?></span>
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M21 21L16.514 16.506L21 21ZM19 10.5C19 15.194 15.194 19 10.5 19C5.806 19 2 15.194 2 10.5C2 5.806 5.806 2 10.5 2C15.194 2 19 5.806 19 10.5Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </button>
    </div>
</form>
EOF

log_success "searchform.php criado!"

# Criar search.php (página de resultados de busca)
log_info "Criando search.php..."
cat > "$THEME_PATH/search.php" << 'EOF'
<?php
/**
 * Search Results Template
 * 
 * @package VancouverTec_Store
 */

get_header(); ?>

<div class="container">
    <div class="content-area">
        <main id="main" class="site-main">
            
            <header class="page-header search-header">
                <h1 class="page-title">
                    <?php
                    printf(
                        __('Resultados da busca por: %s', 'vancouvertec'),
                        '<span class="search-term">"' . get_search_query() . '"</span>'
                    );
                    ?>
                </h1>
                
                <?php if (have_posts()) : ?>
                    <p class="search-results-count">
                        <?php
                        global $wp_query;
                        printf(
                            _n(
                                '%d resultado encontrado',
                                '%d resultados encontrados',
                                $wp_query->found_posts,
                                'vancouvertec'
                            ),
                            $wp_query->found_posts
                        );
                        ?>
                    </p>
                <?php endif; ?>
                
                <!-- Search form again -->
                <div class="search-form-wrapper">
                    <?php get_search_form(); ?>
                </div>
            </header>
            
            <?php if (have_posts()) : ?>
                
                <div class="search-results">
                    <?php while (have_posts()) : the_post(); ?>
                        <article id="post-<?php the_ID(); ?>" <?php post_class('search-result'); ?>>
                            
                            <?php if (has_post_thumbnail()) : ?>
                                <div class="result-thumbnail">
                                    <a href="<?php the_permalink(); ?>">
                                        <?php the_post_thumbnail('vt-thumbnail', ['loading' => 'lazy']); ?>
                                    </a>
                                </div>
                            <?php endif; ?>
                            
                            <div class="result-content">
                                <header class="result-header">
                                    <h2 class="result-title">
                                        <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
                                    </h2>
                                    
                                    <div class="result-meta">
                                        <span class="result-type">
                                            <?php
                                            $post_type = get_post_type();
                                            $post_type_obj = get_post_type_object($post_type);
                                            echo $post_type_obj->labels->singular_name;
                                            ?>
                                        </span>
                                        
                                        <time datetime="<?php echo get_the_date('c'); ?>">
                                            <?php echo get_the_date(); ?>
                                        </time>
                                        
                                        <?php if (has_category()) : ?>
                                            <span class="result-categories">
                                                <?php the_category(', '); ?>
                                            </span>
                                        <?php endif; ?>
                                    </div>
                                </header>
                                
                                <div class="result-excerpt">
                                    <?php the_excerpt(); ?>
                                </div>
                                
                                <footer class="result-footer">
                                    <a href="<?php the_permalink(); ?>" class="read-more">
                                        <?php _e('Leia mais', 'vancouvertec'); ?>
                                    </a>
                                </footer>
                            </div>
                        </article>
                    <?php endwhile; ?>
                </div>
                
                <?php
                // Pagination
                the_posts_pagination([
                    'mid_size' => 2,
                    'prev_text' => __('← Anterior', 'vancouvertec'),
                    'next_text' => __('Próximo →', 'vancouvertec'),
                ]);
                ?>
                
            <?php else : ?>
                
                <section class="no-results not-found">
                    <header class="page-header">
                        <h1 class="page-title"><?php _e('Nenhum resultado encontrado', 'vancouvertec'); ?></h1>
                    </header>
                    
                    <div class="page-content">
                        <p><?php _e('Desculpe, mas nada foi encontrado para sua busca. Tente novamente com palavras-chave diferentes.', 'vancouvertec'); ?></p>
                        
                        <div class="search-suggestions">
                            <h3><?php _e('Sugestões:', 'vancouvertec'); ?></h3>
                            <ul>
                                <li><?php _e('Verifique se todas as palavras estão escritas corretamente', 'vancouvertec'); ?></li>
                                <li><?php _e('Tente palavras-chave diferentes', 'vancouvertec'); ?></li>
                                <li><?php _e('Tente palavras-chave mais gerais', 'vancouvertec'); ?></li>
                                <li><?php _e('Tente menos palavras-chave', 'vancouvertec'); ?></li>
                            </ul>
                        </div>
                        
                        <?php get_search_form(); ?>
                        
                        <!-- Popular posts or categories as fallback -->
                        <div class="popular-content">
                            <h3><?php _e('Posts Populares', 'vancouvertec'); ?></h3>
                            <div class="popular-posts-grid">
                                <?php
                                $popular_posts = get_posts([
                                    'numberposts' => 6,
                                    'meta_key' => 'post_views_count',
                                    'orderby' => 'meta_value_num',
                                    'order' => 'DESC'
                                ]);
                                
                                if (!$popular_posts) {
                                    $popular_posts = get_posts(['numberposts' => 6]);
                                }
                                
                                foreach ($popular_posts as $post) : setup_postdata($post); ?>
                                    <article class="popular-post">
                                        <h4><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h4>
                                        <time><?php echo get_the_date(); ?></time>
                                    </article>
                                <?php endforeach; wp_reset_postdata(); ?>
                            </div>
                        </div>
                    </div>
                </section>
                
            <?php endif; ?>
        </main>
    </div>
    
    <?php get_sidebar(); ?>
</div>

<?php get_footer(); ?>
EOF

log_success "search.php criado!"

# Criar CSS para os novos templates
log_info "Criando CSS para templates específicos..."
cat > "$THEME_PATH/assets/css/templates.css" << 'EOF'
/* VancouverTec Store - Templates CSS */

/* Single Post Styles */
.single-post {
  max-width: 800px;
  margin: 0 auto var(--vt-space-3xl);
}

.entry-header {
  margin-bottom: var(--vt-space-xl);
  text-align: center;
}

.entry-title {
  font-size: clamp(1.75rem, 5vw, 2.5rem);
  font-weight: 700;
  color: var(--vt-neutral-800);
  margin-bottom: var(--vt-space-md);
  line-height: 1.2;
}

.entry-meta {
  color: var(--vt-neutral-500);
  font-size: 0.875rem;
  margin-bottom: var(--vt-space-lg);
}

.entry-excerpt {
  font-size: 1.125rem;
  color: var(--vt-neutral-600);
  font-style: italic;
  margin-bottom: var(--vt-space-lg);
}

.entry-content {
  font-size: 1.1rem;
  line-height: 1.8;
  margin-bottom: var(--vt-space-xl);
}

.entry-content h2,
.entry-content h3,
.entry-content h4 {
  margin-top: var(--vt-space-xl);
  margin-bottom: var(--vt-space-md);
  color: var(--vt-neutral-800);
}

/* Author Bio */
.author-bio {
  display: flex;
  gap: var(--vt-space-md);
  padding: var(--vt-space-lg);
  background: var(--vt-neutral-50);
  border-radius: var(--vt-radius-lg);
  margin: var(--vt-space-xl) 0;
}

.author-avatar img {
  border-radius: var(--vt-radius-full);
}

.author-name {
  font-size: 1.125rem;
  margin-bottom: var(--vt-space-xs);
  color: var(--vt-neutral-800);
}

/* Social Share */
.social-share {
  margin: var(--vt-space-xl) 0;
  padding: var(--vt-space-lg);
  border: 2px solid var(--vt-neutral-200);
  border-radius: var(--vt-radius-lg);
  text-align: center;
}

.share-buttons {
  display: flex;
  gap: var(--vt-space-sm);
  justify-content: center;
  flex-wrap: wrap;
  margin-top: var(--vt-space-md);
}

.share-btn {
  padding: var(--vt-space-sm) var(--vt-space-md);
  border-radius: var(--vt-radius-md);
  text-decoration: none;
  font-weight: 600;
  font-size: 0.875rem;
  transition: var(--vt-transition-fast);
}

.share-btn.twitter { background: #1DA1F2; color: white; }
.share-btn.facebook { background: #1877F2; color: white; }
.share-btn.linkedin { background: #0A66C2; color: white; }
.share-btn.whatsapp { background: #25D366; color: white; }

.share-btn:hover {
  transform: translateY(-2px);
  box-shadow: var(--vt-shadow-md);
}

/* Post Navigation */
.post-navigation {
  margin: var(--vt-space-2xl) 0;
}

.nav-links {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--vt-space-lg);
}

.nav-previous,
.nav-next {
  padding: var(--vt-space-lg);
  background: white;
  border: 2px solid var(--vt-neutral-200);
  border-radius: var(--vt-radius-lg);
  transition: var(--vt-transition-fast);
}

.nav-previous:hover,
.nav-next:hover {
  border-color: var(--vt-blue-600);
  box-shadow: var(--vt-shadow-md);
}

.nav-subtitle {
  display: block;
  font-size: 0.875rem;
  color: var(--vt-neutral-500);
  margin-bottom: var(--vt-space-xs);
}

.nav-title {
  display: block;
  font-weight: 600;
  color: var(--vt-neutral-800);
}

/* Related Posts */
.related-posts {
  margin: var(--vt-space-2xl) 0;
}

.related-posts-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: var(--vt-space-lg);
  margin-top: var(--vt-space-lg);
}

.related-post {
  background: white;
  border-radius: var(--vt-radius-lg);
  box-shadow: var(--vt-shadow-sm);
  overflow: hidden;
  transition: var(--vt-transition-normal);
}

.related-post:hover {
  box-shadow: var(--vt-shadow-md);
  transform: translateY(-2px);
}

/* Sidebar Styles */
.sidebar {
  background: var(--vt-neutral-50);
  padding: var(--vt-space-lg);
  border-radius: var(--vt-radius-lg);
  margin-top: var(--vt-space-lg);
}

.sidebar .widget {
  background: white;
  padding: var(--vt-space-lg);
  border-radius: var(--vt-radius-md);
  box-shadow: var(--vt-shadow-sm);
  margin-bottom: var(--vt-space-lg);
}

.sidebar .widget:last-child {
  margin-bottom: 0;
}

/* Search Results */
.search-header {
  margin-bottom: var(--vt-space-xl);
  text-align: center;
}

.search-term {
  color: var(--vt-blue-600);
  font-weight: 700;
}

.search-results-count {
  color: var(--vt-neutral-600);
  margin: var(--vt-space-md) 0;
}

.search-result {
  display: flex;
  gap: var(--vt-space-md);
  padding: var(--vt-space-lg);
  background: white;
  border-radius: var(--vt-radius-lg);
  box-shadow: var(--vt-shadow-sm);
  margin-bottom: var(--vt-space-lg);
  transition: var(--vt-transition-fast);
}

.search-result:hover {
  box-shadow: var(--vt-shadow-md);
}

.result-thumbnail {
  flex-shrink: 0;
  width: 80px;
  height: 80px;
  border-radius: var(--vt-radius-md);
  overflow: hidden;
}

.result-thumbnail img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.result-content {
  flex: 1;
}

.result-title {
  font-size: 1.125rem;
  margin-bottom: var(--vt-space-xs);
}

.result-title a {
  color: var(--vt-neutral-800);
  text-decoration: none;
  transition: var(--vt-transition-fast);
}

.result-title a:hover {
  color: var(--vt-blue-600);
}

.result-meta {
  display: flex;
  gap: var(--vt-space-sm);
  font-size: 0.875rem;
  color: var(--vt-neutral-500);
  margin-bottom: var(--vt-space-sm);
}

.result-type {
  background: var(--vt-blue-600);
  color: white;
  padding: 0.125rem 0.5rem;
  border-radius: var(--vt-radius-sm);
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
}

/* Content Area Layout */
.content-area {
  display: grid;
  grid-template-columns: 1fr 300px;
  gap: var(--vt-space-xl);
  align-items: start;
}

/* Responsive Layouts */
@media (max-width: 768px) {
  .content-area {
    grid-template-columns: 1fr;
  }
  
  .sidebar {
    order: -1;
    margin-top: 0;
    margin-bottom: var(--vt-space-lg);
  }
  
  .nav-links {
    grid-template-columns: 1fr;
  }
  
  .related-posts-grid {
    grid-template-columns: 1fr;
  }
  
  .search-result {
    flex-direction: column;
  }
  
  .result-thumbnail {
    width: 100%;
    height: 200px;
  }
  
  .author-bio {
    flex-direction: column;
    text-align: center;
  }
  
  .share-buttons {
    justify-content: center;
  }
}

@media (max-width: 480px) {
  .share-buttons {
    flex-direction: column;
    align-items: center;
  }
  
  .share-btn {
    width: 100%;
    max-width: 200px;
  }
}
EOF

log_success "templates.css criado!"

# Atualizar functions.php para incluir o novo CSS
log_info "Atualizando functions.php para incluir templates.css..."
sed -i '/wp_enqueue_style.*vt-animations/a\    wp_enqueue_style('"'"'vt-templates'"'"', VT_THEME_URI . '"'"'/assets/css/templates.css'"'"', ['"'"'vt-main'"'"'], VT_THEME_VERSION);' "$THEME_PATH/functions.php"

# Atualizar sidebar no functions.php (expandir widgets)
log_info "Expandindo configuração de widgets..."
cat >> "$THEME_PATH/functions.php" << 'EOF'

/**
 * Enhanced Widget Areas
 */
function vt_enhanced_widgets_init() {
    // Footer widgets
    for ($i = 3; $i <= 4; $i++) {
        register_sidebar([
            'name' => sprintf(__('Rodapé %d', 'vancouvertec'), $i),
            'id' => "footer-$i",
            'description' => sprintf(__('Área de widget do rodapé %d.', 'vancouvertec'), $i),
            'before_widget' => '<div id="%1$s" class="widget %2$s">',
            'after_widget' => '</div>',
            'before_title' => '<h3 class="widget-title">',
            'after_title' => '</h3>',
        ]);
    }
}
add_action('widgets_init', 'vt_enhanced_widgets_init');

/**
 * Post Views Counter
 */
function vt_set_post_views($postID) {
    $count_key = 'post_views_count';
    $count = get_post_meta($postID, $count_key, true);
    if ($count == '') {
        $count = 0;
        delete_post_meta($postID, $count_key);
        add_post_meta($postID, $count_key, '0');
    } else {
        $count++;
        update_post_meta($postID, $count_key, $count);
    }
}

function vt_track_post_views($post_id) {
    if (!is_single()) return;
    if (empty($post_id)) {
        global $post;
        $post_id = $post->ID;
    }
    vt_set_post_views($post_id);
}
add_action('wp_head', 'vt_track_post_views');

/**
 * Get Post Views
 */
function vt_get_post_views($postID) {
    $count_key = 'post_views_count';
    $count = get_post_meta($postID, $count_key, true);
    if ($count == '') {
        delete_post_meta($postID, $count_key);
        add_post_meta($postID, $count_key, '0');
        return "0";
    }
    return $count;
}

/**
 * Breadcrumbs Function
 */
function vt_breadcrumbs() {
    if (is_home() || is_front_page()) return;
    
    echo '<nav class="breadcrumbs" aria-label="' . __('Breadcrumbs', 'vancouvertec') . '">';
    echo '<ol class="breadcrumb-list">';
    echo '<li class="breadcrumb-item"><a href="' . home_url() . '">' . __('Início', 'vancouvertec') . '</a></li>';
    
    if (is_category() || is_single()) {
        $category = get_the_category();
        if ($category) {
            echo '<li class="breadcrumb-item"><a href="' . get_category_link($category[0]->term_id) . '">' . $category[0]->cat_name . '</a></li>';
        }
        if (is_single()) {
            echo '<li class="breadcrumb-item active" aria-current="page">' . get_the_title() . '</li>';
        }
    } elseif (is_page()) {
        if (wp_get_post_parent_id(get_the_ID())) {
            $ancestors = get_post_ancestors(get_the_ID());
            $ancestors = array_reverse($ancestors);
            foreach ($ancestors as $ancestor) {
                echo '<li class="breadcrumb-item"><a href="' . get_permalink($ancestor) . '">' . get_the_title($ancestor) . '</a></li>';
            }
        }
        echo '<li class="breadcrumb-item active" aria-current="page">' . get_the_title() . '</li>';
    }
    
    echo '</ol>';
    echo '</nav>';
}
EOF

log_success "functions.php expandido!"

# Criar arquivo 404.php
log_info "Criando 404.php..."
cat > "$THEME_PATH/404.php" << 'EOF'
<?php
/**
 * 404 Error Page Template
 * 
 * @package VancouverTec_Store
 */

get_header(); ?>

<div class="container">
    <div class="error-404-content">
        <main id="main" class="site-main">
            <section class="error-404 not-found">
                <header class="page-header">
                    <div class="error-number">404</div>
                    <h1 class="page-title"><?php _e('Página não encontrada', 'vancouvertec'); ?></h1>
                    <p class="error-description">
                        <?php _e('A página que você está procurando não existe ou foi movida.', 'vancouvertec'); ?>
                    </p>
                </header>

                <div class="page-content">
                    <div class="error-actions">
                        <a href="<?php echo esc_url(home_url('/')); ?>" class="btn btn-primary">
                            <?php _e('Voltar ao Início', 'vancouvertec'); ?>
                        </a>
                        <button onclick="history.back()" class="btn btn-secondary">
                            <?php _e('Página Anterior', 'vancouvertec'); ?>
                        </button>
                    </div>

                    <div class="search-section">
                        <h3><?php _e('Ou tente pesquisar:', 'vancouvertec'); ?></h3>
                        <?php get_search_form(); ?>
                    </div>

                    <div class="helpful-links">
                        <h3><?php _e('Links Úteis:', 'vancouvertec'); ?></h3>
                        <div class="links-grid">
                            <div class="link-item">
                                <h4><a href="<?php echo esc_url(home_url('/')); ?>"><?php _e('Página Inicial', 'vancouvertec'); ?></a></h4>
                                <p><?php _e('Volte para nossa página principal', 'vancouvertec'); ?></p>
                            </div>
                            
                            <?php if (class_exists('WooCommerce')) : ?>
                                <div class="link-item">
                                    <h4><a href="<?php echo get_permalink(wc_get_page_id('shop')); ?>"><?php _e('Loja', 'vancouvertec'); ?></a></h4>
                                    <p><?php _e('Veja nossos produtos digitais', 'vancouvertec'); ?></p>
                                </div>
                            <?php endif; ?>
                            
                            <div class="link-item">
                                <h4><a href="<?php echo esc_url(home_url('/sobre')); ?>"><?php _e('Sobre Nós', 'vancouvertec'); ?></a></h4>
                                <p><?php _e('Conheça a VancouverTec', 'vancouvertec'); ?></p>
                            </div>
                            
                            <div class="link-item">
                                <h4><a href="<?php echo esc_url(home_url('/contato')); ?>"><?php _e('Contato', 'vancouvertec'); ?></a></h4>
                                <p><?php _e('Entre em contato conosco', 'vancouvertec'); ?></p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>
</div>

<?php get_footer(); ?>
EOF

log_success "404.php criado!"

# Reiniciar servidor
log_info "Reiniciando servidor..."
cd "$PROJECT_PATH"
php -S localhost:8080 -t . > /tmp/vt-server-8080.log 2>&1 &
SERVER_PID=$!

sleep 3

if kill -0 $SERVER_PID 2>/dev/null; then
    log_success "Servidor reiniciado (PID: $SERVER_PID)"
else
    log_error "Falha ao reiniciar servidor!"
    exit 1
fi

echo -e "\n${GREEN}╔══════════════════════════════════════════════╗"
echo -e "║    ✅ TEMPLATES ESPECÍFICOS CRIADOS! ✅       ║"
echo -e "║       WordPress theme completo               ║"
echo -e "╚══════════════════════════════════════════════╝${NC}\n"

log_success "✅ single.php - Posts individuais com bio e compartilhamento"
log_success "✅ page.php - Páginas estáticas otimizadas"
log_success "✅ sidebar.php - Sidebar dinâmica com widgets"
log_success "✅ search.php - Resultados de busca avançados"
log_success "✅ searchform.php - Formulário de busca personalizado"
log_success "✅ 404.php - Página de erro útil"
log_success "✅ templates.css - Estilos específicos para templates"

echo -e "\n${CYAN}📄 Templates Criados:${NC}"
echo -e "• Posts individuais com navegação e posts relacionados"
echo -e "• Páginas com layout limpo e focado"
echo -e "• Sidebar responsiva com widgets padrão"
echo -e "• Busca avançada com sugestões"
echo -e "• Página 404 com links úteis"
echo -e "• Sistema de breadcrumbs"
echo -e "• Contador de visualizações"

echo -e "\n${YELLOW}🎯 Funcionalidades Adicionadas:${NC}"
echo -e "• Compartilhamento social (Twitter, Facebook, LinkedIn, WhatsApp)"
echo -e "• Bio do autor em posts"
echo -e "• Posts relacionados automáticos"
echo -e "• Navegação entre posts"
echo -e "• Sistema de busca inteligente"
echo -e "• Layout responsivo para todas as telas"

echo -e "\n${PURPLE}🌐 Teste Agora:${NC}"
echo -e "• Crie um post: http://localhost:8080/wp-admin/post-new.php"
echo -e "• Crie uma página: http://localhost:8080/wp-admin/post-new.php?post_type=page"
echo -e "• Teste a busca na home"
echo -e "• Configure widgets em Aparência > Widgets"

log_success "Base completa do tema WordPress criada!"
log_success "Próximo: Digite 'continuar' para criar integração WooCommerce"

exit 0