---
layout: post
toc: true
title:  "Citrix VDA versions breakdown, a giant leap forward"
hidden: false
authors: [eltjo]
categories: [ 'citrix' ]
tags: [ 'citrix', 'VDA' ]
image: assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-feature-image.png
---
With each iteration of the Citrix Virtual Delivery Agent (VDA) software Citrix always treats us to new features and functionalities. For the Current Releases (CR) Citrix is constantly adding new features and functionalities while also improving the performance of the HDX protocol itself. This should, in theory, result in a better user experience, coupled with a higher user density and less strain on the system.

> **Disclaimer:** These results have been affected by the Login VSI progress bar and results may be different in practice. For more information please read the following [post]({{site.baseurl}}/important-influence-of-citrix-login-vsi-on-the-results){:target="_blank"}.

The Long Term Service Release (LTSR) program provides stability and long-term support for XenApp and XenDesktop releases. XenApp and XenDesktop LTSRs are currently available for Versions 7.6 and 7.15. Cumulative Update 3 (CU3) is the most recent update to the 7.15 LTSR.

Since the last LTSR release, Citrix has shipped five CRs: 7.16, 7.17, 7.18, 7 1808.2 and 7 1811.1.

Version 7 1808.2 is the first version to use not only the new product naming but also the new version naming scheme. For the sake of clarity, we will refer to Virtual Apps and Desktops for all product versions in this post.

In this research we will focus on the lasted latest three CRs from that list and compare them to the lasted latest two cumulative updates for 7.15 LTSR which at the time of writing are CU2 and CU3.

This means that there are five scenarios in total:

  * Desktop OS VDA version 7.15 LTSR CU2
  * Desktop OS VDA version 7.15 LTSR CU3
  * Desktop OS VDA version 7.18
  * Desktop OS VDA version 7 1808.2
  * Desktop OS VDA version 7 1811.1

## What’s new
To get some context for the different VDA versions here is a small breakdown of some of the more notable VDA improvements and new features that we suspect can have an impact on the user experience or the server scalability of the environment:


