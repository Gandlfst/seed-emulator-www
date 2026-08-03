---
layout: default
title: Mini Internet
section: internet
intro: "A comprehensive mini Internet example with Internet exchanges, transit ASes, stub ASes, routing layers, and runtime validation."
---

{% assign example = site.data.example_sources | where: "id", "b00-mini-internet" | first %}
{% capture readme %}
{% include example-readmes/b00-mini-internet.md %}
{% endcapture %}

<div class="example-readme">
{{ readme | markdownify }}
</div>

<hr>

<p class="example-source-note">
  Source README:
  <a href="{{ example.repository_url }}/tree/{{ example.branch }}/{{ example.source_path }}">{{ example.source_path }}/README.md</a>.
</p>
