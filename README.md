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

Math is rendered using Katex.  It is set up to use pandoc syntax, and has custom
setup for Jekyll and Markdown Navigator so that both the site and the Markdown preview
render math correctly.

_From [Katex docs](https://katex.org/docs/autorender.html)_ with customised delimiter options so that it is  
consistent with pandoc:
- `$ $` for inline math
- `$$ $$` for centred display math
  - currently doesn't support multi-line math, you should instead use display math
    delimiters for each line

### Example

- This is $E = mc^2$ inline math
- This is $$E = mc^2$$ display math
- $$ multi-line $$
  $$ display\times math $$

### Katex in Preview

- For preview to work I added the following to the HTML head in
  _Settings > Markdown > HTML Generation > Head Top_:
```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/katex.min.css" integrity="sha384-zB1R0rpPzHqg7Kpt0Aljp8JPLqbXI3bhnPWROx27a9N0Ll6ZP/+DiW/UqRcLbRjq" crossorigin="anonymous">
<script defer src="https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/katex.min.js" integrity="sha384-y23I5Q6l+B6vatafAwxRu/0oK/79VlbSz7Q9aiSZUvyWYIYsd+qj+o24G5ZU2zJz" crossorigin="anonymous"></script>
<script defer src="https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/contrib/auto-render.min.js" integrity="sha384-kWPLUVMOks5AQFrykwIup5lo0m3iMkkHrD0uJ4H5cjeGihAutqP0yW0J6dpFiVkI" crossorigin="anonymous"></script>
```
  And also added this to _Settings > Markdown > HTML Generation > Body Bottom_:
```html
<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        renderMathInElement(document.body, {
            delimiters: [{left: "$$", right: "$$", display: true},
                         {left: "$", right: "$", display: false}]
        });
    });
</script>
```

### Katex with Jekyll

In Jekyll I set up:
- `default.js`: uses the same delimiters
- `_includes\head.html`: imports katex css
- `_layouts\default.html`: import katex scripts
However I didn't seem to be able to disable the kramdown math engine, so I had to
use an additional [ script ]() to turn `math/tex` scripts to be rendered.

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
