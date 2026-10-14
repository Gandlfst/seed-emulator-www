---
layout: "default"
nav_key: "internet"
example: true
title: "Funding Accounts with a Faucet"
description: "Request test funds and compare build-time and runtime account funding."
code: "D20"
category_id: "blockchain"
source_path: "examples/blockchain/D20_faucet"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Reuse the faucet from a PoA or PoS component and add a client that requests funds after startup.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Choose PoA or PoS and the appropriate machine architecture.
2. Run the command below from the example directory, then follow its generated-output launch instructions.
3. Compare requests registered during the build with requests sent by FaucetUserService at runtime.

```sh
python faucet.py poa amd
cd output
docker compose up
```

## Check your understanding

Observe the recipient balance and the funding transaction. Inspect the configured maximum request amount and faucet balance when investigating unsuccessful requests.
