# sinetris.tools pki Role

A role to generate PKIs.

Part of the [sinetris.tools](https://github.com/sinetris/ansible-tools-collection) Ansible collection.

## Requirements

OpenSSL 3 CLI (can be installed by this role).

## Role Variables

See [argument_specs.yml](https://github.com/sinetris/ansible-tools-collection/blob/main/roles/pki/meta/argument_specs.yml).

## Dependencies

None.

## Example Playbook

Example to create Root CA:

```yaml
- name: Create Root CA
  hosts: localhost
  roles:
    - role: sinetris.tools.pki
      pki_action: prepare
      pki_project: demo
      pki_ca_identifier: demo-root-ca
    - role: sinetris.tools.pki
      pki_action: create-cert
      pki_project: demo
      pki_cert_type: self-signed-cert
      pki_ca_identifier: demo-root-ca
    - role: sinetris.tools.pki
      pki_action: create-ca
      pki_project: demo
      pki_ca_type: root-ca
      pki_ca_identifier: demo-root-ca
- name: Create Intermediate CA
  hosts: localhost
  roles:
    - role: sinetris.tools.pki
      pki_action: prepare
      pki_project: demo
      pki_ca_identifier: demo-intermediate-ca
    - role: sinetris.tools.pki
      pki_action: create-cert
      pki_project: demo
      pki_cert_type: self-signed-cert
      pki_ca_identifier: demo-intermediate-ca
    - role: sinetris.tools.pki
      pki_action: create-ca
      pki_project: demo
      pki_ca_type: intermediate-ca
      pki_ca_identifier: demo-intermediate-ca
      pki_ca_issuer: demo-root-ca
```

Another way to consume this role would be:

```yaml
- name: Create Root CA
  hosts: localhost
  roles:
    - role: sinetris.tools.pki
      pki_action: prepare
    - role: sinetris.tools.pki
      pki_action: create-cert
    - role: sinetris.tools.pki
      pki_action: create-ca
  vars:
    pki_project: demo
    pki_ca_identifier: demo-root-ca
    pki_cert_type: self-signed-cert
    pki_ca_type: root-ca
- name: Create Intermediate CA
  hosts: localhost
  roles:
    - role: sinetris.tools.pki
      pki_action: prepare
    - role: sinetris.tools.pki
      pki_action: create-cert
    - role: sinetris.tools.pki
      pki_action: create-ca
  vars:
    pki_project: demo
    pki_ca_identifier: demo-intermediate-ca
    pki_cert_type: ca-cert
    pki_ca_issuer: demo-root-ca
    pki_ca_type: intermediate-ca
```

## Role Idempotency

This role is idempotent (can be applied multiple times without changing the result).

## License

Apache License 2.0 or later.

See [LICENSE](https://github.com/sinetris/ansible-tools-collection/blob/main/LICENSE)
to see the full text.

## Resources

I took inspiration from the following sources:

- [OpenSSL Cookbook - 3rd Edition (by Ivan Ristić)][openssl-cookbook]
- [K3s custom CA certificate generator script][k3s-custom-ca]
- [OpenSSL PKI Tutorials][pki-tutorial]

[openssl-cookbook]:
  <https://www.feistyduck.com/library/openssl-cookbook/online/>
  "OpenSSL Cookbook - 3rd Edition (by Ivan Ristić)"
[k3s-custom-ca]:
  <https://github.com/k3s-io/k3s/blob/v1.33.3%2Bk3s1/contrib/util/generate-custom-ca-certs.sh>
  "K3s custom CA certificate generator script"
[pki-tutorial]:
  <https://pki-tutorial.readthedocs.io/en/>
  "OpenSSL PKI Tutorials"
