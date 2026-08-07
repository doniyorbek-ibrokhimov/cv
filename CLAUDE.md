# CV repo

Personal CV for Doniyorbek Ibrokhimov. Ported from Overleaf, built locally with Tectonic.

**Three variants** built from one set of sources: `cv-ios.tex` (iOS roles),
`cv-backend.tex` (backend / data roles), and `cv-mixed.tex` (everything).

## Build

- `make` builds all three: `build/cv-ios.pdf`, `cv-backend.pdf`, `cv-mixed.pdf`.
- `make ios` / `make backend` / `make mixed` build one; `make watch` rebuilds all.
- **After any `.tex` edit, run `make` and confirm exit 0 before reporting done.**
  Most content is shared — an edit usually lands in more than one PDF. Check all.
- Never edit anything in `build/` — it is generated and gitignored.

## Engine

Overleaf compiled this with **pdfLaTeX** (TeX Live 2023). Tectonic is **XeTeX**-based,
so the engine is not identical — XeTeX substitutes Latin Modern for Computer Modern.
Output was verified pixel-identical at the time of the port, but be aware that anything
pdfLaTeX-specific (`\pdf...` primitives, `inputenc` tricks) will not work here.

## Layout

- `cv-ios.tex`, `cv-backend.tex`, `cv-mixed.tex` — document skeletons:
  `\documentclass`, `\input{preamble.tex}`, the per-variant knobs, and one
  `\input` per section. Touch only to toggle a section or change a knob.
- `preamble.tex` — packages plus the `resume_section` / `resume_employer` /
  `tabbedsection` environment definitions. Rarely needs changes.
- `sections/*.tex` — **shared by all variants**: `header`, `about`, `education`,
  plus the disabled `volunteer` and `honors`.
- **`sections/entries/*.tex` — one file per job or project.** This is where the
  actual content lives and where edits belong.
- `sections/ios/`, `sections/backend/`, `sections/mixed/` — `experience.tex` and
  `projects.tex`, each just an **ordered list of `\input` lines**. No prose.
- `contact.tex` — **gitignored**, holds the real phone/email as `\contactdetails`.
  `contact.example.tex` is the tracked stand-in that keeps a fresh clone building.

### The entry model

An entry file holds one job or project, in one canonical wording, used by every
CV that lists it. A variant includes an entry by `\input`, and drops it by
commenting that line out. Entries disabled everywhere (`wss`, `quakeready`,
`musico`, …) stay as files — they are the archive.

Consequences worth knowing:

- **Editing an entry changes every CV that includes it.** That is the point. Do
  not resolve a divergence by copying an entry into a second file.
- Where variants genuinely need different framing, make a second entry file with
  a suffix — see `steamfriends-ios` / `-backend` / `-fullstack`.
- Where a variant needs part of an entry, split that part out and gate it with a
  knob — see `ai-lab-minor.tex` and `\ailabminorprojects`.
- Canonical wording was chosen as: iOS CV wins for iOS roles, backend CV wins for
  backend roles. Alternate phrasings from the losing variant are kept, commented,
  under `%% --- archived alternate wording ---` at the bottom of the entry file.

### Knobs

Each variant sets these after `\input{preamble.tex}`:

- `\interests` — the About Me interests line. Deliberately **not** given a default
  in `preamble.tex`: a missing definition must fail the build (verified: exit 1,
  no PDF) rather than render a placeholder into a PDF that gets sent out.
- `\sectionfilbreak` — whether a section is kept on one page. Defaults to
  `\filbreak`; `cv-backend.tex` and `cv-mixed.tex` set it empty to match their
  originals.
- `\contactextra` — appended to the Contacts line. Empty by default; only
  `cv-mixed.tex` sets it, to add LinkedIn.
- `\ailabminorprojects` — the Cashier and Momento sub-projects inside the AI Lab
  iOS entry. Off by default; only `cv-ios.tex` switches them on.

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
- The GPA line in `sections/education.tex` is `3.5/4 88%`, confirmed by the author.
  The three Overleaf originals disagreed (`3.5/4 85%`, `3.5-4(85%)`, `3.5-4 88%`).
  Keep one wording — CVs contradicting each other on a fact is the bug that
  merging them fixed.

## Length

iOS **2 pages**, backend **2 pages**, mixed **3 pages**. If a change pushes any of
them over, say so and stop — do not silently compensate by shrinking margins,
reducing font size, or tightening the `\secsep` / `\projectspacing` lengths.
Cutting content is the author's call. An edit to a shared entry can overflow one
variant and not another, so check all three.
