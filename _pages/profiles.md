---
layout: page
permalink: /team/
title: Team
description: Members of NIMBUS
nav: true
nav_order: 7
---

<style>
  .team-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
    gap: 1.75rem 1.5rem;
    margin-bottom: 1.5rem;
  }
  .team-photo {
    width: 100%;
    aspect-ratio: 3 / 4;
    object-fit: cover;
    display: block;
    border-radius: 0;
  }
  .professor-photo {
    max-width: 240px;
    margin-bottom: 0.75rem;
  }
  .team-member-name {
    margin-top: 0.6rem;
    margin-bottom: 0.15rem;
    font-weight: 600;
    text-align: center;
  }
  .team-member-address {
    text-align: center;
    font-size: 0.875rem;
    opacity: 0.75;
  }
  .team-segment-title {
    margin-top: 2rem;
    margin-bottom: 1rem;
    font-size: 1.35rem;
    border-bottom: 1px solid rgba(128, 128, 128, 0.35);
    padding-bottom: 0.35rem;
  }
  .team-list {
    padding-left: 1.4rem;
    margin-bottom: 1.5rem;
  }
  .team-list li {
    margin-bottom: 0.4rem;
  }
  .team-list-address {
    margin-left: 0.4rem;
    font-size: 0.9em;
    opacity: 0.75;
  }
</style>

{% assign professor = site.data.team.professor %}

<hr />
<div class="profile float-left">
  {% if professor.photo and professor.photo != '' %}
    <img
      src="{{ professor.photo | prepend: 'assets/img/' | relative_url }}"
      alt="{{ professor.name }}"
      class="team-photo professor-photo"
    />
  {% endif %}
  <div class="more-info">
    <p>{{ professor.title }}</p>
  </div>
</div>
<div class="clearfix">
  {% capture professor_content %}{% include_relative {{ professor.content }} %}{% endcapture %}
  {{ professor_content | markdownify }}
</div>

{% for segment in site.data.team.segments %}
<h2 class="team-segment-title">{{ segment.title }}</h2>
{% if segment.layout == 'list' %}
<ul class="team-list">
{% for member in segment.members %}
<li>{{ member.name }}{% if member.address and member.address != '' %} <span class="team-list-address">&mdash; {{ member.address }}</span>{% endif %}</li>
{% endfor %}
</ul>
{% else %}
<div class="team-grid">
{% for member in segment.members %}
{% if member.photo and member.photo != '' %}
{% assign photo_path = member.photo | prepend: 'assets/img/' %}
{% else %}
{% assign photo_path = 'assets/img/team/placeholder.svg' %}
{% endif %}
<div class="team-member">
<img src="{{ photo_path | relative_url }}" alt="{{ member.name }}" class="team-photo" loading="lazy" />
<div class="team-member-name">{{ member.name }}</div>
{% if member.address and member.address != '' %}
<div class="team-member-address">{{ member.address }}</div>
{% endif %}
</div>
{% endfor %}
</div>
{% endif %}
{% endfor %}
