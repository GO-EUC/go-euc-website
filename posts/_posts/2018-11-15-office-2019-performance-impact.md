---
layout: post
toc: true
title:  "Office 2019 performance impact"
hidden: false
authors: [omar]
categories: [ 'microsoft', 'office' ]
tags: [ 'microsoft', 'office', '2016', '2019' ]
image: assets/images/posts/004-office-2019-performance-impact/004-office2019-feature-image.png
---
Microsoft Office is by far the most used productivity suite used by enterprises around the world. According to the latest #VDILIKEAPRO State of the Union survey, enterprises are using Office 2016 with an adoption of 30%. Office 2013 is not far behind with 25% and Office 2010 is still used in 15% of the environments.

Microsoft is continuously working on improvements and new features and released Office 2019 last month.

This blog post focuses on the performance and capacity impact of the three most recent Office versions in a VDI environment.

## What’s new in Office 2019
Microsoft has always piqued the interests of its users by offering new features and improvements, such as:

  * Word; Learning tools (captions and audio descriptions), speech feature (text-to-speech) and improved inking functionality
  * Excel; Ability to publish to PowerBI, PowerPivot enhancements and PowerQuery enhancements
  * PowerPoint; Zoom capabilities for ordering of slides within presentations, morph transition feature and the ability to insert and manage icons, SVG, and 3D models
  * Outlook; Updated contact cards, focused inbox and travel and delivery summary cards

