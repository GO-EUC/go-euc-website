---
layout: post
toc: true
title:  "Performance comparison Windows 2016 vs Windows 2019 RDSH"
hidden: false
authors: [sven]
categories: [ 'microsoft', 'windows server 2016', 'windows server 2019' ]
tags: [ 'microsoft', 'windows server 2016', 'windows server 2019', 'RDSH', 'Office' ]
image: assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-feature-image.png
---
If you are thinking about updating your Remote Desktop Session Host (RDSH) environment from Windows Server 2016 to Windows Server 2019, one of the considerations is the impact this change has on user density and performance. There are other considerations as well, application compatibility and support for example, but this research will focus on the impact on performance and capacity.

## Introduction
RDSH, or Server Based Computing (SBC) as we used to call it, can be used in different flavors. You can use RDSH in the plain vanilla Microsoft variant or use for example Citrix Virtual Apps and Desktops (formally known as XenApp), VMware Horizon, Parallels Remote Application Server or another product on top of RDSH. One of the reasons to choose RDSH over VDI is the higher user density you (should) get. Sharing the operating system with multiple users allows you to host more users per physical server than you could host with VDI. One thing you don’t want is a lower user density when changing the operating system of the RDSH servers (unless it will offer new functionality or offer a better user experience, then you might accept the lower user density).

