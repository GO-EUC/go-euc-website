---
layout: post
toc: true
title:  "Optimizer Smackdown"
hidden: false
authors: [ marcel ]
categories: [ 'VMware','Citrix' ]
tags: [ 'VMware OSOT', 'Citrix Optimizer', 'Smackdown' ]
image: assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-feature-image.png
---
Delivering the best user experience is a key factor when building virtual environments. To accomplish this, administrators use optimization tools, like VMware OS Optimization Tool (OSOT) or Citrix Optimizer (CTXO). This research focuses on the performance difference between both editions of OSOT and CTXO.

## About the optimizers
Both tools are free tools that can be downloaded [here (OSOT)](https://flings.vmware.com/vmware-os-optimization-tool){:target="_blank"} and [here (CTXO)](https://support.citrix.com/article/CTX224676){:target="_blank"}. The tools contain predefined and community templates that are intended for specific operating systems. The optimizations vary from disabling scheduled tasks and services, to removing built-in applications. All templates are intendent to improve the performance and scalability in a virtualized environment.

Please note, this research is not comparing functionality between both tools.

These optimizers have come a long way since the introduction of OSOT in 2013. I’ve personally broken a few Windows images throughout the years in my enthusiasm to create the fastest desktop possible.

An out-of-the-box Windows deployment is not designed for virtual environments. It is the responsibility of the administrators for optimizing the deployment and finding the balance between user experience, speed and scale.

## Infrastructure and configuration
The research took place on the GO-EUC infrastructure which is described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. The same baseline image was used for every scenario. The machines were provisioned with Citrix Virtual Apps & Desktops version 1909 and the infrastructure used VDA 7.15 CU5. The test machines were deployed using Citrix MCS with a default configuration of 2vCPU’s and 4GB of memory.

The Windows 10 1909 is the default operating system which is by default not optimized with an out-of-the-box Windows deployment.

Besides measuring what the performance difference is between Citrix Optimizer and VMware OSOT, we decided to throw their most used community templates in the mix as well. The following scenarios are defined:

  * Citrix Optimizer - Default settings;
  * Citrix Optimizer - With the template from https://wilkyit.com/;
  * VMware OSOT - Default settings;
  * VMware OSOT - With the template from LoginVSI (VDILIKEAPRO);
  * The combination between Citrix Optimizer and VMware OSOT.

> <b>Disclaimer</b>: The templates were selected by popularity in downloads and not by personal preference.

In this research the following versions of the optimizers are used:

  * VMware OSOTversion: b1120;
  * Citrix Optimizerversion: 260118.

All tests were done using our standardized testing methodology, which is described [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Results – templates compared to out-of-the-box Windows
It is expected that all templates provide an enormous performance boost relative to an out-of-the-box deployment, simply because the base Windows image is not made for virtual environments.

This can be validated using the Login VSI VSImax and baseline which represents the scalability and responsiveness of the environment.

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There are a couple of important conclusions to take away from the Login VSI VSImax and baseline results. Firstly, optimizing definitely helps reaching the optimum number of users on a targeted environment. Secondly, both Citrix Optimizer and VMware OSOT have reached the same results, so from a performance and scalability perspective there is no difference.

It is important to validate these results with metrics from the hypervisor. Based on the results above, it is expected to see a big difference compared to an out-of-the-box deployment. The difference between both VMware OSOT and Citrix Optimizer should be minimal to none.

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-host-cpu.png" data-lightbox="host-cpu">
![host-cpu]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-host-mem.png" data-lightbox="host-mem">
![host-mem]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-host-mem.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higer is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-host-cpu-mem-compare.png" data-lightbox="host-cpu-mem-compare">
![host-cpu-mem-compare]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-host-cpu-mem-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better / Higher is better </i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-host-storage-compare.png" data-lightbox="host-storage-compare">
![host-storage-compare]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-host-storage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The metrics from the hypervisors perspective confirm both the Login VSI VSImax and baseline results.

With an out-of-the-box deployment, the big difference in storage is among other things, caused by indexing and processing data, as this is constantly running on the background. The main culprits impacting the performance are: Windows Update, .NET Runtime Optimization, MS Telemetry Service, Windows Defender and WSAPPX. So, too many services and programs that need to be disabled to still write about an “out-of-the-box image”. For this reason, the rest of the research compares the optimizers and their templates with each other and not with an out-of-the-box deployment.

This final chart shows a direct comparison between Citrix Optimizer and VMware OSOT. The differences are a lot smaller than first expected.

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-various-compare.png" data-lightbox="various-compare">
![various-compare]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-various-compare.png)
</a>

## Results – templates compared to each other
Both tools provide various templates including templates that are created by the community. As the optimizations in these templates vary, it is expected to see some differences.

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-vsimax.png" data-lightbox="templates-vsimax">
![templates-vsimax]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-baseline.png" data-lightbox="templates-baseline">
![templates-baseline]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The Login VSI VSImax and baseline results between the templates are minimal. The main concern is finding a balance between speed and user experience (UX). For example, you can strip the UI to a bare minimum, but the end user always prefers a nice UX to optimal speed.

Again, it is important to validate these results using other metrics.

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-host-cpu.png" data-lightbox="templates-host-cpu">
![templates-host-cpu]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-host-cpu-compare.png" data-lightbox="templates-host-cpu-compare">
![templates-host-cpu-compare]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The VDILIKEAPRO template had the highest Login VSI VSImax, which is caused by a lower CPU usage. But the quirkiest result was that the Citrix Optimizer and VMware OSOT combined, resulted in a slightly lower Login VSI VSImax compared to the two optimizers on their own.

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-host-mem.png" data-lightbox="templates-host-mem">
![templates-host-mem]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-host-mem.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-host-mem-compare.png" data-lightbox="templates-host-mem-compare">
![templates-host-mem-compare]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-host-mem-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

While using less CPU, the VDILIKEAPRO template uses more memory without load, but catches up after the users start logging on (or doesn’t claim as much as users start logging on).

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-host-reads.png" data-lightbox="templates-host-reads">
![templates-host-reads]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-host-writes.png" data-lightbox="templates-host-writes">
![templates-host-writes]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-host-storage-compare.png" data-lightbox="templates-host-storage-compare">
![templates-host-storage-compare]({{site.baseurl}}/assets/images/posts/048-optimizer-smackdown/048-optimizer-smackdown-templates-host-storage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The reads and writes of the VDILIKEPRO template are higher compared to the other templates, but to be fair, the template is a couple of years old, and has not been updated since.

## Conclusion
The optimizer tools are there to help administrators improve the performance and scalability in a virtualized environment. Both VMware OSOT and Citrix Optimizer come with default templates and community created templates.

It is recommended to review and understand every setting Citrix Optimizer and VMware OSOT modify before applying. Speed is not everything; functionality and UX must be kept in mind. After evaluating every setting, you should test the master image from front to back. It is easy to break the image when optimizing, believe me, this can take days of frustrating troubleshooting.

Citrix and VMware both [advice](https://communities.vmware.com/thread/616245){:target="_blank"} to be careful with using community templates. Our advice is to simply review and use Citrix Optimizer (supported for Citrix environments) for your Citrix image and VMware OSOT (community project, no support) for your VMware image without the use of a template. The combination of both optimizers does not seem to add any performance boost to the image.

What are you using in your environment? Please share it in the comments below or start the conversation in the [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Tim Gouw](https://unsplash.com/@punttim?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/sprint?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
