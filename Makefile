OUTDIR := build

.PHONY: all build ios backend mixed jobs watch open clean

## Build all variants, plus every per-job CV.
all: ios backend mixed jobs
build: all

## Per-job CVs: one skeleton per application in jobs/, built to build/jobs/.
## Compiled from the repo root (-Z search-path) so \input paths match the variants.
JOBS := $(wildcard jobs/*.tex)
jobs:
	@mkdir -p $(OUTDIR)/jobs
	@for f in $(JOBS); do \
	  tectonic -X compile -Z search-path=. "$$f" --outdir $(OUTDIR)/jobs || exit 1; \
	done

## Tectonic will not create OUTDIR itself, hence the mkdir.
ios:
	@mkdir -p $(OUTDIR)
	tectonic -X compile cv-ios.tex --outdir $(OUTDIR)

backend:
	@mkdir -p $(OUTDIR)
	tectonic -X compile cv-backend.tex --outdir $(OUTDIR)

mixed:
	@mkdir -p $(OUTDIR)
	tectonic -X compile cv-mixed.tex --outdir $(OUTDIR)

## Rebuild all on every save. Ctrl-C to stop.
watch:
	@mkdir -p $(OUTDIR)
	tectonic -X watch \
	  -x "compile cv-ios.tex --outdir $(OUTDIR)" \
	  -x "compile cv-backend.tex --outdir $(OUTDIR)" \
	  -x "compile cv-mixed.tex --outdir $(OUTDIR)"

## Build all, then open them.
open: all
	open $(OUTDIR)/cv-ios.pdf $(OUTDIR)/cv-backend.pdf $(OUTDIR)/cv-mixed.pdf

clean:
	rm -rf $(OUTDIR)