More information can be found [here](https://support.microsoft.com/en-us/help/4133312/office-2019-commercial-for-windows-and-mac-frequently-asked-questions){:target="_blank"}.

## Office 2019 requirements
It is important to comply with the requirements specified by the vendor in order to make use of the latest features and functionalities. For Office 2019 the requirements are:

  * Computer and processor; 1.6 gigahertz (GHz) or faster, 2-core.
  * Professional Plus: 2.0 GHz or greater recommended for Skype for Business.
  * Memory; 4 GB RAM; 2 GB RAM (32-bit)
  * Hard disk; 4.0 GB of available disk space
  * Display; 1280 x 768 screen resolution
  * Graphics; Graphics hardware acceleration requires DirectX 9 or later, with WDDM 2.0 or higher for Windows 10 (or WDDM 1.3 or higher for Windows 10 Fall Creators Update).
  * Professional Plus: Skype for Business requires DirectX 9 or later, 128 MB graphics memory, and 32 bits per pixel capable format.
  * Operating system; Windows 10, Windows Server 2019
  * Browser; The current version of Microsoft Edge, Internet Explorer, Chrome, or Firefox.
  * .NET version; Some features may require .NET 3.5 or 4.6 and higher to also be installed

Microsoft’s announcement regarding Office 2019 is, it will only work on SAC (Semi-Annual Channel) and Enterprise Long-Term Servicing Channel (LTSC 2019 (or 1809)) for both Windows 10 and Windows Server 2019. Although Windows 7 has extended support that goes until early 2020 and Windows 8.1 until the year 2023, Microsoft will not support the latest version of Office on these operating systems.

While adding new features can improve the work productivity and user experience of the end-user, it might also impact compute resources. The software requirements are therefore important to note and used for sizing calculations.

More information can be found [here](https://products.office.com/en-us/office-system-requirements?ms.officeurl=systemrequirement){:target="_blank"}.

# Infrastructure and configuration
The infrastructure used for the different scenarios are described in the following [post]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"} and uses {{site.title}}’s testing methodology posted [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

Three different scenarios were tested:

  * Office 2013
  * Office 2016
  * Office 2019

Because of limitations on the required Azure AD and Office365 licenses, Office365 is not included in the test scenario.

The tests were configured to use non-persistent desktops with Citrix Virtual Desktops (MCS), including Citrix VDA 7.18, running Microsoft Windows 10 build 1803. Both Windows and Office are fully patched. Windows Defender was disabled, as this may influence the results with unexpected behavior.

Windows 10 was configured with the following specifications for each scenario:

  * Microsoft Windows 10 Enterprise x64, 1803, build 17134.320
  * 2 vCPU
  * 4 GB RAM

Office 2013, 2016 and 2019 were configured with the following specifications for each scenario:

  * Microsoft Office Professional Plus 2013 x64, 15.0.4569.1506
  * Microsoft Office Professional Plus 2016 x64, 16.0.4266.1001
  * Microsoft Office Professional Plus 2019 x64, 16.0.10827.20138

Office features enabled:

  * Microsoft Excel
  * Microsoft Outlook
  * Microsoft PowerPoint
  * Microsoft Word
  * Microsoft Shared Features
  * Microsoft Tools

Windows 10 was optimized with the default Citrix Optimizer 1803 template.

## The results
Office 2013, depicted in blue, is the baseline reference (100%) for comparison against Office 2016 and 2019. The VSImax value refers to user capacity, higher is better.

<a href="{{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The Office 2016 workload has the lowest impact on user capacity, which means more users on a host without performance degradation. Office 2019 shows the highest impact on user capacity.

Interesting to see that migrating from Office 2013 to 2016 has a user capacity increase while migrating from either Office 2013 or 2016 to 2019 a user capacity impact.

### Host usage
The VSImax will be reached if the host usage is saturated by the generated (work)load. This load will be reflected in the underlying host usage.

### CPU host usage
The graph below shows how the test environment consumes host CPU resources with the different Office workloads.

<a href="{{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-host-cpu-util.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-host-cpu-util.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The CPU load of Office 2019 is the heaviest and Office 2016 the most efficient, which corresponds with the VSImax results.

The bar chart below shows the CPU impact in percentages, lower is better.

<a href="{{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-host-cpu-util-bar.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-host-cpu-util-bar.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Reviewing all the CPU results in comparison to Office 2013 the following conclusions can be made: the Office 2016 workload is the most efficient and has the highest user capacity number. Office 2019 has the greatest impact on CPU utilization which results in less user capacity in the VDI environment. Both Office 2016 and 2019 correspond with the VSImax results.

### Disk IO host usage
A change in your VDI environment can also have an impact on your disk usage. So, it’s important for VDI to use storage in the most efficient way to optimize virtual desktop performance and user experience. The following graphs will shed some light on the different Office versions from a storage point of view. On a side note, writes are more expensive and valuable for VDI environments.

<a href="{{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The disk usage graphs in comparison to Office 2013 show that Office 2019 is the most efficient in read usage. Office 2019 uses less write usage the first 15 minutes and increases towards the end of the workload while Office 2016 consume more write in the first 15 minutes but decreases towards the end of the workload. Both read and write correspond with the average commands.

Let’s take a closer look at the numbers in the bar chart below, that shows the impact in percentages, lower is better. The Office 2016 workload is the most efficient in write usage, whereas Office 2019 is more efficient in read usage. Both Office 2016 and 2019 correspond with the disk usage graphs.

<a href="{{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-host-disk-bar.png" data-lightbox="storage-compare">
![storage-compare]({{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-host-disk-bar.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

### Office start times
During the three scenario’s Office application start times are collected by the workload. The application start times provide an indication on user experience but also identify which applications limit performance and user capacity compared to Office 2013. The following graph shows the average user load and application start times in milliseconds for each Office scenario (combination of Excel, Outlook, PowerPoint, and Word).

<a href="{{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-vsi-avg-appstarts.png" data-lightbox="app-start">
![app-start]({{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-vsi-avg-appstarts.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It is clear that upgrading to Office 2019 has a significant impact on Office application start times. With both Office 2013 and 2016 the average application starting rates are almost identical. With the exception that around the 24-minute mark in the runtime, where Office 2013 shows a slight increase. However, Office 2019 does not only have a higher average starting rate difference of 1 second, it also shows a clear rising trend in terms of application start times. If we calculate the start and end runtime difference is seconds, Office 2019 has an average start time of around 2 seconds and increases with an average of almost 2 seconds resulting in an end time of about 4 seconds. The application start time results are also reflected in the CPU load of Office 2019.

The bar chart below is the combination of Excel, Outlook, PowerPoint and Word start times in percentages, lower is better.

<a href="{{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-vsi-avg-appstarts-combined-bar.png" data-lightbox="app-start-compare">
![app-start-compare]({{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-vsi-avg-appstarts-combined-bar.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There are two applications, in the bar chart below, that have the biggest impact in the individual Office application start times, lower is better.

<a href="{{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-vsi-avg-appstat-bar-ind.png" data-lightbox="app-start-detail-compare">
![app-start-detail-compare]({{site.baseurl}}/assets/images/posts/004-office-2019-performance-impact/004-office2019-vsi-avg-appstat-bar-ind.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Both Outlook and Word are the culprits of the average high application start times. If we compare them in terms of seconds instead of percentages, starting from high to low: Outlook 2019 has an impact of 2 seconds and Word 2019 has an impact of 1 second in comparison to Office 2013 and 2016. But what if the trend line of Office 2019, without Outlook and Word, continues as shown in the bar chart above? Then there is a very good chance that Office 2019 will show faster average application start times compared to Office 2013 and 2016.

Based on the results so far, it’s unexplainable why only Outlook and Word show so much impact, this requires further investigation. The CPU results described earlier, are also reflected in the applications start times.

## Conclusion
Based on the test results so far, upgrading or migrating to Office 2019 shows a measurable performance decrease. This can have an impact on the overall user capacity of your environment.

The new features and functionalities of Office 2019 require more resources and therefore the software requirements are higher compared to Office 2016 and 2013. The testing results also measured a performance difference between the individual Office applications. Word results with an observable difference in application start times measuring 95% greater resource consumption. In a distant second to Word is Outlook with a frequent occurrence difference of 158%.

The 10% CPU impact can be caused by the startup anomaly in Outlook and Word. However, this is only the case with Outlook and Word. The question is: do other people see this behavior too? This anomaly is hard to explain and may be worth a follow-up investigation.

The results prove it is recommended to validate the impact of Office with each upgrade. Especially with the (new) lifecycle management flow of Microsoft’s Office 365 and its continuously process changes in performance may be different in each update. And to avoid unexcepted performance or user experience issues, continuously validation is required. This is the only way to reduce the possible capacity impact of Office upgrades.

If you have any comments or questions, please leave them below.

Photo by [Nastuh Abootalebi](https://unsplash.com/photos/yWwob8kwOCk?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/workspace?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
