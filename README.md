# Notebooks

## Adding a notebook

- To keep notes organised add a folder
  `<project_root>/_notebooks/<notebook_name>`
  - Create notes in this folder
  - Use front-matter to specify which notebook the note belongs to

## Create a note

Front matter
```yaml
---
title: <title of note>
notebook: <notebook name>
date: YYYY-mm-dd
layout: note
order: <specifies sequential order of page in notebook>
...
```
A file template has been set up so that it's easy to create a new note:
```markdown
---
title: $title
notebook: $notebook
layout: default
date: ${YEAR}-${MONTH}-${DAY} ${HOUR}:${MINUTE}
tags: $tag
...

# $title

[TOC]: #
```

## Images and other files

Through use of [jekyll-relative-links](https://github.com/benbalter/jekyll-relative-links),  
images can be placed in `_notebooks/<notebook>/img/`.

Alternative location: `static/img/<notebook>/` can be used to uncouple an image
from a particular notebook for whatever reason.

Other files should be placed in:
- `_notebooks/<notebook>/files`: for tightly coupled files
- `static/files`: for loosely coupled files

## Math


TODO: need a solution for
- inline math with LaTeX
- fenced math with LaTeX
that is compatible with
- Markdown preview
  - with Katex engine can use \$\` \`\$ for inline math
  - fenced math with \```math \latexthing \```
  - e.g.
1.
```math
G = \langle{V,E}\rangle
```
2.
  $`G = \langle{V,E}\rangle`$

3. Katex is supposed to work with $ G = \langle{V,E}\rangle $ for inline and  
$$`
G = \langle{V,E}\rangle  
`$$
4.
$$`
```latex
G = \langle{V,E}\rangle
```
`$$

for block

- Jekyll
- pandoc converter

Table comparing methods that work vs environment

- see if can get jekyll working with gitlab markdown syntax
- may have to use regex to edit markdown files before pdf build
[Part 1](https://web.archive.org/web/20170117172154/http://willdrevo.com/latex-equation-rendering-in-javascript-with-jekyll-and-katex/)
I installed katex with npm, then copied the katex dist directory into static files
I added javascript and css imports for katex to the default.html and head.html files
Then I added .equation to main.css and katex rendering to default.js
This enabled rendering of katex in raw display tags
[Part 2](https://nealde.github.io/blog/2017/10/20/How-to-make-a-local-Jekyll-website/)
I instead moved to copy this approach which enables \$\$ syntax


# PDFs

In the project root run `make` to build all PDFs for all *.md files in notebook folders. Note I have only used this on WSL.

PDFs are stored as `static/pdf/<notebook>/<note>.pdf`

To remove generated pdfs, run `make clean`

The template used for PDFs is [Eisvogel](https://github.com/Wandmalfarbe/pandoc-latex-template)

Templates for building PDFs are stored in `static/tex`

# Development

To build and view the site locally, run:
```bash
bundle exec jekyll serve -w 
```
- `-w`: auto-regeneration
- `-v`: verbose

## PyCharm Run Config

So that you aren't constantly running this command, you can [ set up a configuration ](https://turing4ever.github.io/2018/07/16/use-pycharm-to-blog-with-jekyll.html)
in pycharm and just hit run (`shift+f10`).

My setup:
![pycharm_jekyll_config](./static/img/pycharm_jekyll_config.png)
On Windows, to find the path to bundler, in PowerShell run:
```commandline
> where.exe bundle
```
