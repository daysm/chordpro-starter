# Directory containing source files 
source := src

# Directory containing pdf files
output := output

# Songbook output path
songbook := $(output)/songbook.pdf

# All .cho files in src/ are considered sources
sources := $(wildcard $(source)/*.cho)


# Convert the list of source files in sr/
# into a list of output files in public/.
objects := $(patsubst %.cho,%.pdf,$(subst $(source)/,$(output)/,$(sources)))

all: $(objects)

# Recipe for converting a ChordPro file into PDF
$(output)/%.pdf: $(source)/%.cho

# Create output directory if it does not yet exist
	@[ -d $(output) ] || mkdir -p $(output)
	@echo Making "$(@)"...
	@chordpro "$(<)" -o "$(@)"


.PHONY: songbook
songbook:
# Create output directory if it does not yet exist
	@[ -d $(output) ] || mkdir -p $(output)
	@echo Making "$(songbook)"...
# Remove songbook.txt in case the previous making of songbook did not complete
	@rm -f $(source)/songbook.txt
	@ls $(source)/* > $(source)/songbook.txt
	@chordpro --filelist=$(source)/songbook.txt --no-csv -o "$(songbook)"
	@rm $(source)/songbook.txt


.PHONY: clean
clean:
	rm -f $(output)/*.pdf
