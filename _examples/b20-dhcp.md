---
layout: "default"
nav_key: "internet"
example: true
title: "Dynamic Addressing with DHCP"
description: "Deploy DHCP servers and compare address allocation across two autonomous systems."
code: "B20"
category_id: "internet-services"
source_path: "examples/internet/B20_dhcp"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Add DHCP to the mini Internet and examine the difference between static host addresses and leased addresses.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Inspect the DHCP server bindings in AS151 and AS161.
2. Compare the custom AS151 address pool with the default AS161 pool.
3. Start the example using the README instructions and inspect the four client leases.

```python
as151.createHost('dhcp-client-01').joinNetwork('net0', address='dhcp')
```

## Check your understanding

AS151 clients should receive addresses in 10.151.0.125–140; AS161 clients use 10.161.0.101–120. Inspect lease acquisition rather than assuming the configured address was assigned.
