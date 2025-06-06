FROM mcr.microsoft.com/devcontainers/dotnet:1-8.0-bookworm

ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages
RUN apt-get update && apt-get install -y \
    zsh curl git unzip sudo wget locales build-essential ruby ruby-dev \
    procps apt-transport-https ca-certificates gnupg lsb-release \
    fontconfig dos2unix

# Set shell for RUN commands
SHELL ["/bin/bash", "-c"]

# Install Oh My Zsh
RUN if [ ! -d "/home/vscode/.oh-my-zsh" ]; then \
    su vscode -c "sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" \"\" --unattended"; \
    fi

# Install popular zsh plugins
RUN su vscode -c "git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions" && \
    su vscode -c "git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" && \
    su vscode -c "git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search" && \
    su vscode -c "git clone https://github.com/agkozak/zsh-z ~/.oh-my-zsh/custom/plugins/zsh-z" && \
    su vscode -c "git clone https://github.com/wfxr/forgit ~/.oh-my-zsh/custom/plugins/forgit"

# Install fonts-noto-color-emoji for emoji support
RUN apt-get update && apt-get install -y fonts-noto-color-emoji && \
    fc-cache -f -v

# Set locale to UTF-8
RUN apt-get update && apt-get install -y locales && \
    sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Install fzf with default keybindings
RUN su vscode -c "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf" && \
    su vscode -c "~/.fzf/install --key-bindings --completion --no-update-rc"

# Configure .zshrc with agnoster theme and plugins
RUN sed -i 's/^ZSH_THEME=.*/ZSH_THEME="agnoster"/' /home/vscode/.zshrc && \
    sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' /home/vscode/.zshrc

# Install CaskaydiaMono Nerd Font (monospace required for terminal)
RUN apt-get update && apt-get install -y unzip fontconfig && \
    mkdir -p /usr/share/fonts/truetype/caskaydia && \
    cd /tmp && \
    curl -fLo CascadiaCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/CascadiaCode.zip && \
    unzip CascadiaCode.zip -d CascadiaCode && \
    cp CascadiaCode/*NerdFontMono-*.ttf /usr/share/fonts/truetype/caskaydia/ && \
    fc-cache -fv && \
    rm -rf CascadiaCode CascadiaCode.zip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Homebrew (non-interactive)
RUN if [ ! -d "/home/linuxbrew/.linuxbrew" ]; then \
    su vscode -c "NONINTERACTIVE=1 /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""; \
    fi

# Add Homebrew to shell profiles
RUN echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/vscode/.zshrc && \
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/vscode/.bashrc && \
    echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >> /home/vscode/.bashrc && \
    chown vscode:vscode /home/vscode/.zshrc /home/vscode/.bashrc

# Set Zsh as default shell for vscode user
RUN chsh -s $(which zsh) vscode

# Install SQL tools (sqlcmd and sqlpackage)
COPY mssql/installSQLtools.sh installSQLtools.sh
RUN dos2unix installSQLtools.sh && bash ./installSQLtools.sh && rm installSQLtools.sh

# Install Node.js and TypeScript using NVM
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && \
    nvm install --lts && \
    nvm use --lts && \
    npm install -g typescript" && \
    echo 'source /usr/local/share/nvm/nvm.sh' >> /home/vscode/.zshrc && \
    echo 'nvm use --lts >/dev/null' >> /home/vscode/.zshrc

# Set working directory
WORKDIR /workspaces

# Start Zsh by default
CMD ["zsh"]
