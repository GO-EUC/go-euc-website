---
layout: post
toc: true
title:  "Page file sizing for virtualized environments"
hidden: false
authors: [marcel]
categories: [ 'microsoft', 'windows 10']
tags: [ 'page file', 'citrix', 'windows 10', 'microsoft' ]
image: assets/images/posts/038-page-file-sizing-for-virtualized-environments/038-page-file-feature-image.png
---
In Q2 2019, a colleague asked what my best practices were for page file sizing in a provisioned environment. I wasn’t quite sure what to answer, because I had used different setups in the past (depending on the environment) with good results. For Windows in general there is enough [documentation](https://docs.microsoft.com/en-us/windows/client-management/determine-appropriate-page-file-size){:target="_blank"} around, but not for VDI. So, we decided to test it once and for all.

## Paging
According to Wikipedia, a page file is:

> A memory management scheme by which a computer stores and retrieves data from secondary storage for use in main memory. In this scheme, the operating system retrieves data from secondary storage in same-size blocks called pages. Paging is an important part of virtual memory implementations in modern operating systems, using secondary storage to let programs exceed the size of available physical memory.
>
> Source: [https://en.wikipedia.org/wiki/Paging](https://en.wikipedia.org/wiki/Paging){:target="_blank"}

In other words, the basic function for a page file is providing the possibility to exceed the available memory in a temporary file on the disk. We created the following scenarios with this in mind.

## The scenarios and configuration
The goal of this research is to understand the impact of various page file configurations. In addition to that, we aim to find the most efficient page file configuration.

A page file can be configured in multiple ways. Besides the default out-of-the-box configuration there is a much-used alternative, in which the initial size is set to one-and-a-half (1.5) times the amount of total system memory and the maximum size is three (3) times the initial size. In our case we have a VM configuration with 4 GB of memory. Therefore, the initial size in this case would be 1.5 times 4096 = 6144 MB and the maximum size would be 3 times 6144 = 18432 MB according to this alternative configuration.

There is also the option to disable the page file configuration which means all data will be kept in memory and cannot be swapped to disk. When using this configuration, it is important to have enough memory available as it could lead to blue screens, also known as BSOD (Blue Screen of Death) when the system runs out of memory.

To end up with a holistic approach, we decided to include multiple configurations, which are defined in the following scenarios:

  * Default, “System managed size”: 40GB space available, as the baseline
  * None, no page file configured
  * Small, page file configuration: 1024 – 1024 MB
  * Large, page file configuration: 6144 – 18432 MB, based on the calculation specified above
  * Fixed, “Custom size” page file configuration: 32 – 2048 MB

The scenarios use a default configuration with 2vCPUs, 4GB memory and a 64GB thin disk. Windows 10 1803, including the required Login VSI applications, is the default operating system. All Windows and Office updates are installed and optimized using Citrix Optimizer with the recommended template. The desktops are delivered using Citrix MCS running version 1906.1.

More information about the infrastructure can be found [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}.

In order to ensure the page file is used during the tests, enough applications need to be started. The Login VSI memory footprint is approximately 1.5GB – 2GB which is not enough for our configuration. Therefore, a memory eater tool is introduced to the workload to ensure enough memory is allocated during the tests. For this purpose, we used [Testlimit](https://docs.microsoft.com/en-us/sysinternals/downloads/testlimit){:target="_blank"} by Mark Russinovich which allows the allocation of a certain amount (2GB) of memory.

Besides the small workload modification, the default testing methodology is used which is described [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Results
Our initial expectation in case of the page file was the bigger, the better. So, a large page file configuration should lead to a capacity improvement as there is enough room to use in the page file. We also expected to break Windows 10 in the configuration without a page file when there was no memory left.

Differences in Login VSI VSImax give the best overview in capacity offset between the scenarios.

<a href="{{site.baseurl}}/assets/images/posts/038-page-file-sizing-for-virtualized-environments/038-page-file-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/038-page-file-sizing-for-virtualized-environments/038-page-file-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The results show a big impact in Login VSI VSImax when using no page file. This extreme drop in capacity is caused by system crashes occurring after a few minutes into the test. The other scenarios don’t show any differences in capacity, in contrast to our expectations.

It is important to validate the Login VSI VSImax results performance metrics from the hypervisor. Based on the Login VSI VSImax, we expected to see a difference when using no page file.

<a href="{{site.baseurl}}/assets/images/posts/038-page-file-sizing-for-virtualized-environments/038-page-file-host-cpu.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/038-page-file-sizing-for-virtualized-environments/038-page-file-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/038-page-file-sizing-for-virtualized-environments/038-page-file-host-cpu-compare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/038-page-file-sizing-for-virtualized-environments/038-page-file-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The CPU Utilization results confirm the Login VSI VSImax results. The system crashes cause a higher CPU usage overall, but not as extreme as the difference in the Login VSI VSImax. This is due to the workload that is stopped preemptively.

As the page file produces reads and writes, it is important to include the storage usages for all scenarios.

<a href="{{site.baseurl}}/assets/images/posts/038-page-file-sizing-for-virtualized-environments/038-page-file-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/038-page-file-sizing-for-virtualized-environments/038-page-file-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/038-page-file-sizing-for-virtualized-environments/038-page-file-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/038-page-file-sizing-for-virtualized-environments/038-page-file-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/038-page-file-sizing-for-virtualized-environments/038-page-file-host-reads-writes-compare.png" data-lightbox="storage-compare">
![storage-compare]({{site.baseurl}}/assets/images/posts/038-page-file-sizing-for-virtualized-environments/038-page-file-host-reads-writes-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The results show a similar pattern as the previous metrics. Besides the confirmation of the configuration without a page file, there is no difference in storage usage, which was not expected.

## Conclusion
Over time, best practices regarding the page file configuration has shifted. Some say no page file should be used, while others recommend the usage of a large or system managed configuration.

As this research shows, it is not recommended to disable the page file, as this could result in system crashes. This is only possible when you really understand the memory usage of your systems and not exceed the limits of these.

We have not seen any difference in the other configuration and, therefore, it is recommended to leave it system managed. When using other storage accelerators like Citrix MCS I/O or [Citrix PVS](https://www.carlstalhood.com/pvs-master-device-preparation/#pagefile){:target="_blank"}, we strongly recommend using a small page file to reduce the size on disk footprint.

We would like to know the sizing used in your environment. Share them in the comments below or join the interaction on the Slack channel [here](https://worldofeuc.slack.com){:target="_blank"}. And as always, please confirm any findings in your own environment before going live.

Photo by [Patrick Lindenberg](https://unsplash.com/@heapdump?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
