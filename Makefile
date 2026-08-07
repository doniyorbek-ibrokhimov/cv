MAIN    := cv.tex
OUTDIR  := build
PDF     := $(OUTDIR)/cv.pdf

.PHONY: build watch open clean

## Compile the CV. Tectonic will not create OUTDIR itself, hence the mkdir.
build:
	@mkdir -p $(OUTDIR)
	tectonic -X compile $(MAIN) --outdir $(OUTDIR)

## Rebuild on every save. Ctrl-C to stop.
watch:
	@mkdir -p $(OUTDIR)
	tectonic -X watch -x "compile $(MAIN) --outdir $(OUTDIR)"

## Open the built PDF in the default viewer.
open: build
	open $(PDF)

clean:
	rm -rf $(OUTDIR)
