#!/usr/bin/env bash
set -Eeuo pipefail

# Is likely that your host UID and the container UID are different.
# To avoid complaints when running 'tox', we tell git to ignore it.
git config --global --add safe.directory "${PROJECT_WORKDIR:?}"
cp "${PROJECT_WORKDIR}/.devcontainer/assets/.gitignore_global" ~/.gitignore_global

cd "${PROJECT_WORKDIR}"
pre-commit install --install-hooks
ansible-galaxy install -r requirements.yml

# Ensure proper DOCKER_HOST for docker-in-docker
# for bash
sed -zi '/export DOCKER_HOST=/!s/$/\nexport DOCKER_HOST=unix:\/\/\/var\/run\/docker\.sock/' \
  ~/.bashrc
# for zsh
sed -zi '/export DOCKER_HOST=/!s/$/\nexport DOCKER_HOST=unix:\/\/\/var\/run\/docker\.sock/' \
  ~/.zshenv
