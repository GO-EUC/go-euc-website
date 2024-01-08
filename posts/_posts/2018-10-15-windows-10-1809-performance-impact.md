---
layout: post
toc: true
title:  "Windows 10 1809 performance impact"
hidden: false
authors: [ryan]
categories: [ 'microsoft', 'windows 10' ]
tags: [ 'microsoft', 'windows 10', '1809', '1709', '1803' ]
image: assets/images/posts/006-windows-10-1809-performance-impact/006-win10-1809-feature-image.png
---
This month (2nd October 2018) Microsoft has officially released Windows 10 1809 also known as Redstone 5. This is the semi-annual targeted release which is scheduled biannual. With the new release, a lot of organizations are preparing to migrate to the new 1809 edition. But what is the impact migrating to Windows 1809 in a virtual environment?  This blog post shows the performance impact of Windows 10 1809 in a virtual desktop infrastructure (VDI) scenario.

> **Please note:** There are known issues with the upgrade path to Windows 10 1809.
>
> “We have paused the rollout of the Windows 10 October 2018 Update (version 1809)* for all users as we investigate isolated reports of users missing some files after updating.
> For the latest information on this issue please see [John Cable’s blog](https://blogs.windows.com/windowsexperience/2018/10/09/updated-version-of-windows-10-october-2018-update-released-to-windows-insiders){:target="_blank"}.”
>
> Source: [https://support.microsoft.com/en-us/help/4464619/windows-10-update-history](https://support.microsoft.com/en-us/help/4464619/windows-10-update-history){:target="_blank"}

## What’s new in Windows 10 1809
With each release of Windows 10, Microsoft adds a lot of new functionally and improvements. This shows Windows 10 is in continuous development. The following list contains some features from the Windows 10 1809 release:

  * Your Phone App
  * Wireless projection experience
  * Windows Autopilot self-deploying mode
  * Kiosk setup experience
  * Registry editor improvements
  * Remote Desktop with Biometrics
  * Security improvements
  * Faster sign-in to a Windows 10 shared pc
  * Web sign-in to Windows 10
  * Dark theme

More information regarding the new features and improvements can be found [here](https://docs.microsoft.com/en-us/windows/whats-new/whats-new-windows-10-version-1809){:target="_blank"}.

## Infrastructure and configuration
The {{site.title}} platform is used for this research which is described in the following [post]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. We applied the same testing methodology where all results are average of multiple runs. For more information please read the following [post]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}. The default desktop delivery solution is Citrix Virtual Desktop as this is a commonly used solution and supports Windows 10 1809 right from the release day which is described [here](https://support.citrix.com/article/CTX224843){:target="_blank"}.

To understand the performance impact of Windows 10 1809 the results needs to be compared to previous releases. In this case, the following 3 scenarios are tested:

  * Windows 10 1709
  * Windows 10 1803
  * Windows 10 1809

All scenarios contain the latest Windows Updates for Office and Windows itself. Within a VDI environment tuning is mandatory and for this scenario, the Citrix Optimizer is used. In order to compare the Windows 10 1709 template from the Citrix Optimizer is used for all scenarios. Please note, the Windows 10 1809 template is not available and is expected in the upcoming weeks. The default VM configuration is used which is 2vCPUs with 4GB of memory which is enough based on the following [requirements](https://www.microsoft.com/en-us/windows/windows-10-specifications){:target="_blank"}. The default deployment contains Office 2016 and Ctirix VDA 7.18.

## The results
Unfortunately, the VSImax metric cannot be used. Windows 10 1809 is not fully optimized where Login VSI reported a VSImax of 1. Therefore this research only uses the baseline metric.

The baseline is a valuable metric. The baseline contains the lowest response times of the tests. A higher baseline indicates a slower response time which results in a lower VSImax. More information about the baseline can be found [here](https://www.loginvsi.com/documentation/index.php?title=Login_VSI_VSImax#VSImax_Baseline){:target="_blank"}.

<a href="{{site.baseurl}}/assets/images/posts/006-windows-10-1809-performance-impact/006-win10-1809-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/006-windows-10-1809-performance-impact/006-win10-1809-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It is interesting to see the difference between 1709 and 1803 release has a minimal impact on the Login VSI baseline, but Windows 10 1809 has an increase of 24%.

<a href="{{site.baseurl}}/assets/images/posts/006-windows-10-1809-performance-impact/006-win10-1809-host-cpu-util.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/006-windows-10-1809-performance-impact/006-win10-1809-host-cpu-util.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

This difference is also reflected in the CPU Utilization on the hypervisor which indicates Windows 10 1809 clearly consumes more resources from the CPU.

<a href="{{site.baseurl}}/assets/images/posts/006-windows-10-1809-performance-impact/006-win10-1809-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/006-windows-10-1809-performance-impact/006-win10-1809-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/006-windows-10-1809-performance-impact/006-win10-1809-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/006-windows-10-1809-performance-impact/006-win10-1809-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

From the storage perspective, the difference is small. There is a slight increase in writes with the latest version of Windows 10.

### The difference in services, scheduled tasks, and apps
Of course, there is a reason that Windows 10 1809 consumes more resources. Microsoft is continuously adding new functionality in Windows which results in more services, tasks, and apps.

<a href="{{site.baseurl}}/assets/images/posts/006-windows-10-1809-performance-impact/006-win10-1809-windows-services-tasks-apps.png" data-lightbox="services-tasks-apps">
![services-tasks-apps]({{site.baseurl}}/assets/images/posts/006-windows-10-1809-performance-impact/006-win10-1809-windows-services-tasks-apps.png)
</a>

Windows 10 1809 has more default services, scheduled tasks, and default apps compared to Windows 10 1709. This is the main reason the impact of Windows 10 1809 is higher. Please note, the chart above is based on the test deployment which includes VMware tools, Citrix VDA, and Adobe Reader.

As mentioned, in this scenario the Windows 10 1709 optimization template is used, so the impact can be optimized. It’s important to understand with each release of Windows 10 re-evaluating the optimizations are mandatory to avoid an unexpected impact.

## Conclusion
With the new release of Windows 10 1809, a lot of organization are preparing the migration to the new release. Based on the results the new release consumes more resources which can have an impact on the overall capacity of your environment. This has all to do with the new functionality which results in extra services, scheduled tasks, and apps. This confirms with each release of Windows 10 it’s mandatory to re-evaluate all the optimizations. Only this way it’s possible to reduce the impact of Windows 10 1809. This research did not contain any deep dive into the available optimizations and is scheduled for another research.

If you have any comments or questions, please leave them below.

Photo by [Scott Webb](https://unsplash.com/photos/myFsTTkub9E?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText{:target="_blank"}) on [Unsplash](https://unsplash.com/search/photos/seattle?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
