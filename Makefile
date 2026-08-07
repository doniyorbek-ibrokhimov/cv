OUTDIR := build

.PHONY: all build ios backend mixed watch open clean

## Build all variants.
all: ios backend mixed
build: all

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
