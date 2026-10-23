---
layout: manual
title: Explore the IX view
nav_key: visualization
permalink: "/internet-emulator/how-to-use/visualization/topology/ix-view/"
source_path: docs/user-manual/topology/ix-view.md
source_url: https://github.com/seed-labs/seed-visualization/blob/main/docs/user-manual/topology/ix-view.md
---

[User manual](/internet-emulator/how-to-use/visualization/) / [Topology](/internet-emulator/how-to-use/visualization/topology/)

# Explore the IX view

Choose **IX MAP** on Home to open **/pro/ixMap**. This view starts at the Internet exchange level, with deeper host detail omitted initially. IX nodes are represented by stars in the example diagram.

![IX-level network view](https://raw.githubusercontent.com/seed-labs/seed-visualization/main/InternetMap-Toplogy/docs/assets/ixMap.png)

## Choose the initial scope

If the page asks whether to display all nodes, choose **Yes** for the full initial view. Choose **No** to begin by selecting the groups in **Settings ? Categories**.

## Limit the number of exchanges

1. Open **Settings**.
2. Change **Num of IX**.
3. Click outside the number field to apply it.
4. Wait for the diagram to redraw.

The selection uses exchange connectivity weight, so a numeric limit is not a request for specific exchange IDs.

![Limiting the number of displayed exchanges](https://raw.githubusercontent.com/seed-labs/seed-visualization/main/InternetMap-Toplogy/docs/assets/ix_by_number.png)

## Choose exchanges by name

1. Open the **IX** selector in Settings.
2. Select the exchanges you want to inspect.
3. Click outside the selector to apply the selection.
4. To broaden the view again, restore the exchanges you want included and increase the count if needed.

![IX selector with exchange names](https://raw.githubusercontent.com/seed-labs/seed-visualization/main/InternetMap-Toplogy/docs/assets/ix_by_name1.png)

The resulting diagram focuses on those exchanges. Selecting an exchange changes the view only. For individual host inspection, expand the appropriate nodes or switch to [MAP](/internet-emulator/how-to-use/visualization/topology/network-map/). Search, settings, and live traffic controls follow the shared map workflows.

[Back to Topology](/internet-emulator/how-to-use/visualization/topology/)
