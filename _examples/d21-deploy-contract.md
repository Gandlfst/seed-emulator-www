---
layout: "default"
nav_key: "internet"
example: true
title: "Deploying Smart Contracts"
description: "Use a utility server to deploy contracts and publish their addresses to clients."
code: "D21"
category_id: "blockchain"
source_path: "examples/blockchain/D21_deploy_contract"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Follow the separation between registering contract files during compilation and deploying the contract after the blockchain starts.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Inspect the contract files registered with EthUtilityServer.
2. Launch the example from its directory with the command below, selecting arm instead of amd when appropriate.
3. Use the README API examples to retrieve the deployed contract address.

```sh
python deploy_contract.py poa amd
cd output
docker compose up
```

## Check your understanding

Verify that a contract deployment has completed before using its address. Trace how the utility server connects to the execution node and faucet.
