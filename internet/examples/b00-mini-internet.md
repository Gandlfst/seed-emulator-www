---
layout: default
title: Mini Internet
section: internet
intro: "A comprehensive SEED Emulator scenario with Internet exchanges, transit ASes, stub ASes, routing layers, real-world reachability, VPN ingress, and runtime validation."
---

{% assign example = site.data.example_sources | where: "id", "b00-mini-internet" | first %}
{% capture readme %}
{% include example-readmes/b00-mini-internet.md %}
{% endcapture %}
{% capture mermaid_diagram %}
flowchart LR
  Internet((Real Internet))
  Outside[Outside machines]
  VPN[AS-152 VPN ingress]
  Gateway[AS-99999 real-world egress]

  subgraph Fabric["Mini Internet fabric"]
    IX["6 Internet exchanges"]
    Transit["5 transit ASes"]
    Stub["12 stub ASes"]
    Component["base_internet.bin"]
  end

  Stub --> IX
  IX <--> Transit
  Transit --> Gateway
  Gateway --> Internet
  Outside --> VPN
  VPN --> IX
  Fabric -. reused by other examples .-> Component

  classDef fabric fill:#edf5f1,stroke:#254e58,stroke-width:2px,color:#162225;
  classDef bridge fill:#fff4dc,stroke:#f0b84a,stroke-width:2px,color:#162225;
  classDef outside fill:#ffe8e6,stroke:#ff2f25,stroke-width:2px,color:#162225;
  class IX,Transit,Stub,Component fabric;
  class Gateway,VPN bridge;
  class Internet,Outside outside;
{% endcapture %}

<section class="example-showcase">
  <div class="example-showcase__header">
    <p class="example-showcase__kicker">{{ example.category }}</p>
    <h2>A compact topology you can reuse</h2>
    <p>
      The README remains the source of truth, but this page presents the example
      as a showcase: topology at a glance, a rendered Mermaid diagram, run commands,
      and runtime validation flow.
    </p>
  </div>

  <div class="example-actions" aria-label="Example links">
    <a class="button button--primary" href="{{ example.repository_url }}/tree/{{ example.branch }}/{{ example.source_path }}">View source</a>
    <a class="button button--secondary" href="#mini-internet-mermaid">Mermaid diagram</a>
    <a class="button button--secondary" href="#run-the-example">Run the example</a>
    <a class="button button--secondary" href="#readme-reference">README reference</a>
  </div>

  <div class="example-stats" aria-label="Mini Internet topology summary">
    <div class="example-stat">
      <strong>6</strong>
      <span>Internet exchanges</span>
    </div>
    <div class="example-stat">
      <strong>5</strong>
      <span>Transit ASes</span>
    </div>
    <div class="example-stat">
      <strong>12</strong>
      <span>Stub ASes</span>
    </div>
    <div class="example-stat">
      <strong>2</strong>
      <span>Real-world bridges</span>
    </div>
  </div>
</section>

<section id="mini-internet-mermaid" class="example-mermaid">
  <div class="example-mermaid__intro">
    <div>
      <p class="example-showcase__kicker">Topology diagram</p>
      <h2>Mermaid-ready Mini Internet map</h2>
      <p>
        This simplified diagram focuses on the relationships people need first:
        exchange fabric, transit backbone, stub AS edge networks, real-world
        egress, VPN ingress, and the reusable component file.
      </p>
    </div>
  </div>

  <div class="example-mermaid__preview" aria-label="Rendered Mermaid topology diagram">
    <pre class="mermaid">{{ mermaid_diagram | strip }}</pre>
  </div>
</section>

<section class="example-panel">
  <div>
    <p class="example-showcase__kicker">Topology story</p>
    <h2>What the generated network represents</h2>
    <p>
      IX hubs form the shared exchange fabric, transit ASes provide backbone
      connectivity, and stub ASes attach hosts and services around the edge.
    </p>
  </div>
  <div class="example-callouts">
    <div>
      <b>AS-99999</b>
      <span>Announces real-world prefixes so packets can leave the emulator.</span>
    </div>
    <div>
      <b>AS-152</b>
      <span>Provides VPN ingress so outside machines can join the emulation.</span>
    </div>
    <div>
      <b>base_internet.bin</b>
      <span>Stores the reusable emulator component used by other examples.</span>
    </div>
  </div>
</section>

<section class="example-flow" aria-labelledby="example-flow-title">
  <div class="example-flow__heading">
    <p class="example-showcase__kicker">Build flow</p>
    <h2 id="example-flow-title">From topology helpers to runtime checks</h2>
  </div>

  <div class="example-flow__grid">
    <article>
      <span>01</span>
      <h3>Create AS layers</h3>
      <p>Utility helpers create transit ASes with IX presence and stub ASes with hosts and services.</p>
    </article>
    <article>
      <span>02</span>
      <h3>Render routing</h3>
      <p>The scenario combines exchange fabric, internal routing, and inter-AS reachability.</p>
    </article>
    <article>
      <span>03</span>
      <h3>Compile or dump</h3>
      <p>Generate Docker output for execution, or save a reusable serialized Internet component.</p>
    </article>
    <article>
      <span>04</span>
      <h3>Probe and test</h3>
      <p>Use the included test manifest to validate readiness, cross-AS probes, and custom runtime checks.</p>
    </article>
  </div>
</section>

<section id="run-the-example" class="example-panel example-run">
  <div>
    <p class="example-showcase__kicker">Entrypoint</p>
    <h2>Run the example</h2>
    <p>
      The Python API is kept stable so other examples can use this scenario as
      their underlying network topology.
    </p>
  </div>

  <div class="example-code-grid">
{% highlight python %}
from examples.internet.B00_mini_internet import mini_internet

mini_internet.run(dumpfile="./base_internet.bin")
mini_internet.run(dumpfile="./base_internet.bin", hosts_per_as=2)
{% endhighlight %}

{% highlight sh %}
cd examples/internet/B00_mini_internet

python mini_internet.py amd
python mini_internet.py \
  --platform amd \
  --output output
python mini_internet.py \
  --dumpfile base_internet.bin
{% endhighlight %}
  </div>
</section>

<section class="example-lifecycle">
  <div>
    <p class="example-showcase__kicker">Validation</p>
    <h2>Validate the example end to end</h2>
    <p>
      Run the manifest from the repository root to rebuild the lab, start it,
      wait for readiness probes, run tests, and tear everything down.
    </p>
  </div>

  <div class="example-code-grid">
{% highlight sh %}
python seedemu/testing/cli.py all \
  examples/internet/B00_mini_internet/example.yaml \
  --artifact-dir ci-artifacts/b00
{% endhighlight %}
  </div>
</section>

<section id="readme-reference" class="example-readme-section">
  <div class="example-readme-section__header">
    <div>
      <h2>Details</h2>
    </div>
  </div>

  <div class="example-readme">
    {{ readme | markdownify }}
  </div>
</section>

<script src="https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js"></script>
<script>
(function () {
  if (window.mermaid) {
    window.mermaid.initialize({
      startOnLoad: true,
      theme: "base",
      themeVariables: {
        primaryColor: "#edf5f1",
        primaryBorderColor: "#254e58",
        primaryTextColor: "#162225",
        lineColor: "#254e58",
        secondaryColor: "#fff4dc",
        tertiaryColor: "#ffe8e6",
        fontFamily: "Arial, Helvetica, sans-serif"
      }
    });
  }
})();
</script>
