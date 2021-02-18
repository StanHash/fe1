
CA65 ?= ca65
LD65 ?= ld65

SHASUM ?= sha1sum

ROM := fe1.nes
CFG := fe1.cfg

SOURCE := fe1.asm
OBJECT := fe1.obj

DEPENDS := $(shell find code include data -type f -name '*.asm')

compare: $(ROM)
	$(SHASUM) -c fe1.sha1

.PHONY: compare

$(ROM): $(OBJECT) $(CFG)
	$(LD65) -o $@ -C $(CFG) $(OBJECT)

$(OBJECT): $(SOURCE) $(DEPENDS)
	$(CA65) -o $@ -g $<
