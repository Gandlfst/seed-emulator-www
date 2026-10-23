# Black logo with a subtle shadow

Output: `seed-emulator-black-white-shadow-v1.png`.

Mode: built-in image editing, not CLI. White-background preview only; the active website logo has not been replaced.

Edit target: `seed-emulator-black-white-v1.png`.
Historical shadow style reference: https://github.com/seed-labs/seedemu-website/blob/6bc8275616edb8ec240956345b85b68f650c6559/assets/images/seed_emulator.png
The recovered reference file was verified against Git blob `b78c8abee066c453a0c884e1371ed352ff9776e2`.

## Final prompt

```text
Use case: precise-object-edit.
Image 1 is the EDIT TARGET: the current BLACK SEED EMULATOR logo on white, with a hollow circular arc crossing the upper-left rim of its network globe.
Image 2 is the user's HISTORICAL STYLE REFERENCE only: the original repository logo. Borrow only its restrained slightly raised/shadowed impression, NOT its white EMULATOR face, transparency or old node shape.
Single requested change: add a subtle short gray DROP SHADOW behind the existing logo lettering, lightly offset DOWN and RIGHT. At the displayed mark's roughly 1500px width, use approximately 5px horizontal and 6px vertical displacement, very lightly softened edges, medium-light neutral gray at roughly 25–30% opacity. It should look like a shallow raised logo, not a floating object or heavy 3D extrusion. Apply consistent light direction to SEED and EMULATOR; any shadow behind the network symbol must be especially restrained so the ring and curved links stay crisp.
LOCKED: keep all existing letter contours, segmented cuts, spacing, proportions, baseline, original red SE and near-black ED, and near-black EMULATOR. Text exactly "SEED EMULATOR" (E M U L A T O R). Do not retype the words or redesign the brand. No new bevel or metallic highlights on the letter faces.
Keep the globe unchanged: its original shape, black curved links and center arrow, the two solid nodes, and especially the small HOLLOW circular ring straddling the globe's upper-left rim, half inside and half outside. Do not turn that hollow ring into a filled dot or cut it off.
Retain the same pure WHITE #FFFFFF background, horizontal composition and whitespace. Output one logo only. No captions, borders, watermarks, extra objects, long cast shadow, vignette or background gradient. Change only the requested subtle shadow.
```

