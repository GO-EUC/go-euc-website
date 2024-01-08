---
layout: post
toc: true
title:  "Citrix Optimizer version 2 – Windows Server 2019"
hidden: false
authors: [ryan, eltjo]
categories: [ 'citrix', 'windows server 2019' ]
tags: [ 'citrix', 'microsoft', 'windows 10' ]
image: assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-feature-image.png
---
Optimizing and tuning your environment is one of the best practices for any virtual desktop environment. This applies both to desktop and server operating systems like Windows 10 and Windows Server 2019. In the previous research, we had the opportunity to test with the new Citrix Optimizer tool (CTXO) which also contain a template for Windows Server 2019. As promised, we did another research using CTXO running Windows Server 2019 in a Virtual Apps & Desktops (XenApp) scenario.

More details regarding the new release of CTXO are described in the previous [post]({site.baseurl}}/citrix-optimizer-version-2-windows-10-1809){:target="_blank"}

For this research we ran the following scenarios:

  * Windows Server 2019 without any optimization as the baseline;
  * Windows Server 2019 with optimizations using the CTXO template.

<a href="{{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-optimizer.png" data-lightbox="optimizer">
![optimizer]({{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-optimizer.png)
</a>

## Infrastructure and configuration
This research has taken place on the {{site.title}} platform that is described in the following [post]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. We applied the same testing methodology as the previous researches, where all results are average numbers of multiple runs. More information about the testing methodology can be found in the following [post]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

The default desktop delivery solution is Citrix Virtual Desktop running the latest available version, 1808.2. The virtual machines are created using Citrix Machine Creation Service (MCS) with a stateless configuration using local profiles. All virtual machines are configured with 6vCPU’s and 32GB memory.

Conforming Microsoft best practice the latest Windows Updates for both Windows and Office are applied. To avoid any inconsistent results Defender is disabled in all scenarios.

## Results
When optimizing an operating system, the expected result is to have an improvement in resource utilization, e.g. a lower CPU utilization on the hypervisor and lower memory footprint for example. This will result in a higher VSImax and in GO-EUC’s case a lower CPU utilization.

More information about the VSImax can be found on the [Login VSI website](https://www.loginvsi.com/blog-alias/login-vsi/481-calculating-maximum-virtual-desktop-capacity-vsimax-explained){:target="_blank"}.

<a href="{{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

According to the VSImax values, there is no improvement in user density which is not as expected. This means that optimizing Windows Server 2019 using the CTXO version 2 results in no capacity improvement to the server-side scalability. It is important to validate these results with the other metrics captured from the hypervisors and other sources. Based on the VSImax there should be no difference with the other host metrics.

<a href="{{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-host-cpu-util.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-host-cpu-util.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-host-mem.png" data-lightbox="memory">
![memory]({{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-host-mem.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

As expected, there is no noticeable difference in the host metrics, which confirms the previous VSImax results. Another important metric is the logon time. Logon times have a big impact on the overall user experience.

<a href="{{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-logon.png" data-lightbox="logon">
![logon]({{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-logon.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As shown, there is no difference in the logon times for both scenarios.

During the tests, additional protocol data is collected using Remote Display Analyzer. The optimizations can influence the protocol resulting in a better performance as shown in previous Windows 10 post.

<a href="{{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-rda-fps.png" data-lightbox="fps">
![fps]({{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-rda-fps.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-rda-bandwidth.png" data-lightbox="bandwidth">
![bandwidth]({{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-rda-bandwidth.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-rda-rtt.png" data-lightbox="rtt">
![rtt]({{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-rda-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The applied optimizations do not have any influence on the protocol data.

## Conclusion
Optimizing Windows Server 2019 using the CTXO version 2 in combination with the Citrix provided template does not result in a lower resource utilization. It is important to understand a default installation of a desktop operating system like Windows 10 has more enabled features compared to a server operating system. This means there is less to gain when optimizing a server OS, but there should be at least some improvement.

There have been multiple checks on both Windows Server 2016 and 2019 to ensure the optimizations are applied including running additional tests but with the same results.

<a href="{{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-rda-rtt.png" data-lightbox="rtt">
> <img style="width: 200px; float: left; margin-right: 15px; margin-top: 5px" src="{{site.baseurl}}/assets/images/posts/012-citrix-optimizer-version-2-windows-server-2019/012-ctxo-w2k19-martin-zugec.png"/> Despite the limited results we still recommend to always optimize your operating system. A production workload is always different and may have some benefits of the applied optimizations.
</a>
>
> If we want to keep Citrix Optimizer as a supported tool, we have to be more conservative than we would like to. While there are many more optimizations that we could include, it would not be possible to test them all.
>
> That is why we decided to focus version 2 of Optimizer on this problem – we are making it easier not only to create new templates (with Template Builder feature) but also to share with community through Citrix Optimizer Marketplace. Official Citrix templates will stay conservative, however we are hoping that community will start releasing extended templates, so anyone can find the right balance between performance and stability.
>
> We hope that {{site.title}} team that has done such a great job with performance testing will soon get their hands on templates from other creators with more positive results.
>
> Power to the community!

All information gathered is shared with Martin Zugec to improve the template. If you have recommended settings to optimize, please share those in the comments so we can help Martin to improve the default template.

Photo by [Glen Wheeler](https://unsplash.com/photos/gN3oQVVJDYo?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/f1?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
