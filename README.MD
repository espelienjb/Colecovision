# Summer of '85: Shadow Rift

*“Bikes. Best friends. A town in trouble.”*

A new ColecoVision adventure in the summer of 1985—kids on bikes, closing rifts before fireworks night! Built for ColEm and real hardware using z88dk.

## Quickstart (z88dk)

Install [z88dk](https://github.com/z88dk/z88dk) and ensure `zcc` is in your PATH. You also need Python 3 for asset conversion tools.

## Building & Running

```sh
make          # builds tools, converts assets, compiles ROM
make run      # runs in ColEm (if installed)
```
The ROM will be at `build/shadow_rift.rom`.

## Controls

- **D-Pad:** Move / climb ladders
- **Button 1:** Jump, attack, interact (context)
- **Down + Button 1:** Slide (side-view) or Sneak (top-down)
- **Keypad:** Enter 6-char password on title

## ColEm Usage

If [ColEm](https://fms.komkon.org/ColEm/) is installed, `make run` will launch the ROM. Otherwise, run `colem build/shadow_rift.rom` manually.

## Credits

- **Design & Code:** [Your Name]
- **Music & SFX:** [Your Name]
- **Art:** [Your Name]
- **Tools:** Python scripts in `/tools`

## Devlog

- *Design:* Top-down and side-view rooms, sprite flicker manager, tight 32KB, all assets embedded.
- *Constraints:* 4 sprites per scanline, 16-color tiles, SN76489 music/SFX, password system avoids confusing characters.
- *Tech:* z88dk, Python asset tools, minimal heap use, real Coleco input/hardware.
