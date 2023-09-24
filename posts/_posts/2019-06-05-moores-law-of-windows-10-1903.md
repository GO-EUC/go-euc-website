---
layout: post
toc: true
title:  "Moore’s law of Windows 10 1903"
hidden: false
authors: [ryan, omar]
categories: [ 'microsoft', 'windows 10' ]
tags: [ '1709', '1803', '1809', '1903', 'microsoft', 'windows 10' ]
image: assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-feature-image.png
---
Every 6 months Microsoft releases a new version of Windows 10. Last month Microsoft has released version 1903 with plenty of new features and improvements. But based on previous researches we have seen a Moore’s law of Windows 10. This research will focus on the performance and user experience impact of Windows 10 1903 in a virtual desktop infrastructure (VDI) scenario.

## What’s new in Windows 10 1903
Windows 10 is constantly evolving and with each release of Windows 10, Microsoft adds new features and improvements. Let’s highlight a couple of the new features from Windows 10 1903, that we think are interesting.

### Windows Sandbox
In our opinion, this is the biggest feature of this Windows 10 release. Windows Sandbox is a new feature designed to safely run untrusted application in an isolated environment without harming your device. The feature uses hardware virtualization and the Microsoft Hypervisor technology to create a lightweight environment. This environment is then used to install and run untrusted applications. It is a virtualized environment without the need of creating the virtual machine manually.

### Light theme and Acrylic effect
These are the most visible features in this release of Windows 10. The new light theme brings lighter colors for the Start menu, Action Center, taskbar, touch keyboard, and other elements that didn’t have a true light color scheme when switching from dark to light.

Microsoft also added an acrylic effect, which is part of the fluent design, within the sign-in background. The translucent texture helps you focus on the login task by moving the actionable controls up in the visual hierarchy while maintaining their accessibility. As this is a visual change it might have an impact on the performance.

### Enhanced search indexing options
By default, Windows Search indexes the contents of all the data folders in your personal profile and in any libraries you create. Often power users and developers require more control over what’s searchable. Under the settings app, search and searching Windows, you’ll find a new enhanced option that indexes your entire Windows 10 machine. Since the search and index feature in a VDI environment is often disabled due to a potential performance hit, this new feature can provide a potential performance advantage because exclusions can now be configured.

For the complete list and all the details of the new features and improvements please see this blog post found [here](https://pureinfotech.com/windows-10-1903-19h1-april-2019-update-features){:target="_blank"}.

## Infrastructure and configuration
The research has taken place in the {{site.title}} lab environment which is described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. Based on the requirements of Windows 10, a VM configuration of 2vCPU, 4GB memory, and a 64GB disk are used. The desktops are delivered using Citrix Virtual Apps and Desktops using MCS running with the Citrix VDA version 1811.1. As Login VSI requires a Microsoft Office, version 2016 x64 is installed within the VM.

In order to compare Windows 10 1903, the following scenarios are executed:

  * Windows 10 1709, build 16299.1087, as the baseline;
  * Windows 10 1803, build 17134.706;
  * Windows 10 1809, build 17763.437;
  * Windows 10 1903, build 18162.

Each scenario is tested using the default testing methodology which is described in detail [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}. As it is a best practice, each deployment is fully updated and optimized using the Citrix Optimizer with the correct template. As Windows 10 1903 template is not yet available within the Citrix Optimizer the 1809 template is used, as this is the recommendation from Citrix.

## Expectations and results
The title of this research gives a clear indication of what you can expect. The Moore’s law of Windows 10 is every release will consume more compute resources. Therefore, it is expected to see a bigger impact on user density with Windows 10 1903.

In order to prove the expectations, one of the used metrics is the Login VSI VSImax. This provides a clear indication of the user density of the environment. The Login VSI baseline provides insights into the responsiveness of the session.

<a href="{{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The Login VSI results confirm the expectations, each version of Windows 10 has a bigger impact on the user density. The baseline also shows increased responsiveness, resulting in a slower user experience.

It is important to take other metrics in account to get a complete view of the impact.

<a href="{{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-host-cpu-util.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-host-cpu-util.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-host-cpu-util-compare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-host-cpu-util-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It is clear Windows 10 1903 consumes more CPU resources, which confirms the Login VSI VSImax results. As most environments are CPU limited, it is important to take this into account to avoid capacity problems in your environment.

<a href="{{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-host-storage-compare.png" data-lightbox="storage-compare">
![storage-compare]({{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-host-storage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

From a storage perspective, the same trend continues, namely that Windows 10 1903 needs more storage resources. As the {{site.title}} environment uses local SSD’s there are no resources constraints on storage. But when using a shared storage solution, it is important to ensure there are enough storage resources available when upgrading to a newer Windows 10 build.

Good user experience is important in almost every environment. One of those experiences is the logon times, where a high logon time is often experienced as slow and annoying.

<a href="{{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-logon-times.png" data-lightbox="logon">
![logon]({{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-logon-times.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-logon-times-compare.png" data-lightbox="logon-compare">
![logon-compare]({{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-logon-times-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There is a huge increase in the logon times when using Windows 10 1903. From a previous research, we know the majority of logon time is caused by the built-in apps. Since there is no official Windows 10 1903 optimization template, it is expected that there will be a decrease in login times if it is available.

The Citrix Optimizer disables various services, scheduled tasks and removes the built-in apps. It is interesting to see the differences between the various builds in a basic deployment, which includes Office.

<a href="{{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-windows-task-services-apps.png" data-lightbox="services-tasks-apps">
![services-tasks-apps]({{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-windows-task-services-apps.png)
</a>

The new features come with new services and scheduled tasks. Although there is a decrease in the built-in apps, which is good, we still see the increase in the logon time. Based on [previous research]({{site.baseurl}}/citrix-optimizer-version-2-breakdown){:target="_blank"} we have learned the built-in apps have a major influence on the logon times. This is worth a for a future investigation.

Another important user experience metric is application start times. Where high start times are experienced as slow, annoying and bad.

<a href="{{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-app-start-office.png" data-lightbox="app-office">
![app-office]({{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-app-start-office.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-app-start-other.png" data-lightbox="app-other">
![app-other]({{site.baseurl}}/assets/images/posts/030-moores-law-of-windows-10-1903/030-win10-1903-app-start-other.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

From a user experience perspective, the same trend continues, a huge increase in the application start times when using Windows 10 1903. Windows 10 1903 needs more overall compute resources. These are just the default workload applications, but when using own applications, it is important to ensure there are enough resources available when upgrading to a newer Windows 10 build.

## Conclusion
There are two perspectives of Moore’s law of Windows 10. Microsoft makes efficient use of Moore’s law prediction with the use of the resources. But as most of the hardware is bought for 4 or 5 years it won’t keep up with Moore’s law.

The results are clear, every release of Windows 10 will require more compute resources. Based on these results every two years Windows 10 will require half more compute resources in a VDI environment.

Each release of Windows 10 comes with new features and improvements but requires more resources. While not every feature is required in a VDI context you need to ensure these are removed. Tools like the Citrix Optimizer help with optimizing Windows 10.

In general, it is important to take this trend in account, so you don’t get surprised by capacity problems. As the load continues to increase it will have a negative effect on the user experience.

If you decided to deploy Windows 10 1903 ensure to validate the impact in your environment to avoid capacity or performance problems.

Are you planning to deploy Windows 10 1903 in your VDI environment? Get involved and share you experience in the [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Fabrizio Verrecchia](https://unsplash.com/@fabrizioverrecchia?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/@fabrizioverrecchia?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
