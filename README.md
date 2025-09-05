# VancouverTec Store - Loja Digital Premium

🚀 **Tema WordPress Premium + Plugin Proprietário** para venda de produtos digitais (sites, sistemas, apps, cursos, templates).

## 🎯 Objetivo

Sistema completo para `https://store.vancouvertec.com.br` com:
- **Performance 99+ PageSpeed**
- **SEO Avançado** com Rich Snippets
- **Segurança Máxima**
- **Design Azul Institucional VancouverTec**

## 📦 Componentes

### 1. **Tema: VancouverTec Store**
- UI/UX minimalista e focada em conversão
- Compatível com WooCommerce + Elementor
- Páginas de produto com abas: Descrição, Especificações, Avaliações, Demonstração
- Box de compra otimizado com badges de confiança
- Performance 99+ com otimizações avançadas

### 2. **Plugin: VancouverTec Digital Manager**
- Painel do cliente com downloads seguros
- Gestão completa de cursos online
- Especificações técnicas avançadas
- API interna para mobile
- Links temporários com assinatura HMAC

## 🛠️ Stack Tecnológica

- **WordPress 6.4+**
- **WooCommerce 8.0+**
- **Elementor 3.16+**
- **PHP 8.1+**
- **MySQL 8.0+**

## 🎨 Design System

Paleta baseada em `https://vancouvertec.com.br`:
- `--vt-blue-600`: Azul principal
- `--vt-blue-700`: Azul escuro
- `--vt-indigo-500`: Índigo complementar
- Neutros e verdes de sucesso

## 📋 Funcionalidades Principais

### Páginas de Produto
- ✅ Abas interativas (Descrição, Specs, Avaliações, Demo)
- ✅ Grid de especificações técnicas
- ✅ Histograma de avaliações com média
- ✅ Box de compra com badges de confiança
- ✅ Produtos relacionados em carrossel
- ✅ Schema.org e JSON-LD

### Painel do Cliente
- ✅ Downloads seguros com links temporários
- ✅ Cursos com progresso e certificados
- ✅ Gestão de conta e suporte

### Admin
- ✅ Metaboxes para especificações técnicas
- ✅ Gestão completa de cursos
- ✅ Relatórios de progresso
- ✅ Gerador de links seguros

## 🔧 Instalação

1. **Pré-requisitos**
   ```bash
   # WordPress 6.4+
   # WooCommerce ativo
   # Elementor ativo
   # PHP 8.1+
   ```

2. **Instalação do Tema**
   ```bash
   # Via WordPress Admin
   Aparência > Temas > Adicionar Novo > Enviar Tema
   
   # Via FTP
   Extrair em /wp-content/themes/vancouvertec-store/
   ```

3. **Instalação do Plugin**
   ```bash
   # Via WordPress Admin
   Plugins > Adicionar Novo > Enviar Plugin
   
   # Via FTP
   Extrair em /wp-content/plugins/vancouvertec-digital-manager/
   ```

4. **Ativação**
   ```bash
   # 1. Ativar tema VancouverTec Store
   # 2. Ativar plugin VancouverTec Digital Manager
   # 3. Configurar WooCommerce
   # 4. Importar páginas de exemplo
   ```

## ⚙️ Configuração

### Especificações Técnicas
1. Acesse produto no admin
2. Role até "Especificações Técnicas"
3. Preencha os campos disponíveis
4. Adicione campos customizados se necessário

### Cursos Online
1. Vá em "VT Cursos" no admin
2. Crie um novo curso
3. Adicione módulos e aulas
4. Vincule ao produto WooCommerce

### Downloads Seguros
1. Configure produto como "Virtual"
2. Adicione arquivos na aba "VT Downloads"
3. Links temporários são gerados automaticamente

## 🚀 Performance

### Otimizações Implementadas
- ✅ CSS crítico inline
- ✅ Code-splitting JavaScript
- ✅ Imagens WebP/AVIF
- ✅ Preload de fontes essenciais
- ✅ Lazy-load de imagens
- ✅ Preconnect/prefetch
- ✅ Minificação automática
- ✅ Cache headers otimizados
- ✅ Defer de scripts não críticos
- ✅ Ícones SVG inline

### Métricas Esperadas
- **PageSpeed Desktop**: 99+
- **PageSpeed Mobile**: 95+
- **Core Web Vitals**: Todos verdes
- **TTFB**: < 200ms

## 🔐 Segurança

### Medidas Implementadas
- ✅ Escape e validação de todos inputs
- ✅ Nonces em todos forms
- ✅ Roles e capabilities
- ✅ REST API protegida
- ✅ Proteção XSS/CSRF/SQLi
- ✅ Downloads com assinatura HMAC
- ✅ Rate limiting

## 📱 API Interna

Base URL: `https://store.vancouvertec.com.br/wp-json/vt/v1/`

### Endpoints Principais
- `GET /courses` - Lista cursos do usuário
- `GET /downloads` - Links de download
- `POST /progress` - Atualiza progresso
- `GET /certificates` - Gera certificados

## 🧪 Desenvolvimento

### Estrutura do Projeto
```
store-vancouvertec-com-br/
├── themes/vancouvertec-store/
├── plugins/vancouvertec-digital-manager/
├── scripts/
├── docs/
└── tests/
```

### Comandos Úteis
```bash
# Criar estrutura
chmod +x scripts/01-criando-estrutura-projeto.sh
./scripts/01-criando-estrutura-projeto.sh

# Deploy para VPS
chmod +x scripts/deploy.sh
./scripts/deploy.sh

# Atualizar produção
git push origin main  # Auto-deploy configurado
```

## 🌐 Deploy

### Desenvolvimento Local
- WSL2 Ubuntu
- Docker opcional
- Hot-reload ativado

### Produção VPS
- Servidor: `root@212.85.1.55`
- Auto-deploy via GitHub Actions
- SSL automático via Let's Encrypt

## 📚 Documentação

### Para Desenvolvedores
- [Hooks e Filters](docs/hooks.md)
- [API Reference](docs/api.md)
- [Custom Fields](docs/fields.md)

### Para Usuários
- [Guia de Uso](docs/user-guide.md)
- [FAQ](docs/faq.md)
- [Suporte](docs/support.md)

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch (`git checkout -b feature/nova-funcionalidade`)
3. Commit as mudanças (`git commit -am 'Adiciona nova funcionalidade'`)
4. Push para branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## 📄 Licença

Propriedade da **VancouverTec**. Todos os direitos reservados.

## 🆘 Suporte

- **Email**: suporte@vancouvertec.com.br
- **Docs**: https://docs.vancouvertec.com.br
- **Issues**: GitHub Issues deste repositório

---

**VancouverTec** - Soluções Digitais de Alta Performance 🚀