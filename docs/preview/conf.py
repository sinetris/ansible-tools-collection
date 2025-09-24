"""
Configuration file for building docs.
"""

project = "sinetris.tools Ansible collection"

title = "Sinetris Tools Ansible Collection Documentation"
html_short_title = "Sinetris Tools Ansible Collection Documentation"
copyright = "2025"

extensions = [
    "sphinx.ext.autodoc",
    "sphinx.ext.intersphinx",
    "sphinx_antsibull_ext",
    "sphinx_copybutton",
]

pygments_style = "ansible"

highlight_language = "YAML+Jinja"

html_theme = "sphinx_ansible_theme"
html_show_sphinx = False

html_use_smartypants = True
html_use_modindex = False
html_use_index = False
html_copy_source = False
html_show_copyright = False

suppress_warnings = [
    "toc.not_included",
    "ref.ref",
]

default_role = "any"
