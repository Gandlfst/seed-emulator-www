---
layout: "default"
nav_key: "internet"
example: true
title: "Ethereum Proof of Stake"
description: "Connect execution, beacon, and validator nodes in a private Ethereum test network."
code: "D01"
category_id: "blockchain"
source_path: "examples/blockchain/D01_ethereum_pos"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Explore the split between Geth execution nodes and Lighthouse consensus services, with a separate setup node preparing genesis data.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Map the Geth, Beacon, Validator Client, and Beacon Setup roles in the source.
2. Inspect the bootstrap and genesis configuration before launching the example.
3. Follow the README launch sequence and its access points to inspect chain activity.

```python
eth = EthereumService()
blockchain = eth.createBlockchain(
    chainName="pos", consensus=ConsensusMechanism.POS)
```

## Check your understanding

Check that execution and consensus services communicate. Distinguish a running container from a synchronized node and an actively participating validator.
