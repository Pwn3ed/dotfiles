{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim                       # Editor de texto moderno e extensível
    wget                         # Ferramenta de download via HTTP/FTP
    curl                         # Cliente de linha de comando para URLs
    git                          # Sistema de controle de versão distribuído
    gh                           # CLI oficial do GitHub
    firefox                      # Navegador web
    htop                         # Monitor de processos interativo
    mysql                        # Banco de dados relacional SQL (cliente)
    fzf                          # Ferramenta de fuzzy finder (busca aproximada)
    unzip                        # Utilitário para descompactar arquivos .zip
    xclip                        # Acesso à área de transferência no X11
    gcc                          # Compilador C/C++ padrão
    ripgrep                      # Ferramenta de busca rápida em arquivos
    fd                           # Alternativa rápida ao comando `find`
    nodejs                       # Ambiente de execução JavaScript do lado do servidor
    lua-language-server          # LSP (Language Server Protocol) para desenvolvimento em Lua
    tree-sitter                  # Parser incremental para análise sintática de código-fonte
    make                         # Ferramenta de automação de compilação
    python3                      # Interpretador da linguagem Python
    pip                          # Gerenciador de pacotes Python
    go                           # Linguagem de programação Go
    openjdk                      # Kit de Desenvolvimento Java (JDK)
    maven                        # Ferramenta de build e gerenciamento de dependências Java
    latexmk                      # Compilador automatizado para projetos LaTeX
    texlive.combined.scheme-full # Conjunto completo de pacotes LaTeX
    nerd-fonts.fira-code         # Fonte Fira Code com ligaduras, ótima para programadores
    # Android Studio
    # Flutter
    # Gimp
    # Love
    # Tree-sitter-cli
    # gnupg gnupg2 ?
    # libc6:amd64 libstdc++6:amd64 lib32z1 libbz2-1.0:amd64 libsdl2-dev
    # xz-utils zip libglu1-mesa
    # love luarocks
    # unityhub
    # dotnet
  ];
}
