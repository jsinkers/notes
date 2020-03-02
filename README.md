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
