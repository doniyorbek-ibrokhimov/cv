# CV

My CV, written in LaTeX and built locally with [Tectonic](https://tectonic-typesetting.github.io/).

Two variants are built from one set of sources — **iOS** and **backend / data**.
They share everything except Work Experience and Personal Projects, so a fix to
the header, About Me or Education lands in both.

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
make          # both -> build/cv-ios.pdf, build/cv-backend.pdf
make ios      # just the iOS one
make backend  # just the backend one
make watch    # rebuild both on every save
make open     # build both, then open them
make clean
```

The first build downloads the LaTeX packages the document needs and caches them,
so it takes about a minute. Later builds take a couple of seconds.

## Layout

| Path | |
| --- | --- |
| `cv-ios.tex`, `cv-backend.tex` | document skeletons — one `\input` per section |
| `preamble.tex` | packages and the `resume_*` environments |
| `sections/` | shared content: header, About Me, Education |
| `sections/ios/`, `sections/backend/` | per-variant Work Experience and Personal Projects |
| `contact.tex` | private contact details (gitignored) |

Where the two CVs genuinely need to differ, the variant file sets a macro rather
than forking the section — `\interests` supplies the About Me interests line, and
`\sectionfilbreak` controls whether a section is kept on one page.

Sections that are switched off — `volunteer`, `freelance`, `honors` — are
commented-out `\input` lines in the variant files. Toggle one by uncommenting it.

Commented-out blocks inside the section files are an archive of past roles and
alternate phrasings, kept on purpose rather than deleted.

## Engine

Tectonic is XeTeX-based. This document was originally compiled on Overleaf with
pdfLaTeX; the output is identical, but anything pdfLaTeX-specific (`\pdf...`
primitives, `inputenc` tricks) will not work here.
