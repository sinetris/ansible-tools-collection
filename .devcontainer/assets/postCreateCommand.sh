#!/usr/bin/env bash
set -Eeuo pipefail

# Is likely that your host UID and the container UID are different.
# To avoid complaints when running 'tox', we tell git to ignore it.
git config --global --add safe.directory "${PROJECT_WORKDIR:?}"
cp "${PROJECT_WORKDIR}/.devcontainer/assets/.gitignore_global" ~/.gitignore_global

# Ensure proper DOCKER_HOST for docker-in-docker (for bash and zsh)
sed -zi '/export DOCKER_HOST=/!s/$/\nexport DOCKER_HOST=unix:\/\/\/var\/run\/docker\.sock/' \
  ~/.bashrc
sed -zi '/export DOCKER_HOST=/!s/$/\nexport DOCKER_HOST=unix:\/\/\/var\/run\/docker\.sock/' \
  ~/.zshrc

cd "${PROJECT_WORKDIR}"

# Create and activate Python virtual environment
uv venv --allow-existing --python="$(cat .python-version-default)"
source .venv/bin/activate

# Install tox and required dependencies
uv tool install tox --with tox-ansible,tox-docker,tox-extra,tox-uv

# Install pre-commit and pre-commit-uv
uv tool install pre-commit --with pre-commit-uv --force-reinstall

# Install ansible-dev-tools and executables
_dev_tools_exec=(
  ansible-builder
  ansible-core
  ansible-creator
  ansible-dev-environment
  ansible-lint
  ansible-sign
  molecule
  ansible-navigator
)
uv tool install ansible-dev-tools --with-executables-from \
  "${_dev_tools_exec[0]}$(printf ",%s" "${_dev_tools_exec[@]:1}")"
