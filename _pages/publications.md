---
layout: page
permalink: /publications/
title: Publications
description: Automatically populated from Dr. Laura Brattain's Google Scholar profile.
nav: true
nav_order: 2
---

<div class="publications scholar-pubs">
  <style>
    .scholar-pubs {
      counter-reset: pub-num;
    }
    .scholar-pubs ol {
      list-style: none;
      padding-left: 0;
    }
    .scholar-pubs ol li {
      counter-increment: pub-num;
      position: relative;
      padding-left: 3em;
      margin-bottom: 0.75rem;
    }
    .scholar-pubs ol li::before {
      content: counter(pub-num) ".";
      position: absolute;
      left: 0;
      width: 2.4em;
      text-align: right;
      opacity: 0.75;
    }
    .scholar-pubs h2.pub-year {
      margin-top: 1.75rem;
      margin-bottom: 0.75rem;
      font-size: 1.35rem;
      border-bottom: 1px solid rgba(128, 128, 128, 0.35);
      padding-bottom: 0.35rem;
    }
    .scholar-pubs h2.pub-year:first-of-type {
      margin-top: 0.5rem;
    }
  </style>
  {% if site.data.citations.papers_list and site.data.citations.papers_list.size > 0 %}
    {% assign current_year = '' %}
    {% for paper in site.data.citations.papers_list %}
      {% if paper.year != current_year %}
        {% unless forloop.first %}
    </ol>
        {% endunless %}
    <h2 class="pub-year">{{ paper.year }}</h2>
    <ol class="pub-year-list">
        {% assign current_year = paper.year %}
      {% endif %}
      <li>
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
