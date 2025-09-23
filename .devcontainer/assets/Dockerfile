ARG VARIANT=bookworm
FROM mcr.microsoft.com/devcontainers/base:${VARIANT}

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update

# Install dependencies needed to build Python and required libraries
RUN apt-get -y install --no-install-recommends \
  build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
  curl libonig-dev bash-completion libncursesw5-dev xz-utils tk-dev libxml2-dev \
  libxmlsec1-dev libffi-dev liblzma-dev

# Install other dependencies
RUN apt-get -y install --no-install-recommends \
  shellcheck

ARG USERNAME=vscode

USER ${USERNAME}
ENV HOME=/home/${USERNAME}
ENV PROJECT_WORKDIR=/workspace/ansible_collections/sinetris/tools/
WORKDIR ${HOME}

# Ensure ~/.local/bin exists and is in PATH
RUN mkdir -p "$HOME/.local/bin"
RUN echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
RUN echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
ENV PATH="$HOME/.local/bin/:$PATH"

# Install uv
ENV UV_INSTALL_DIR="$HOME/.local/bin"
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Enable shell autocompletion for uv amd uvx commands (for bash and zsh)
RUN echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bashrc
RUN echo 'eval "$(uvx --generate-shell-completion bash)"' >> ~/.bashrc
RUN echo 'eval "$(uv generate-shell-completion zsh)"' >> ~/.zshrc
RUN echo 'eval "$(uvx --generate-shell-completion zsh)"' >> ~/.zshrc

# Switch the shell to zsh
SHELL ["/bin/zsh", "-c"]

# Use uv to install Python versions from .python-version-default
COPY .python-version-default .
RUN uv python install "$(cat .python-version-default)"

WORKDIR ${PROJECT_WORKDIR}

CMD ["/bin/zsh", "-l"]
