# Summer of '85: Shadow Rift — ColecoVision Makefile

ZCC := zcc
COLEM := $(shell command -v colem 2> /dev/null)
PYTHON := python3
BUILD := build
SRC := src
TOOLS := tools
ASSETS_SRC := assets_src

ROM := $(BUILD)/shadow_rift.rom
CFILES := $(wildcard $(SRC)/*.c)

TOOLSCRIPTS := $(TOOLS)/png2chr.py $(TOOLS)/png2spr.py $(TOOLS)/tracker2psg.py

ASSET_INPUTS := \
  $(ASSETS_SRC)/tiles_suburb.png \
  $(ASSETS_SRC)/tiles_mall.png \
  $(ASSETS_SRC)/tiles_lab.png \
  $(ASSETS_SRC)/tiles_rift.png \
  $(ASSETS_SRC)/sprites_player.png \
  $(ASSETS_SRC)/sprites_enemies.png \
  $(ASSETS_SRC)/font8x8.png \
  $(ASSETS_SRC)/music_title.txt \
  $(ASSETS_SRC)/music_zone1.txt \
  $(ASSETS_SRC)/music_boss.txt

ASSET_OUTPUTS := \
  $(SRC)/assets_tiles_suburb.c $(SRC)/assets_tiles_suburb.h \
  $(SRC)/assets_tiles_mall.c   $(SRC)/assets_tiles_mall.h \
  $(SRC)/assets_tiles_lab.c    $(SRC)/assets_tiles_lab.h \
  $(SRC)/assets_tiles_rift.c   $(SRC)/assets_tiles_rift.h \
  $(SRC)/assets_sprites_player.c $(SRC)/assets_sprites_player.h \
  $(SRC)/assets_sprites_enemies.c $(SRC)/assets_sprites_enemies.h \
  $(SRC)/assets_font8x8.c $(SRC)/assets_font8x8.h \
  $(SRC)/assets_music_title.c $(SRC)/assets_music_title.h \
  $(SRC)/assets_music_zone1.c $(SRC)/assets_music_zone1.h \
  $(SRC)/assets_music_boss.c $(SRC)/assets_music_boss.h

$(ROM): $(CFILES) $(ASSET_OUTPUTS) | $(BUILD)
	$(ZCC) +coleco -vn -SO3 -clib=sdcc_iy \
	  -pragma-define:CRT_ORG_CODE=0x8000 \
	  -pragma-define:CRT_MODEL=1 \
	  -m \
	  -create-app \
	  -o $(BUILD)/shadow_rift \
	  $(SRC)/*.c
	@if [ -f $(BUILD)/shadow_rift.rom ]; then :; else \
	  mv $(BUILD)/shadow_rift $(ROM); fi

$(BUILD):
	mkdir -p $(BUILD)

# Asset conversion
$(SRC)/assets_tiles_suburb.c $(SRC)/assets_tiles_suburb.h: $(ASSETS_SRC)/tiles_suburb.png $(TOOLS)/png2chr.py | $(BUILD)
	$(PYTHON) $(TOOLS)/png2chr.py $(ASSETS_SRC)/tiles_suburb.png $(SRC)/assets_tiles_suburb

$(SRC)/assets_tiles_mall.c $(SRC)/assets_tiles_mall.h: $(ASSETS_SRC)/tiles_mall.png $(TOOLS)/png2chr.py | $(BUILD)
	$(PYTHON) $(TOOLS)/png2chr.py $(ASSETS_SRC)/tiles_mall.png $(SRC)/assets_tiles_mall

$(SRC)/assets_tiles_lab.c $(SRC)/assets_tiles_lab.h: $(ASSETS_SRC)/tiles_lab.png $(TOOLS)/png2chr.py | $(BUILD)
	$(PYTHON) $(TOOLS)/png2chr.py $(ASSETS_SRC)/tiles_lab.png $(SRC)/assets_tiles_lab

$(SRC)/assets_tiles_rift.c $(SRC)/assets_tiles_rift.h: $(ASSETS_SRC)/tiles_rift.png $(TOOLS)/png2chr.py | $(BUILD)
	$(PYTHON) $(TOOLS)/png2chr.py $(ASSETS_SRC)/tiles_rift.png $(SRC)/assets_tiles_rift

$(SRC)/assets_sprites_player.c $(SRC)/assets_sprites_player.h: $(ASSETS_SRC)/sprites_player.png $(TOOLS)/png2spr.py | $(BUILD)
	$(PYTHON) $(TOOLS)/png2spr.py $(ASSETS_SRC)/sprites_player.png $(SRC)/assets_sprites_player

$(SRC)/assets_sprites_enemies.c $(SRC)/assets_sprites_enemies.h: $(ASSETS_SRC)/sprites_enemies.png $(TOOLS)/png2spr.py | $(BUILD)
	$(PYTHON) $(TOOLS)/png2spr.py $(ASSETS_SRC)/sprites_enemies.png $(SRC)/assets_sprites_enemies

$(SRC)/assets_font8x8.c $(SRC)/assets_font8x8.h: $(ASSETS_SRC)/font8x8.png $(TOOLS)/png2chr.py | $(BUILD)
	$(PYTHON) $(TOOLS)/png2chr.py $(ASSETS_SRC)/font8x8.png $(SRC)/assets_font8x8

$(SRC)/assets_music_title.c $(SRC)/assets_music_title.h: $(ASSETS_SRC)/music_title.txt $(TOOLS)/tracker2psg.py | $(BUILD)
	$(PYTHON) $(TOOLS)/tracker2psg.py $(ASSETS_SRC)/music_title.txt $(SRC)/assets_music_title

$(SRC)/assets_music_zone1.c $(SRC)/assets_music_zone1.h: $(ASSETS_SRC)/music_zone1.txt $(TOOLS)/tracker2psg.py | $(BUILD)
	$(PYTHON) $(TOOLS)/tracker2psg.py $(ASSETS_SRC)/music_zone1.txt $(SRC)/assets_music_zone1

$(SRC)/assets_music_boss.c $(SRC)/assets_music_boss.h: $(ASSETS_SRC)/music_boss.txt $(TOOLS)/tracker2psg.py | $(BUILD)
	$(PYTHON) $(TOOLS)/tracker2psg.py $(ASSETS_SRC)/music_boss.txt $(SRC)/assets_music_boss

clean:
	rm -rf $(BUILD) $(SRC)/assets_*.c $(SRC)/assets_*.h

run: $(ROM)
ifdef COLEM
	colem $(ROM)
else
	@echo "ColEm not found. Please run: colem $(ROM)"
endif

.PHONY: clean run
