---
layout: "default"
nav_key: "internet"
example: true
title: "Customizing Nodes"
description: "Install software, copy files, and add startup commands to emulated hosts."
code: "A09"
category_id: "foundations"
source_path: "examples/basic/A09_node_customization"
---
<!-- Each section corresponds to a chapter in the shared lesson navigation. -->

## Overview

Learn how node-level customization becomes container build and startup instructions.

## Before you start

{% include example-setup.html %}

## Walkthrough

1. Open the example source and locate its software installation calls.
2. Compare file installation calls with the generated Dockerfile COPY instructions.
3. Inspect startup-command customization and the resulting start.sh file.

## Check your understanding

Distinguish changes applied while building an image from commands executed when a container starts. Use the inline source comments to match each API call to its output.
