---
layout: page
permalink: /dashboard/
title: Dashboard
description: Upcoming conference deadlines for the NIMBUS lab.
nav: true
nav_order: 3
---

<style>
  .deadline-title {
    margin-top: 2rem;
    margin-bottom: 1rem;
    font-size: 1.35rem;
    border-bottom: 1px solid rgba(128, 128, 128, 0.35);
    padding-bottom: 0.35rem;
  }
  .deadline-title:first-of-type {
    margin-top: 0.5rem;
  }
  .deadline-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
    gap: 1.75rem 1.5rem;
    margin-bottom: 1.5rem;
  }
  .cd-circle {
    position: relative;
    width: 100%;
    max-width: 160px;
    aspect-ratio: 1;
    margin: 0 auto;
    --cd-color: #adb5bd;
  }
  .cd-circle svg {
    width: 100%;
    height: 100%;
    transform: rotate(-90deg);
  }
  .cd-track {
    fill: none;
    stroke: rgba(128, 128, 128, 0.25);
    stroke-width: 8;
  }
  .cd-progress {
    fill: none;
    stroke: var(--cd-color);
    stroke-width: 8;
    stroke-linecap: round;
    stroke-dasharray: 326.73;
    stroke-dashoffset: 0;
    transition: stroke 0.5s ease;
  }
  .cd-text {
    position: absolute;
    inset: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 0.1rem;
  }
  .cd-main {
    font-weight: 700;
    font-size: 0.95rem;
    color: var(--cd-color);
  }
  .cd-sub {
    font-variant-numeric: tabular-nums;
    font-size: 0.8rem;
    opacity: 0.85;
  }
  .cd-type {
    text-align: center;
    margin-top: 0.6rem;
    font-weight: 600;
  }
  .cd-when {
    text-align: center;
    font-size: 0.75rem;
    opacity: 0.7;
  }
</style>

{% assign now_iso = site.time | date: '%Y-%m-%dT%H:%M:%SZ' %}
{% assign any_entry = false %}

<div class="deadline-list">
{% for conf in site.data.conferences.ccf.conferences %}
{% assign conf_future = false %}
{% for d in conf.deadlines %}
{% if d.at >= now_iso %}
{% assign conf_future = true %}
{% endif %}
{% endfor %}
{% if conf_future %}
{% assign any_entry = true %}
<div class="deadline-conf">
<h2 class="deadline-title">
{% if conf.link %}
<a href="{{ conf.link }}" target="_blank" rel="noopener">{{ conf.name }} {{ conf.year }}</a>
{% else %}
{{ conf.name }} {{ conf.year }}
{% endif %}
</h2>
<div class="deadline-grid">
{% for d in conf.deadlines %}
{% if d.at >= now_iso %}
<div class="deadline-item">
<div class="cd-circle" data-at="{{ d.at }}">
<svg viewBox="0 0 120 120" aria-hidden="true">
<circle class="cd-track" cx="60" cy="60" r="52"></circle>
<circle class="cd-progress" cx="60" cy="60" r="52"></circle>
</svg>
<div class="cd-text">
<div class="cd-main">--</div>
<div class="cd-sub">--:--:--</div>
</div>
</div>
<div class="cd-type">{{ d.type }}</div>
<div class="cd-when">{{ d.display }}</div>
</div>
{% endif %}
{% endfor %}
</div>
</div>
{% endif %}
{% endfor %}

{% for conf in site.data.conferences.manual %}
{% assign any_entry = true %}
<div class="deadline-conf">
<h2 class="deadline-title">
{% if conf.link %}
<a href="{{ conf.link }}" target="_blank" rel="noopener">{{ conf.name }} {{ conf.year }}</a>
{% else %}
{{ conf.name }} {{ conf.year }}
{% endif %}
</h2>
<div class="deadline-grid">
{% for d in conf.deadlines %}
<div class="deadline-item">
<div class="cd-circle" data-date="{{ d.date }}" data-tz="{{ conf.timezone | default: 'UTC' }}">
<svg viewBox="0 0 120 120" aria-hidden="true">
<circle class="cd-track" cx="60" cy="60" r="52"></circle>
<circle class="cd-progress" cx="60" cy="60" r="52"></circle>
</svg>
<div class="cd-text">
<div class="cd-main">--</div>
<div class="cd-sub">--:--:--</div>
</div>
</div>
<div class="cd-type">{{ d.type }}</div>
<div class="cd-when">{{ d.date }} {{ conf.timezone | default: 'UTC' }}</div>
</div>
{% endfor %}
</div>
</div>
{% endfor %}
</div>

{% unless any_entry %}
<p>No upcoming conference deadlines right now — check back soon.</p>
{% endunless %}

