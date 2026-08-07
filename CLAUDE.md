# CV repo

Personal CV for Doniyorbek Ibrokhimov. Ported from Overleaf, built locally with Tectonic.

## Build

- Compile with `make`. Output: `build/cv.pdf`.
- `make watch` rebuilds on save; `make open` builds and opens the PDF.
- **After any `.tex` edit, run `make` and confirm exit 0 before reporting done.**
- Never edit anything in `build/` — it is generated and gitignored.

## Engine

Overleaf compiled this with **pdfLaTeX** (TeX Live 2023). Tectonic is **XeTeX**-based,
so the engine is not identical — XeTeX substitutes Latin Modern for Computer Modern.
Output was verified pixel-identical at the time of the port, but be aware that anything
pdfLaTeX-specific (`\pdf...` primitives, `inputenc` tricks) will not work here.

## Layout

- `cv.tex` — document skeleton only: `\documentclass`, `\input{preamble.tex}`, and one
  `\input` per section. Avoid touching it except to toggle a section on/off.
- `preamble.tex` — packages plus the `resume_section` / `resume_employer` /
  `tabbedsection` environment definitions. Rarely needs changes.
- `sections/*.tex` — all content. This is where edits belong.
- `contact.tex` — **gitignored**, holds the real phone/email as `\contactdetails`.
  `contact.example.tex` is the tracked stand-in that keeps a fresh clone building.

Sections currently disabled are commented-out `\input` lines in `cv.tex`
(`volunteer`, `freelance`, `honors`). Toggle a whole section by uncommenting one line
rather than moving content between files.

## Publishing / privacy

This repo is intended to be public. Personal data must not enter tracked files.

- Phone and email belong **only** in `contact.tex`. Never inline them into
  `sections/*.tex`, not even inside a comment — comments are published too.
- Never re-add student IDs, date of birth, or home address. They were
  deliberately removed; they are invisible in the PDF but plain text in source.
- Commented-out content is published verbatim. Before committing, treat a comment
  as public writing: no private notes, no remarks about named people.
- `preamble.tex` loads contacts via `\IfFileExists`, so the build must keep working
  when `contact.tex` is absent. Verify with:
  `mv contact.tex /tmp && make && mv /tmp/contact.tex .`

## Content conventions

- This CV keeps a lot of **commented-out history** inline — past employers, old projects,
  alternate phrasings. That is deliberate. Do not delete commented blocks to "clean up";
  they are an archive the author toggles between versions.
- Entries are ordered most-recent-first within each section.
- `\vspace{\projectspacing}` separates projects inside a single `resume_employer` block.

## Length

The CV is currently **2 pages**. If a change pushes it to 3, say so and stop — do not
silently compensate by shrinking margins, reducing font size, or tightening the
`\secsep` / `\projectspacing` lengths. Cutting content is the author's call.