### Office Support
If you are providing access to Microsoft Office applications through RDSH, you must be aware of the [support status of Microsoft Office](https://products.office.com/en-us/office-system-requirements){:target="_blank"} on specific operating system versions. In the following table you can see the support of the different Office versions on Windows Server 2016 and 2019.

| Office version        | Windows Server 2016           | Windows Server 2019           |
| :-------------------: | :---------------------------: | :---------------------------: |
| Office 365            | Supported until October 2025	| Supported until October 2025* |
| Office 2016 perpetual	| Supported until October 2025  | Not supported                 |
| Office 2019 perpetual | Not supported	                | Supported until October 2025  |

As you can see, only Office 2019 perpetual licensing is supported on Windows Server 2019. In my opinion, you would need to have a very good reason to use Windows Server 2019 instead of 2016 for RDSH. If you have Office 365 licensing or Office 2016 perpetual, you are forced to stay on Windows Server 2016 or move to VDI. Microsoft would love to see you migrate to [Windows Virtual Desktop](https://azure.microsoft.com/en-us/services/virtual-desktop){:target="_blank"} (which is also multi-session), but that is only available on Azure.

*Update: On July 1 2019, [Microsoft announced that Office 365 will be supported on Windows Server 2019](https://www.microsoft.com/en-us/microsoft-365/blog/2019/07/01/improving-office-app-experience-virtual-environments){:target="_blank"}.

## Configuration and infrastructure
The tests for this research were performed on a Nutanix-lab environment. The node on which the tests were performed is part of a 4-node cluster. In a Nutanix cluster a controller VM (CVM) is present on each Nutanix node, but for these tests, the CVM was powered off on the test-node. The storage in the other nodes in the cluster was presented by the Nutanix distributed file system (DFS) and accessed by the test-node over NFS. For this test, a node with a dual socket Intel Xeon Gold 6130 Processor was used. This CPU is based on a Skylake architecture, containing 16 cores. That means a total of 32 physical CPU cores are present and with Hyperthreading enabled 64 logical CPU cores are available. VMware ESXi 6.7U1 was used during these tests. You can read more about this Nutanix-lab infrastructure [here]({{site.baseurl}}/nutanix-lab-architecture-and-hardware-setup-overview-2019){:target="_blank"}.

The ideal RDSH virtual machine setup in this configuration is 8 virtual machines with 8 vCPU each. Each VM had 42GB of RAM. The installed operation system is Windows Server 2016 or Windows Server 2019 with patches until February 2019. Although Office 2016 is not supported on Windows Server 2019, we used it in our tests to be able to see the impact of just the change in Operating System and not the impact of changing the Office version as well.

In both Operation Systems, Spectre (CVE-2017-5715) and Meltdown (CVE-2017-5754) mitigations were enabled ([using the registry keys mentioned in this article](https://support.microsoft.com/en-us/help/4072698/windows-server-speculative-execution-side-channel-vulnerabilities-prot){:target="_blank"}). The Side-Channel Aware scheduler was not enabled on ESXi.

{{site.title}}’s default workload was used (described [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}) with two modifications. The Remote Desktop Analyzer (RDA) data capture was disabled due to the overhead of RDA on RDSH and the PDF-printer was not disabled. SBC timer was not enabled during the tests.

## The results
Using Login VSI we can measure the impact by comparing the Login VSI VSImax and the Login VSI baseline. The VSImax is one of the best metrics to see if there is a capacity (user density) improvement. More information about the VSImax can be found [here](https://www.loginvsi.com/blog-alias/login-vsi/481-calculating-maximum-virtual-desktop-capacity-vsimax-explained){:target="_blank"}.

<a href="{{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

Changing from Windows Server 2016 to 2019 in a RDSH-environment impacts the VSImax score with 18%, which basically translates to 18% lower user density. Keep in mind that the impact on user density depends on the workload

<a href="{{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The impact on the Login VSI baseline is 26% with Windows Server 2019, which means 26% higher response times of applications. That’s quite a high impact on the user experience!

<a href="{{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-host-cpu-util.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-host-cpu-util.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-host-cpu-util-compare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-host-cpu-util-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It’s interesting to see the impact on average CPU utilization is “only” 9%. That’s lower than the impact on the VSImax score.

<a href="{{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-host-reads-compare.png" data-lightbox="reads-compare">
![reads-compare]({{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-host-reads-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-host-writes-compare.png" data-lightbox="writes-compare">
![writes-compare]({{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-host-writes-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The average Reads/sec (15%) and Writes/sec (25%) are significantly lower using Windows Server 2019, but storage performance is never (or shouldn’t be) a bottleneck in RDSH-environments.

<a href="{{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-logon-times.png" data-lightbox="logon">
![logon]({{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-logon-times.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-logon-times-compare.png" data-lightbox="logon-compare">
![logon-compare]({{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-logon-times-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The average logon times are similar when Windows Server 2016 and 2019 are compared.

<a href="{{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-running-task-services.png" data-lightbox="tasks-services">
![tasks-services]({{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-running-task-services.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Looking at the difference in the average start times of the applications, we see there is an increase in start time of all the used applications on Windows Server 2019 compared to Windows Server 2016. Office application start times increases with 15 to 22%, which is also reflected in the Login VSI baseline. Because the VSImax is lower on Windows Server 2019, we only compared the average start times of the applications until 75% of the sessions were launched.

Let’s take a look at the differences in installed services and scheduled tasks between the two operating systems. These number of services and scheduled tasks are the numbers after installing the required applications for the Login VSI tests (Office, Acrobat Reader, Citrix VDA).

<a href="{{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-installed-task-services.png" data-lightbox="installed-tasks">
![installed-tasks]({{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-installed-task-services.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-running-task-services.png" data-lightbox="running-tasks">
![running-tasks]({{site.baseurl}}/assets/images/posts/029-performance-comparison-windows-2016-vs-windows-2019-rdsh/029-rdsh-2016vs2019-running-task-services.png)
</a>

The lower results with Windows Server 2019 can be partially explained by the higher number of installed services and higher number of Scheduled Tasks. But after applying optimizations, the difference in running services and scheduled tasks is very little.

## Conclusion
In our tests, the impact of changing from Windows Server 2016 to 2019 was 18% lower user density and 26% lower user experience. The application start times, which will affect the user experience, also increases when running Windows Server 2019.  These performance results, and the lack of support for Office 365 on Windows Server 2019*, makes you wonder why you should upgrade your RDSH environment in the first place. Sure, the required storage IO is lower with RDSH 2019, but in my experience, storage IO has never really been a challenge in RDSH environments. If you’re currently running Windows Server 2016 RDSH, you must have a very good reason to upgrade to 2019.

If you deployed Microsoft Office in your RDSH environment, support, or the lack of it, will play a major role in the decision to upgrade. Microsoft Office 365 will be supported on Windows Server 2016 until October 2025. After that, you will need to move to either VDI (Windows 10) or to Windows Virtual Desktop (WVD). Unfortunately, WVD is currently only available on Azure. We can only hope that Microsoft decides to release WVD for on-premises and other cloud providers, before October 2025.

*Update: On July 1 2019, [Microsoft announced that Office 365 will be supported on Windows Server 2019](https://www.microsoft.com/en-us/microsoft-365/blog/2019/07/01/improving-office-app-experience-virtual-environments){:target="_blank"}. The impact on performance is still a consideration to (not) upgrade to Windows Server 2019.

If you have comments about this research, please join us on the World of EUC [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Uriel Soberanes](https://unsplash.com/photos/L1bAGEWYCtk?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/fight?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
