---
layout: post
toc: true
title:  "Citrix XenServer 7.1 LTSR vs. Citrix Hypervisor 8.0 CR"
hidden: false
authors: [krishan]
categories: [ 'citrix' ]
tags: [ '7.1', '8.0', 'citrix hypervisor', 'xenserver', 'LTSR', 'CR', 'citrix' ]
image: assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-feature-image.png
---
Hypervisors are a commodity for SBC and VDI infrastructures. Citrix also has a hypervisor in their product line, which, until recently, used to be called Citrix XenServer and Citrix changed the name to Citrix Hypervisor. As the latest version is based on a new Linux kernel, it is good to know what the performance impact is of the different versions on a SBC or VDI environment.

This research focuses on the differences in performance of the two hypervisor versions in a VDI environment.

Citrix introduces with their Current Release cycle, each trimester an updated version of their software. For the Long Time Service Release (LTSR) Citrix releases once in a while a Cumulative Update (CU) version. Citrix released Citrix XenServer 7.1 LTSR CU2 in December 2018 and Citrix Hypervisor 8.0 in April 2019. As mentioned earlier, common usage of this hypervisor is in an SBC or a VDI platform. Based on knowledge and experience, these changes and updates could have performance impact on a SBC or VDI environment. Without conducting performance tests it would be an educated guess and therefore making an assumption.

