---
layout: "default"
nav_key: "internet"
example: true
title: "Ethereum Proof of Authority"
description: "Create a private Ethereum chain with pre-funded accounts and emulated nodes."
code: "D00"
category_id: "blockchain"
source_path: "examples/blockchain/D00_ethereum_poa"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Separate blockchain configuration from the physical network by creating virtual Ethereum nodes and binding them to hosts.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Create the Ethereum service and select the PoA consensus mechanism.
2. Review account balances in the genesis configuration and node-specific settings.
3. Follow the bindings and Docker compilation in the source; use the README for the complete launch procedure.

```python
eth = EthereumService()
blockchain = eth.createBlockchain(chainName="POA", consensus=ConsensusMechanism.POA)
```

## Check your understanding

Inspect the configured accounts and node roles. Locate the faucet and utility services that later application examples reuse.
