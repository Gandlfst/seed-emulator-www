---
layout: "default"
nav_key: "internet"
example: true
title: "Visualizing a Network"
description: "Give routers, hosts, and Internet exchanges readable names in the topology view."
code: "A04"
category_id: "foundations"
source_path: "examples/basic/A04_visualization"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Use display metadata to explain a topology without changing the underlying node identifiers.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Find AS151 and its existing router and host.
2. Assign descriptive display names to those nodes.
3. Label the exchange networks, then inspect the resulting emulation in the visualization interface.

```python
as151 = base.getAutonomousSystem(151)
as151.getRouter('router0').setDisplayName('AS151 Core Router')
as151.getHost('host0').setDisplayName('example.com')
```

## Check your understanding

Compare the visible labels with the internal names. Changing a display name should leave the network structure intact.
