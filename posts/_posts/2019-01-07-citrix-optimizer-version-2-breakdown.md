---
layout: post
toc: true
title:  "Citrix Optimizer version 2 – Breakdown"
hidden: false
authors: [eltjo]
categories: [ 'citrix' ]
tags: [ 'citrix', 'CTXO', 'citrix optimizer' ]
image: assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-feature-image.png
---
Last year we covered the performance results of the Citrix Optimizer (CTXO) version 2 Beta on [Windows 10]({{site.baseurl}}/citrix-optimizer-version-2-windows-10-1809){:target="_blank"} and [Windows Server 2019]({{site.baseurl}}citrix-optimizer-version-2-windows-server-2019){:target="_blank"}.

The final version of Citrix Optimizer (CTXO) version 2 was released on December 17th 2018. In this research we’ll present a more in-depth analysis of this version of CTXO, version v2.0.0.109.

For this analysis we’ve broken down the optimization from the Citrix supplied optimization template for Windows 10 build 1809 based on the groups below into five scenarios:

<a href="{{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-ctxo1.png" data-lightbox="optimizer">
![optimizer]({{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-ctxo1.png)
</a>

  * Windows 10 Build 1809 without any optimization. This will be our baseline run to which we’ll compare the result to the groups;
  * Windows 10 Build 1809 template with all default optimizations selected;
  * Windows 10 Build 1809 template with only the optimizations from the ‘Disable Services’ group selected;
  * Windows 10 Build 1809 template with only the optimizations from the ‘Remote Built-in Apps’ group selected;
  * Windows 10 Build 1809 template with only the optimizations from the ‘Disable Scheduled Tasks’ group selected;
  * Windows 10 Build 1809 template with only the optimizations from the ‘Miscellaneous’ group selected

We’ve left optimizations from the ‘Optional Components’ group in CTXO per default (deselected).

Our hypothesis was that the removal of the built-in apps and the optimization of the scheduled tasks should have the biggest impact on the user density and performance.

While the optimization of the first four groups are mostly self-explanatory, the last group ‘Miscellaneous’ might require some additional explanation. This group contains optimizations that generally don’t fall in one of the other categories such as optimizations for the Enhanced Write Filter (EWF) and the Native Image Generation.

## Infrastructure and configuration
As always this research was done on the GO-EUC platform that is described in the following [post]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. This setup is identical as our previous two CTXO posts. Although the setups are identical we never compare these results to the results from the previous post due to a number of factors. The image is built from scratch for every research and is updated with both Windows and Office updates afterwards so this could result in a difference of the installed updates between the researches that can influence the results.

The desktop delivery solution is Citrix Virtual Desktop running the latest available version which is version 1808.2 as of writing. The virtual machines are created using Citrix Machine Creation Service (MCS) with a stateless configuration using local profiles. All virtual machines are configured with 2vCPU’s and 4GB memory.

In each scenario the tests were run multiple times as per default and after a scenario is completed the VDI’s were rolled back to their default state and the new optimization for the chosen scenario was applied. More information about the testing methodology can be found in the following [post]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Results
As with all {{site.title}} posts, we use the Login VSI VSImax as the main performance gauge. The VSImax is the defacto industry standard metric and is a calculated score to determine the saturation point of the VDI environment. The saturation point (VSImax) is defined as the session count before the threshold was reached.

More information about the VSImax can be found on the [Login VSI website](https://www.loginvsi.com/blog-alias/login-vsi/481-calculating-maximum-virtual-desktop-capacity-vsimax-explained){:target="_blank"}.

<a href="{{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

All optimization scenarios show a performance increasement with a maximum of 17%. Comparing the ‘Full Optimized’ scenario to the ‘Remove Built-in Apps’ group has a mean percent drop of 2 percent whereas the ‘Disable Services’ and the ‘Miscellaneous’ groups both perform 11 percent worse than the ‘Full Optimized’ scenario and therefore have the least impact in terms of performance gain.

<a href="{{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-hostcpu.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-hostcpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-average-hostcpu.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-average-hostcpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

In the Host CPU usage there is a similar trend, the ‘Remove Built-in Apps’ has lowest CPU utilization on the hosts.

<a href="{{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-commands.png" data-lightbox="commands">
![commands]({{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-commands.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-average-commands.png" data-lightbox="storage-compare">
![storage-compare]({{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-average-commands.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-memory.png" data-lightbox="memory">
![memory]({{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-memory.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The ‘Remove Built-in Apps’ group also scores best when it comes to disk usage and memory consumption with the Built-in Apps removal having a 46% higher impact than the other three groups compared to the fully optimized scenario based on the data.

Please be aware that the Commands/sec metric is not a simple addition of the Number of read/sec + Number of write/sec because the Commands/sec may also include SCSI reservations for instance. That being said, the Commands/sec should be relatively close to the IOPS.

<a href="{{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-rtt.png" data-lightbox="rtt">
![rtt]({{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-bandwidth.png" data-lightbox="bandwidth">
![bandwidth]({{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-bandwidth.png)
</a>

With the other metrics collected from Remote Display Analyzer (RDA) there is something strange noticeable in the data. Disabling unnecessary services shows the biggest reduction in bandwidth consumption, while the ICA Round Trip Time has the biggest reduction with the removal of the built-in Apps.

Data collection from RDA is a bit different than how we collect data from the hosts. For the hosts data we collect and average the data from all runs in a scenario. For RDA we only show the data for the first virtual user that is logged on in the scenario. We double checked the data for the second and third user and these show the same discrepancy.

As we did not measure the brokering time, the average logon time is a key metric to measure the performance of the Virtual Desktop from the standpoint of the end user. For an end user a slow logon almost always equals to a slow desktop experience so it’s important to have the logon times as low as can be.

<a href="{{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-logon.png" data-lightbox="logon">
![logon]({{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-logon.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-average-logon.png" data-lightbox="logon-compare">
![logon-compare]({{site.baseurl}}/assets/images/posts/015-citrix-optimizer-version-2-breakdown/015-ctxo-breakdown-average-logon.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

For data from the Logon times, as suspected, the trend continues with the removal of the Built-in Apps showing the biggest reduction in logon times compared to the optimizations from the other groups.

## Conclusion
In general, optimizations have a performance improvement. As we suspected in the introduction of the post, the removal of the Built-in Apps group has the highest impact on the VDI performance and user density according to the results. While the impact of the optimization of services and scheduled tasks may seem small we do always recommend disabling unused services and scheduled tasks.

Based on the data presented, these results also look consistent with our Windows Server 2019 findings. Windows Server 2019 as standard has a fewer built-in apps compared to Windows 10 and consequently, there is less to optimize and that results in a lesser gain in terms of performance.

## Afterthought
As always, your own mileage might vary. In our lab setup, we have the hosts set to Static high Performance on the hypervisor level for instance, which may not be relatable to a real-world environment. Secondly, we let our environment idle for 30 minutes after startup before we run our tests to ensure no other factors can influence the test results.

Especially for the optimizations in the ‘Miscellaneous’ group like the Native Image Generation for the .NET framework, the impact might be higher if the image has just been updated with the latest Windows Updates. Without pre-optimizing the .NET framework for instance, the Host CPU usage and logon times could be severely impacted.

Photo by [Ryoji Iwata](https://unsplash.com/photos/5siQcvSxCP8?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/puzzle?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
