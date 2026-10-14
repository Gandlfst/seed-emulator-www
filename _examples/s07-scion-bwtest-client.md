---
layout: "default"
nav_key: "internet"
example: true
title: "Automating SCION Bandwidth Tests"
description: "Configure a test client to start automatically and write results to shared logs."
code: "S07"
category_id: "scion"
source_path: "examples/scion/S07-scion-bwtest-client"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Extend a SCION network with test servers and a configured client service, including a startup delay.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Find the bandwidth servers and the client host in AS153.
2. Replace the sample shared-folder path with a local log directory before compiling.
3. Review the target server and wait time, then inspect the captured client output after startup.

```python
bwtestclient.install('bwtestclient153') \
    .setServerAddr('1-151,10.151.0.30').setWaitTime(20)
```

## Check your understanding

Confirm that the client waits for the network to initialize and reaches the intended server. Compare repeated measurements using the same traffic parameters.
