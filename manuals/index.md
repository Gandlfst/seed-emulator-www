---
layout: default
title: User Manuals
section: manuals
intro: "User manuals and guides for configuring, building, and extending the SEED Emulator."
---

## Environment Setup

  - [Set up development environment](./env.html)

## Core Elements and Features

  - [Create an emulator: the overall flow](./overall_flow.html)
  - [IP address assignment](./ip_address.html)
  - [BGP peering and connecting to the real world](./bgp.html)
  - [Node customization](./node_customization.html): install software, add startup commands, and customize nodes
  - [Compilation](./compiler.html): generate emulation files and Docker files
  - [Internal routing](./routing.html): IBGP and OSPF setup
  - [Generating Docker images for different platforms](./platform.html): support AMD and ARM platforms
  - [Adding custom containers](./custom_container.html)
  - [IP anycast]({{ site.example-url }}/internet/B24_ip_anycast/)
  - [Let outside machines join emulation]({{ site.example-url }}/basic/A03_real_world/)
  - [Visualization](./visualization.html): visualize the emulated Internet

## Components

  - [Component and binding](./component.html): the design philosophy
  - [DNS Infrastructure](./components/dns.html)
  - [Public Key Infrastructure (PKI)](./ca.html): set up a PKI inside the emulator
  - [DHCP server]({{ site.example-url }}/internet/B20_dhcp/): set up a DHCP server on a network
  - [Botnet]({{ site.example-url }}/internet/B22_botnet/)
  - [Darknet (Tor)]({{ site.example-url }}/internet/B23_darknet_tor/)
  - [The Hosts file]({{ site.example-url }}/internet/B21_etc_hosts/): add IP-hostname mappings to `/etc/hosts`
  - [IPFS (InterPlanetary File System)]({{ site.example-url }}/internet/B26_ipfs_kubo): set up IPFS in the emulator
  - [IPFS Kubo](./kubo.html)
