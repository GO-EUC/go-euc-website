---
layout: post
toc: true
title:  "Windows 7 vs Windows 10 VDI Performance Test"
hidden: false
authors: [sven]
categories: [ 'microsoft', 'windows 10', 'windows 7' ]
tags: [ 'windows 10', 'windows 7', 'microsoft' ]
image: assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-feature-image.png
---
Windows 7 is almost end of support but still, there are VDI environments running Windows 7. What would the impact on performance be if you migrate from Windows 7 to Windows 10? In this research, we investigated the impact on performance when comparing Windows 7 and Windows 10 in a VDI-context.

## Windows 7
On January 14 2020, support will end for Windows 7. This shouldn’t come as a surprise to you, as Microsoft has been warning for this for the past couple of years:
<a href="{{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-end-of-support.jpg" data-lightbox="support">
![support]({{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-end-of-support.jpg)
</a>
Nonetheless, there are still (VDI) environments that haven’t been upgraded to Windows 10 (or 8) and are still running Windows 7. For those environments, it’s interesting to know what the performance impact will be when they migrate to Windows 10. We’ve already seen that with every new feature release of Windows 10, there is an impact on user density and application response times. We’ve also seen that vulnerability mitigations for Spectre, Meltdown, L1TF, and MDS also have an impact. Therefore it would be interesting to see what the performance differences are between Windows 7 SP1 without updates versus Windows 7 SP1 that is fully updated. Then we compare these results to Windows 10 build 1809 fully updated.

## Infrastructure & configuration
This research has taken place on [the Nutanix lab environment]({{site.baseurl}}/nutanix-lab-architecture-and-hardware-setup-overview-2019){:target="_blank"}. The host for the desktops has the following specifications:

  * 2x CPU: Intel Xeon Gold 5220, 18 cores @ 2.20GHz
  * 768GB Memory
The three other Nutanix nodes in the cluster provide the test host with storage through an NFS-mount.

The following parameters apply to this research:

  * The Hypervisor we used was vSphere 6.7 Update 3.
  * The Side Channel Aware scheduler was not enabled.
  * The Nutanix Controller VM (CVM) was powered off during the tests on the host with the virtual desktops (This will make it easier for the community to reproduce these tests if using hardware with the same specifications).
  * VMware Horizon 7.10 was used for desktop provisioning and brokering.
  * The non-persistent desktops were created using Horizon Composer Linked clones with the View Composer Array Integration.
  * The display protocol used during the tests was Blast Extreme
  * The default configuration for the desktop is 2vCPU’s with 3GB memory.
  * All Login VSI required applications are installed including Microsoft Office 2016 x86.

For this research three scenarios are defined:

  * Windows 7 SP1 without Windows updates;
  * Windows 7 SP1, fully updated until October 13th as the baseline, set at 100% in the charts.
  * Windows 10 build 1809 (build 17763.805), fully updated until October 13th.

All scenarios are optimized using the VMware OSOT (version b1110) with the recommended templates. Each scenario is tested according to our default testing methodology which is described [here]({{stite.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Expectations and results
I remember a couple of years ago that Login VSI tests showed an impact of 30% when upgrading from Windows 7 to Windows 10 in a VDI-context. Previous [research]({{site.baseurl}}/moores-law-of-windows-10-1903/){:target="_blank"} showed that the individual feature builds of Windows 10 (1709 vs 1803 vs 1809, etc) already show a big impact in performance. And let’s not forget all the vulnerability mitigations that cause a huge impact. I expect that these mitigations will have an impact on Windows 7 as well and that there is an impact between a fully updated Windows 7 environment and a fully updated Windows 10 environment.

<a href="{{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The results from this research show that installing all the updates and mitigations after Windows 7 SP1 already has an impact on the Login VSI VSImax of 35%. Comparing Windows 10 fully patched to Windows 7 fully patched results in 16% lower Login VSI VSImax.

Like the previous researches on GO-EUC using the Login VSI VSImax, it is possible to validate the user density between the scenarios. The Login VSI baseline provides an indication of the difference in the overall response times.

<a href="{{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

All the patches after Windows 7 SP1 only have an impact of 5% on the Login VSI baseline. But comparing Windows 10 to Windows 7 shows an increase in Login VSI baseline of 33%.

Based on the Login VSI VSImax we should see a similar pattern in the CPU utilization as the lab environment is CPU constrained.

<a href="{{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-host-cpu-util.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-host-cpu-util.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-host-cpu-util-compare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-host-cpu-util-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

A higher CPU utilization means fewer users can be hosted on the environment. There is a 6% increase in the CPU utilization when comparing Windows 10 to Windows 7, while the Login VSI VSImax results showed an impact of 16%.

<a href="{{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-host-cpu-util-compare-30min.png" data-lightbox="cpu-compare-30min">
![cpu-compare-30min]({{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-host-cpu-util-compare-30min.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Comparing just the first 30 minutes of the test shows a difference in CPU utilization that is much more like the impact in Login VSI VSImax: 14% increase in CPU utilization when comparing Windows 10 to Windows 7.

The next charts show the impact of the Login VSI workload on the storage. This is especially important if your current storage solution was designed for Windows 7 and you don’t have much overhead.

<a href="{{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-host-reads-compare.png" data-lightbox="reads-compare">
![reads-compare]({{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-host-reads-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-host-writes-compare.png" data-lightbox="writes-compare">
![writes-compare]({{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-host-writes-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

This research shows that the impact of upgrading to Windows 10 is 50% more read I/O compared to Windows 7. If you kept your Windows 7 image up to date, then you already should have noticed an increase in write I/O. In our testing, we see an increase of 22% in write I/O when comparing Windows 7 unpatched to Windows 7 patched. Comparing Windows 7 to Windows 10 we see only an increase of 5%.

Logon times are important in a VDI environment and have a big effect on the first user experience. When the logon times are increasing it is likely to have a negative effect on the user’s experience.

<a href="{{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-logon.png" data-lightbox="logon">
![logon]({{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-logon.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-logon-compare.png" data-lightbox="logon-compare">
![logon-compare]({{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-logon-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

A 160% increase in logon time with Windows 10 compared to Windows 7 is not realistic because the test with Windows 10 was hitting the maximum capacity of the CPU at 28 minutes already. A better comparison is to compare the logons of only the first 25 minutes of the tests.

<a href="{{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-logon-compare-25min.png" data-lightbox="logon-compare-25min">
![logon-compare-25min]({{site.baseurl}}/assets/images/posts/046-windows-7-vs-windows-10-vdi-performance-test/046-win7-vs-win10-logon-compare-25min.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Even if only comparing the first 25 minutes, there is an increase of 35% in logon times with Windows 10 compared to Windows 7. One of the reasons for this increase is the installation of the Universal Windows Platform (UWP) apps, which are installed at first login. Although the optimization tool does remove a lot of these apps, you cannot remove all of UWP apps.

## Conclusion
I was surprised that there was such a huge impact on the capacity when comparing Windows 7 unpatched to a fully patched Windows 7. The 16% lower capacity (Login VSI VSImax) of Windows 10 is definitely something to take into consideration before upgrading to Windows 10. There could be a bigger impact if you’re currently using Windows 7 with just 1 vCPU (yes, these environments do exist). Windows 10 needs at least 2 vCPUs and increasing the total number of vCPUs will also impact the density.

Another concern is the lower response times (33% lower Login VSI baseline) and slower logins with Windows 10. If possible, consider planning the migration to Windows 10 with a hardware renewal, using newer CPUs, with more cores and higher clock speed will help get back some of this performance. The increase in Read I/O (50%) is also worth mentioning, especially when your storage solution doesn’t have the performance or caching to handle this increase.

As a final word of advice, always validate the performance and user experience in your own environment before moving to production.

Is your VDI environment still on Windows 7? Share your experience in the [Slack Channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Alex Mertz](https://unsplash.com/@alexmertz?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/seattle?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