| Version | Feature | Remark |
| :-----: | :-----: | :----: |
| 7.18 | Battery icon notification | While not necessarily performance related a very much requested feature nonetheless |
| 7.18 | Enhanced server VDA webcam functionality | Thinwire enhancements (‘Build to lossless’ preference of the Visual quality policy setting is now H.264 instead of JPEG for moving images) |
| 7.18 | H.264 | Build-to-Lossless |
| 1808.2 | Better network throughput over high latency connection | [https://support.citrix.com/article/CTX125027](https://support.citrix.com/article/CTX125027){:target="_blank"} |
| 1808.2 | Chrome enhancement to browser content redirection | Browser content redirection now supports the Chrome browser in addition to the previously supported Internet Explorer browser |
| 1808.2 | NVENC video encoding support on Server OS VDAs | NVENC video encoding support on Server OS VDAs. The XenApp and XenDesktop 7.17 release introduced Desktop VDA support for selective H.264/H.265 encoding with NVIDIA NVENC GPUs. In this release, the similar capabilities have now been extended to Server OS VDAs equipped with NVIDIA NVENC GPUs |
| 1811.1 | Graphics status indicator | The Graphics status indicator policy has been updated to replace the display lossless indicator policy |
| 1811.1 |DPI matching on Windows 10 | DPI matching allows the Windows 10 desktop session to match the DPI of the endpoint when using Citrix Workspace app for Windows. |
| 1811.1 | HDX adaptive throughput | HDX adaptive throughput intelligently fine-tunes the peak throughput of the ICA session by adjusting output buffers. The number of output buffers is initially set at a high value. This high value allows data to be transmitted to the client more quickly and efficiently, especially in high latency networks. Providing better interactivity, faster file transfers, smoother video playback, higher framerate and resolution results in an enhanced user experience. |

<i> **Note:** from version 7.17 and onward, a new higher compression ratio MDRLE encoder has been added. The Citrix reworked the MDRLE codec so that it consumes less bandwidth in typical desktop sessions when compared with 2DRLE. More information on the Lossless Compression Codec (MDRLE) can be found here: [https://support.citrix.com/article/CTX232041](https://support.citrix.com/article/CTX232041){:target="_blank"} </i>

## Configuration and infrastructure
As always, the tests were conducted by the standard testing methodology, an in-depth look into the methodology can be found [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

The tests were configured to use non-persistent desktops delivered using Citrix Virtual Desktops (MCS) running Microsoft Windows 10 build 1809 and are configured with 2 vCPU and 4 GB RAM. Both Windows and Office are fully patched. Windows Defender was disabled, as this may influence the metrics and result in unreliable data. The image was fully optimized with Citrix Optimizer version 2 with the Citrix supplied ‘Windows 10 1809’ template.

## Host Results
Based on the improvements outlined above we should expect an improvement in scalability, performance and network throughput.
As usual, the first metric that we use to evaluate the scalability of the scenario’s is the Login VSI VSImax value. More information about the VSImax can be found on the Login VSI [website](https://www.loginvsi.com/blog-alias/login-vsi/481-calculating-maximum-virtual-desktop-capacity-vsimax-explained){:target="_blank"}.

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

All Current Release VDA versions show an overall improvement in scalability of the environment to both of the LTSR versions, but from 1808.2 onward the improvement is massive. An improvement of over 30% is really exceptional and our interpretation is that Citrix worked very hard to minimize the footprint of the VDA’s in the latest versions.

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-hostcpu.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-hostcpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-hostcpucompare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-hostcpucompare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Because with most workloads the CPU usage is the main bottleneck, the CPU usage results are in line with the previously listed VSImax results.

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-hostmemory.png" data-lightbox="memory">
![memory]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-hostmemory.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-hostmemorycompare.png" data-lightbox="memory-compare">
![memory-compare]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-hostmemorycompare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Memory consumption, on the other hand, shows a slight increase across the newer versions compared to 7.15.

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-hostreadscompare.png" data-lightbox="reads-compare">
![reads-compare]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-hostreadscompare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-hostwritescompare.png" data-lightbox="writes-compare">
![writes-compare]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-hostwritescompare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-hostcommandscompare.png" data-lightbox="command-compare">
![command-compare]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-hostcommandscompare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The storage charts all show an overall decrease in storage load for versions 1808.2 and 1811.1. It’s unclear why version 7.15 CU3 is showing a minor increase in the load compared to 7.15 CU2.

To get an idea of the user experience from a users perspective we use the tool Remote Display Analyzer to collect data from the protocol. This data is captured for each individual user but it’s important to take into account that different users cannot be compared because the duration of the Login VSI workload is different for each user. Therefore the results published are from a single user, being the first user that is active.

Within the HDX protocol, the metric framerate is reported and collected. The metric framerate is called FPS or Frames per second. In general the greater the FPS value is, the smoother the user experience will appear.

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-fps.png" data-lightbox="fps">
![fps]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-fps.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-fpscompare.png" data-lightbox="fps-compare">
![fps-compare]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-fpscompare.png)
</a>

With the FPS there is an enormous drop in the average FPS during the workload with version 1808.2 and 1811.1. As stated earlier, in general, a higher framerate is favorable because this will result in a smoother user experience.

In respect of the accuracy of the data, we validated the findings by examining the Remote Display Analyzer data for the second user:

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-fpsvalidation.png" data-lightbox="fps-validation">
![fps-validation]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-fpsvalidation.png)
</a>

Again we can see the same trend: an overall drop in FPS for 1808.2 and 1811.1. With this validation, we can conclude that the data is accurate and that we need to find a plausible explanation for the drop in FPS.

On that account let’s focus on the FPS data for 7.18 and 1808.2:

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-fpscompare7181808.png" data-lightbox="fps-vda-version">
![fps-vda-version]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-fpscompare7181808.png)
</a>

During the first part of the workload which is mostly textbased we can see that the FPS count for 1808.2 is lower, but when the part of the workload that plays multimedia content is reached there is an increase in FPS for 1808.2. Specifically, the part of the workload starting from the 43-minute mark unto the 50-minute mark (the multimedia section):

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-fpscompare7181808multimediasection.png" data-lightbox="fps-vda-version-compare">
![fps-vda-version-compare]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-fpscompare7181808multimediasection.png)
</a>

Normally we would rate a low FPS count as disadvantageous because a higher FPS count would result in a better and smoother user experience. In the multimedia section of the workload, the FPS count increases in order to deal effectively with the increased screen output. Here we can see that in the 44, 46 and 48-minute marks during the workload we can see a bump in the FPS for version 1808.2.

At this section of the workload is where the multimedia content is played, that is where the newer VDA versions really start to shine and show the benefit of all the improvements into the protocol that Citrix has created.

The newer caching algorithms for the newer VDA’s result in a lower FPS and have a huge impact on text-based workloads like in the first part of the Login VSI workload. By caching the screen updates this enables the reuse of frequently-used images. Because these screen updates are cached locally by the VDA they don’t need to be transmitted and will result in a lower FPS.

