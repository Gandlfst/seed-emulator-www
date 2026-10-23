# SEED Emulator logo options

Three AI-edited color studies for the existing logo. The active website logo is unchanged.

- `seed-emulator-black-v1.png`: near-black EMULATOR (recommended direction).
- `seed-emulator-graphite-v1.png`: softer graphite EMULATOR.
- `seed-emulator-teal-v1.png`: navigation-coordinated dark teal EMULATOR.
- `index.html`: light-background comparison preview.
- `comparison.jpg`: screenshot of all three options on the website's pale background.

These are design drafts, not pixel-identical recolors; lettering and geometry should be checked again before adopting a final production asset.

Source: `assets/images/shared/seed-emulator-logo.png`.
Mode: built-in image generation/editing tool, not CLI.
Transparent PNG outputs are preserved without post-processing.

# Final prompts

## 方案 1：纯黑

```text
Use case: precise-object-edit.
Edit target: the attached existing SEED EMULATOR logo PNG. This is a very small recolor edit, NOT a new logo design.
Change ONLY the white letters of the word EMULATOR, in the lower right part of the input, to solid near-black #202126. Preserve their exact slim geometric letter shapes and spacing, including the stylized sliced E.
Every other part must stay as in the input: red SE, black ED, and especially the small network globe above the word. The globe has WHITE interior spaces with thin BLACK lines and black nodes; KEEP its white interior and black network lines. Do NOT turn the whole globe dark. Do not redraw, enlarge, simplify, or redesign that icon.
Text remains exactly SEED EMULATOR. Preserve original alignment, proportion and logo appearance. Transparent background outside the logo only, not inside the white globe. No extra text, background, labels, frame, shadow or glow.
```

## 方案 2：石墨灰

```text
Use case: precise-object-edit (logo-brand raster edit).
Input image 1 is the EDIT TARGET: the existing SEED EMULATOR transparent logo. It is not merely a style reference.
Primary request: improve the contrast of the EMULATOR word for a website header with a very pale green-white background.
Invariants: preserve the existing stylized SEED letters, their original red SE and near-black ED, the recognizable small network/globe symbol above the start of EMULATOR, all letter shapes, relative positions, alignment, and overall horizontal proportions. Do not redesign SEED, do not replace the network with gears, and do not add any objects or slogans.
Change only the rendering of the existing EMULATOR word as specified below. Literal text must remain exactly "SEED EMULATOR"; EMULATOR is spelled E M U L A T O R. Do not add any other text, option label, watermark or frame.
Clean, crisp professional logo edges. Keep the original slim geometric uppercase letter shapes of EMULATOR. No white lettering or white highlights in EMULATOR, and no glow. Preserve transparency outside the mark, genuinely transparent alpha, with no opaque background rectangle or checkerboard baked into the image. Retain a wide horizontal canvas with modest transparent margins and trim unnecessary empty space, without cropping any part of the logo.
Variant: softer graphite correction. Render EMULATOR as uniform dark graphite #4C5157 with a clean flat face, no bevel or drop shadow. It must remain clearly dark against a pale website background, but slightly softer than the black ED. Everything else remains unchanged.
```

## 方案 3：深青绿

```text
Use case: precise-object-edit (logo-brand raster edit).
Input image 1 is the EDIT TARGET: the existing SEED EMULATOR transparent logo. It is not merely a style reference.
Primary request: improve the contrast of the EMULATOR word for a website header with a very pale green-white background.
Invariants: preserve the existing stylized SEED letters, their original red SE and near-black ED, the recognizable small network/globe symbol above the start of EMULATOR, all letter shapes, relative positions, alignment, and overall horizontal proportions. Do not redesign SEED, do not replace the network with gears, and do not add any objects or slogans.
Change only the rendering of the existing EMULATOR word as specified below. Literal text must remain exactly "SEED EMULATOR"; EMULATOR is spelled E M U L A T O R. Do not add any other text, option label, watermark or frame.
Clean, crisp professional logo edges. Keep the original slim geometric uppercase letter shapes of EMULATOR. No white lettering or white highlights in EMULATOR, and no glow. Preserve transparency outside the mark, genuinely transparent alpha, with no opaque background rectangle or checkerboard baked into the image. Retain a wide horizontal canvas with modest transparent margins and trim unnecessary empty space, without cropping any part of the logo.
Variant: website-coordinated color correction. Render EMULATOR as uniform deep muted teal-green #2C7173 matching the website navigation palette. Use a clean flat face, no bevel or drop shadow. SEED retains its existing red and black, and the small network symbol is unchanged. No gradient.
```

