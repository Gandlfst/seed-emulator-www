---
layout: default
title: Internet Emulator Examples
section: internet
intro: "Examples and starter scenarios for building experiments with the SEED Internet Emulator."
---

{% assign examples = site.data.example_sources | default: empty %}

<div class="example-list">
  {% for example in examples %}
    <a class="example-card" href="{{ example.url | relative_url }}">
      <span class="example-card__eyebrow">{{ example.category }}</span>
      <h2>{{ example.title }}</h2>
      <p>{{ example.description }}</p>
      {% if example.tags %}
        <div class="example-card__meta" aria-label="Example tags">
          {% for tag in example.tags %}
            <span>{{ tag }}</span>
          {% endfor %}
        </div>
      {% endif %}
      <strong class="example-card__action">View README page</strong>
    </a>
  {% endfor %}
</div>

Run `ruby tools/fetch_example_readmes.rb` before building the site to refresh
the source README files used by these Jekyll pages.
