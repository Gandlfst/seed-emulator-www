---
layout: manual
title: Search and display settings in 3D
nav_key: visualization
permalink: "/internet-emulator/how-to-use/visualization/geographic-3d/search-display/"
source_path: docs/user-manual/geographic-3d/search-display.md
source_url: https://github.com/seed-labs/seed-visualization/blob/main/docs/user-manual/geographic-3d/search-display.md
---

[User manual](/internet-emulator/how-to-use/visualization/) / [Geographic 3D](/internet-emulator/how-to-use/visualization/geographic-3d/)

# Search and display settings in 3D

Open **Settings** in the bottom-right panel to locate nodes and adjust the readability of the view. These controls work with live and uploaded topologies.

![High-resolution Settings panel with search and visibility controls](https://raw.githubusercontent.com/seed-labs/seed-visualization/main/InternetMap-Geographic/docs/assets/current-dock-settings.png)

## Find a node

1. Enter a known node name, IP address, AS number, role, or identifier in the search field.
2. Choose a suggestion, press **Enter**, or click **Search**.
3. Look for highlighted matches. If there is one match, the page tries to move the view to it.
4. Enable **Hover details** and point to the result to inspect its identity and addresses.

Use a value from your own experiment. If you get no visible match, check the spelling, clear topology filters, and enable the relevant node type. Rotate the globe if a result is on its far side.

## Make a crowded topology readable

| Control | Effect |
| --- | --- |
| IX, Network, Router, Host | Show or hide the corresponding node type. |
| Node / link scale | Change marker and connection sizes. |
| Node labels | Show or hide labels without removing the nodes. |
| Hover details | Show a details card when pointing to a node. |

Hiding **Router** disables the ordinary Network control. Hiding **Network** also hides topology links. These are display changes, not changes to the experiment.

For a large topology, start by hiding labels and reducing the scale. Then use [AS / IX filters](/internet-emulator/how-to-use/visualization/geographic-3d/overview-filters/) to isolate a smaller area. For runtime controls shown in a live node's details, see [Node actions](/internet-emulator/how-to-use/visualization/geographic-3d/node-actions/).

[Back to Geographic 3D](/internet-emulator/how-to-use/visualization/geographic-3d/)
