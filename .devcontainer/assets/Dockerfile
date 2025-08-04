FROM mcr.microsoft.com/devcontainers/python:1-3.12-bullseye

# Install the xz-utils package
RUN apt-get update

# Install basic dependencies
RUN apt-get install -y make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev curl git libonig-dev bash-completion \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

  # Install pre-commit dependencies
RUN apt-get install -y shellcheck

USER vscode

ENV PROJECT_WORKDIR=/workspace
WORKDIR ${PROJECT_WORKDIR}

RUN pip install --upgrade pip

COPY dev-requirements.txt /tmp/dev-requirements.txt
COPY test-requirements.txt /tmp/test-requirements.txt
RUN pip install -r /tmp/dev-requirements.txt

RUN curl https://pyenv.run | bash

RUN echo 'export PYENV_ROOT="${HOME}/.pyenv"' >> ~/.bashrc
RUN echo '[[ -d "${PYENV_ROOT}/bin" ]] && export PATH="${PYENV_ROOT}/bin:${PATH}"' >> ~/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
RUN echo 'export CXX=/usr/bin/g++' >> ~/.bashrc
