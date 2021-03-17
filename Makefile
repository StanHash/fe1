
ifeq ($(CC65_HOME),)
  CA65 ?= ca65
  LD65 ?= ld65
else
  CA65 := $(CC65_HOME)/bin/ca65
  LD65 := $(CC65_HOME)/bin/ld65
endif

SHASUM ?= sha1sum

ROM := fe1.nes
CFG := fe1.cfg
MAP := fe1.map
SYM := fe1.sym

SOURCES := fe1.asm home.asm bank0.asm bank1.asm
OBJECTS := $(SOURCES:.asm=.obj)

DEPENDS := $(shell find code include data -type f -name '*.asm')

compare: $(ROM)
	$(SHASUM) -c fe1.sha1

.PHONY: compare

$(ROM): $(OBJECTS) $(CFG)
	$(LD65) -o $@ -C $(CFG) $(OBJECTS) -m $(MAP) -Ln $(SYM)

%.obj: %.asm $(DEPENDS)
	$(CA65) -o $@ -g $<
