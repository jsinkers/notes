---
layout: default
title: Notes
---
<div>
{% assign notebooks = site.notebooks | group_by: "notebook" %}
{% include group-by-array.html collection=site.notebooks field='notebook' %}
{% for group in group_names %}
    {{ group }}
{% endfor %}
{% for notebook in notebooks %}
    <h1>{{ notebook.name }}</h1>
    <ul>
    {% for note in notebook.items %}
        <li>
            <a href="{{ site.baseurl }}{{ note.url }}">{{ note.title }}</a>
        </li>
    {% endfor %}
    </ul>
{% endfor %}
</div>
