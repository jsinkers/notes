---
layout: default
title: Notes
---
<div>
{% assign notes = site.collections | where: "label", "notebooks" | first %}
{% comment %}
{% assign notebooks = notes | group_by: "notebook" %}
{% for notebook in notebooks %}
    {{ notebook.name }}
    {% for note in notebook %}
        {{ note.title }}
    {% endfor %}
{% endfor %}
{% endcomment %}
<ul>
    {% for note in notes.docs %}
        <li>
            <a href="{{ site.baseurl }}{{ note.url }}">{{ note.title }}</a> : {{ note.notebook }}
        </li>
    {% endfor %}
</ul>
</div>
