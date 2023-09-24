---
layout: post
toc: true
title:  "Windows 10 1909 Scalability in VDI environments"
hidden: false
authors: [omar, ryan]
categories: [ 'microsoft', 'windows 10' ]
tags: [ 'microsoft', 'windows 10', '1803', '1809', '1903', '1909' ]
image: assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-feature-image.png
---
Two months ago, Microsoft released the autumn edition of Windows 10. Also known as Windows 10 1909. This release is a Semi-Annual Channel (SAC) version and is therefore often implemented by enterprise companies. We take this opportunity to verify the impact of Windows 10 1909 in a VDI environment.

## What’s new in Windows 10 1909?
Before dealing with the results, it is important to understand what has been added in this new version of Windows 10.

> **Microsoft statement:** Windows 10, version 1909 is a scoped set of features for select performance improvements, enterprise features and quality enhancements.

### Taskbar calendar
The new calendar, located in the taskbar, has to ability to create calendar events without the need to open the calendar app.

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-calander.png" data-lightbox="calander">
![calander]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-calander.png)
</a>


### Start menu
Once the start menu is opened, no noticeable changes are visible. Until the moment you float over the left rail.  Namely, there is a new menu for accessing the profile, documents, photos, settings and power switches. This new menu applies to all users.

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-startmenu.png" data-lightbox="start-menu">
![start-menu]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-startmenu.png)
</a>


### File Explorer and search
Within the file explorer, the search bar is now controlled by Windows search. Searches will now include online content from OneDrive, similar to the search bar.

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-search.png" data-lightbox="file-explorer">
![file-explorer]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-search.png)
</a>

### Other improvements
Besides the visible changes there are more improvements under the hood in Windows 10 1909:

The digital assistant Cortana provides the ability to support third-party digital assistants to voice activate above the Lock screen;
Some improvements in Windows Containers are included which allows more flexibility;
More control over the level of isolation in Windows Sandbox;
An experimental implementation of TLS 1.3;
Battery life has been improved for devices with certain processors, which may not apply for a VDI deployment or environment. However, if Microsoft improved battery life by lowering CPU usage, this also impacts VDI environments.
A noticeable change that can have a computational improvement is the new processor rotation policy. Windows 10 1909 divides the work more fairly among the favorite cores (for better performance and reliability). It is not clear whether this applies to all processor types or whether it is also applied in a virtual environment.

