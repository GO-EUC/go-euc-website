---
layout: post
toc: true
title:  "The impact of patching MDS on Windows 10 in a virtual desktop infrastructure"
hidden: false
authors: [sven, ryan]
categories: [ 'vulnerabilities', 'microsoft', 'windows 10' ]
tags: [ 'MDS', 'citrix', 'mitigations', 'RIDL', 'Zombieload', 'windows 10' ]
image: assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-feature-image.png
---

On May 14th 2019 a group of security advisors, together with Intel, publicly announced, yet again, vulnerabilities in the Intel CPUs called Microarchitectural Data Sampling (MDS). These vulnerabilities are also known as Fallout, RIDL (Rogue In-Flight Data Load) and ZombieLoad. On the same date, major vendors like Microsoft, Google, Amazon and VMware released mitigations against these vulnerabilities. This research will investigate the impact of these mitigations on a virtual desktop infrastructure and shows the impact on user density.

## MDS and your VDI environment

A lot has been written and published about the MDS vulnerabilities. To learn more about these vulnerabilities, it is recommended to read [cpu.fail](https://cpu.fail) or [mdsattacks.com](https://mdsattacks.com){:target="_blank"}.

For this research, it is important to understand the context and setup for these performance tests. The goal is to understand the impact of the MDS mitigations. In a VDI environment, this means patching at the hardware level, virtualization layer, and guest OS. Because at the time of testing there was no patch available for the hardware we used, we only tested the impact of patching the hypervisor (VMware vSphere) and the guest OS (Windows 10 build 1809).

You can read more about these mitigations in the following articles:

VMware: [https://www.vmware.com/security/advisories/VMSA-2019-0008.html](https://www.vmware.com/security/advisories/VMSA-2019-0008.html){:target="_blank"}

Microsoft: [https://support.microsoft.com/en-us/help/4073119/protect-against-speculative-execution-side-channel-vulnerabilities-in](https://support.microsoft.com/en-us/help/4073119/protect-against-speculative-execution-side-channel-vulnerabilities-in){:target="_blank"}

In short: for the guest OS just install the required cumulative patch, containing the security update. For VMware vSphere, install the required update and enable the Side-Channel-Aware scheduler. The Side-Channel-Aware scheduler is an alternative to disabling Hyper-Threading (which is required to be fully protected). VMware introduced the Side-Channel-Aware scheduler in vSphere ESXi, which basically disables Hyper-Threading if there are no hardware mitigations in place. Newer processors will/could be introduced to protect the system at the hardware-level. VMware introduced in vSphere version 6.7U2 the Side-Channel-Aware scheduler version 2 mitigation, which should increase the performance while maintaining (almost) the same level of protection.

Read about the Side Channel Aware scheduler V1 and V2 here: [https://www.vmware.com/techpapers/2018/scheduler-options-vsphere67u2-perf.html](https://www.vmware.com/techpapers/2018/scheduler-options-vsphere67u2-perf.html){:target="_blank"}

## Configuration and infrastructure
This research has taken place on the {{site.title}} platform which is described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. All the desktops are delivered using Citrix Virtual Desktop version 1906 and contain 2vCPU’s with 4GB memory. The operating system is Windows 10 1809 and is optimized using the Citrix Optimizer with the recommended template.

In order to get a complete overview of the impact, five scenarios are required.

| Test          | Windows   | VMware vSphere    | Comment                            |
| :-----------: | :-------: | :---------------: | :--------------------------------: |
| Baseline      | 17763.475 | ESXi670-201904001 | Pre MDS patches                    |
| vSphere Patch | 17763.475 | ESXi670-201905001 | Without Windows patch              |
| Windows Patch | 17763.503 | ESXi670-201905001 | Includes vSphere patch             |
| SCAv1	        | 17763.503 | ESXi670-201905001	| Includes vSphere and Windows patch |
| SCAv2	        | 17763.503 | ESXi670-201905001 | Includes vSphere and Windows patch |

As always the default testing methodology is used which is described [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Expectations and results
It is expected that MDS and enabling the Side Channel Aware Scheduler will have an impact on user density and user experience. Using Login VSI we can measure the impact by comparing the Login VSI VSImax and the Login VSI baseline. The Login VSI VSImax is one of the best metrics to see the difference in user capacity. More information about the VSImax can be found [here](https://www.loginvsi.com/blog-alias/login-vsi/481-calculating-maximum-virtual-desktop-capacity-vsimax-explained){:target="_blank"}.

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As expected, applying the MDS mitigations will results in lower user capacity, but only if both the hypervisor and the guest OS are patched. Enabling SCAv1 has an even bigger impact on the user capacity, while SCAv2 does show a small improvement in capacity comparing to SCAv1. This is also reflected in the VSI baseline results, which shows that the overall responsiveness within the desktop gets a bit slower.

It is always important to confirm the Login VSI results using other metrics and therefore performance data from the hypervisor is collected. The {{site.title}} lab environment is CPU limited and therefore the CPU results should be similar to the Login VSI results.

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-cpu.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-cpu-compare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The CPU Utilization is similar to the Login VSI results where the SCAv1 has a significantly higher CPU utilization. SCAv1 shows a higher utilization which is caused by disabling Hyper-Threading. SCAv2 has a lower CPU utilization and which is not similar to the VSImax results. This has to do with the scheduling where the VMs are allocated on the same core which influences the performance. However, SCAv2 does show an improvement in capacity and CPU utilization compared to SCAv1.

Next, we compared the storage performance when applying the patches and enabling the SCA. As the patches only should affect the CPU, we don’t expect huge differences between the scenarios.

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-reads-compare.png" data-lightbox="reads-compare">
![reads-compare]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-reads-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-writes-compare.png" data-lightbox="writes-compare">
![writes-compare]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-writes-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-commands.png" data-lightbox="commands">
![commands]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-commands.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-commands-compare.png" data-lightbox="commands-compare">
![commands-compare]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-commands-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

When the patches are applied to both the hypervisor and the guest OS, we see an increase in both read and write IO, which is not as expected. The average host commands/sec decreases again when enabling SCAv1 but increases again when SCAv2 is enabled. It is interesting to see what the differences are when only the first 20 minutes of the tests are compared, when the host is not saturated in any scenario.

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-commands-20min.png" data-lightbox="commands-20min">
![commands-20min]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-commands-20min.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-commands-20min-compare.png" data-lightbox="commands-20min-compare">
![commands-20min-compare]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-host-commands-20min-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

When comparing only the first 20 minutes of the Login VSI tests, the average host commands per seconds increases with 30 to 36%. These results are more representative of the real impact of the MDS patches.

There are many factors that are part of the user experience. One of the first things that users will experience are the logon times. When the logon times are long it has a negative effect on the user experience. It is important to keep the logon time as short as possible.

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-logon-times.png" data-lightbox="logon">
![logon]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-logon-times.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-logon-times-compare.png" data-lightbox="logon-compare">
![logon-compare]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-logon-times-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The impact on the logon times is huge when we compare the average logon time from the entire test. The test where SCAv1 is enabled shows an increase in logon time of 188%! This is due to the fact that the logon times increase rapidly when the CPU usage is at maximum.

As the logon times are influenced by the server saturation comparing the first 20 minutes provides a more realistic perspective.

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-logon-times-20min.png" data-lightbox="logon-20min">
![logon-20min]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-logon-times-20min.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-logon-times-20min-compare.png" data-lightbox="logon-20min-compare">
![logon-20min-compare]({{site.baseurl}}/assets/images/posts/034-the-impact-of-patching-mds-on-windows-10-in-a-virtual-desktop-infrastructure/034-mds-logon-times-20min-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Applying the patches and enabling the Side-Channel-Aware scheduler does increase the logon time with 5-7% on average, but it isn’t as bad as comparing the averages of the entire duration of the test. This shows the saturation point of the server has a big influence on the logon times.

## Conclusion
Beginning of 2018 the first Intel vulnerabilities were exposed and since then multiple mitigations from multiple vendors have been released to mitigate these vulnerabilities. On May 14th  2019 new Intel vulnerabilities were exposed by a group of security advisors, called Microarchitectural Data Sampling (MDS), also known as Fallout, RIDL (Rogue In-Flight Data Load) and ZombieLoad.

It is expected to see an impact when applying these mitigations and the result shows an impact of around 25%. As the mitigations effects the CPU resources an impact is also having an impact on the user experience which is visible in the logon times.

The key takeaway is to validate the appropriate sizing on your environment after applying these mitigations. Only this way you can ensure the user experience is not affected by these mitigations. This does probably mean more hardware is required to host all those users, which is the big downside of these mitigations.

> **Important note:** the impact is related to the hardware specification and may be different in your environment.

If you don’t enable the mitigations, your environment is vulnerable to these exploits. We cannot decide for you if it is worth the risk of not enabling the mitigations. We can only advice you to test the mitigations and measure the impact on your environment and take the appropriate measures.

If you have comments about this research or want to discuss other configurations, please join us on the World of EUC [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Christian Wiediger](https://unsplash.com/@christianw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/cpu?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
