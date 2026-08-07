OUTDIR := build

.PHONY: all build ios backend watch open clean

## Build both variants.
all: ios backend
build: all

## Tectonic will not create OUTDIR itself, hence the mkdir.
ios:
	@mkdir -p $(OUTDIR)
	tectonic -X compile cv-ios.tex --outdir $(OUTDIR)

backend:
	@mkdir -p $(OUTDIR)
	tectonic -X compile cv-backend.tex --outdir $(OUTDIR)

## Rebuild both on every save. Ctrl-C to stop.
watch:
	@mkdir -p $(OUTDIR)
	tectonic -X watch \
	  -x "compile cv-ios.tex --outdir $(OUTDIR)" \
	  -x "compile cv-backend.tex --outdir $(OUTDIR)"

## Build both, then open them.
open: all
	open $(OUTDIR)/cv-ios.pdf $(OUTDIR)/cv-backend.pdf

clean:
	rm -rf $(OUTDIR)