<p class="text-muted small mt-4">
Auto-updated daily from
<a href="https://github.com/ccfddl/ccf-deadlines" target="_blank" rel="noopener">ccfddl/ccf-deadlines</a>
&middot; data as of {{ site.data.conferences.ccf.last_updated }} &middot; manual entries:
<code>_data/conferences.yml</code>
</p>

<script>
  (function () {
    var C = 2 * Math.PI * 52;
    function pad(n) {
      return (n < 10 ? '0' : '') + n;
    }
    function parseWhen(el) {
      if (el.dataset.at) {
        return new Date(el.dataset.at);
      }
      var m = /^(\d{4})-(\d{2})-(\d{2})[ T](\d{2}):(\d{2})(?::(\d{2}))?$/.exec(el.dataset.date || '');
      if (!m) {
        return null;
      }
      var ms = Date.UTC(+m[1], +m[2] - 1, +m[3], +m[4], +m[5], +(m[6] || 0));
      var tz = el.dataset.tz || 'UTC';
      var off = 0;
      var t = /^UTC([+-])(\d{1,2})(?::(\d{2}))?$/.exec(tz);
      if (t) {
        off = (t[1] === '-' ? -1 : 1) * (parseInt(t[2], 10) * 60 + (t[3] ? parseInt(t[3], 10) : 0));
      } else if (/^aoe$/i.test(tz)) {
        off = -12 * 60;
      }
      return new Date(ms - off * 60000);
    }
    function colorFor(target, now) {
      if (now >= target) {
        return '#e03131';
      }
      var twoMonths = new Date(target.getTime());
      twoMonths.setMonth(twoMonths.getMonth() - 2);
      if (now < twoMonths) {
        return '#2f9e44';
      }
      if (now < target - 21 * 86400000) {
        return '#f59f00';
      }
      if (now < target - 7 * 86400000) {
        return '#e8590c';
      }
      return '#e03131';
    }
    var circles = Array.prototype.slice.call(document.querySelectorAll('.cd-circle'));
    circles.forEach(function (circle) {
      var progress = circle.querySelector('.cd-progress');
      progress.style.strokeDasharray = C;
      progress.style.strokeDashoffset = 0;
    });
    function tick() {
      var now = new Date();
      circles.forEach(function (circle) {
        var target = circle._target || (circle._target = parseWhen(circle));
        var item = circle.closest('.deadline-item');
        if (!target || isNaN(target.getTime()) || target <= now) {
          item.style.display = 'none';
          return;
        }
        item.style.display = '';
        var diff = target - now;
        var sec = Math.floor(diff / 1000);
        var daysTotal = Math.floor(sec / 86400);
        var months = Math.floor(daysTotal / 30.44);
        var days = Math.floor(daysTotal - months * 30.44);
        var hours = Math.floor((sec % 86400) / 3600);
        var mins = Math.floor((sec % 3600) / 60);
        var secs = sec % 60;
        var color = colorFor(target, now);
        circle.style.setProperty('--cd-color', color);
        circle.querySelector('.cd-main').textContent = months + ' mo ' + days + ' d';
        circle.querySelector('.cd-sub').textContent = pad(hours) + ':' + pad(mins) + ':' + pad(secs);
        circle.querySelector('.cd-progress').style.strokeDashoffset =
          C * (1 - Math.min(diff / (365 * 86400000), 1));
      });
      Array.prototype.forEach.call(document.querySelectorAll('.deadline-conf'), function (section) {
        var items = section.querySelectorAll('.deadline-item');
        var anyVisible = Array.prototype.some.call(items, function (item) {
          return item.style.display !== 'none';
        });
        section.style.display = anyVisible ? '' : 'none';
      });
    }
    function sortSections() {
      var list = document.querySelector('.deadline-list');
      if (!list) {
        return;
      }
      var entries = Array.prototype.map.call(
        list.querySelectorAll('.deadline-conf'),
        function (section) {
          var earliest = Infinity;
          Array.prototype.forEach.call(section.querySelectorAll('.deadline-item'), function (item) {
            if (item.style.display === 'none') {
              return;
            }
            var circle = item.querySelector('.cd-circle');
            var target = circle && circle._target;
            if (target && !isNaN(target.getTime())) {
              earliest = Math.min(earliest, target.getTime());
            }
          });
          return { section: section, earliest: earliest };
        }
      );
      entries.sort(function (a, b) {
        return a.earliest - b.earliest;
      });
      entries.forEach(function (entry) {
        list.appendChild(entry.section);
      });
    }
    tick();
    sortSections();
    setInterval(tick, 1000);
  })();
</script>
