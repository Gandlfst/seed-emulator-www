# Original logos recovered from Git history

These are byte-for-byte Git exports, not AI-generated or image-edited files. The active website logo is unchanged.

## SEED Emulator

- Recovered file: `seed_emulator-original-6bc8275.png`
- Original path: `assets/images/seed_emulator.png`
- First added: 2025-12-04, commit `6bc8275616edb8ec240956345b85b68f650c6559`, author Kevin Du, message `added logo`.
- Git blob: `b78c8abee066c453a0c884e1371ed352ff9776e2`.
- Dimensions: 800 x 143; size: 19,274 bytes.
- The upper-left globe node already has transparent pixels in this historical source: pixel (320,14) has alpha 0. The globe region x=300..374, y=0..74 has an identical alpha channel in the current `assets/images/shared/seed-emulator-logo.png`; five visible color values differ, but the missing-node transparency is unchanged.
- User clarification: this feature is a circular arc crossing the large sphere's outline, with the other semicircle outside. Its transparent pixels do not establish a missing node or image defect. Earlier descriptions calling it a missing node were inaccurate; preserve the original arc construction rather than filling it as a solid dot.

## SEED Labs 2.0

- Recovered file: `seed-labs-original-b541889.png`
- Original path: `assets/images/seed2.0_logo.png`
- First added: 2025-11-17, commit `b541889`, message `added initial files`.
- Git blob: `6db060327e9bd3474212403db98143052c1af84d`.
- Dimensions: 701 x 150; size: 24,015 bytes.

Both recovered files were verified with `git hash-object` against the recorded historical blobs.
