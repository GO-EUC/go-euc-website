---
layout: post
toc: true
title:  "Performance impact of Citrix CVAD 2003"
hidden: false
authors: [eltjo, ryan]
categories: [ 'citrix' ]
tags: [ 'citrix', 'cvad', '1912', '2003', '1909', '1906', 'LTSR', 'CR' ]
image: assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-feature-image.png
---
Not so long ago, Citrix released version 7.2003 of Citrix Virtual Apps and Desktops (CVAD). This version is the first Current Release (CR) released after the release of the 7.1912 Long-Term Servicing Release (LTSR) released in December 2019. As such, this version marks a fork in the road for IT decisionmakers and administrators. This research will focus on the performance difference of CVAD 2003.

## What is new in CVAD 2003
As always, with this version being a CR release, CVAD version 2003 is only supported for 6 months from its release date. If a longer support cycle is required, LTSR is the way to go.

One of the most surprising changes in this new CR release is the deprecation of support for workloads running in public clouds. This means a site running on CVAD 2003 or higher with workloads in public clouds configuration will be an unsupported. CVAD 1912 LTSR will continue to support public cloud workloads.

While this might not come as a surprise, the fact remains, however, that Citrix clearly pushes its Citrix Cloud offering in this regard.

Next to that, Citrix deprecated the use of the NVIDIA GRID version 9 display drivers for the hardware encoding with NVIDIA GPUs.

Apart from the public cloud support deprecation, Citrix has also added quite a few improvements to the functionalities of the product.

  * Citrix Scout data masking;
  * Updated browser content redirection routing with new proxy capabilities;
  * MTU Discovery;
  * Enhanced build to lossless;
  * Loss tolerant mode.

Citrix also added support for Electron based applications like Teams and Slack to the Server OS VDA.
As a preview function, Citrix also released support for the dragging and dropping of files from and to a Citrix session.

For a full description of the new functionalities please see the what’s new page [here](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/whats-new.html){:target="_blank"}.

## Setup and Configuration
This research is focused on how this CR release stacks up against its LTSR counterpart, release 1912, and predecessors CR 1906 and 1909.
This research has taken place on the GO-EUC infrastructure, which is described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. Windows 10 1809 is used as the default operating system, configured with 2vCPU’s and 4GB memory. The desktops are delivered using Citrix MCS, running version 2003. The default applications are installed including Microsoft Office 2016. The image is optimized with Citrix Optimizer, using the default template and recommended settings.

This research contains the following scenarios:

  * Citrix VDA 2003 CR, as the baseline;
  * Citrix VDA 1912 LTSR;
  * Citrix VDA 1909 CR;
  * Citrix VDA 1906 CR.

This is the first research that was done with the new testing methodology using LoadGen as the default performance testing solution, including GO-EUCs own proprietary content library. For more information on the new testing methodology, please check out the detailed breakdown [here]({{site.baseurl}}/insight-in-the-testing-methodology-2020){:target="_blank"}.

## Expectations and results
The new MTU discovery functionality will most likely have no impact on the workload because we are running the simulated endpoints from the same network as the VDI machines. This setup used the default (and standard Windows) MTU size and consequently no packet fragmentation should be occurring during the testruns.

The ‘visual quality’ policy settings are kept as default, meaning it is set to ‘Medium’. While the new enhanced built to lossless functionality will most likely have an impact on the performance and scalability, testing build to lossless is out-of-scope for this research.

The ‘loss tolerant mode’ that is available in combination with the Citrix Workspace App 2002 or higher has not been tested either. The default thresholds of 5% packet loss and a RTT latency of 300ms will not trigger a switch to EDT lossy in the lab environment.

