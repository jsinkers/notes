# Notebooks

## Adding a notebook

- To keep notes organised add a folder
  `<project_root>/_notebooks/<notebook_name>`
- Create notes in this folder, use front-matter to specify
  which notebook the note belongs to

## Create a note

Front matter
```yaml
---
title: <title of note>
notebook: <notebook name>
date: YYYY-mm-dd
layout: default
order: <specifies sequential order in notebook>
---
```

## Development

To build and view the site locally, run:
```bash
bundle exec jekyll serve -w 
```