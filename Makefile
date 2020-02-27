# Generate PDFs from the Markdown source files
#
# In order to use this makefile, you need some tools:
# - GNU make
# - Pandoc
# - LuaLaTeX

# Directory containing source (Markdown) files
source := ./

# Directory containing pdf files
output := pdf

# All markdown files in src/ are considered sources
sources := $(wildcard $(source)/*.md)

# Convert the list of source files (Markdown files in directory src/)
# into a list of output files (PDFs in directory print/).
objects := $(patsubst %.md,%.pdf,$(subst $(source),$(output),$(sources)))

all: $(objects)

# Recipe for converting a Markdown file into PDF using Pandoc
$(output)/%.pdf: $(source)/%.md
	pandoc \
		$< \
		-o $@ \
		--from gfm \
		--template eisvogel \
		--include-in-header inline_code.tex \
		--listings \
		--pdf-engine xelatex


.PHONY : clean
clean:
	rm -f $(output)/*.pdf
