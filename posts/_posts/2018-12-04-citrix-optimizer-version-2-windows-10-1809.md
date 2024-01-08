---
layout: post
toc: true
title:  "Citrix Optimizer version 2 – Windows 10 1809"
hidden: false
authors: [eltjo, ryan]
categories: [ 'citrix', 'windows 10' ]
tags: [ 'citrix', 'CTXO', 'windows 10', 'microsoft' ]
image: assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-feature-image.png
---
Recently, there has been considerable interest in the field of image optimization. One of the most commonly used tools is the Citrix Optimizer (CTXO). CTXO is a free to use image optimization tool from Citrix for VDI and SBC environment. CTXO uses various templates for instructions of what to do. Right now, all templates are provided by Citrix themselves and are focused solely on OS optimizations. At the moment of writing version, 1.2.0.67 is the latest available version and can be downloaded from the Citrix [website](https://support.citrix.com/article/CTX224676){:target="_blank"}.


CTXO Version 2 is currently in closed beta and will be released shortly. One of the major improvements is that version 2 will add a GUI for creating custom templates called ‘template builder’. CTXO version 2 will also feature a marketplace from where you can obtain and use custom and third party templates besides the ones that Citrix supplies themselves. Along with the new template builder and it’s ability to easily create custom templates this will greatly enhance the functionality of CTXO and will broaden the userbase even further.

CTXO creator [Martin Zugec](https://twitter.com/martinzugec){:target="_blank"} about the goal of CTXO version 2:

<a href="{{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-vsi-avg-appstat-bar-ind.png" data-lightbox="app-start-detail-compare">
> <img style="width: 150px; float: left; margin-right: 15px; margin-top: 5px" src="{{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-martin-zugec.png"/> With version 2 of Optimizer, we have decided to move to the next big step in our vision – get community more involved in developing, improving and testing Citrix Optimizer.
</a>
>
> To start, we are adding template builder feature to make it easier to create new templates and marketplace feature to make sharing of custom templates easier.

<a href="{{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-optimizer.png" data-lightbox="optimizer">
![optimizer]({{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-optimizer.png)
</a>

We had the opportunity to test the beta version of CTXO on our {{site.baseurl}} platform. For the beta test we ran two scenarios:

  * Windows 10 version 1809 without any optimizations as the baseline
  * Windows 10 version 1809 with the beta version of CTXO with the 1809 template from Citrix

A follow-up post is also scheduled with the results for a Windows Server 2019 workload with Citrix Virtual Apps 1808.2.

## Infrastructure and configuration
The {{site.baseurl}} platform used for conducting this research which is described in the following [post]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. We applied the same testing methodology as the previous researches, where all results are average numbers of multiple runs. More information about the testing methodology can be found in the following [post]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}. The default desktop delivery solution used is Citrix Virtual Desktops version 1808.2.

The Machine Catalog for the VDI’s is created using MCS with a stateless configuration using local profiles. At user logoff, the virtual machine is restored to the original state.

To get consistent results Windows Defender is disabled in all scenarios and the environment contains the latest Windows Updates for both Office and Windows itself.

## Results
The VSImax is the defacto industry standard metric and is a calculated score to determine the saturation point of the VDI environment. The saturation point (VSImax) is defined as the session count before the threshold was reached.

More information about the VSImax can be found on the [Login VSI website](https://www.loginvsi.com/blog-alias/login-vsi/481-calculating-maximum-virtual-desktop-capacity-vsimax-explained){:target="_blank"}.

<a href="{{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The VSImax score shows an increase of 17% in the optimized scenario compared to the baseline scenario, which in this case means we can fit 13 more users on the host before saturation of the environment occurs.

It’s also clear to see that the Login VSI VSImax is much more erratic for the baseline run without any optimization, whereas the optimized scenario shows more stable and consistent figures.

<a href="{{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-vsimax-line.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-vsimax-line.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The increased VSIMax score is also reflected in the host CPU usage metrics as shown the chart below

<a href="{{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-host-cpu-util.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-host-cpu-util.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

On average around 42 minutes into the scenario the baseline test on reached a consistent 100% CPU usage on the host.

Temporary spikes in CPU usage are normal and indicate that the designated workload is making the best use of CPU resources. The consistently high CPU usage, on the contrary, does indicate a problem. High CPU usage can lead to processor queuing of the virtual machines on the host and will negatively impact the performance of the VDI’s running on the host.

One of the first things, in addition to the brokering time, that a user will notice when they launch their virtual desktop is the logon time. Slow logons are one of the most reported end-user issues when it comes to virtual desktops.

<a href="{{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-logon.png" data-lightbox="logon">
![logon]({{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-logon.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

A VDI optimized with CTXO clearly benefits from decreased logon times compared to the baseline.

The other metrics show the same solid trend as the previous metrics; whether it’s disk usage or memory consumption, all metrics clearly show the significant positive impact that CTXO has on the overall performance of the environment.

<a href="{{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-host-mem.png" data-lightbox="memory">
![memory]({{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-host-mem.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

During the tests, Remote Display Analyzer (RDA) is used to capture additional protocol data that we cannot collect with login VSI such as the frames per second and ICA round trip time. This data is captured for each individual user. It’s important to know different users cannot be compared because the duration of the Login VSI workload is different for each user. Therefore, the results published are from a single user, in these cases the first user that is logged on during the workload. More information about RDA can be found [here](https://www.rdanalyzer.com).

<a href="{{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-rda-fps.png" data-lightbox="fps">
![fps]({{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-rda-fps.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

With the optimized VDI, we can achieve a slightly higher FPS count with an overall increase of 5,3%.

<a href="{{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-rda-bandwidth.png" data-lightbox="bandwidth">
![bandwidth]({{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-rda-bandwidth.png)
</a>

A higher framerate will automatically result in a higher bandwidth usage for the optimized scenario in comparison to the baseline. In this case, there is a 14% increase in average bandwidth usage.

Where CTXO really shines is when it comes to the ICA Round Trip Time or RTT. The ICA RTT is used to measure latency. The RTT is the elapsed time from when the user hits a key or mouse button until the response is displayed back at the endpoint. A high RTT equals a high latency and this will negatively affect the user experience. A low RTT in on the other hand will result in an improved user experience.

<a href="{{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-rda-rtt.png" data-lightbox="rtt">
![rtt]({{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-rda-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-rda-rtt-bar.png" data-lightbox="rtt-compare">
![rtt-compare]({{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-rda-rtt-bar.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The average reduction of the ICA round trip time is almost 10% dropping from an average of 43 milliseconds to an average of 39 milliseconds.

## Conclusion
Without any optimization Windows 10 1809 has 276 running services, as shown in Ryan’s post about the [Windows 10 1809 Performance Impact]({{site.baseurl}}/windows-10-1809-performance-impact){:target="_blank"}. After optimizing the number of running services is reduced significantly. Aside from disabling unneeded services CTXO also significantly trims the amount of enabled scheduled tasks on the system based on the recommendations from the selected template. All these optimizations have resulted in a better performing VDI and in a substantial increase in overall server scalability.

<a href="{{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-conclusion.png" data-lightbox="conclusion">
![conclusion]({{site.baseurl}}/assets/images/posts/011-citrix-optimizer-version-2-windows-10-1809/011-ctxo-win10-conclusion.png)
</a>

As always, your mileage may vary depending on your specific environment and situation. Always conduct a thorough evaluation of the environment when using any optimizer.

Many thanks to [Martin Zugec](https://twitter.com/martinzugec){:target="_blank"} for providing us with the Beta version of Citrix Optimizer version 2. As soon as version 2 is released this post will feature an updated link to the download location of the new version.

Photo by [Osman Rana](https://unsplash.com/photos/G7VN8NadjO0?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/speed?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}.
