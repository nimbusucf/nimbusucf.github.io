---
layout: page
permalink: /publications/
title: Publications
description: Automatically populated from Dr. Laura Brattain's Google Scholar profile.
nav: true
nav_order: 2
---

<div class="publications">
  {% if site.data.citations.papers_list and site.data.citations.papers_list.size > 0 %}
    <ol class="publication-list">
      {% for paper in site.data.citations.papers_list %}
        <li class="mb-3">
          <a href="{{ paper.url }}" target="_blank" rel="noopener">{{ paper.title }}</a>
          {% if paper.authors and paper.authors != '' %}
            <br />
            <span class="text-muted">{{ paper.authors }}</span>
          {% endif %}
          <br />
          <span class="text-muted small">
            {% if paper.venue and paper.venue != '' %}{{ paper.venue }}{% endif %}
            {% if paper.year and paper.year != 'Unknown Year' %}
              {% if paper.venue and paper.venue != '' %}&middot;{% endif %}
              {{ paper.year }}
            {% endif %}
            {% if paper.citations and paper.citations > 0 %}
              &middot; Cited by {{ paper.citations }}
            {% endif %}
          </span>
        </li>
      {% endfor %}
    </ol>
    <p class="text-muted small mt-4">
      Last updated: {{ site.data.citations.metadata.last_updated }} &middot;
      <a
        href="https://scholar.google.com/citations?user={{ site.data.socials.scholar_userid }}&hl=en"
        target="_blank"
        rel="noopener"
        >View on Google Scholar</a
      >
    </p>
  {% else %}
    <p>Publications are being fetched from Google Scholar. Please check back soon.</p>
  {% endif %}
</div>
