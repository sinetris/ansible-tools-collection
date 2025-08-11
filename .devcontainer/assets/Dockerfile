ARG VARIANT=3-bookworm
FROM mcr.microsoft.com/devcontainers/python:${VARIANT}

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update

# Install dependencies needed to build Python and required libraries
RUN apt-get -y install --no-install-recommends \
  build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
  curl libonig-dev bash-completion libncursesw5-dev xz-utils tk-dev libxml2-dev \
  libxmlsec1-dev libffi-dev liblzma-dev

# Install other dependencies
RUN apt-get -y install --no-install-recommends \
  shellcheck fonts-powerline

ARG USERNAME=vscode

USER ${USERNAME}
ENV HOME=/home/${USERNAME}
ENV PROJECT_WORKDIR=/workspace
WORKDIR ${HOME}

RUN curl https://pyenv.run | bash

# Configure pyenv for bash
RUN echo 'export PYENV_ROOT="${HOME}/.pyenv"' >> ~/.bashrc
RUN echo '[[ -d "${PYENV_ROOT}/bin" ]] && export PATH="${PYENV_ROOT}/bin:${PATH}"' >> ~/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

# Configure pyenv for zsh
RUN echo 'export PYENV_ROOT="${HOME}/.pyenv"' >> ~/.zshenv
RUN echo '[[ -d ${PYENV_ROOT}/bin ]] && export PATH="${PYENV_ROOT}/bin:${PATH}"' >> ~/.zshenv
RUN echo 'eval "$(pyenv init - zsh)"' >> ~/.zshenv
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshenv

# Switch the shell to zsh
SHELL ["/bin/zsh", "-c"]

# Install Python versions from .python-version
COPY .python-version .
RUN pyenv install

# Install development dependencies
RUN pip install --upgrade pip

COPY requirements.txt /tmp/pip-temp/
COPY dev-requirements.txt /tmp/pip-temp/
COPY test-requirements.txt /tmp/pip-temp/
RUN pip --no-cache-dir install -r /tmp/pip-temp/dev-requirements.txt

WORKDIR ${PROJECT_WORKDIR}

CMD ["/bin/zsh", "-l"]
