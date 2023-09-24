---
layout: post
toc: true
title:  "Citrix VDA version breakdown update"
hidden: false
authors: [eltjo, ryan]
categories: [ 'citrix' ]
tags: [ '1808', '1811', '1906', '1909', 'CR', 'LTSR', 'citrix', 'VDA' ]
image: assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-feature-image.png
---
In September this year Citrix released version 7 1909 for the Current Release (CR) branch of Citrix Virtual Apps and Desktops (CVAD) to the world. During that time Citrix also released two new Cumulative Updates, tentatively called CU4 and CU5 for the Long Term Service Release (LTSR) 7.15.

While performance and scalability are by no means the only rationales for choosing either CR or LTSR, in this research we just wanted to focus on these two aspects to determine if CR would be still be the most obvious choice **link**.

Build 1909 was released roughly 9 months after version 1811.1, which was the latest version available when we released our previous research of the various Citrix VDA agents.

In our previous research, we concluded that based on those results, that CR would be the better choice in terms of performance, scalability and feature richness.

## Citrix VDA Current Release (CR) versus Long Term Service Release (LTSR)
The Long Term Service Release (LTSR) program provides stability and long-term support for Citrix Virtual Apps and Desktops releases. CVAD LTSRs are currently available for versions 7.6 and 7.15 at the moment, but Citrix is targeting to release the next LTSR version (version 1912) this quarter. LTSR 1912 will be based on the lasted CR version, version 1909, which has served for Citrix as the base platform for the 1912 release. More information on the new 1912 LTSR can be found [here](https://www.citrix.com/blogs/2019/10/28/ltsr-1912-preparing-for-the-next-long-term-service-release){:target="_blank"}.

The current LTSR version, version 7.15 was released almost two years ago, and in the meantime Citrix released 8 CRs up until the lasted 1909 CR release.

CR Version 1909 of the VDA for Windows Desktop OS brought AMD GPU hardware support and Enhanced session reliability logging capability among other things. With Enhanced session reliability logging, Citrix VDAs will now report more information to the Windows Eventlog for diagnostic purposes.

More information on version 1909 can be found in the following [blogpost](https://www.citrix.com/blogs/2019/09/19/whats-new-with-citrix-virtual-apps-and-desktops-september-2019){:target="_blank"} and in the ‘Virtual Delivery Agents (VDAs) 1909’ paragraph of the ‘whats new’ section of the Citrix Documentation [website](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/whats-new.html#virtual-delivery-agents-vdas-1909){:target="_blank"}.

Based on recent poll that we conducted on Twitter where we asked if respondents preferred to deploy CR over LTSR, the results couldn’t be more evenly divided with a clean split through the middle.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Good afternoon community folks, for a new <a href="https://twitter.com/g0_euc?ref_src=twsrc%5Etfw">@g0_euc</a><br> research we need your help! If you deploy <a href="https://twitter.com/hashtag/citrix?src=hash&amp;ref_src=twsrc%5Etfw">#citrix</a> CVAD do you have a preference for the CR branch or do you stick with the LTSR releases?</p>&mdash; Eltjo van Gulik [CTP, LVTA] (@eltjovg) <a href="https://twitter.com/eltjovg/status/1189225002383691782?ref_src=twsrc%5Etfw">October 29, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

A similar poll in the CTA Slack channel was biased a little more towards LTSR with 63% and 38% for CR.

## Configuration and infrastructure
This research has taken place on the {{site.title}} environment which is described [here]({{stite.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. Like previous research a similar configuration is used which has 2vCPU’s and 4GB memory. In this case, Windows 10 1809 is the default operating system including Microsoft Office 2016 and the required Login VSI applications. All Windows and Office updates are installed as this is a best practice. For optimizations the Citrix Optimizer is applied with the recommended template.

For this research the following scenarios are defined:

  * Citrix VDA 7.15 CU4, as the baseline and represented in light blue in the charts;
  * Citrix VDA 1808.2, in orange;
  * Citrix VDA 1811.1, in gray;
  * Citrix VDA 1906, in yellow;
  * Citrix VDA 1909 exhibited in dark blue.

As you may have noticed the latest Cumulative Update, 7.15 CU5 is not listed as a scenario. At the time of executing the tests for this research the VDA CU5 was not released yet, so therefore not included in this research.

Compared to previous research we did apply the Login VSI progress modification to avoid any influence in FPS. More information can be found here.

All scenarios are tested using our default testing methodology which is described [here]({{stite.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Results
Based on the results of our previous research we suspect that the new Current Release VDA versions would have an improvement in performance and scalability within our lab. With progressive insight it is expected that version 1909 would have the best result. But based on the release notes on the other hand we suspected this would only be a minimal increase.

Like always, we start with the Login VSI VSImax and Baseline which reflects the scalability and responsiveness between all versions.

<a href="{{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There is a clear difference in capacity between the CR and LTSR. Our expectations are not met as version 1909 shows a decrease in capacity comparing to previous releases.

In the previous research there was a huge increase in capacity, which is not reflected in these results. The results from this research are not affected by the Login VSI progress bar and are more representative compare to previous research.

The Login VSI baseline results are similar as the Login VSI VSImax which means  there is an improvement in the responsiveness using the current release.

It is always important to validate the results using other metrics. Based on the aforementioned Login VSI VSImax results we should see similar results in the Host CPU Utilization.

<a href="{{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-host-cpu.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-host-cpu-compare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The Host CPU utilization data shows that compared to the LTSR versions, all CR’s have a significantly lower CPU footprint, but that the trend diminishes somewhat with version 1909.

Another important factor is the storage load. When there is an unexpected increase in the storage load this could lead to potential issues, especially running on a shared storage solution.

<a href="{{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-host-reads-writes-compare.png" data-lightbox="storage-compare">
![storage-compare]({{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-host-reads-writes-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The results do not look consistent between the various versions. Although based on the Login VSI and CPU results it is expected to see an increase using version 1909. Version 1811 stands out as it has, on average, the same amount of reads per second as version 1909. Based on the line graph the reads per second activity spirals at the end of the test, which could be a side effect caused by other factors. It is not clear what caused this higher read activity, but we are almost certain this is not due to the Citrix VDA.

When talking about user experience an important factor is the logon times. When logon times increase it probably will result in a negative experience.

<a href="{{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-logon-times.png" data-lightbox="logon">
![logon]({{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-logon-times.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-logon-times-compare.png" data-lightbox="logon-compare">
![logon-compare]({{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-logon-times-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The logon times shows a similar pattern, which make sense. As the CPU Usage is higher, it takes longer to logon a user and to load all group policies and to create the profile.

Another metric that provides an indication of the user experience is the FPS.

<a href="{{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-session-fps.png" data-lightbox="fps">
![fps]({{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-session-fps.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-session-fps-compare.png" data-lightbox="fps-compare">
![fps-compare]({{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-session-fps-compare.png)
</a>

Comparing with previous research, all versions show a similar line pattern, which is important. This means that the data is consistent not only across all runs in this research but also compared to previous research. This indicates that the Login VSI progress bar is not producing the continuous frame updates during the entire session.

Although the results within the individual runs are consistent; the FPS count is heavily influenced by the content. As Login VSI uses randomized content (and even more so using the Pro library with an even broader mix of content), the results will be different when using a static content. This warrants further investigation on our part.

As a result, we still believe that the FPS metric is useful for measuring changes in the user experience but should not be solely relied on as a primary indicator for the perceived user experience.

<a href="{{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-session-bandwidth.png" data-lightbox="fps">
![fps]({{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-session-bandwidth.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-session-bandwidth-compare.png" data-lightbox="fps-compare">
![fps-compare]({{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-session-bandwidth-compare.png)
</a>

In terms of metrics, FPS and bandwidth are the odd balls out. While for most metrics we can definitely state that either higher or lower is better. Take the Login VSI VSImax for example, a higher Login VSI VSImax will result in a higher scalability, and therefore we always assume that for the Login VSI VSImax higher is better. But for FPS and bandwidth this is not always the case. Generally speaking, a higher FPS count should result in a better and smoother user experience. But, in that case sending over more frames per second will also increase the bandwidth consumption. If there is ample bandwidth, the fact that more bandwidth is used will not be considered as a negative factor.

But if the workload has a static part, where there are only minimal screen updates, we would not except to see a high FPS count. That would suggest the protocol is inefficient in determining how many frames to send to the client.

## Conclusion
While based on the performance and scalability data, as we mention in the intro, these are by no means the only two things that should be taken into account when making the decision regarding the CR and LTSR. Long time support can be an important factor to take into account. Or maybe the CR has features available that are business critical for the organization.

Our main recommendation based on our starting points: performance and scalability, would still be CR (as was in our previous research). This will also mean you will benefit the most from all the work Citrix has put in terms of features and functionality.

This research has more representative results compare to previous research as those were affected by the Login VSI progress bar. Although the results seem less impressive than in our previous research, the results of both researches cannot be directly compared to each other. Since the previous research a lot of things changed in the lab, such as Windows updates, host updates, component upgrades and for instance the inclusion of the Login VSI Pro library.

To a certain extent we can relate to both the old and the new results and conclude that the increase in terms of scalability and performance have dwindled somewhat with the newer CR releases. We could also argue that this can be contributed to the fact that Citrix has put in a fair amount of new functionality in the product which as always will have an impact  on the overall performance. Also, our concerns for the FPS and the randomness of the content in the Login VSI workload could attribute to the decline in scalability.

We are working close with Citrix to get a root cause of the decrease in scalability. As soon as we have more information, we will update the post and inform you via Twitter of the update.

At this point Citrix has identified a change which may cause a small increase in bandwidth & CPU for server-rendered video regions, and that this has been rectified in the upcoming 1912 release. It is also important to note that only server-rendered video regions are affected; static content is unchanged.

On that note we would like to thank Martin Rowan and Muhammad Dawood for their help, effort and insights.

<a href="{{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-conclusion.png" data-lightbox="conclusion">
![conclusion]({{site.baseurl}}/assets/images/posts/042-citrix-vda-version-breakdown-update/042-vda-compare-conclusion.png)
</a>

Questions or comment about this research? Leave them below in the comments or ask them on the [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Lindsay Henwood](https://unsplash.com/@lindsayhenwood?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/step?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
