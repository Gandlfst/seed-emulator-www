---
layout: "default"
nav_key: "internet"
example: true
title: "Building a Mini Internet"
description: "Explore a reusable Internet topology with exchanges, transit networks, and stub networks."
code: "B00"
category_id: "internet-services"
source_path: "examples/internet/B00_mini_internet"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Inspect a larger network containing six exchanges, five transit ASes, and twelve stub ASes. Its reusable component underpins several service examples.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Trace the transit and stub AS utility functions in mini_internet.py.
2. Review the real-world access and VPN configuration before starting containers.
3. Compile from the repository root using the command below; follow the README for runtime tests.

```sh
python examples/internet/B00_mini_internet/mini_internet.py --platform amd
```

## Check your understanding

Identify transit paths between stub networks. Compare the live topology with the generated component and note which AS provides external connectivity.
