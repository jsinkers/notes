# Generate PDFs from the Markdown source files
#
# In order to use this makefile, you need some tools:
# - GNU make
# - Pandoc
# - xelatex

# Directory containing source (Markdown) files
source := _notebooks

# Directory containing pdf files
output := static/pdf

# All markdown files in _notebooks/<notebook>/ are considered sources
sources := $(wildcard $(source)/*/*.md)
#notebooks := $(wildcard $(source)/*/)
#sources = $(wildcard $(source)/$(notebook)/*.md)
#sources := $(shell git ls-files -m **.md)

# Convert the list of source files (Markdown files in directory src/)
# into a list of output files (PDFs in directory print/).
objects := $(patsubst %.md,%.pdf,$(subst $(source),$(output),$(sources)))

all: $(objects)

# Recipe for converting a Markdown file into PDF using Pandoc
$(output)/%.pdf: $(source)/%.md
	# ensure target directory exists
	mkdir -p $(@D)
	pandoc \
		$< \
		-o $@ \
		--from markdown \
		--template static/tex/eisvogel.latex \
		--include-in-header static/tex/inline_code.tex \
		--listings \
		--pdf-engine xelatex \
		--resource-path $(dir $<)

.PHONY : clean
clean:
	rm -rIdv $(output)/*/*.pdf

.PHONY : list
list: $(sources)
	echo $?
