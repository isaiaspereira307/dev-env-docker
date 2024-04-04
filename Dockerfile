FROM alpine:edge

# Definindo o email como variável de ambiente
ARG EMAIL="your_email@example.com"

# Instalação de pacotes necessários
RUN apk add --update \
    git \
    lazygit \
    neovim \
    ripgrep \
    alpine-sdk \
    python3 \
    python3-dev \
    py3-pip \
    rust \
    go \
    tmux \
    openssh

# Criação de usuário dev com sudo
RUN adduser -D dev && \
    echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Configuração do ambiente
USER dev
WORKDIR /home/dev

# Geração de chaves SSH
RUN ssh-keygen -q -t ed25519 -C "$EMAIL" -N '' -f ~/.ssh/id_ed25519 && \
    cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys

# Clone do repositório do LazyVim e configuração do NeoVim
RUN git clone https://github.com/LazyVim/starter ~/.config/nvim