For more information please visit the following [blog](https://techcommunity.microsoft.com/t5/Windows-IT-Pro-Blog/What-s-new-for-IT-pros-in-Windows-10-version-1909/ba-p/1002699){:target="_blank"}. This doc [blog](https://docs.microsoft.com/en-us/windows/deployment/planning/windows-10-removed-features){:target="_blank"} includes which features and functionalities have been removed in the various Windows 10 builds.

## Infrastructure and configuration
This research has taken place on the {{site.title}} infrastructure which is described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. The parent Windows 10 deployments are based upon MDT with identical task sequences. The only difference between the task sequences is the Windows 10 build. The machines are provided with Citrix Virtual Apps & Desktops version 1909 and the infrastructure uses VDA 7.15 CU5. The test machines are deployed using Citrix MCS with a default configuration of 2vCPU’s and 4GB of memory.

The Windows 10 machines have been optimized using the Citrix Optimizer (CTXO) with the recommended template. Because the Windows 10 1909 optimization template is not yet available in the Citrix Optimizer, the Windows 10 1903 template has been used.

The following scenarios are defined for this research:

  * Windows 10 1803, 17134.1130, as the baseline;
  * Windows 10 1809, 17763.864;
  * Windows 10 1903, 18362.476;
  * Windows 10 1909, 18363.476.
Additionally, it is also interesting to see what the difference between a default out-of-the-box and an optimized VDI deployment of the latest Windows 10 is:

  * Windows 10 1909, 18363.476, default, as the baseline;
  * Windows 10 1909, 18363.476, optimized with CTXO 1903 template.
All tests are done using our standardized testing methodology, which is described [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Expectations and results
When executing these kinds of researches there is always an expectation. Based upon our previous Windows 10 researches it is expected that Windows 10 1909 will result in a lower user capacity, caused by a higher resource utilization, because of the continuously added new features and functionalities.

To validate the difference in user capacity the Login VSI VSImax metric is used. The Login VSI baseline provides an indication of the difference in response times within the virtual desktop.

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The pattern between the different Windows 10 versions are changing. Previous researches have shown a steady decrease in capacity between each Windows 10 version, which is not confirmed in this research. Windows 10 1909 shows promising results, as the difference in scalability is minimal, compared to Windows 10 1803.

It is always important to validate the Login VSI VSImax with other metrics from the hypervisor’s perspective.

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-host-cpu.png" data-lightbox="host-cpu">
![host-cpu]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-host-cpu-compare.png" data-lightbox="host-cpu-compare">
![host-cpu-compare]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As the {{site.title}} lab environment is CPU limited, the Login VSI VSImax pattern is similar as the CPU utilization.

Next to CPU utilization, it is also important to take the storage resources into account. An unexpected switch in storage load could result in bad performance issues.

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-host-reads.png" data-lightbox="host-reads">
![host-reads]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-host-writes.png" data-lightbox="host-writes">
![host-writes]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-host-storage-compare.png" data-lightbox="host-storage-compare">
![host-storage-compare]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-host-storage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As noted, there are fewer read activities in the newer Windows 10 releases. Whereas the writes increased in comparison to Windows 10 1803.

One of the most common user experience indicators are the logon times. This is the first thing a user is experiencing when using a virtual desktop. Therefore, it is important to keep the logon times as low as possible. Based on the previous Windows 10 researches and metrics, it is expected to see an increase in logon times.

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-logon.png" data-lightbox="user-logon">
![user-logon]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-logon.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-logon-24min.png" data-lightbox="user-logon-24min">
![user-logon-24min]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-logon-24min.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-logon-compare.png" data-lightbox="user-logon-compare">
![user-logon-compare]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-logon-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>


<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-logon-24min-compare.png" data-lightbox="user-logon-24min-compare">
![user-logon-24min-compare]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-logon-24min-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The logon times are stable between Windows 10 1903 and 1909, but still, way higher compared to the Windows 10 18 series. When upgrading to a recent Windows 10 version, it is very important to take this into account.

All this extra load can be caused by the new added features, functionalities and improvements which is reflected in more apps, services and tasks.

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-apps-services-tasks.png" data-lightbox="apps-task-services">
![apps-task-services]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-apps-services-tasks.png)
</a>

There is no difference between 1903 and 1909 in comparison to the different apps, services or tasks, which is also reflected in the other metric results, such as CPU, disk IO and logon times.

## Out-of-the-box Windows 10 1909
Applying the right optimizations is one of the best practices when deploying a Windows VDI environment. Using an out-of-the-box Windows 10 deployment in a VDI environment will have a dramatic impact on capacity and user experience.

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The Login VSI VSImax shows a big reduction in user capacity with the out-of-the-box deployment. The user experience is also affected as the Login VSI baseline increases, resulting in slower response times.

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-host-cpu.png" data-lightbox="host-cpu">
![host-cpu]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-host-cpu-compare.png" data-lightbox="host-cpu-compare">
![host-cpu-compare]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

With the out-of-the-box deployment, both the Login VSI VSImax and Login VSI baseline are reflected in a higher CPU utilization. As learned from a previous research the main cause, next to the OneDrive setup, are the Windows 10 UWP apps. These are provisioned for each user at logon.

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-host-reads.png" data-lightbox="host-reads">
![host-reads]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-host-writes.png" data-lightbox="host-writes">
![host-writes]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-host-storage-compare.png" data-lightbox="host-storage-compare">
![host-storage-compare]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-host-storage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The footprint on storage is dramatic when using the out-of-the-box deployment. Of course, this is also related to the OneDrive setup and UWP apps. On that note, the OneDrive setup is removed via GPO in the {{site.title}} lab.

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-logon.png" data-lightbox="user-logon">
![user-logon]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-logon.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-logon-24min.png" data-lightbox="user-logon-24min">
![user-logon-24min]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-logon-24min.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-logon-compare.png" data-lightbox="user-logon-compare">
![user-logon-compare]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-logon-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>


<a href="{{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-logon-24min-compare.png" data-lightbox="user-logon-24min-compare">
![user-logon-24min-compare]({{site.baseurl}}/assets/images/posts/044-windows-10-1909-scalability-in-vdi-environments/044-windows-1909-default-logon-24min-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The above results don’t really need an explanation. It is clear that as a best practice “optimizing Windows” in a VDI environment still applies to Windows 10 1909.

## Conclusion
Each Windows 10 release contains new features, functionalities, and improvements to make the operating system better. But in a virtual environment, these have a negative impact on the capacity, user experience, and resource utilization.

Although the resource usages are very similar comparing Windows 10 1903 and 1909, it is still way higher in comparison to Windows 10 1803. Therefore, it is important to take this into account when upgrading to a recent build.

There is also a shift when comparing these results to previous researches. The user capacity and compute resource percentages differ on the various builds. As in each research, new deployments are used with all the latest cumulative updates. It is very possible there have been some cumulative updates that have a big impact on capacity. This might be interesting to validate in an additional research, what do you think?

Never use an out-of-the-box deployment of any Windows 10 build in your VDI environment. The results proved that applying the right optimizations is still a best practice.

Are you preparing to deploy Windows 10 1909 in your environment? Let us know in the comments below or tell us on the [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Andrew Mantarro](https://unsplash.com/@andymant?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/microsoft?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
