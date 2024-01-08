---
layout: post
toc: true
title:  "Deepdive into the glyphdetection algorithm"
hidden: false
authors: [eltjo]
categories: [ 'Citrix' ]
tags: [ 'glyph', 'hdx', 'cvad', '1912' ]
image: assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-feature-image.png
---
Since Citrix Virtual Apps and Desktop version 7.12 , Citrix is using  Glyph detection and caching algorithms to save on bandwidth while still delivering  a great user performance. In this research we are going to explore the glyph detection benefits and its potential drawbacks.

## Introduction to glyph detection
The Glyph detection algorithm that Citrix uses is based on the detection of glyphs, or alphabetical or numerical characters, to determine if a portion of the screen is character based. The algorithm uses a form of OCR (Optical Character Recognition) to accomplish this. The basic idea employs real-time OCR, and the re-use of the character glyphs as and when they appear in the Citrix session.

<div align="center">
<a href="{{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-glyph-example.png" data-lightbox="glyph-example">
<img src="{{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-glyph-example.png" alt="glyph-example">
</a>
</div>
<p align="center" >
  <i>Example of various glyphs</i>
</p>

The goal of the Glyph detection algorithm is to cache and re-use these character glyphs in order to save bandwidth, especially in task worker workloads. It has a huge benefit in reducing bandwidth in text heavy workloads, due to the fact that these types of workloads often consist of Excel spreadsheet work for example, which features a lot of, in this case numerical characters, that usually repeat frequently.

<a align="center" href="{{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-excel-block-workload.png" data-lightbox="excel-workload">
![excel-workload]({{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-excel-block-workload.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Excel example in the GO-EUC workload</i>
</p>

But there is a tradeoff; because the algorithm uses OCR, it will consume additional CPU cycles in order to analyze portions of the screen to function. This may have a negative effect on the performance and scalability as a drawback.

The glyph detection algorithm was added to CVAD 7.12 in 2017 and has been continuously improved in every new version of CVAD. The last changes to the algorithm were introduced in version 7.18.

Prior to version 2003, glyph detection was enabled by default. To reduce CPU usage in Citrix sessions, it was changed an automatic mode from version VDA 2003 and onwards. Now, when bandwidth is low or latency is high, the algorithm automatically enables glyph caching . These bandwidth and latency thresholds are currently nonconfigurable and the transition is completely invisible to the end-user and and does not require configuration or intervention by an administrator..

To force the glyph detection on or off the following registry setting can be set:

`HKLM\Software\Citrix\Graphics\GlyphCacheBehaviour = 2`

`2 = on`

`1 = automatic mode`

`0 = off`

As mentioned earlier, the default value for glyph detection in CVAD 2003 is `1`, which puts the behavior in automatic mode.

## Setup and Configuration

This research has taken place on the GO-EUC infrastructure, which is described here. Windows 10 1809 is used as the default deployment, configured with 2vCPU’s and 4GB memory. The VDIs are delivered using Citrix MCS, running version 2003. The default applications are installed, including Microsoft Office 2016. The image is fully patched and optimized with Citrix Optimizer, using the default template and recommended settings.

GO-EUC uses a custom workload and content library, that are described in detail [here](https://www.go-euc.com/insight-in-the-testing-methodology-2020){:target="_blank"}.

Two scenarios have been defined for the analysis of glyph detection algorithm:

* Glyph detection behaviour disabled, as the baseline and represented in blue in the charts
* Glyph detection behaviour explicitly turned on which is represented in orange

## Expectations and Results

The key metrics for this research are the network bandwidth consumption along with CPU utilization.

<a href="{{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-bandwidth.png" data-lightbox="bandwidth">
![bandwidth]({{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-bandwidth.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-bandwidth-comparison.png" data-lightbox="bandwidth-compare">
![bandwidth-compare]({{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-bandwidth-comparison.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The primary goal of the algorithm is to reduce bandwidth usage. As expected, the caching algorithm results in a reduction in bandwidth and can deliver a reduction of 9% during the entirety of workload.

<a href="{{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-bandwidth-comparison-excel.png" data-lightbox="bandwidth-excel-compare">
![bandwidth-excel-compare]({{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-bandwidth-comparison-excel.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The reduction is most prominent in the Excel block of the workload, where the algorithm achieves a 38% bandwidth reduction compared to the scenario where the Glyph detection is explicitly disabled.

<a href="{{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-latency.png" data-lightbox="latency">
![latency]({{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-latency.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-latency-comparison.png" data-lightbox="latency-compare">
![latency-compare]({{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-latency-comparison.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Using glyph detection additionally has a positive effect on the network latency. This decreased latency result in a snappier and more responsive session.

As explained earlier, the tradeoff for the use of glyph detection is a CPU penalty.

<a href="{{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-host-cpu.png" data-lightbox="host-cpu">
![bandwidthcomparisonexcel]({{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-host-cpu-comparison.png" data-lightbox="host-cpu">
![host-cpu-compare]({{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-host-cpu-comparison.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

From a hypervisor host CPU perspective however, there is no noticeable difference between the two scenarios.

A closer look to the data shows a marginal higher CPU usage for the scenario with the glyph detection turned on:

| GlyphCacheBehaviourOff | GlyphCacheBehaviourOn |
| :--------------------: |:---------------------:|
| 100%                   | 99,87%                |


The user density, or overall scalability of the system, is mostly dependent on the hosts CPU utilization, because the main bottleneck in the GO-EUC lab is CPU capacity. We can consequently determine that according to the hosts CPU utilization metrics, the overall scalability will most likely not be impacted by the algorithm.

As an additional drawback, the algorithm might have an impact on the user experience when it comes to the amount number of frames that is send to the client device. A reduction in FPS might result in a degradation of the perceived user experience.

<a href="{{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-fps.png" data-lightbox="fps">
![fps]({{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-fps.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-fps-comparison.png" data-lightbox="fps-compare">
![fps-compare]({{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-fps-comparison.png)
</a>

However, in this particular test for the entirety of the workload, we saw a 1% increase in FPS. Because of this small increase, the likelihood is that this will be not noticeable to an end user.

<a href="{{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-fps-comparison-excel.png" data-lightbox="fps-compare-excel">
![fps-compare-excel]({{site.baseurl}}/assets/images/posts/058-deepdive-into-the-glyphdetection-algorithm/058-citrix-glyphdetection-fps-comparison-excel.png)
</a>

For the Excel block of the workload there is an opposite effect with a decrease in FPS. Because of this small decrease, using the glyph detection will very slightly hinder the user performance in the Excel block of the workload.

## Conclusion
While there is not much documentation available on the glyph detection, it yields impressive results.

In text heavy workloads like the task worker workload for example, the glyph detection algorithm really shines and is able to reduce bandwidth consumption as much as 38% in our tests, with only minimal CPU increase. It is our estimation that the more text heavy the workload is, the more the workload will benefit from the algorithm.

In most cases glyph detection mode can be left, as per default, in automatic mode.  The automatic mode will ensure that the glyph caching will only occur on low bandwidth or high latency situations.

Furthermore, because the CPU increase for the algoritm is negligible, we see no reason to disable the algorithm in older versions where the automatic mode is not yet available.

If you want to share your own experiences with glyph detection, consider joining the Slack channel [here](https://worldofeuc.slack.com)
