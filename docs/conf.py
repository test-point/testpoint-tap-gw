extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.viewcode',
    'sphinx.ext.graphviz',
    'sphinxcontrib.httpdomain'
]
templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'
project = u'TAP-GW'
copyright = u'2017, Chris Gough'
author = u'Chris Gough'
version = u'0.1'
release = u'0.1'
language = None
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store', '.venv']
pygments_style = 'sphinx'
todo_include_todos = False
html_theme = 'alabaster'
html_static_path = ['_static']
html_sidebars = {
    '**': ['about.html', 'navigation.html', 'searchbox.html']
}

htmlhelp_basename = 'tapgwdocsdoc'
latex_elements = {
    'papersize': 'a4paper',
}
latex_documents = [
    (master_doc, 'tapgwdocs.tex', u'TAP-GW Testpoint API Documentation',
     u'Chris Gough', 'manual'),
]
man_pages = [
    (master_doc, 'tapgwdocs', u'TAP-GW Testpoint API Documentation',
     [author], 1)
]
texinfo_documents = [
    (master_doc, 'tapgwdocs', u'TAP-GW Testpoint API Documentation',
     author, 'tapgwdocs', 'One line description of project.',
     'Miscellaneous'),
]
