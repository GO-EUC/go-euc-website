---
layout: post
toc: true
title:  "The Impact of Spectre, Meltdown and L1TF in a virtualized RDSH environment"
hidden: false
authors: [sven]
categories: [ 'vulnerabilities' ]
tags: [ 'L1TF', 'spectre', 'meltdown', 'RDSH', 'foreshadow' ]
image: assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-feature-image.jpg
---
In 2018 the CPU hardware vulnerabilities Spectre, Meltdown and later L1 Terminal Fault (L1TF, also known as ForeShadow) made headlines. Hardware and software vendors released firmware updates and software patches to mitigate these vulnerabilities. Unfortunately, depending on the workload, these mitigations come with a performance impact. This GO-EUC research focusses on the impact on the performance of enabling the mitigations on the Windows server OS in an RDSH environment.

## Spectre, Meltdown and L1 Terminal Fault
By now you should have heard about the hardware vulnerabilities that exist in modern processors and the exploits called Spectre, Meltdown and L1TF. You are probably also aware of the fact that hardware and software vendors released patches to mitigate against these vulnerabilities and that there might be a performance impact implementing and enabling these patches. If you don’t know about any of these vulnerabilities, start by reading [Meltdownattack.com](https://meltdownattack.com){:target="_blank"}.

### Protect your infrastructure
In most cases, after installing the necessary patches, you are protected against Spectre and Meltdown. On firmware-level, BIOS-level and Hypervisors, the mitigations are enabled by default. In Windows 10, the Spectre and Meltdown mitigations are enabled by default as well. In Windows server operating systems, it’s different. In the following table the default settings in Windows Operating systems are presented:

| OS                             | Spectre  | Meltdown |
| :----------------------------: | :------: | :------: |
| Windows 10                     | Enabled  | Enabled  |
| Windows Server 2016 or earlier | Disabled | Disabled |
| Windows Server 2019            | Disabled | Enabled  |

For more information about Spectre and Meltdown on Windows Operating Systems, read the [support article](https://support.microsoft.com/en-us/help/4072698/windows-server-speculative-execution-side-channel-vulnerabilities-prot){:target="_blank"} on the Microsoft website. This article describes how to enable or disable the mitigations in Windows.

To address the risk from L1TF you are required to take an extra step. In VMware vSphere the so called [Side-Channel-Aware scheduler](https://kb.vmware.com/s/article/55806){:target="_blank"} is available. On Hyper-V there is a similar feature called the [Hyper-V Core Scheduler](https://portal.msrc.microsoft.com/en-us/security-guidance/advisory/adv180018){:target="_blank"}. Performance-wise, enabling these schedulers can have the same impact as disabling Hyperthreading.

## Configuration and infrastructure
The tests for this research were performed on a Nutanix-lab environment. The node on which the tests were performed is part of a 4-node cluster. In a Nutanix cluster a controller VM (CVM) is present on each Nutanix node, but for these tests this CVM was powered off. The storage of the other nodes in the cluster was accessed by the test-node over NFS. For this test, a node with a dual socket Intel Xeon Gold 6130 Processor was used. This CPU is based on a Skylake architecture, containing 16 cores. That means a total of 32 physical CPU cores are present and with Hyperthreading enabled 64 logical CPU cores are available. VMware ESXi 6.7U1 was used during these tests. You can read more about this Nutanix-lab infrastructure [here]({{site.baseurl}}nutanix-lab-architecture-and-hardware-setup-overview-2019){:target="_blank"}.

{{site.title}}’s default workload was used ([described here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}) with two modifications. The Remote Desktop Analyzer (RDA) data capture was disabled due to the overhead of RDA on RDSH and the PDF-printer was not disabled. SBC timer was not enabled during the tests.

### RDSH VM configurations
In the test-host there are 32 physical cores available, 64 logical cores with hyperthreading. The ideal RDSH virtual machine setup in this configuration is 8 virtual machines with 8 vCPU each. Each VM is configured with 42GB of RAM. The installed operating system is Windows Server 2016 with Office 2016 and patches are included until February 2019.

Before performing the tests, all relevant patches were installed (with mitigations against Spectre, Meltdown and L1TF) on all levels in the infrastructure (BIOS, hardware firmware, hypervisor and guest OS). Because Spectre and Meltdown mitigations are disabled by default in Windows Server 2016, we set registry keys to enable Spectre and Meltdown mitigations when we tested the impact of Spectre and meltdown.
The following three scenarios were tested:

  * Windows server 2016 RDSH, with all relevant patches installed. Spectre and Meltdown are disabled by default. The Side-Channel Aware scheduler was not enabled on ESXi. This test is considered the baseline;
  * The same Windows server 2016 image, but with Spectre and Meltdown enabled. The Side-Channel Aware scheduler was not enabled on ESXi;
  * The same Windows server 2016 image with Spectre and Meltdown enabled and the Side-Channel Aware scheduler on VMware ESXi enabled as well.

## The results
It is expected that Spectre, Meltdown and L1TF will have an impact on user density and user experience. Using Login VSI we can measure the impact by comparing the Login VSI VSImax and the Login VSI baseline. The VSImax is one of the best metrics to see if there is a capacity (user density) improvement. More information about the VSImax can be found here.

<a href="{{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

Enabling Spectre and Meltdown in a virtualized RDSH environment will decrease the VSImax with 9%. If the L1TF mitigation is also enabled, the VSImax will decrease with 50%! Enabling this mitigation (enabling the Side-Channel Aware scheduler on ESXi in this case) will result in not being able to leverage Hyperthreading, which partially explains this high impact.

<a href="{{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The impact of enabling Spectre and Meltdown mitigations in the Windows server OS will cause the response times (Login VSI baseline) to go up with 9%. If you then enabled the Side-Channel Aware scheduler on ESXi as well, to mitigate the L1TF vulnerability, the response times will be back to almost the same level as before, only 2% difference from the baseline. This is probably because the VMs are now leveraging real CPU cores instead of hyperthreaded cores.
The impact on the VSImax score and VSI baseline are most likely a result of a higher load on the CPU.

<a href="{{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-host-cpu.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-host-cpu-compare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

On average, the CPU utilization is 5% higher with Spectre and Meltdown mitigations enabled, and with the Side-Channel Aware scheduler enabled 17% higher. The trend is similar as the Login VSI results, but the impact on CPU utilization is lower than expected. Other aspects might influence the results of Login VSI as well, like CPU ready times.

<a href="{{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-host-reads-compare.png" data-lightbox="reads-compare">
![reads-compare]({{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-host-reads-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-host-writes-compare.png" data-lightbox="writes-compare">
![writes-compare]({{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-host-writes-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As expected, there is no impact on reads enabling the mitigations. There is a small increase in writes when the average writes during the test are compared, but the chart of the Host writes/sec during the tests look very similar.

<a href="{{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-logon-times.png" data-lightbox="logon">
![logon]({{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-logon-times.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-logon-times-compare.png" data-lightbox="logon-compare">
![logon-compare]({{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-logon-times-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

An increase in logon times of 17% when enabling Spectre and Meltdown and 71% when also enabling the Side-Channel Aware scheduler does seem a lot. But this is also caused by the higher CPU utilization when the mitigations are enabled. In the next chart, the logon times during the first 20 minutes are compared.

<a href="{{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-logon-times-compare-20min.png" data-lightbox="logon-20min-compare">
![logon-20min-compare]({{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-logon-times-compare-20min.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

When the CPU utilization of the host is still below 80%, the logon times are much closer between the tests. Enabling the Spectre and Meltdown mitigations increase the logon times with 5% and with 6% if the Side-Channel aware scheduler is enabled.

## Alternative test
Because the impact of enabling the mitigations against these vulnerabilities is significant (especially enabling the Side-Channel aware scheduler on ESXi), we decided to run another test with a lower number of sessions and VMs when the Side-Channel Aware scheduler is enabled. The number of launched sessions is lowered by 25% and the number of VMs is 4 instead of 8 RDSH VMs running on the host. These results should provide a more realistic comparison of user density because the virtual CPU to CPU core ration will now be the same again as enabling the Side-Channel Aware scheduler will not leverage hyperthreading.

### The alternative results
In the following chart, the impact on Login VSI VSImax of enabling Spectre, Meltdown and L1TF in an RDSH environment is presented, when the number of sessions and VMs are adjusted for the test with L1TF mitigations.

<a href="{{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-alt-vsimax.png" data-lightbox="vsimax-alt">
![vsimax-alt]({{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-alt-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

Lowering the number of launched sessions and VMs when the Side-Channel Aware scheduler is enabled on ESXi will improve the user density. Instead of a decrease of VSImax of 50%, it’s now “only” 34%.

<a href="{{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-alt-baseline.png" data-lightbox="baseline-alt">
![baseline-alt]({{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-alt-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The Login VSI Baseline is now comparable to the Login VSI Baseline of the test without the mitigations for Spectre and Meltdown enabled (instead of the 2% increase in Login VSI baseline).

<a href="{{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-alt-host-cpu.png" data-lightbox="cpu-alt">
![cpu-alt]({{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-alt-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As you can see, the CPU load is quite similar between the 3 configurations. The CPU utilization of the test with 4 VMs with L1TF enabled is lower during almost the entire test. This is caused by the lower number of launched sessions. In the end, the CPU still reaches 100% utilization.

<a href="{{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-alt-host-cpu-compare.png" data-lightbox="cpu-compare-alt">
![cpu-compare-alt]({{site.baseurl}}/assets/images/posts/024-the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/024-w2k16-spectre-alt-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

On average, the CPU utilization was 6% lower with the Side-Channel Aware scheduler enabled, using less VMs, but also with 25% fewer users launched.

## Conclusion
The impact of Spectre, Meltdown, and L1TF on a virtualized RDSH infrastructure can be significant. In our testing enabling just the Spectre and Meltdown mitigations cause an impact on user density of 9%. The impact on the user experience (Login VSI baseline) is 9%, which means 9% higher response times of applications. The mitigation for L1TF is a different story. Our testing shows an impact of 50% on Login VSI VSImax when the Side-Channel aware scheduler on ESXi is enabled. Testing with a different amount of launched sessions and a lower number of VMs showed that the impact was still more than 30% on the Login VSI VSImax score, with all mitigations enabled.

The question remains, should you enable these mitigations in your RDSH environment? And the answer is: it depends on who you ask. If you ask your security officer, he will (or should) say yes. Anyone else probably doesn’t know or don’t care and just want good performance, good user experience or a low TCO (fewer servers hosting the RDSH-environment). This translates to not wanting the mitigations enabled because it will impact the performance, user experience and TCO.

If you don’t enable the mitigations, your environment is vulnerable to these exploits. We cannot decide for you if it’s worth the risk of not enabling the mitigations. We can only advice you to test the mitigations and measure the impact on your environment and take the appropriate measures.

If you have comments about this research or want to discuss other configurations, please join us on the World of EUC [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Shawn Ang](https://unsplash.com/photos/0VSZVXggySQ?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/melt-ice?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
