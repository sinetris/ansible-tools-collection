#!/usr/bin/env bash
set -Eeuo pipefail

# Is likely that your host UID and the container UID are different.
# To avoid complaints when running 'tox', we tell git to ignore it.
git config --global --add safe.directory "${PROJECT_WORKDIR:?}"
cp "${PROJECT_WORKDIR}/.devcontainer/assets/.gitignore_global" ~/.gitignore_global

cd "${PROJECT_WORKDIR}"
pre-commit install --install-hooks
ansible-galaxy install -r requirements.yml
