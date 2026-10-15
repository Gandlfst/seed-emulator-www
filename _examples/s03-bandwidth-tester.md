---
layout: "default"
nav_key: "internet"
example: true
title: "Measuring SCION Bandwidth"
description: "Deploy a bandwidth-test service and measure traffic in both directions."
code: "S03"
category_id: "scion"
source_path: "examples/scion/S03_bandwidth_tester"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Use a SCION address that includes the isolation domain, AS, IP address, and port to connect a test client to its server.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Inspect the ScionBwtestService installation and host binding.
2. Start the example using the upstream prerequisites and runtime procedure.
3. Run the client command below inside an emulated SCION host, then vary the documented client-to-server and server-to-client parameters.

```sh
scion-bwtestclient -s 1-153,10.153.0.30:40002
```

## Check your understanding

Compare attempted bandwidth, achieved throughput, and packet loss. Keep duration and packet size controlled when comparing paths.
