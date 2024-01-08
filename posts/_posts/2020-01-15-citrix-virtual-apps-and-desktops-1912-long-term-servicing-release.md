---
layout: post
toc: true
title:  "Citrix Virtual Apps and Desktops 1912 Long-Term Servicing Release"
hidden: false
authors: [ryan, eltjo]
categories: [ 'citrix' ]
tags: [ 'citrix', '1912', '7.15', 'CR', 'LTSR', 'CVAD' ]
image: assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-breakdown-feature-image.png
---
December 18th 2019, Citrix released the new Citrix Virtual Apps and Desktops 7 1912 Long-Term Servicing Release (LTSR). This is the updated edition of the previous 7.15. This research will take a closer look at any performance improvements this latest LTSR version provides regarding the previous LTSR releases.


## The 1912 Long-Term Servicing Release
As mentioned before, Citrix has released the new Long-Term Servicing release 1912 on December 18th, 2019. There are many blog posts out there that will address the new features. We recommend starting with the following post to understand what’s new in this release.

[https://www.citrix.com/blogs/2019/12/18/announcing-the-citrix-virtual-apps-and-desktops-1912-ltsr/](https://www.citrix.com/blogs/2019/12/18/announcing-the-citrix-virtual-apps-and-desktops-1912-ltsr){:target="_blank"}

For a full feature by feature comparison for the different release, Citrix has provided a complete feature overview for each version, which can be found [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}.

## Configuration & infrastructure
This research has taken place on the GO-EUC lab environment which is specified here. The following scenarios are included in this research:

  * Citrix VDA 1912 LTSR, as the baseline;
  * Citrix VDA 7.15 CU5;
  * Citrix VDA 7.15 CU4;
  * Citrix VDA 7.15 CU3.

As there is a never-ending debate whether to choose for the current release or long-term servicing release, it is valuable to include this comparison in this research. As the 1912 release is both current and long-term servicing release, previous current release is used, resulting in an additional scenario compared separately:

  * Citrix VDA 1912 LTSR, as the baseline;
  * Citrix VDA 1909 CR.

The VDA 7.15 CU3 is supported on Windows 10 1809 and below. Therefore, the default operating system in this research is Windows 10 1809. All required Login VSI applications are installed including Microsoft Office 2016 x64. Optimizations are applied using the Citrix Optimizer version 2.6, with the recommended template.

All scenarios have been performed according to our default testing methodology, which is described in detail [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Expectations and results of Long-Term Servicing Release

Citrix has based the LTSR edition on the latest current release offering of CVAD, which was version 1909 at that time. Technically speaking this means that 1909 and 1912 share most of their code. We can therefore expect to see only a small deviation between both versions. However, Citrix did confirm a bunch of bug fixes, as well as some new capabilities that have been added in 1912. The new capabilities, such as user personalization layers, Teams optimization and app protection, are not enabled by default. Based on previous VDA research, it is expected to see an improvement in both scalability and user experience when comparing to the previous LTSR versions.

In order to validate our expectations various sets of results are used. For scalability the Login VSI VSImax is a reliable metric. The Login VSI baseline is a good indication of the overall response time of the VDI session, which is a decent reflection of the user experience.

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There is a clear difference in the Login VSI VSImax results. Upgrading to the latest LTSR version has resulted in a higher user density on our environment. Due to the fact that we use a lab setup in our researches, it is expected that the scalability will be even better then real-world scenarios. The overall response times are fairly consistent across all scenarios. Based on the Login VSI Baseline, it is most likely the user experience stays consistent when switching to the latest LTSR.

For the sake of consistency, it is important to validate the Login VSI results with other metrics to get the complete overview.

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-host-cpu.png" data-lightbox="host-cpu">
![host-cpu]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-host-cpu-compare.png" data-lightbox="host-cpu-compare">
![host-cpu-compare]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Based on the CPU utilization metrics, we can confirm the Login VSI VSImax results. The difference in scalability is reflected in the results, where the CPU utilization is lower with the latest 1912 LTSR release.

During the analysis we did noticed a difference in the memory footprint. In most cases an environment is already sized to host a set number of users. When the environment is sized appropriately, memory scalability should not be an issue but, it is still beneficial to use memory efficiently. On the other hand, high memory usage might force memory swapping on the virtualization host and could have a negative effect on the performance of the VDI sessions.

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-host-mem.png" data-lightbox="host-mem">
![host-mem]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-host-mem.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-host-mem-compare.png" data-lightbox="host-mem-compare">
![host-mem-compare]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-host-mem-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The metrics shown above are the available memory to the virtualization host, meaning, a higher score is better. All 7.15 CU versions have a bigger memory footprint, leaving less memory available.

Next to memory usage it is important to take storage into account. Performance issues on storage could result in a very bad user experience.

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-host-reads.png" data-lightbox="host-reads">
![host-reads]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-host-writes.png" data-lightbox="host-writes">
![host-writes]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-host-storage-compare.png" data-lightbox="host-storage-compare">
![host-storage-compare]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-host-storage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

This is a bit of a surprise. The previous 7.15 CU versions have fewer read activities in comparison to 1912 LTSR. There is a minimal difference in writes, which is the most expensive on the storage subsystem. Based upon the data collected with this research, there is no clear evidence for the lower reads on the storage subsystem for the previous LTSR versions.

User experience is key when delivering a virtual desktop environment. One of the primary indicators that is used to measure the user experience, is the frames per second metric.

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-session-fps.png" data-lightbox="session-fps">
![session-fps]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-session-fps.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-session-fps-compare.png" data-lightbox="session-fps-compare">
![session-fps-compare]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-session-fps-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The differences are negligible, resulting in a similar user experience. This confirms the Login VSI baseline results.

Another key indicator is the round trip time, also known as RTT. RTT is the delay between the user input and the action in the virtual desktop. When the RTT is increasing this may result in degradation of the user experience.

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-session-rtt.png" data-lightbox="session-rtt">
![session-rtt]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-session-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-session-rtt-compare.png" data-lightbox="session-rtt-compare">
![session-rtt-compare]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-session-rtt-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The pattern is overall similar but showing an increasing RTT during the video content for all 7.15 CU versions. A higher RTT, will have a negative impact on the user experience. As we have learned in previous researches, the Login VSI progress bar will have an effect on these results, therefore for this research it was removed. More information about this can be found [here](https://www.go-euc.com/important-influence-of-citrix-login-vsi-on-the-results).

These results show that there are numerous protocol improvements made in recent CRs that have also been included in the latest 1912 release.

In our case, bandwidth is not a problem as all our testing scenarios and communications occur within the boundaries of the datacenter. Not only the VDIs are located in the datacenter, but the endpoints as well (also known as Login VSI Launchers). This differs from real-world cases where the endpoints always reside outside of the datacenter and are sometimes only connected via cellular networks where bandwidth consumption might very well be one of the biggest challenges.

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-session-bandwidth.png" data-lightbox="session-bandwidth">
![session-bandwidth]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-session-bandwidth.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-session-bandwidth-compare.png" data-lightbox="session-bandwidth-compare">
![session-bandwidth-compare]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-session-bandwidth-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The new 1912 LTSR is more efficient compared to 7.15 CU versions. In most cases this will not directly influence the user experience but, it does have a positive effect in WAN scenarios.

## Long-Term Servicing Release vs. Current Release
Additionally, we compared the LTSR to the latest CR release, which is 1909 at time of this research. As explained at the beginning of the previous chapter, we know the 1912 LTSR is based on CR 1909. As there are some bug fixes and additional improvements, we do not expect to see much difference between both versions.

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-vsimax.png" data-lightbox="cr-vsimax">
![cr-vsimax]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-baseline.png" data-lightbox="cr-baseline">
![cr-baseline]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The Login VSI VSImax difference is 4%. Although there was not an expectation of any scalability improvements, the results confirms the applied changes have a positive effect.

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-host-cpu.png" data-lightbox="cr-host-cpu">
![cr-host-cpu]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-host-cpu-compare.png" data-lightbox="cr-host-cpu-compare">
![cr-host-cpu-compare]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The CPU utilization has a similar pattern and on average there is only a difference of 2%. It is 2% lower, but based on the Login VSI VSImax it was expected to have a slightly higher CPU Utilization.

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-host-mem.png" data-lightbox="cr-host-mem">
![cr-host-mem]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-host-mem.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-host-mem-compare.png" data-lightbox="cr-host-mem-compare">
![cr-host-mem-compare]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-host-mem-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

These results show 1909 CR has 8% more memory available compared to 1912 LTSR. At this point, based on the data we collected, it is not clear what is causing the difference.

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-host-reads.png" data-lightbox="cr-host-reads">
![cr-host-reads]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-host-writes.png" data-lightbox="cr-host-writes">
![cr-host-writes]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-host-storage-compare.png" data-lightbox="cr-host-storage-compare">
![cr-host-storage-compare]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-host-storage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There is a noticeable difference in the reads/sec, which we have seen before in the LTSR comparison. The results of 1909 CR are on par with the previously shown storage metrics of 7.15 CU LTSR versions.

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-session-fps.png" data-lightbox="cr-session-fps">
![cr-session-fps]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-session-fps.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-session-fps-compare.png" data-lightbox="cr-session-fps-compare">
![cr-session-fps-compare]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-session-fps-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The workload is divided in segments, which contains both static and more dynamic content, like videos and PowerPoint presentations. In the segments with the dynamic content, it is expected to see more spikes in the FPS charts. For the 1912 LTSR release these spikes are higher compared to 1909 CR, which results on average a lower FPS. Using the LTSR will results in a smoother user experience.

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-session-rtt.png" data-lightbox="cr-session-rtt">
![cr-session-rtt]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-session-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-session-bandwidth.png" data-lightbox="cr-session-bandwidth">
![cr-session-bandwidth]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-session-bandwidth.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-session-rtt-bandwidth-compare.png" data-lightbox="cr-session-rtt-bandwidth-compare">
![cr-session-rtt-bandwidth-compare]({{site.baseurl}}/assets/images/posts/049-citrix-virtual-apps-and-desktops-1912-long-term-servicing-release/049-citrix-ltsr-cr-session-rtt-bandwidth-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Both RTT and bandwidth show no differences. 1912 LTSR was able to deliver more frames per seconds, resulting in a smoother user experience, while keeping the RTT and bandwidth the same as 1909 CR.

## Wrap-up
Depending on the agility within your organization, there is always the debate to choose for the current release (CR) or Long-Term Servicing Release. If your organization is not depending on new functionality within CVAD and must support a stable release over the coming 5 years, LTSR is the best option. Otherwise, you have the possibility to benefit from new functionality with the CR releases, but this does require you to update the environment every 3 to 6 months using the CR release.

Whether you choose for long-term supportability or looking ahead for new functionality, now it is the time to update to the 1912 release.

Based on this and previous researches, in either case, upgrading will benefit the user experience, performance and scalability.

Did you already upgrade to the new version? Let us know in the Twitter poll below or discuss it at the [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Let us know what version of Citrix Virtual Apps and Desktops you are running in the poll below <a href="https://twitter.com/hashtag/Citrix?src=hash&amp;ref_src=twsrc%5Etfw">#Citrix</a> <a href="https://twitter.com/hashtag/CitrixSummit2020?src=hash&amp;ref_src=twsrc%5Etfw">#CitrixSummit2020</a></p>&mdash; G0-EUC (@g0_euc) <a href="https://twitter.com/g0_euc/status/1217448627628584960?ref_src=twsrc%5Etfw">January 15, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Photo by [JESHOOTS.COM](https://unsplash.com/@jeshoots?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/speed?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
