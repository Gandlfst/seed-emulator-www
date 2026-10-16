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
