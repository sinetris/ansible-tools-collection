# Sinetris Tools Collection

This repository contains the `sinetris.tools` Ansible Collection.

- [Ansible version compatibility](#ansible-version-compatibility)
- [External requirements](#external-requirements)
- [Included content](#included-content)
- [Using this collection](#using-this-collection)
- [Release notes](#release-notes)
- [Roadmap](#roadmap)
- [Development](#development)
  - [Requirements](#requirements)
    - [Use a Dev Container](#use-a-dev-container)
      - [Install Colima on Mac](#install-colima-on-mac)
    - [Local OS](#local-os)
  - [Run tests](#run-tests)
  - [Propose Changes](#propose-changes)
  - [Create changelogs for a new release](#create-changelogs-for-a-new-release)
  - [Generate Documentation](#generate-documentation)
- [More information](#more-information)
- [Licensing](#licensing)

<!--start requires_ansible-->
## Ansible version compatibility

This collection has been tested against the following Ansible versions: **>=2.16.0**.

Plugins and modules within a collection may be tested with only specific Ansible versions.
A collection may contain metadata that identifies these versions.
PEP440 is the schema used to describe the versions of Ansible.
<!--end requires_ansible-->

## External requirements

Some modules and plugins require external libraries. Please check the
requirements for each plugin or module you use in the documentation to find out
which requirements are needed.

## Included content

<!--start collection content-->
<!--end collection content-->

## Using this collection

```bash
ansible-galaxy collection install sinetris.tools
```

You can also include it in a `requirements.yml` file and install it via
`ansible-galaxy collection install -r requirements.yml` using the format:

```yaml
collections:
  - name: sinetris.tools
```

To upgrade the collection to the latest available version, run the following
command:

```bash
ansible-galaxy collection install sinetris.tools --upgrade
```

You can also install a specific version of the collection, for example, if you
need to downgrade when something is broken in the latest version (please report
an issue in this repository). Use the following syntax where `X.Y.Z` can be any
[available version](https://galaxy.ansible.com/sinetris/tools):

```bash
ansible-galaxy collection install sinetris.tools:==X.Y.Z
```

See
[Ansible Using Collections](https://docs.ansible.com/ansible/latest/user_guide/collections_using.html)
for more details.

## Release notes

See the
[changelog](https://github.com/sinetris/ansible-tools-collection/tree/main/CHANGELOG.md).

## Roadmap

<!--
  Optional. Include the roadmap for this collection, and the proposed release/versioning
  strategy so users can anticipate the upgrade/update cycle.
-->

## Development

### Requirements

#### Use a Dev Container

To simplify development, this project includes a [devcontainer.json] file that
takes care of installing all dependencies in a container, allowing you to use the
[Visual Studio Code Dev Containers][vs-code-devcontainers] extension.

Requirements:

- [Docker][docker-setup]

> **NOTE:** If you are on macOS, is more convenient to install Docker in [Colima](#install-colima-on-mac).
> instead of using [Docker Desktop for Mac][docker-mac].

##### Install Colima on Mac

To use Docker in [Colima][colima] on macOS, you also need to install the related docker client CLIs.

```sh
brew install docker docker-compose docker-buildx
brew install colima
mkdir -p ~/.docker
cat > ~/.docker/config.json <<'EOF'
	{
	  "auths": {},
	  "currentContext": "colima",
	  "cliPluginsExtraDirs": [
	    "/opt/homebrew/lib/docker/cli-plugins"
	  ]
	}
EOF
```

Th default machine started by colima use 2 CPUs an 2GB of RAM.

```terminal
$ colima list
PROFILE    STATUS     ARCH       CPUS    MEMORY    DISK      RUNTIME    ADDRESS
default    Running    aarch64    2       2GiB      100GiB    docker
```

To change the machine resources used, stop the image and restart it with different amount of CPUs
and RAM (if you want to assign an IP to the machine, add `--network-address`).

```sh
colima stop
colima start --cpu 4 --memory 8 --network-address
```

Check if the changes have been applied.

```terminal
$ colima list
PROFILE    STATUS     ARCH       CPUS    MEMORY    DISK      RUNTIME    ADDRESS
default    Running    aarch64    4       8GiB      100GiB    docker     192.168.106.13
```

#### Local OS

> **Note:** To develop Ansible collections, the collection must be in a directory under
> `ansible_collections/<namespace>/<name>`.
>
> For example, this project must be in `ansible_collections/sinetris/tools`.

Requirements:

- git
- Python 3 (installed using `pyenv`)
- [pyenv](https://github.com/pyenv/pyenv)

```sh
# Clone the repository in a valid directory
MY_COLLECTIONS_PATH=${HOME}/projects/ansible_collections
mkdir -v -p "${MY_COLLECTIONS_PATH:?}"/sinetris
cd "${MY_COLLECTIONS_PATH}"/sinetris
git clone git@github.com:sinetris/ansible-tools-collection.git tools
cd tools

# Install Python 3 using pyenv
pyenv install

# Ensure we are using pyenv
pyenv version
# should show something like: 3.12.6 (set by PYENV_VERSION environment variable)

# Update pip
pip install --upgrade pip

# Install development packages
pip install -r dev-requirements.txt

# Install collection requirements
ansible-galaxy install -r requirements.yml
```

### Run tests

After fulfilling the [requirements](#requirements),
from the project root run:

```sh
# Validate pre-commit config
pre-commit validate-config
# Update pre-commit config repos
pre-commit autoupdate
# Install pre-commit script and hooks
pre-commit install --install-hooks
# Run pre-commit for all files (to ensure there are no errors)
pre-commit run --all-files
# Ensure generated documentation is up to date
collection_prep_add_docs -p . --link-collection
# List tests available environments
tox list --ansible --conf tox-ansible.ini
# Run sanity tests on all available environments
tox run --ansible -f sanity --conf tox-ansible.ini
# Run all tests in parallel
ansible-test integration --docker --docker-privileged --docker-network=bridge
```

### Propose Changes

Create a new branch, make changes, add a changelog file documenting the changes (see
[antsibull-changelog documentation][antsibull-changelog-docs] for details), run tests,
commit changes in new branch, make pull request.

```sh
# Validating changelog fragments
antsibull-changelog lint
# Run all tests on all available environments
tox run-parallel --ansible --conf tox-ansible.ini
# If you want to test changes not committed to git yet, add `--allow-dirty`
# For example:
echo 'Remember to remove this line' >> README.md
tox -e sanity-py3.12-2.19 --ansible --conf tox-ansible.ini --allow-dirty
```

### Create changelogs for a new release

> **Note:** This is done by the collection maintainers

```sh
antsibull-changelog release --version 0.1.1
```

### Generate Documentation

To update the documentation, run:

```sh
tox run -f docs --ansible --conf tox-ansible.ini
```

To generate html files from the documentation, run:

```sh
tox run -f docs-build --ansible --conf tox-ansible.ini
```

To see a preview, open `docs/build/index.html` in a browser.

## More information

- [Ansible collection development forum](https://forum.ansible.com/c/project/collection-development/27)
- [Ansible User guide](https://docs.ansible.com/ansible/devel/user_guide/index.html)
- [Ansible Developer guide](https://docs.ansible.com/ansible/devel/dev_guide/index.html)
- [Ansible Collections Checklist](https://docs.ansible.com/ansible/devel/community/collection_contributors/collection_requirements.html)
- [Ansible Community code of conduct](https://docs.ansible.com/ansible/devel/community/code_of_conduct.html)
- [The Bullhorn (the Ansible Contributor newsletter)](https://docs.ansible.com/ansible/devel/community/communication.html#the-bullhorn)
- [News for Maintainers](https://forum.ansible.com/tag/news-for-maintainers)

## Licensing

Apache License 2.0 or later.

See [LICENSE](https://github.com/sinetris/ansible-tools-collection/blob/main/LICENSE)
to see the full text.

[antsibull-changelog-docs]: <https://ansible.readthedocs.io/projects/antsibull-changelog/changelogs/> "antsibull-changelog Documentation"
[colima]: <https://github.com/abiosoft/colima> "Colima: container runtimes on macOS"
[docker-mac]: <https://docs.docker.com/desktop/setup/install/mac-install/> "Install Docker Desktop on Mac"
[docker-setup]: <https://docs.docker.com/get-started/introduction/get-docker-desktop/> "Get Docker Desktop"
[vs-code-devcontainers]: <https://code.visualstudio.com/docs/devcontainers/containers> "VS Code: Developing inside a Container"
[devcontainer.json]: <https://github.com/sinetris/ansible-tools-collection/blob/main/.devcontainer/devcontainer.json> "devcontainer.json"