More information regarding lifecycle of Citrix products can be found on the Citrix website: [https://www.citrix.com/support/product-lifecycle/milestones/citrix-hypervisor.html](https://www.citrix.com/support/product-lifecycle/milestones/citrix-hypervisor.html){:target="_blank"}

## Citrix XenServer 7.1 LTSR vs Citrix Hypervisor 8.0 CR
Citrix XenServer 7.1 version is based on LTSR. Meaning security updates are released in CU and no new functionality is added. On the contrary for Citrix Hypervisor 8.0 Current Release (CR), the release cycle is each trimester. To have support on a CR release it is mandatory to update within the next two CR releases. Each CR comes with new (security) updates and most of all new functionality. Here is a short summary of some of the features:

  * New Linux kernel
  * Updated guest operating system support
  * Create VDI’s with disk larger than 2 TiB
More information regarding Citrix Hypervisor 8.0 can be found on the Citrix website: [https://docs.citrix.com/en-us/citrix-hypervisor.html](https://docs.citrix.com/en-us/citrix-hypervisor.html){:target="_blank"}

Besides improvements and new added functionality, a major change has been done under the hood for Citrix Hypervisor 8.0 in comparison to Citrix XenServer 7.1 LTSR CU2. The kernel version has been updated, as well as the OS of DOM0. In the table below the differences on kernel, hypervisor version and DOM0 operating system is elaborated.

| Component              | Citrix XenServer 7.1 CU2 | Citrix Hypervisor 8.0 |
| :--------------------: | :----------------------: | :-------------------: |
| Kernel Version         | 4.4                      | 4.19                  |
| Xen Hypervisor version | 4.7.1                    | 4.11                  |
| DOM0 OS	               | CentOS 7.4               | CentOS 7.5            |

## DOM0
DOM0 is an abbrevation for “Domain 0 or Control Domain” and is a special VM that has access to the underlaying hardware. Without DOM0 the Citrix Hypervisor is useless. Via DOM0 it is possible to manage and configure networking, VM’s, storage, configuration etc. The usual day-to-day administration is not performed directly via DOM0, but instead this is done through a central management interface called Citrix XenCenter. This is the management tool that is used to manage a Citrix XenServer / Citrix Hypervisor environment with.

## Configuration and infrastructure
This research has taken place on the {{site.title}} platform which is described [here]({{stite.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. All the VDI’s are delivered using Citrix Virtual Desktop version 1906 and contains 2 vCPU’s with 4GB memory. The operating system is Windows 10 1809 and is optimized using the Citrix Optimizer with the recommended template. It is worth to mention that both hypervisors are clean installed. There has not been an upgrade from Citrix XenServer 7.1 CU2 to Citrix Hypervisor 8.0. The variety of conducted tests are summarized below.

  * Citrix XenServer 7.1 LTSR CU2, as the baseline;
  * Citrix Hypervisor 8.0.

All scenarios are tested using the default testing methodology which is described [here]({{stite.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Expectation and Results
It is expected that there will be a performance impact when using Citrix Hypervisor 8.0, because of a newer kernel. Besides the newer kernel there are a lot of security updates on CPU level. Most of the time a security update has (a slight) negative performance impact. Also based on personal experience with newer versions that sometimes could have a performance impact.This should result in a lower Login VSI VSImax compared to Citrix XenServer 7.1 CU2, essentially meaning that Citrix Hypervisor 8.0 could host less users.

The Login VSI VSImax is one of the best metrics to see if there is a performance impact on capacity. More information about he VSImax can be found [here](https://www.loginvsi.com/blog-alias/login-vsi/481-calculating-maximum-virtual-desktop-capacity-vsimax-explained){:target="_blank"}.

<a href="{{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As expected the usage of Citrix Hypervisor 8.0 has a slight negative performance impact. This will result in lower capacity. Therefore upgrading to a newer hypervisor should be carefully taken into account as this could have a negative performance impact. Looking at the Login VSI Baseline, Citrix XenServer 7.1 has better responsiveness. Citrix Hypervisor 8.0 has almost a 10% impact on user experience.

It is important to validate the Login VSI results against metrics from the hypervisors themselves. Starting with the host CPU utilization, which should show a similar trend as the previous Login VSI VSImax results.

<a href="{{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-cpu.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-cpu-compare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

CPU is an important component when it comes to user experience within a session. As the results above shows, Citrix Hypervisor 8.0 has impact on the host CPU compared to Citrix XenServer 7.1. It also reaches CPU saturation earlier then Citrix XenServer 7.1. Although the impact is as minor as 6% when using Citrix Hypervisor 8.0, there is still an impact on CPU which is reflected in the VSIMax results.

Free Memory is a metric that shows how much free memory is available on the Citrix XenServer / Citrix Hypervisor.

<a href="{{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-free-mem.png" data-lightbox="memory">
![memory]({{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-free-mem.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-free-mem-compare.png" data-lightbox="memory-compare">
![memory-compare]({{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-free-mem-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

Comparing the results of both hypervisors results in a major difference between them. Concerning free memory Citrix Hypervisor 8.0 is way more efficient (or uses less memory) with memory usage than its predecessor. Looking at the line chart, it is clear that Citrix Xenserver 7.1 uses more memory during the performance tests.

The allocated memory to the DOM0 has been increased with the recent Citrix Hypervisor 8.0 release and is able to allocate more memory. For more information it is recommended to read the documentation.

Citix XenServer 7.1 LTSR documentation: [https://docs.citrix.com/en-us/xenserver/7-1/downloads/administrators-guide.pdf](https://docs.citrix.com/en-us/xenserver/7-1/downloads/administrators-guide.pdf){:target="_blank"}

Citrix Hypervisor 8.0 documentation: [https://docs.citrix.com/en-us/citrix-hypervisor/memory-usage.html](https://docs.citrix.com/en-us/citrix-hypervisor/memory-usage.html){:target="_blank"}

Nowadays storage resources are not a challenge as an SSD provides more IOPS ever. But it is still important to take any storage differences into account especially using shared storage.

<a href="{{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-read-iops.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-read-iops.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-read-iops-compare.png" data-lightbox="reads-compare">
![reads-compare]({{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-read-iops-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-write-iops.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-write-iops.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-write-iops-compare.png" data-lightbox="writes-compare">
![writes-compare]({{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-write-iops-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Read IOPS is slightly better with Citrix XenServer 7.1 as it shown on the line chart and bar chart. Although there is a performance impact when using Citrix Hypervisor 8.0, the impact is (very) small. The impact is so small that with the current (hardware) techniques, like SSD / caching mechanisms etc, the performance impact would most likely not be noticeable for an end user.

Looking at the Write IOPS, there is a bigger impact compared to the read IOPS in the previous charts. Using Citrix Hypervisor 8.0 requires 16% more write IOPS than its precedessor Citrix XenServer 7.1. Most likely the reason for this could be the newer Linux kernel and the security updates that comes with it. Nonetheless the impact of 16% should be taken into account when using shared storage. Most likely when using local storage and SSD / Flashbased storage, the write IOPS increase will not be a bottleneck.

<a href="{{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-total-iops.png" data-lightbox="total-iops">
![total-iops]({{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-total-iops.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-total-iops-compare.png" data-lightbox="total-iops-compare">
![total-iops-compare]({{site.baseurl}}/assets/images/posts/036-citrix-xenserver-7-1-ltsr-vs-citrix-hypervisor-8-0-cr/036-citrix-xenserver-host-total-iops-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Based on the results of read IOPS and write IOPS it was expected that Citrix Hypervisor 8.0 would have a higher “Total IOPS”. Although the Total IOPS is 11% higher compared to Citrix XenServer 7.1 CU2, most likely with the local SSD or Flash storage this would not be noticeable. Again when having shared storage, this could be noticeable or could have an impact on your storage environment.

## Conclusion
Citrix released their newest hypervisor in April 2019. As with each CR release, improvement, features and security updates are included. Security updates are often known for the performance impact that it could have on an SBC or VDI platform. With that in mind, this is case for Citrix Hypervisor 8.0 compared with the previous version, Citrix XenServer 7.1 CU2.

As expected with the newest Citrix Hypervisor 8.0, there is a minor performance impact on CPU and storage compared to Citrix XenServer 7.1 CU2 LTSR. Looking at the memory usage, it is way more efficient than its predecessor. With Citrix Hypervisor 8.0 a newer Linux kernel has been introduced. Most likely that kernel and the additional security measurements in the kernel is responsible for the minor performance impact.

Nevertheless upgrading to the Citrix Hypervisor 8.0 does make sure your platform is up to date. That means also with the newest functionality, but most of all with a newer Linux kernel and the included security updates. It is worth mentioning that Citrix Hypervisor 8.0 is a Current Release version. Therefore it is mandatory that this version needs to be updated on a regular base to be supported. This comes with extra administration, planning and capacity that is needed within your organization.

Based on these results it is important to validate this in your own environment before upgrading to Citrix Hypervisor 8.0. Another important fact to take into account is the supported hardware with Citrix Hypervisor 8.0.

> The kernel device drivers have also been updated to newer versions. Some hardware that was supported in previous releases might not work with the newer drivers.
>
> Source: [https://docs.citrix.com/en-us/citrix-hypervisor/citrix-hypervisor-8.0.pdf](https://docs.citrix.com/en-us/citrix-hypervisor/citrix-hypervisor-8.0.pdf){:target="_blank"}

More information about the HCL can be found here. [http://hcl.vmd.citrix.com/](http://hcl.vmd.citrix.com){:target="_blank"}

If you have comments about this research or want to discuss other configurations, please join us on the World of EUC [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Ramin Khatibi](https://unsplash.com/@raminix?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/foundation?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
