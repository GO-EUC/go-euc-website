---
layout: post
toc: true
title:  "Microsoft Windows Server 2022 performance testing"
hidden: false
authors: [gerjon, tom]
categories: [ 'Windows Server 2022' ]
tags: [ 'Windows Server 2022', 'Windows Server 2019', 'Windows Server 2016', 'Citrix']
image: assets/images/posts/078-windows-server-2022-performance-testing/078-windows-server-2022-feature-image.png
---
On August 18th 2021 Microsoft released Windows Server 2022. This new version has some interesting new features. Windows Server 2022 is released in three editions:

  * Standard
  * Datacenter
  * Datacenter Azure Edition

New features include a lot of security improvements such as: secure DNS support with DNS-over-HTTPS, Server Message Block AES-256 and East-West SMB encryption, SMB over QUIC, HTTPS, and TLS 1.3, Azure Arc, and Azure Automanage - Hotpatch.

Other new features include Nested virtualization for AMD processors, Edge browser and several storage optimalisation features such as SMB compression and Storage Migration Service to name a few. You can read about the new features on the Windows Server 2022 pages on Microsoft Edocs.

Although there aren’t any new features for multiuser use cases there is always the question of how does the new Windows Server 2022 version scale compare to the older versions. So, if you are thinking about updating your environment to Windows Server 2022, one of the considerations is the impact this change has on user density and performance. There are other considerations as well, application compatibility and support for example.

Please be advised that on moment of testing Microsoft 365 apps are not supported on Windows Server 2022. Microsoft Office 2019 is the only supported Office product! So when upgrading your environment check the [Windows and Office configuration support matrix](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE2OqRI){:target="_blank"}.

## Context
This research will focus on answering the following question:

> What is the performance impact of the new Windows Server 2022 on performance in comparison to the older versions

