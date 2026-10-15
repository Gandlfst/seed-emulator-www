---
layout: "default"
nav_key: "internet"
example: true
title: "Merging Two Emulations"
description: "Combine independently built networks into one connected emulation."
code: "A06"
category_id: "foundations"
source_path: "examples/basic/A06_merge_emulation"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Explore how the default mergers combine compatible layers from two emulator objects.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Review the two separately constructed emulations in the example.
2. Find the merge operation and inspect how the resulting emulator is compiled.
3. Use the upstream TestRunner instructions to check connectivity between AS150 and AS151 through IX100.

```python
emu_merged = emuA.merge(emuB, DEFAULT_MERGERS)
```

## Check your understanding

Confirm that both autonomous systems appear in the merged output. Compare their exchange connections before and after the merge.
