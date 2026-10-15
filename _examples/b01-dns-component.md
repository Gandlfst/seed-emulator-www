---
layout: "default"
nav_key: "internet"
example: true
title: "Building a DNS Component"
description: "Define a reusable DNS hierarchy with root, top-level, and authoritative nameservers."
code: "B01"
category_id: "internet-services"
source_path: "examples/internet/B01_dns_component"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Build virtual DNS services independently of a physical topology. This example produces dns_component.bin; it does not launch a standalone network.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Review the root, COM, NET, EDU, and domain-specific nameservers.
2. Follow the zone definitions and the records added to each domain.
3. Generate the component, then use the upstream B02 deployment example to bind it into a runnable emulation.

```python
dns.install('a-root-server').addZone('.').setMaster()
dns.install('b-root-server').addZone('.')
```

## Check your understanding

Check the zone hierarchy and master-server assignment. DNS queries become meaningful only after the component has been deployed on physical hosts.
