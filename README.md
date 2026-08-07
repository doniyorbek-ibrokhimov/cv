# CV

My CV, written in LaTeX and built locally with [Tectonic](https://tectonic-typesetting.github.io/).

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
make          # -> build/cv.pdf
make watch    # rebuild on every save
make open     # build, then open the PDF
make clean
```

The first build downloads the LaTeX packages the document needs and caches them,
so it takes about a minute. Later builds take a couple of seconds.

## Layout

| Path | |
| --- | --- |
| `cv.tex` | document skeleton — one `\input` per section |
| `preamble.tex` | packages and the `resume_*` environments |
| `sections/` | all content; edits go here |
| `contact.tex` | private contact details (gitignored) |

Sections that are switched off — `volunteer`, `freelance`, `honors` — are
commented-out `\input` lines in `cv.tex`. Toggle one by uncommenting its line.

Commented-out blocks inside the section files are an archive of past roles and
alternate phrasings, kept on purpose rather than deleted.

## Engine

Tectonic is XeTeX-based. This document was originally compiled on Overleaf with
pdfLaTeX; the output is identical, but anything pdfLaTeX-specific (`\pdf...`
primitives, `inputenc` tricks) will not work here.
