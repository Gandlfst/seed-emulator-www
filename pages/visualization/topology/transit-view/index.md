---
layout: manual
title: Explore the transit view
nav_key: visualization
permalink: "/visualization/topology/transit-view/"
source_path: docs/user-manual/topology/transit-view.md
source_url: https://github.com/seed-labs/seed-visualization/blob/main/docs/user-manual/topology/transit-view.md
---

[User manual](/visualization/) / [Topology](/visualization/topology/)

# Explore the transit view

Choose **TRANSIT MAP** on Home to open **/pro/transitMap**. This view starts at the transit level and omits deeper host detail initially. It is useful when comparing the networks connecting exchanges.

![Transit-level network view](https://raw.githubusercontent.com/seed-labs/seed-visualization/main/InternetMap-Toplogy/docs/assets/transitMap.png)

## Choose the initial scope

If prompted to display all nodes, choose **Yes** for the full initial view or **No** to select groups through **Settings ? Categories**.

## Limit the number of transit networks

1. Open **Settings** and change **Num of Transit**.
2. Click outside the number field.
3. Wait for the diagram to redraw.

More highly connected transit groups take priority. A count limit does not select a particular ASN; use the name selector for that.

![Transit count control and resulting diagram](https://raw.githubusercontent.com/seed-labs/seed-visualization/main/InternetMap-Toplogy/docs/assets/transit_by_number.png)

## Choose by ASN

1. Click the **Transits...** / **Transit** selection button in Settings.
2. Select the ASNs you want to inspect.
3. Enable **Display details** if you want details while hovering over an ASN.
4. Click **Confirm** and wait for the diagram to update.
5. Reopen the selector to change or broaden the selection.

![Transit ASN selection dialog](https://raw.githubusercontent.com/seed-labs/seed-visualization/main/InternetMap-Toplogy/docs/assets/transit_by_name2.png)

Filtering the diagram does not disable unselected transit networks. To inspect deeper nodes, expand them or switch to [MAP](/visualization/topology/network-map/). Use [Search](/visualization/topology/search-display/) when you know an endpoint's name or address.

[Back to Topology](/visualization/topology/)
