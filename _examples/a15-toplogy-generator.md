---
layout: "default"
nav_key: "internet"
example: true
title: "Generating an AS Topology"
description: "Generate reproducible router graphs and connect them to external exchanges."
code: "A15"
category_id: "foundations"
source_path: "examples/basic/A15_toplogy_generator"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Create an internal AS topology with a seeded NetworkX graph. The default setup connects AS2 to three exchanges and three stub ASes.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Run the example from the repository root using a fixed seed.
2. Inspect output/topology.json and output/topology.txt for routers, links, and attachment mappings.
3. Change one graph parameter or the internal-router count, keeping the seed fixed for comparison.

```sh
python examples/basic/A15_toplogy_generator/topology_generator.py --seed 42
```

## Check your understanding

Compare the generated graphs and eBGP attachment points. Check how the full-mesh and route-reflector modes change the internal routing design.
