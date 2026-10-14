---
layout: "default"
nav_key: "internet"
example: true
title: "Reusing a Network Component"
description: "Load a saved emulation and extend its networks, hosts, and peering relationships."
code: "A05"
category_id: "foundations"
source_path: "examples/basic/A05_components"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Treat a serialized emulation as a reusable component. Access its existing layers before adding more infrastructure.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Read how the script prepares and loads the component from the transit-AS example.
2. Retrieve the Base and Ebgp layers, then inspect the additional hosts and autonomous system.
3. Compile the extended component with the entrypoint below, running from the repository root.

```sh
python examples/basic/A05_components/components.py --platform amd
```

## Check your understanding

Inspect the generated topology for both the imported infrastructure and the newly added nodes. Check that each added router has the intended peering connection.
