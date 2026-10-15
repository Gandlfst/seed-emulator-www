---
layout: "default"
nav_key: "internet"
example: true
title: "Public Key Infrastructure"
description: "Issue certificates with a private ACME certificate authority and serve HTTPS."
code: "B25"
category_id: "internet-services"
source_path: "examples/internet/B25_pki"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Connect hostname resolution, a private CA, and certificate issuance inside an emulated network.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Compare pki.py, which uses EtcHosts, with pki_with_dns.py, which builds DNS infrastructure.
2. Locate the CA and web nodes, then trace the certificate request configuration.
3. Run the chosen upstream variant and inspect the certificate presented by a web server.

```python
as150.createHost('ca').joinNetwork('net0').addHostName('seedCA.net')
```

## Check your understanding

Check the issuer, hostname, and trust chain. Distinguish failure to resolve a hostname from failure to trust the issuing CA.
