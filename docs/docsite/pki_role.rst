.. Created with antsibull-docs

sinetris.tools.pki role -- Role to create PKIs
++++++++++++++++++++++++++++++++++++++++++++++

This role is part of the `sinetris.tools collection <https://galaxy.ansible.com/ui/repo/published/sinetris/tools/>`_ (version 0.1.0).

It is not included in ``ansible-core``.
To check whether it is installed, run :code:`ansible-galaxy collection list`.

To install it use: :code:`ansible-galaxy collection install sinetris.tools`.

To use it in a playbook, specify: :code:`sinetris.tools.pki`.

.. contents::
   :local:
   :depth: 2

.. _ansible_collections.sinetris.tools.pki_role__entrypoint-main:

Entry point ``main`` -- Role to create PKIs
-------------------------------------------

New in sinetris.tools 0.1.0


Synopsis
^^^^^^^^

- Role to create PKIs


Parameters
^^^^^^^^^^

.. raw:: html

  <table style="width: 100%;">
  <thead>
    <tr>
    <th><p>Parameter</p></th>
    <th><p>Comments</p></th>
  </tr>
  </thead>
  <tbody>
  <tr>
    <td valign="top">
      <div class="ansibleOptionAnchor" id="parameter-main--pki_action"></div>
      <p style="display: inline;"><strong>pki_action</strong></p>
      <a class="ansibleOptionLink" href="#parameter-main--pki_action" title="Permalink to this option"></a>
      <p style="font-size: small; margin-bottom: 0;">
        <span style="color: purple;">string</span>
        / <span style="color: red;">required</span>
      </p>

    </td>
    <td valign="top">
      <p>Action to perform</p>
      <p style="margin-top: 8px;"><b">Choices:</b></p>
      <ul>
        <li><p><code>&#34;prepare&#34;</code></p></li>
        <li><p><code>&#34;create-cert&#34;</code></p></li>
        <li><p><code>&#34;create-ca&#34;</code></p></li>
      </ul>

    </td>
  </tr>
  <tr>
    <td valign="top">
      <div class="ansibleOptionAnchor" id="parameter-main--pki_ca_base_data_dir"></div>
      <p style="display: inline;"><strong>pki_ca_base_data_dir</strong></p>
      <a class="ansibleOptionLink" href="#parameter-main--pki_ca_base_data_dir" title="Permalink to this option"></a>
      <p style="font-size: small; margin-bottom: 0;">
        <span style="color: purple;">string</span>
      </p>

    </td>
    <td valign="top">
      <p>Directory used to store the project PKI generated files</p>
      <p style="margin-top: 8px;"><b style="color: blue;">Default:</b> <code style="color: blue;">&#34;{{ pki_ca_base_dir }}/{{ pki_project }}/ca&#34;</code></p>
    </td>
  </tr>
  <tr>
    <td valign="top">
      <div class="ansibleOptionAnchor" id="parameter-main--pki_ca_base_dir"></div>
      <p style="display: inline;"><strong>pki_ca_base_dir</strong></p>
      <a class="ansibleOptionLink" href="#parameter-main--pki_ca_base_dir" title="Permalink to this option"></a>
      <p style="font-size: small; margin-bottom: 0;">
        <span style="color: purple;">string</span>
      </p>

    </td>
    <td valign="top">
      <p>Base directory used to store PKI related files for the project</p>
      <p style="margin-top: 8px;"><b style="color: blue;">Default:</b> <code style="color: blue;">&#34;$HOME/.local/pki&#34;</code></p>
    </td>
  </tr>
  <tr>
    <td valign="top">
      <div class="ansibleOptionAnchor" id="parameter-main--pki_ca_identifier"></div>
      <p style="display: inline;"><strong>pki_ca_identifier</strong></p>
      <a class="ansibleOptionLink" href="#parameter-main--pki_ca_identifier" title="Permalink to this option"></a>
      <p style="font-size: small; margin-bottom: 0;">
        <span style="color: purple;">string</span>
      </p>

    </td>
    <td valign="top">
      <p>Certificate Authority (CA) identifier</p>
      <p style="margin-top: 8px;"><b style="color: blue;">Default:</b> <code style="color: blue;">&#34;example-ca&#34;</code></p>
    </td>
  </tr>
  <tr>
    <td valign="top">
      <div class="ansibleOptionAnchor" id="parameter-main--pki_ca_issuer"></div>
      <p style="display: inline;"><strong>pki_ca_issuer</strong></p>
      <a class="ansibleOptionLink" href="#parameter-main--pki_ca_issuer" title="Permalink to this option"></a>
      <p style="font-size: small; margin-bottom: 0;">
        <span style="color: purple;">string</span>
      </p>

    </td>
    <td valign="top">
      <p>Issuer Certificate Authority (CA) identifier</p>
      <p>Required when creating Intermediate CA</p>
    </td>
  </tr>
  <tr>
    <td valign="top">
      <div class="ansibleOptionAnchor" id="parameter-main--pki_ca_type"></div>
      <p style="display: inline;"><strong>pki_ca_type</strong></p>
      <a class="ansibleOptionLink" href="#parameter-main--pki_ca_type" title="Permalink to this option"></a>
      <p style="font-size: small; margin-bottom: 0;">
        <span style="color: purple;">string</span>
        / <span style="color: red;">required</span>
      </p>

    </td>
    <td valign="top">
      <p>CA type</p>
      <p style="margin-top: 8px;"><b">Choices:</b></p>
      <ul>
        <li><p><code>&#34;root-ca&#34;</code></p></li>
        <li><p><code>&#34;intermediate-ca&#34;</code></p></li>
        <li><p><code>&#34;signing-ca&#34;</code></p></li>
      </ul>

    </td>
  </tr>
  <tr>
    <td valign="top">
      <div class="ansibleOptionAnchor" id="parameter-main--pki_cert_type"></div>
      <p style="display: inline;"><strong>pki_cert_type</strong></p>
      <a class="ansibleOptionLink" href="#parameter-main--pki_cert_type" title="Permalink to this option"></a>
      <p style="font-size: small; margin-bottom: 0;">
        <span style="color: purple;">string</span>
        / <span style="color: red;">required</span>
      </p>

    </td>
    <td valign="top">
      <p>Certificate type</p>
      <p style="margin-top: 8px;"><b">Choices:</b></p>
      <ul>
        <li><p><code>&#34;self-signed-cert&#34;</code></p></li>
        <li><p><code>&#34;ca-cert&#34;</code></p></li>
        <li><p><code>&#34;cross-cert&#34;</code></p></li>
        <li><p><code>&#34;leaf-cert&#34;</code></p></li>
      </ul>

    </td>
  </tr>
  <tr>
    <td valign="top">
      <div class="ansibleOptionAnchor" id="parameter-main--pki_config_dir"></div>
      <p style="display: inline;"><strong>pki_config_dir</strong></p>
      <a class="ansibleOptionLink" href="#parameter-main--pki_config_dir" title="Permalink to this option"></a>
      <p style="font-size: small; margin-bottom: 0;">
        <span style="color: purple;">string</span>
      </p>

    </td>
    <td valign="top">
      <p>Directory used to store the config files for the PKI project</p>
      <p style="margin-top: 8px;"><b style="color: blue;">Default:</b> <code style="color: blue;">&#34;{{ pki_ca_base_dir }}/{{ pki_project }}/.config&#34;</code></p>
    </td>
  </tr>
  <tr>
    <td valign="top">
      <div class="ansibleOptionAnchor" id="parameter-main--pki_dir_group"></div>
      <p style="display: inline;"><strong>pki_dir_group</strong></p>
      <a class="ansibleOptionLink" href="#parameter-main--pki_dir_group" title="Permalink to this option"></a>
      <p style="font-size: small; margin-bottom: 0;">
        <span style="color: purple;">string</span>
      </p>

    </td>
    <td valign="top">
      <p>Name of the group that should own the directory for the PKI project</p>
      <p style="margin-top: 8px;"><b style="color: blue;">Default:</b> <code style="color: blue;">&#34;{{ ansible_user }}&#34;</code></p>
    </td>
  </tr>
  <tr>
    <td valign="top">
      <div class="ansibleOptionAnchor" id="parameter-main--pki_dir_owner"></div>
      <p style="display: inline;"><strong>pki_dir_owner</strong></p>
      <a class="ansibleOptionLink" href="#parameter-main--pki_dir_owner" title="Permalink to this option"></a>
      <p style="font-size: small; margin-bottom: 0;">
        <span style="color: purple;">string</span>
      </p>

    </td>
    <td valign="top">
      <p>Name of the user that should own the directory for the PKI project</p>
      <p style="margin-top: 8px;"><b style="color: blue;">Default:</b> <code style="color: blue;">&#34;{{ ansible_user }}&#34;</code></p>
    </td>
  </tr>
  <tr>
    <td valign="top">
      <div class="ansibleOptionAnchor" id="parameter-main--pki_project"></div>
      <p style="display: inline;"><strong>pki_project</strong></p>
      <a class="ansibleOptionLink" href="#parameter-main--pki_project" title="Permalink to this option"></a>
      <p style="font-size: small; margin-bottom: 0;">
        <span style="color: purple;">string</span>
        / <span style="color: red;">required</span>
      </p>

    </td>
    <td valign="top">
      <p>A project name for the PKI</p>
    </td>
  </tr>
  </tbody>
  </table>







Authors
^^^^^^^

- Duilio Ruggiero



.. Extra links

Collection links
~~~~~~~~~~~~~~~~

* `Issue Tracker <https://github.com/sinetris/ansible-tools-collection/issues>`__
* `Repository (Sources) <https://github.com/sinetris/ansible-tools-collection>`__
* `Report an issue <https://github.com/sinetris/ansible-tools-collection/issues/new/choose>`__
