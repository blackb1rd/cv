.PHONY: all clean

CC = xelatex
BUILD_DIR = build
SECTIONS = $(wildcard sections/*.tex)

all: $(BUILD_DIR)/resume.pdf

$(BUILD_DIR)/resume.pdf: resume.tex awesome-cv.cls $(SECTIONS)
	mkdir -p $(BUILD_DIR)
	$(CC) -output-directory=$(BUILD_DIR) $<

clean:
	rm -rf $(BUILD_DIR)
