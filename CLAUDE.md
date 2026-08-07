# CV repo

Personal CV for Doniyorbek Ibrokhimov. Ported from Overleaf, built locally with Tectonic.

**Two variants** share one set of sections: `cv-ios.tex` (iOS roles) and
`cv-backend.tex` (backend / data roles).

## Build

- `make` builds both. Output: `build/cv-ios.pdf`, `build/cv-backend.pdf`.
- `make ios` / `make backend` build one; `make watch` rebuilds both on save.
- **After any `.tex` edit, run `make` and confirm exit 0 before reporting done.**
  Edits to shared sections affect both PDFs — check both.
- Never edit anything in `build/` — it is generated and gitignored.

## Engine

Overleaf compiled this with **pdfLaTeX** (TeX Live 2023). Tectonic is **XeTeX**-based,
so the engine is not identical — XeTeX substitutes Latin Modern for Computer Modern.
Output was verified pixel-identical at the time of the port, but be aware that anything
pdfLaTeX-specific (`\pdf...` primitives, `inputenc` tricks) will not work here.

## Layout

- `cv-ios.tex`, `cv-backend.tex` — document skeletons: `\documentclass`,
  `\input{preamble.tex}`, the per-variant knobs, and one `\input` per section.
  Touch only to toggle a section on/off or change a knob.
- `preamble.tex` — packages plus the `resume_section` / `resume_employer` /
  `tabbedsection` environment definitions. Rarely needs changes.
- `sections/*.tex` — **shared by both variants**: `header`, `about`, `education`,
  plus the disabled `volunteer` and `honors`.
- `sections/ios/`, `sections/backend/` — variant-only: `experience`, `projects`
  (and `freelance`, disabled, under `ios/`).
- `contact.tex` — **gitignored**, holds the real phone/email as `\contactdetails`.
  `contact.example.tex` is the tracked stand-in that keeps a fresh clone building.

Sections currently disabled are commented-out `\input` lines in the variant files.
Toggle a whole section by uncommenting one line rather than moving content.

### Shared vs variant

Editing anything in `sections/` directly changes **both** CVs. That is the point —
do not fix a divergence by copying a shared section into `ios/` and `backend/`.
If one variant genuinely needs different wording, add a knob instead:

- `\interests` — the About Me interests line. Each variant defines it with
  `\newcommand`. Deliberately **not** given a default in `preamble.tex`: a missing
  definition must fail the build (verified: exit 1, no PDF) rather than render a
  placeholder into a PDF that gets sent out.
- `\sectionfilbreak` — whether a section is kept on one page. Defaults to
  `\filbreak`; `cv-backend.tex` overrides it to empty to match its original.

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
- The GPA line in `sections/education.tex` was unified to the iOS wording
  (`3.5/4 85%`); the backend original wrote `3.5-4(85%)`. Keep a single wording —
  the two CVs stating the same GPA differently is what merging them fixed.

## Length

Both variants are currently **2 pages**. If a change pushes either to 3, say so and
stop — do not silently compensate by shrinking margins, reducing font size, or
tightening the `\secsep` / `\projectspacing` lengths. Cutting content is the author's
call. A shared-section edit can overflow one variant and not the other, so check both.
