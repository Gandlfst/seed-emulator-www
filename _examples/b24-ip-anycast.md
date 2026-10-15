---
layout: "default"
nav_key: "internet"
example: true
title: "Routing with IP Anycast"
description: "Serve the same IP address from two sites and observe BGP route selection."
code: "B24"
category_id: "internet-services"
source_path: "examples/internet/B24_ip_anycast"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

AS180 has two separate sites connected through IX100 and IX105. Both advertise a service at 10.180.0.100.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Inspect the two internal networks and their exchange connections.
2. Keep the example compiler setting selfManagedNetwork=True so overlapping network prefixes are supported.
3. Use the README test procedure to request the service from different client locations.

```python
Docker(selfManagedNetwork=True, platform=platform)
```

## Check your understanding

Compare the responses ix100-west and ix105-east. Relate the selected server to BGP routes rather than assuming geographic distance determines the destination.
