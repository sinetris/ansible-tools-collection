"""
Configuration file for building docs.
"""

project = "Sinetris Tools Ansible collection"

title = "Sinetris Tools Ansible Collection Documentation"
html_short_title = "Sinetris Tools Ansible Collection Documentation"

extensions = [
    "sphinx.ext.autodoc",
    "sphinx.ext.intersphinx",
    "sphinx_antsibull_ext",
]

pygments_style = "ansible"

html_theme = "sphinx_ansible_theme"
html_show_sphinx = False

suppress_warnings = [
    "toc.not_included",
]