In order to render the frames sent to the endpoint, the VDA’s will require computing power. We can measure the impact of the computing power required with the ‘Average CPU for Encoding’ metric from Remote Display Analyzer.

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-cpuforencodingcompare.png" data-lightbox="cpu-encoding-compare">
![cpu-encoding-compare]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-cpuforencodingcompare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Because of the lower overall FPS count for the newer VDA version, the CPU for encoding is also significantly lower.The chart above shows versions 1808.2 and 1811.1 have a huge drop in CPU load of almost two-thirds in comparison to 7.15.

With the drop in FPS we would expect a significant drop in bandwidth consumption as well. Fewer frames rendered means there is less to transmit over to the client.

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-bandwidth.png" data-lightbox="bandwidth">
![bandwidth]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-bandwidth.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-bandwidthcompare.png" data-lightbox="bandwidth-compare">
![bandwidth-compare]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-bandwidthcompare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As foreseen, the overall bandwidth also benefits from the ICA improvements with a 25% percent drop in bandwidth for 1808.2. Again, the caching done by the HDX protocol can be accounted for these numbers.

Perhaps the HDX adaptive throughput can also be attributed to the drop in bandwidth consumption. With adaptive throughput, the protocol intelligently fine-tunes the peak throughput of the ICA session by adjusting output buffers.

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-rtt.png" data-lightbox="rtt">
![rtt]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-rttcompare.png" data-lightbox="rtt-compare">
![rtt-compare]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-rttcompare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The ICA Roundtrip Time (RTT) which for a large part equals to the responsiveness of the desktop has a steady decline across the versions, which culminates to a 60% decrease in the ICA Round Trip time when comparing VDA 7.15 CU2 to VDA 1811.1. There is no debate here; a lower RTT is always better.

### Launcher results
So far we’ve only looked at the data from the host perspective. As the endpoint (or the launchers in our case) need to process al information send from the VDA, their statistics are also key to take into account.

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-launchercpu.png" data-lightbox="launcher-cpu">
![launcher-cpu]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-launchercpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-launcercpucompare.png" data-lightbox="launcher-cpu-compare">
![launcher-cpu-compare]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-launcercpucompare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As with the host metrics, the newer VDA versions have a significantly lower CPU impact on the launchers, but here the drop is 40% compared to 7.15. The increase in CPU utilization for the 7.18 version is unaccountable at the moment and warrants further investigation.

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-logon.png" data-lightbox="logon">
![logon]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-logon.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-logoncompare.png" data-lightbox="logon-compare">
![logon-compare]({{site.baseurl}}/assets/images/posts/021-citrix-vda-versions-breakdown-a-giant-leap-forward/021-citrix-vda-compare-logoncompare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The time-to-desktop also show a remarkable decline in average login times. This means a faster time to desktop. As one of the key metrics for end users, upgrading to the latest VDA versions will increase end-user experience and satisfaction.

## Conclusion

> **Disclaimer:** These results have been affected by the Login VSI progress bar and results may be different in practice. For more information please read the following post.

The title of this research already gave a way part of the conclusion but a small step for Citrix is a giant leap for end users when it comes to the VDA versions.

Citrix has done a tremendous amount of work on the VDA and HDX protocol fronts. We’ve seen massive improvements in both the user experience and server scalability. Citrix keeps constantly tuning the protocols with each newer version and this clearly shows in the performance of the VDA’s.

More information on the continual improvements in the HDX Protocol can be found here:

[https://www.citrix.com/blogs/2018/10/30/turbo-charging-ica-part-1/](https://www.citrix.com/blogs/2018/10/30/turbo-charging-ica-part-1){:target="_blank"}

[https://www.citrix.com/blogs/2018/12/17/turbo-charging-ica-part-2/](https://www.citrix.com/blogs/2018/12/17/turbo-charging-ica-part-2){:target="_blank"}

In a more real-world scenario’s where multimedia content is becoming more and more common, the impact of these improvements will only be even higher than in our lab environment. The Login VSI workload is configured with moderately static content and with a workload that is a bit outdated in terms that it only uses SD content, whereas multimedia content nowadays is typically 1080p or even 4k in resolution.

If your Life cycle management process fits within the 6 months release timeframe of CR and performance and user experience are key in your environment, based on these findings we can only recommend using CR instead of LTSR.

If you want to comment on this research and its findings, please feel free reach out. Alternatively, you can [join](https://worldofeuc.slack.com){:target="_blank"} the Slack channel and discuss with the community.

Photo by [Joshua Earle](https://unsplash.com/photos/s00F6-W_OQ8?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/jump?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
