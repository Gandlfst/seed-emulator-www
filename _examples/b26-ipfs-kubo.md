---
layout: "default"
nav_key: "internet"
example: true
title: "Distributed Storage with IPFS"
description: "Install Kubo peers across a mini Internet and configure bootstrap nodes."
code: "B26"
category_id: "internet-services"
source_path: "examples/internet/B26_ipfs_kubo"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Add a distributed storage service to an existing network component instead of rebuilding the topology.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Follow the loading of the base component and creation of KuboService.
2. Inspect how virtual Kubo services are bound to physical hosts in each stub AS.
3. Identify the boot nodes and follow the upstream runtime instructions to explore peer connectivity.

```python
ipfs = KuboService()
```

## Check your understanding

Explain how a new peer discovers other peers through bootstrap nodes. Compare service bindings with the physical topology before experimenting with content exchange.
