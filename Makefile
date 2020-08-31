
PATH := tools/bin:$(PATH)

WLA6502 := wla-6502
WLALINK := wlalink

SHASUM := sha1sum

ROM := fe1.nes
LINK := fe1.link

SOURCE := fe1.asm
OBJECT := fe1.o

DEPENDS := $(shell find code include data -type f -name '*.asm')

compare: $(ROM)
	$(SHASUM) -c fe1.sha1

.PHONY: compare

$(ROM): $(OBJECT) header.bin
	$(WLALINK) -S -v $(LINK) $(ROM)

$(OBJECT): $(SOURCE) $(DEPENDS)
	$(WLA6502) -o $@ $<
