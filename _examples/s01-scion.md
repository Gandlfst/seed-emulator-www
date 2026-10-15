---
layout: "default"
nav_key: "internet"
example: true
title: "Building a SCION Network"
description: "Organize autonomous systems into isolation domains and configure SCION paths."
code: "S01"
category_id: "scion"
source_path: "examples/scion/S01_scion"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Explore how ScionBase, ScionRouting, ScionIsd, and Scion separate topology, routing, trust, and inter-AS links.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Install scion-pki using the upstream prerequisites and make it available on PATH.
2. Trace isolation-domain membership and the core or non-core role of each AS.
3. Inspect the inter-AS link definitions, then follow the README build and launch sequence.

```python
from seedemu.layers import ScionBase, ScionRouting, ScionIsd, Scion
```

## Check your understanding

Relate each available path to the configured inter-AS links. Identify the trust boundary of an isolation domain and the roles of its core ASes.