Setting the “Wait for printers to be created before an application starts” feature to enabled, could impose a connection delay and have a negative impact on application start times, but in the lab and workload setup, no printers are used. More information can be found [here](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/policies/reference/ica-policy-settings/printing-policy-settings.html#wait-for-printers-to-be-created){:target="_blank"}.

In this research the user density is determined based on a CPU threshold. As the CPU threshold is reached, it is possible to calculate the active users on the system. Please be aware, this is not a recommend method as other factors can influence the user density of the environment. Based on previous researches it is known that the GO-EUC environment is limited by CPU, so therefore this method is used for now.

Using an out-of-the-box CVAD deployment, it is expected to see a minimal difference in the user density as the new functionalities are not enabled by default.

<a href="{{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-user-density-compare.png" data-lightbox="user-density">
 ![user-density]({{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-user-density-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

There is slight increase in the user density, but as expected, there is a minimal difference between the various VDA versions. As explained, this is expected as the new functionalities are not enabled. Because the user density is primarily based on the CPU utilization, it is expected little to no difference in the host CPU utilization metric.

<a href="{{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-host-cpu.png" data-lightbox="host-cpu">
 ![host-cpu]({{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-host-cpu-compare.png" data-lightbox="host-cpu-compare">
 ![host-cpu-compare]({{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Next to the CPU utilization it is important to validate other host metrics, like storage, to get a complete overview of the performance and scalability of the tested environment. It is always important to validate the impact on the storage, especially when using shared storage, as this can have a negative effect on the user experience once it is saturated.

<a href="{{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-host-reads.png" data-lightbox="host-reads">
 ![host-reads]({{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-host-writes.png" data-lightbox="host-cpu">
 ![host-writes]({{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-host-storage-compare.png" data-lightbox="host-storage-compare">
 ![host-storage-compare]({{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-host-storage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There is minimal difference in the reads per second between the scenarios. For the writes, there is a slight increase for 2003 compared to the other VDA versions, including 1912.

In addition to the host metrics, it is also important to take give thought to the protocol metrics.

<a href="{{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-session-fps.png" data-lightbox="session-fps">
 ![session-fps]({{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-session-fps.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-session-fps-compare.png" data-lightbox="session-fps-compare">
 ![session-fps-compare]({{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-session-fps-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-session-rtt.png" data-lightbox="session-rtt">
 ![session-rtt]({{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-session-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-session-rtt-compare.png" data-lightbox="session-rtt-compare">
 ![session-rtt-compare]({{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-session-rtt-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-session-bandwidth.png" data-lightbox="session-bandwidth">
 ![session-bandwidth]({{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-session-bandwidth.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-session-bandwidth-compare.png" data-lightbox="session-bandwidth-compare">
 ![session-bandwidth-compare]({{site.baseurl}}/assets/images/posts/056-performance-impact-of-citrix-cvad-2003/056-citrix-cvad-2003-session-bandwidth-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As with the other metrics, there is only a minimal difference in the reported FPS for all scenarios. As a consequence, the variance in bandwidth consumption between the VDA versions is also minimal.

We do see a slightly increase in RTT with VDA 2003 in comparison to the previous VDA versions, something that we cannot account for at this point.

## Conclusion
One of the biggest shifts of Citrix CVAD 2003 is the deprecation of the public cloud support. This strategy of Citrix could have a major effect to some Citrix customers. A hybrid public cloud configuration is still possible using the LTSR edition of Citrix. Besides the bug fixes you are going to miss out on added features that are only available in the CR editions.

When maintaining a virtualized environment is it important to be in control. Every change, update or upgrade could potentially have a negative effect on the scalability and user experience.

From a performance and scalability viewpoint, there is no significantly noticeable difference for the new VDA 2003 version of CVAD, which is the key takeaway of this research. Important metrics like CPU usage, roundtrip time and bandwidth usage all show minor to no noticeable difference. With that in mind, take into consideration that to keep support from Citrix, a migration from a previous CR version is advised.

Are you planning to move to the latest CR? Share you experience in the comments below or start the conversation at the [World of EUC Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Franck V.](https://unsplash.com/@franckinjapan?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/fork-in-the-road?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}.