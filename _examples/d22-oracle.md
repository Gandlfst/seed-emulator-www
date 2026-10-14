---
layout: "default"
nav_key: "internet"
example: true
title: "Connecting an Oracle"
description: "Follow data from an off-chain oracle node to a smart contract and its user."
code: "D22"
category_id: "blockchain"
source_path: "examples/blockchain/D22_oracle"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

The sample oracle generates a random price and writes it on chain. It demonstrates the data flow without requiring a live price-feed provider.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Locate the oracle_node and oracle_user hosts added to AS164.
2. Run the example from its directory using the command below.
3. Follow the README observation steps to compare the oracle transaction with the value read by the user.

```sh
python simple_oracle.py poa amd
cd output
docker compose up
```

## Check your understanding

Separate the off-chain data producer, the transaction, and the on-chain state. Identify where an external data source could replace the demonstration price generator.
