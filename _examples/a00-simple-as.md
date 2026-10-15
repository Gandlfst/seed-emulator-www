---
layout: "default"
nav_key: "internet"
example: true
title: "Simple Autonomous System"
description: "Connect three autonomous systems through an exchange and serve a web page from each network."
code: "A00"
category_id: "foundations"
source_path: "examples/basic/A00_simple_as"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Follow the relationship between the Base, Routing, Ebgp, and WebService layers. The example gives each autonomous system a /24 prefix.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Locate the creation of IX100 and the three stub autonomous systems in the example script.
2. Trace each router connection from its local network to the exchange.
3. Follow the web-service bindings and BGP peering configuration before rendering and compiling the emulator.

```python
base.createInternetExchange(100)
as150 = base.createAutonomousSystem(150)
as150.createNetwork('net0')
```

## Check your understanding

Check that hosts in different autonomous systems can reach their web services. Identify which routing layer makes that communication possible.