In May 2019 there has been a GO-EUC research on Windows 2016 vs. 2019 so it’s interesting to see how Windows 2022 compares to the older versions
and how all the updates and patches have changed how the older Windows Server versions will perform. You can read the previous research topic [here](https://www.go-euc.com/performance-comparison-windows-2016-vs-windows-2019-rdsh/){:target="_blank"}.

This previous research focused more on the user experience. In the meantime, the underlying hardware has been changed, tooling has been changed and the hypervisor has also been updated. So even though the results are not comparable, it is still an interesting read.

## Infrastructure and configuration

This research has taken place in the GO-EUC lab environment which is described [here](https://www.go-euc.com/architecture-and-hardware-setup-overview-2020/){:target="_blank"}. The desktops are delivered using Citrix Virtual Apps and Desktops using MCS running with the Citrix VDA version 2106 (which has day 1 support for Windows Server 2022) and Microsoft Windows Server. The target VM’s where configured with 8vCPU, 85GB memory, and a 64GB disk.

To test the different operating systems, the following scenarios where
executed:

  * Microsoft Windows Server 2016 Datacenter ([version 1607 build:14393.1884](https://docs.microsoft.com/en-us/windows/release-health/status-windows-10-1607-and-windows-server-2016){:target="_blank"})
  * Microsoft Windows Server 2019 Datacenter ([version 1809 build:17763.1999](https://docs.microsoft.com/en-us/windows/release-health/status-windows-10-1809-and-windows-server-2019){:target="_blank"})
  * Microsoft Windows Server 2022 Datacenter ([version 21H2 build: 20348.169](https://docs.microsoft.com/en-us/windows-server/get-started/whats-new-in-windows-server-2022){:target="_blank"})

Each scenario was tested using the default testing methodology which is described in detail [here](https://www.go-euc.com/insight-in-the-testing-methodology-2020/){:target="_blank"}. As it is a best practice, each deployment is fully updated and optimized using the Citrix Optimizer with the corresponding template. For Server 2022 there is <b>not</b> yet a specific template and the template for Server 2019 was used.

## Expectations and results

When executing this kind of research there is always an expectation. Based on the previous research that stated that the performance of Windows Server 2019 was not as good as Windows Server 2016. So its expected that performance of the newest verion of the operating system is slightly worse than Windows server 2016/2019.

<a href="{{site.baseurl}}/assets/images/posts/078-windows-server-2022-performance-testing/078-windows-server-2022-host-cpu.png" data-lightbox="server-2022-host-cpu">
![server-2022-host-cpu]({{site.baseurl}}/assets/images/posts/078-windows-server-2022-performance-testing/078-windows-server-2022-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/078-windows-server-2022-performance-testing/078-windows-server-2022-host-cpu-compare.png" data-lightbox="server-2022-host-cpu-compare">
![server-2022-host-cpu-compare]({{site.baseurl}}/assets/images/posts/078-windows-server-2022-performance-testing/078-windows-server-2022-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

When looking at CPU utilization updating to Windows Server 2022 does severely impact user density in our test environment. The most interesting find is how efficient Windows Server 2019 scales CPU-wise in comparison to Server 2016 and 2022 and how this has changed in comparison to earlier research. This could be related to hypervisor/Host CPU or updates that have made Windows Server 2019 more CPU efficient.

<a href="{{site.baseurl}}/assets/images/posts/078-windows-server-2022-performance-testing/078-windows-server-2022-host-reads.png" data-lightbox="server-2022-host-reads">
![server-2022-host-reads]({{site.baseurl}}/assets/images/posts/078-windows-server-2022-performance-testing/078-windows-server-2022-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/078-windows-server-2022-performance-testing/078-windows-server-2022-host-writes.png" data-lightbox="server-2022-host-writes">
![server-2022-host-writes]({{site.baseurl}}/assets/images/posts/078-windows-server-2022-performance-testing/078-windows-server-2022-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/078-windows-server-2022-performance-testing/078-windows-server-2022-host-storage-compare.png" data-lightbox="server-2022-host-storage-compare">
![server-2022-host-storage-compare]({{site.baseurl}}/assets/images/posts/078-windows-server-2022-performance-testing/078-windows-server-2022-host-storage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

When looking at the host reads and writes (these are the read and writes to the underlying storage infrastructure by the session host) the newer versions of Windows server are more efficient and will reduce the load on the underlying storage infrastructure.

<a href="{{site.baseurl}}/assets/images/posts/078-windows-server-2022-performance-testing/078-windows-server-2022-host-memory.png" data-lightbox="server-2022-host-memory">
![server-2022-host-memory]({{site.baseurl}}/assets/images/posts/078-windows-server-2022-performance-testing/078-windows-server-2022-host-memory.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/078-windows-server-2022-performance-testing/078-windows-server-2022-host-memory-compare.png" data-lightbox="server-2022-host-memory-compare">
![server-2022-host-memory-compare]({{site.baseurl}}/assets/images/posts/078-windows-server-2022-performance-testing/078-windows-server-2022-host-memory-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

When looking at memory consumption, measured from a hypervisor perspective, there aren’t big differences in the memory usage between the three Windows Server versions.

## Results compared to prior research

When comparing the prior research with the results from this research the performance pattern has changed. There is a steady increase in load when upgrading based on prior researches. However, simular to the Windows 10 researches there has been a shift as Windows Server 2019 now has a lower impact.

## Conclusion

Based on this research there is a clear impact on scalability when using Windows Server 2022. This is primarly based on a higher CPU utilization which could be caused by new features, code optimization that need to be carried out etcetera. Based on the scope of the research the reason for this cannot be confirmed by data. Additional tests will be scheduled to look at protocol data and other features inside the OS.

In terms of user density, the primary bottleneck is CPU bound, so it is expect to see a simular decrease in users based on the CPU. In the GO-EUC envrioment this resulted in 30% less users per session host. Recommendation, the test showed a significantly higher usage of CPU, but the results can be different with your specific workloads so be sure to check how Windows Server 2022 impacts your workload.

Are you planning to upgrade to Windows Server 2022 on a short notice? Let us know what you are expecing in the comments below... or visit the [Slack Channel](https://worldofeuc.slack.com){:target="_blank"}!

Photo by [Stephen Johnson](https://unsplash.com/@stephenfjohnson?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/abstract?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}.