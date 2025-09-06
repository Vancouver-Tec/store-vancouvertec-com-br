# 🚀 VancouverTec Store - Soluções Digitais Premium

![VancouverTec Store](https://img.shields.io/badge/VancouverTec-Store-0066CC?style=for-the-badge&logo=wordpress&logoColor=white)
![WordPress](https://img.shields.io/badge/WordPress-6.4+-21759B?style=flat-square&logo=wordpress&logoColor=white)
![WooCommerce](https://img.shields.io/badge/WooCommerce-8.0+-96588A?style=flat-square&logo=woocommerce&logoColor=white)
![Elementor](https://img.shields.io/badge/Elementor-Compatible-92003B?style=flat-square&logo=elementor&logoColor=white)
![PHP](https://img.shields.io/badge/PHP-8.0+-777BB4?style=flat-square&logo=php&logoColor=white)

## 📋 Sobre o Projeto

**VancouverTec Store** é uma solução completa para vendas digitais, desenvolvida especialmente para **https://store.vancouvertec.com.br**. O projeto combina um **tema WordPress premium** com um **plugin proprietário**, oferecendo uma experiência completa para venda de produtos digitais como sistemas, sites, aplicativos, cursos e templates.

### 🎯 Objetivo Principal

Criar uma loja virtual moderna, rápida e segura para vender produtos digitais com foco em:
- **Performance**: PageSpeed 99+
- **SEO Avançado**: Estrutura otimizada para motores de busca
- **Segurança Máxima**: Downloads protegidos e autenticação robusta
- **Design Institucional**: Paleta azul da VancouverTec

## 🏗️ Arquitetura do Projeto

### 🎨 Tema WordPress - "VancouverTec Store"
- UI/UX moderno e responsivo
- Compatibilidade total com WooCommerce e Elementor
- Páginas de produto otimizadas para conversão
- Performance superior (99+ PageSpeed)
- SEO e acessibilidade AA+

### 🔌 Plugin Proprietário - "VancouverTec Digital Manager"
- Painel do cliente completo
- Sistema de downloads seguros
- Plataforma de cursos integrada
- API REST interna (`vt/v1`)
- Relatórios e analytics

## 🚀 Funcionalidades Principais

### 📄 Páginas de Produto
- **Abas Dinâmicas**: Descrição, Especificações, Avaliações, Demonstração
- **Caixa de Compra**: Preços, parcelamento, CTAs otimizados
- **Especificações Técnicas**: Grid responsivo e detalhado
- **Produtos Relacionados**: Carrossel automatizado
- **JSON-LD**: Schema markup completo

### 👤 Área do Cliente
- **Meus Produtos**: Lista de produtos adquiridos
- **Meus Cursos**: Plataforma de aprendizado
- **Downloads Seguros**: Links temporários com HMAC
- **Progresso de Cursos**: Relatórios detalhados
- **Certificados**: Geração automática em PDF

### 🛡️ Segurança e Performance
- Downloads protegidos por assinatura HMAC
- Nonces e validação em todas as operações
- Roles e capabilities customizadas
- Minificação automática de assets
- Lazy loading de imagens
- Critical CSS inline

## 🎨 Identidade Visual

### 🎯 Paleta de Cores
```css
:root {
  --vt-blue-600: #0066CC;
  --vt-blue-700: #0052A3;
  --vt-indigo-500: #6366F1;
  --vt-success-500: #10B981;
  --vt-neutral-100: #F5F5F5;
  --vt-neutral-800: #1F2937;
}
```

### 📝 Títulos da Loja
- **Principal**: *"VancouverTec Store – Soluções Digitais para o seu Negócio"*
- **Subtítulo**: *"Sistemas, Sites, Aplicativos, Automação e Cursos para empresas que querem crescer"*

## 📁 Estrutura do Projeto

```
vancouvertec-store/
├── 📂 themes/
│   └── 📂 vancouvertec-store/
│       ├── 📄 style.css
│       ├── 📄 functions.php
│       ├── 📄 index.php
│       ├── 📂 inc/
│       ├── 📂 template-parts/
│       ├── 📂 woocommerce/
│       └── 📂 assets/
├── 📂 plugins/
│   └── 📂 vancouvertec-digital-manager/
│       ├── 📄 vancouvertec-digital-manager.php
│       ├── 📂 includes/
│       ├── 📂 admin/
│       ├── 📂 public/
│       └── 📂 assets/
├── 📂 scripts/
│   ├── 📄 01-criando-estrutura-projeto.sh
│   ├── 📄 02-configurando-ambiente.sh
│   ├── 📄 03-deploy-local-vps.sh
│   └── 📄 deploy.sh
├── 📂 config/
│   └── 📄 wp-config-template.php
├── 📄 README.md
└── 📄 .gitignore
```

## 🌍 Ambientes de Desenvolvimento

### 💻 Local Development
```
DB_HOST=127.0.0.1
DB_PORT=3306
DB_NAME=vt_store_db
DB_USER=root
DB_PASS=12345678
VT_ENV=local
```

### 🌐 Production (VPS)
```
DB_HOST=127.0.0.1
DB_PORT=3306
DB_NAME=vancouvertec-store
DB_USER=vancouvertec-store
DB_PASS=VeNWJAL1JCOQr2h2ohw5
VT_ENV=production
```

## ⚡ Instalação Rápida

### 1️⃣ Preparação do Ambiente
```bash
chmod +x scripts/01-criando-estrutura-projeto.sh
./scripts/01-criando-estrutura-projeto.sh
```

### 2️⃣ Configuração do Banco
```bash
chmod +x scripts/02-configurando-ambiente.sh
./scripts/02-configurando-ambiente.sh
```

### 3️⃣ Deploy para VPS
```bash
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Versão | Propósito |
|------------|--------|-----------|
| **WordPress** | 6.4+ | CMS Base |
| **WooCommerce** | 8.0+ | E-commerce |
| **Elementor** | 3.15+ | Page Builder |
| **PHP** | 8.0+ | Backend |
| **MySQL** | 5.7+ | Banco de Dados |
| **JavaScript** | ES6+ | Frontend |
| **SCSS** | 1.0+ | Estilos |

## 📊 Performance Metrics

- **PageSpeed Score**: 99+ (Mobile & Desktop)
- **Core Web Vitals**: Aprovado
- **SEO Score**: 100/100
- **Acessibilidade**: AA+ Compliance
- **Security**: A+ Rating

## 🔧 Scripts Disponíveis

| Script | Função |
|--------|---------|
| `01-criando-estrutura-projeto.sh` | Cria estrutura de pastas |
| `02-configurando-ambiente.sh` | Configura banco e ambiente |
| `03-deploy-local-vps.sh` | Deploy automatizado |
| `deploy.sh` | Script principal de deploy |

## 📈 Funcionalidades do Plugin

### 🎓 Sistema de Cursos
- CPT de cursos personalizados
- Módulos e aulas estruturadas
- Certificados PDF automatizados
- Progresso de estudos

### 🔐 Downloads Seguros
- Links temporários com expiração
- Assinatura HMAC para segurança
- Controle de acesso por usuário
- Logs de download

### 📊 Relatórios
- Analytics de vendas
- Progresso de cursos
- Downloads por produto
- Engajamento de usuários

## 🤝 Suporte e Documentação

### 📚 Como Usar
1. **Instalar Tema**: Upload via Aparência > Temas
2. **Ativar Plugin**: Plugins > VancouverTec Digital Manager
3. **Configurar Produtos**: WooCommerce > Produtos
4. **Criar Cursos**: VT Manager > Cursos
5. **Configurar Downloads**: Produto > Especificações

### 🆘 Solução de Problemas
- Verifique permissões de arquivo (755/644)
- Confirme PHP 8.0+ e extensões necessárias
- Teste conexão com banco de dados
- Valide configurações de ambiente

## 📞 Contato e Suporte

**VancouverTec** - Soluções Digitais Premium
- 🌐 **Site**: https://vancouvertec.com.br
- 🛒 **Loja**: https://store.vancouvertec.com.br
- 📧 **Email**: contato@vancouvertec.com.br
- 📱 **Suporte**: Painel do Cliente

---

<div align="center">

**Desenvolvido com ❤️ pela VancouverTec**

*Transformando ideias em soluções digitais de alta performance*

</div>