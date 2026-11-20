# NIMBUS Lab Website

Source of [nimbus-ai.dev](https://nimbus-ai.dev) — the website for the NIMBUS lab (Dr. Laura Brattain, UCF).

Built with [Jekyll](https://jekyllrb.com/) on the [al-folio](https://github.com/alshedivat/al-folio) starter. The site is driven by plain files in this repository: **push to `main` and GitHub Actions rebuilds and deploys automatically** (about 5 minutes; progress under the **Actions** tab).

The original al-folio documentation is kept in [alfolio_readme.md](alfolio_readme.md).

---

## 1. Updating the Team page

The team page (`/team/`) is driven by one file: [`_data/team.yml`](_data/team.yml).

### Add a member

1. Put the photo in `assets/img/team/` (jpg/png; portrait orientation works best).
2. Open `_data/team.yml` and find the right segment:
   - `postdocs` — Postdoctoral Researchers (photo cards)
   - `phd` — PhD Students (photo cards)
   - `masters` — Masters Students (photo cards)
   - `undergrads` — Undergraduate Students (bullet list, no photos)
   - `alumni` — Alumni (bullet list, no photos)
3. Add an entry. The `photo` path is **relative to `assets/img/`** and is case-sensitive:

   ```yaml
   - name: Jane Doe
     photo: team/jane.jpg # file lives at assets/img/team/jane.jpg
     address: BMS125 # optional; leave blank to hide
   ```

4. Commit and push to `main` — done.

### Remove a member

Delete their entry from `_data/team.yml`. You can also delete the photo from `assets/img/team/` if nothing else uses it.

### Photos

- Any image size works; it is displayed as a 3:4 portrait crop.
- Paths are case-sensitive: `team/Jose.jpg` is not the same as `team/jose.jpg`.
- Leave `photo:` blank (or omit it) to show the grey silhouette placeholder.

### Professor

- Her full bio: [`_pages/team/laura.md`](_pages/team/laura.md)
- Her name, title, address and photo: the `professor:` block at the top of `_data/team.yml`

### Segment layouts

Each segment accepts `layout: cards` (default — photo, name, address) or `layout: list` (plain bullet list, no photos).

---

## 2. Updating News

News items live in [`_news/](_news/)](_news/) and appear on the home page (most recent 5, newest first).

### Add a news item

1. Create `_news/YYYYMMDD_slug.md`, e.g. `_news/20261120_ai_workshop.md`
2. Use this template:

   ```markdown
   ---
   layout: post
   date: 2026-11-20 9:00:00-0500
   inline: true
   related_posts: false
   ---

   Your announcement text — shown directly on the home page.
   ```

3. Commit and push to `main`.

Notes:

- Use today's date or earlier (future-dated items do not publish).
- The `date` field drives ordering.
- For a full post page instead of an inline blurb, set `title: Post Title` and `inline: false` — the home page then shows the title as a link to `/news/...`.

### Edit or remove news

Edit or delete the corresponding file in `_news/`.

---

## 3. Updating the Prospective Members page

The page (`/prospective/`) is a single file: [`_pages/prospective.md`](_pages/prospective.md).

### Edit the content

1. Open `_pages/prospective.md` and edit the text below the front matter — leave the front matter block intact.
2. The contact address is a normal markdown link in the body:

   ```markdown
   [laura.brattain@ucf.edu](mailto:laura.brattain@ucf.edu)
   ```

   If the address ever changes, update both the visible text and the `mailto:` part.

3. Commit and push to `main`.

### Enable or disable the page

The `hide:` flag in the front matter controls visibility:

1. Open `_pages/prospective.md`.
2. Set `hide: true` to **disable** the page, or `hide: false` to **show** it:

   ```yaml
   hide: false # visible: appears in the menu and at /prospective/
   ```

   ```yaml
   hide: true # hidden: removed from the menu, the URL and the sitemap
   ```

3. Commit and push to `main` — the change takes effect on the next deploy.

Notes:

- `hide: true` removes the page completely (menu, URL, sitemap).
- `nav: false` is a lighter option: keeps the page reachable at `/prospective/` but drops it from the menu only.
- The hide flag is honored by [`_plugins/hide_pages.rb`](_plugins/hide_pages.rb) — plain Jekyll ignores `published: false` for pages.

---

## 4. Updating the Dashboard (conference deadlines)

The Dashboard (`/dashboard/`) is driven by one file: [`_data/conferences.yml`](_data/conferences.yml). It has three parts: `selected:` (conferences fetched automatically), `manual:` (hand-maintained entries), and an AUTO section between markers that only the daily job may rewrite — never edit the AUTO section by hand.

### Add a conference for automatic fetching

1. Find the conference's acronym in the [ccfddl/ccf-deadlines](https://github.com/ccfddl/ccf-deadlines) repository — files live at `conference/<category>/<name>.yml` in lowercase (e.g. `conference/MX/miccai.yml`). Search the repository for the conference name.
2. Open `_data/conferences.yml` and add the lowercase acronym under `selected:`:

   ```yaml
   selected:
     - miccai
     - your-new-conference
   ```

3. Commit and push to `main`. The next daily run (06:23 UTC) — or a manual run via **Actions → "Update conference deadlines" → Run workflow** — fetches every still-future deadline for that conference and shows it on the Dashboard, sorted by soonest deadline.

Notes:

- Only announced, future deadlines appear; venues whose dates are still `TBD` appear automatically once ccfddl publishes them.
- Past deadlines disappear on their own.

### Add a manual entry (conferences not in ccfddl)

1. Open `_data/conferences.yml` and add an entry under `manual:`:

   ```yaml
   manual:
     - name: NIMBUS Symposium
       year: 2027
       link: https://example.com # optional
       timezone: UTC-5 # optional; default UTC (AoE also accepted)
       deadlines:
         - type: Full Paper Submission
           date: "2027-01-15 23:59:59"
         - type: Registration
           date: "2027-02-01 23:59:59"
   ```

2. Commit and push to `main` — the entry renders immediately, no fetch needed.

Notes:

- Manual entries are never overwritten: the daily job only rewrites the AUTO section between the `==== AUTO BEGIN ====` and `==== AUTO END ====` markers.
- `date` is wall-clock time in the entry's `timezone` (UTC when omitted).

---

## 5. Instructing an AI agent (OpenCode, Claude Code, …)

Give the agent this context together with the task, for example:

```text
This repository is the NIMBUS lab website (Jekyll, al-folio fork).
Pushing to main auto-deploys to https://nimbus-ai.dev via GitHub Actions (~5 min).

Where things live:
- _data/team.yml          team page roster (photo paths relative to assets/img/)
- _news/YYYYMMDD_slug.md  news items shown on the home page
- _pages/about.md         home page
- _pages/team/laura.md    professor's bio
- _pages/publications.md  publications page (auto-filled from Google Scholar)
- _pages/prospective.md   prospective members page (hide: true hides it completely)
- _data/conferences.yml    dashboard: conference selection + manual deadlines (AUTO section is generated)
- assets/img/             images (team photos in assets/img/team/)
- README.md               how to update this repo
- alfolio_readme.md       original al-folio documentation

Rules:
1. Only edit content files: _data/, _news/, _pages/, assets/img/, README.md.
   Do NOT edit _layouts/, _includes/, .github/workflows/, Gemfile, or _config.yml
   — they come from the al-folio theme and our fork.
2. Keep YAML valid: no stray unindented lines; indent list items consistently.
3. Photo paths are case-sensitive and relative to assets/img/ (team/jane.jpg).
4. Validate data files after editing, e.g.:
   python3 -c "import yaml; yaml.safe_load(open('_data/team.yml'))"
5. Optional build check (must exit 0):
   docker build -t nimbus-folio-build .
   docker run --rm -v "$PWD":/srv/jekyll -w /srv/jekyll nimbus-folio-build bundle exec jekyll build
6. Commit with a clear message and ask me before pushing to main.

Task: <describe the update>
```

Tips:

- Be specific about the desired result ("add Jane Doe to PhD Students with photo assets/img/team/jane.jpg and address BMS125").
- Ask the agent to show the changed files before committing.
- Agents can open pull requests instead of pushing to `main` if you prefer reviewing on GitHub.

---

## Quick reference

| Task                  | File(s)                                            |
| --------------------- | -------------------------------------------------- |
| Team members/photos   | `_data/team.yml`, `assets/img/team/`               |
| Professor bio         | `_pages/team/laura.md`                             |
| News                  | `_news/YYYYMMDD_slug.md`                           |
| Conference deadlines  | `_data/conferences.yml`                            |
| Prospective Members   | `_pages/prospective.md` (set `hide: true` to hide) |
| Home page text        | `_pages/about.md`                                  |
| Selected publications | `_bibliography/papers.bib`                         |
| Publications (auto)   | Google Scholar → `_data/citations.yml`             |

Publications refresh automatically from Dr. Brattain's Google Scholar profile on the 1st and 15th of each month (Actions → "Update Google Scholar Citations"). Conference deadlines on the Dashboard refresh daily from [ccfddl/ccf-deadlines](https://github.com/ccfddl/ccf-deadlines) (Actions → "Update conference deadlines"); hand-maintained entries go under `manual:` in `_data/conferences.yml`.
