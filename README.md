# CV

My CV, written in LaTeX and built locally with [Tectonic](https://tectonic-typesetting.github.io/).

Three variants are built from one set of sources — **iOS**, **backend / data**,
and **mixed** (everything). Each job and project is a single file under
`sections/entries/`, and a CV is an ordered list of the entries it includes. Fix
a job description once and every CV that lists it picks up the change.

## Setup

```bash
brew install tectonic            # macOS; other platforms in the Tectonic docs
cp contact.example.tex contact.tex
```

`contact.tex` holds the real phone and email. It is gitignored, so it is never
published. If it is missing the build still works — it falls back to
`contact.example.tex` and renders a GitHub link in place of the contact line.

## Build

```bash
make          # all three -> build/cv-{ios,backend,mixed}.pdf
make ios      # just one variant
make backend
make mixed
make watch    # rebuild all three on every save
make open     # build all three, then open them
make clean
```

The first build downloads the LaTeX packages the document needs and caches them,
so it takes about a minute. Later builds take a couple of seconds.

## Layout

| Path | |
| --- | --- |
| `cv-ios.tex`, `cv-backend.tex`, `cv-mixed.tex` | document skeletons — one `\input` per section |
| `preamble.tex` | packages and the `resume_*` environments |
| `sections/` | shared content: header, About Me, Education |
| `sections/entries/` | **one file per job or project** — where content lives |
| `sections/ios/`, `backend/`, `mixed/` | ordered `\input` lists selecting entries |
| `contact.tex` | private contact details (gitignored) |

Adding a job to a CV means uncommenting one `\input` line. Where variants need
different framing of the same thing, there is a second entry file — SteamFriends
has iOS, backend and full-stack versions. Where one needs different wording in a
shared section, the variant sets a macro instead of forking the file: `\interests`
for the About Me line, `\contactextra` to append LinkedIn, `\sectionfilbreak` for
page-break behaviour, `\ailabminorprojects` for two optional sub-projects.

Sections switched off — `volunteer`, `freelance`, `honors` — are commented-out
`\input` lines in the variant files.

Commented-out blocks inside the section files are an archive of past roles and
alternate phrasings, kept on purpose rather than deleted.

## Engine

Tectonic is XeTeX-based. This document was originally compiled on Overleaf with
pdfLaTeX; the output is identical, but anything pdfLaTeX-specific (`\pdf...`
primitives, `inputenc` tricks) will not work here.
