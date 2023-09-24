---
layout: post
toc: true
title:  "Azure cost saving by optimizing WVD workloads in Citrix Cloud."
hidden: false
authors: [ryan, eltjo]
categories: [ 'Azure' ]
tags: [ 'WVD', 'Azure', 'Citrix Cloud', 'Windows 10 multi-session']
image: assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-feature-image.png
---
At GO-EUC, we've already written about the benefits of VDI optimizations from a performance perspective in the past. With the current buzz and increased interest in cloud workspaces such as WVD, are these optimizations still relevant and are there other benefits or caveats that need to be taken into consideration for those environments?
With this research the focus is on the benefit from optimizing when using the new Windows 10 multi-session OS.

## Windows 10 Enterprise multi-session
Windows 10 Enterprise multi-session (hereafter abbreviated to Windows 10 multi-session), is a new Remote Desktop Session Host that enables multiple concurrent interactive sessions, which previously only Windows Server could do.
For Windows 10 multi-session, versions 1809 and later are supported and available in the Azure gallery.
Please note that Windows 10 multi-session isn’t supported in on-premises production environments because it's optimized for the Windows Virtual Desktop service for Azure.

Besides Windows virtual desktop entitlements, users running Citrix Virtual Apps and Desktops Service (Citrix Cloud) and VMware Horizon Cloud users are also eligible for Windows 10 multi-session.

## Infrastructure and configuration
Windows 10 1909 multi-session is used as the default operating system from the Azure Gallery. Microsoft recommends to always use the latest version for performance and reliability. All required applications including, Microsoft Office 2016 x64 are installed using a post-OS installation task sequence in MDT. Citrix VDA version 1912.1 LTSR is used, as this is the most commonly used version at the time of writing.

The machines used are created using Citrix Virtual Apps and Desktops Service from the Citrix Cloud offering, running in a non-persistent scenario. MSCIO is not part of this research and therefore the MCSIO driver installation was omitted. To channel the communication between Citrix Cloud and the Azure resource location, two Cloud Connectors are deployed, using the Standard D2_v3 SKU in Azure. The on-premises GO-EUC AD is leveraged for authentication by using a site-to-site VPN.

One of the most used Azure SKU for VDI workloads is the Standard_D4_v2. This is an 8 vCPU machine with 28GB of memory. The Standard_D4_v2 comes equipped with a standard SSD as the premium storage is not supported on the D-Series. In this research the VM for the VDI workloads is equipped with a single data disk.

Dv2-series Azure VMs follow-on to the original D-series but have more powerful CPUs. The Dv2-series is about 35% faster than the D-series according to Microsoft. The Dv2-series VMs use the Intel Xeon  8171M 2.1 GHz (Skylake),  the Intel Xeon E5-2673 v4 2.3 GHz (Broadwell) or the Intel Xeon E5-2673 v3 2.4 GHz (Haswell) processors.

According to the Azure Compute Unit (ACU) concept, the DV2 series has an ACU in the range of 210-250. More information on the ACU can be found [here](https://docs.microsoft.com/nl-nl/azure/virtual-machines/acu){:target="_blank"}.

The estimated compute running costs for this VM are around €360 euros per month according to Microsoft own Azure estimates.

<a href="{{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-vm-details.png" data-lightbox="vm-size-details">
![vm-size-details]({{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-vm-details.png)
</a>

More information about VM sizes can be found [here](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-general){:target="_blank"}. Please be aware the listed VM sizes may not be available in your region.

For this research the following two scenarios are specified:

  * Standard_D4_v2 SKU, without optimizations, as the baseline;
  * Standard_D4_v2 SKU, optimized using Citrix Optimizer with the 1909 template.

Our testing methodology, as described [here]({{site.baseurl}}/insight-in-the-testing-methodology-2020/), applies to this research. Because of limited credits available in our Azure subscription, only 4 test runs are configured instead of the normal 10 runs.

More information on the various Citrix Optimizer optimizations can be found in another research [here]({{site.baseurl}}/microsoft-azure-windows-10-enterprise-multi-session-scalability/){:target="_blank"}.

## Expectations and results
Prior this research we did a poll on Twitter where we asked the community what they thought was the most important factor to take into consideration when choosing a new DaaS or Hybrid cloud VDI solution.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Quick question to everyone in the <a href="https://twitter.com/hashtag/EUC?src=hash&amp;ref_src=twsrc%5Etfw">#EUC</a> community:<br><br>For a new <a href="https://twitter.com/g0_euc?ref_src=twsrc%5Etfw">@g0_euc</a> research we would like to know what *you* think is the most important factor when choosing a new <a href="https://twitter.com/hashtag/DaaS?src=hash&amp;ref_src=twsrc%5Etfw">#DaaS</a> or (Cloud) <a href="https://twitter.com/hashtag/VDI?src=hash&amp;ref_src=twsrc%5Etfw">#VDI</a> solution:</p>&mdash; Eltjo van Gulik [CTP, LVTA] (@eltjovg) <a href="https://twitter.com/eltjovg/status/1214246128499281920?ref_src=twsrc%5Etfw">January 6, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

The results were, not surprisingly, very biased toward performance with almost half of the respondents choosing performance over cost, availability and security.

As per usual, this research will start with evaluating the scalability. In this case the user density is defined by the CPU utilization within the VM, because for the Dv2 SKUs the expected bottleneck is the CPU.

<a href="{{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-user-density.png" data-lightbox="user-density">
![user-density]({{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-user-density.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

Applying optimizations is a best practice, and these results show this also applies in the cloud. With the optimized scenario there is a potential for a 30% increase in overall user density. It is expected to see a similar difference in other metrics like the VM CPU utilization.

<a href="{{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-vm-cpu.png" data-lightbox="cpu-util">
![cpu-util]({{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-vm-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-vm-cpu-compare.png" data-lightbox="cpu-util-compare">
![cpu-util-compare]({{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-vm-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The metrics show a significant difference in the CPU utilization between both scenarios. Due to the way the user density is calculated, the data for the CPU utilization is in line with expectations.

As mentioned in the introduction, from a storage perspective standard SSDs are used. In Azure the IOPs limit for the Standard_D4_v2 SKU is 500 IOPs per disk with maximum of 32 disks totaling 32x500 IOPs in total.

<a href="{{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-vm-read.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-vm-read.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-vm-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-vm-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-vm-storage-compare.png" data-lightbox="storage-compare">
![storage-compare]({{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-vm-storage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The optimized images show a solid reduction in both read and write operations, and neither of the scenarios is hitting the upper limit of 500 IOPs.
From an end user perspective the time it takes to load their VDI desktop is their first interaction with the VDI. For that reason it is important to give the end user the lowest logon time possible.

<a href="{{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-logon-times.png" data-lightbox="logon-times">
![logon-times]({{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-logon-times.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Optimizing the image has a hugely positive effect on the logon times, which will benefit the user experience. In this particular case, in our deployment the logon times dropped from 28 seconds to 22 seconds just by applying the default optimizations.

The cost model associated with cloud environments like Microsoft Azure or AWS is, without exception, always pay per use. With this in mind, not only performance is an important factor to consider but it is also important to evaluate the associated cost that comes with the VM.

<a href="{{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-hosting-vms.png" data-lightbox="hosting-vms">
![hosting-vms]({{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-hosting-vms.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

To put this into perspective, the data that is collected is extrapolated to rounded number of 1000 users. To facilitate these 1000 users, 55 un-optimized VMs would be needed whereas in the optimized scenario, 42 optimized VMs would suffice.

With the amount of VMs determined, it is also possible to make a cost estimate for the total amount of running cost for the required amount of VMs needed.

<a href="{{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-estimated-running-cost-247.png" data-lightbox="running-cost-247">
![running-cost-247]({{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-estimated-running-cost-247.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

| Item | Without optimizations | Optimized |
| :--- | :-------------------- | :-------- |
| VMs for 1000 users | 55 | 42 |
| VM Price per month| € 334.89 | € 334.89 |
| VM Price per hour | € 0.4588 | € 0.4588 |
| E10 - Man Disk (OS) per month | € 8.10 | € 8.10 |
| E1 - Man Disk (Identity) per month | 	€ 0.26 | € 0.26 |

In this case the running costs are broken down in compute and storage costs. The storage cost is based on the VM disk, which is a E10 (€ 8.10 per disk per month) variant, and Citrix MCS requires an identity disk, which is the E1 (€ 0.26 per disk per month) variant. All prices are collected from the Azure pricing list for both [compute](https://azure.microsoft.com/en-us/pricing/details/managed-disks/){:target="_blank"} and [storage](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/){:target="_blank}.

Due to the reduction of VMs required to host the 1000 users, € 4.462 on running cost per month can be saved.

Based on experience it estimated a VM in a virtualized environment is used for 300 hours per month. As user might start early in the morning and some working late, it is expected to have the VM running for 15 hours per working day as it is a multi-session operating system.

<a href="{{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-estimated-running-cost-300hours.png" data-lightbox="running-cost-300hrs">
![running-cost-300hrs]({{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-estimated-running-cost-300hours.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There is a clear reduction in cost when running the VMs for the estimated hours. This results in an 8.483 euro difference comparing to keeping the VMs on for 24/7.

When using Citrix Cloud, MCS will delete the OS disk but the identity disk will not be deleted. Therefore, the cost for the identity disk is identical to the 24/7 cost estimations.

When looking at these numbers, keep in mind that it is always wise to take the used VM size into account. It is important to understand the workload when moving to the cloud. Running resources in the cloud will be charged on a pay per use basis, so it is key to find the right balance between scaling up and scaling out. Based on these estimations it is clear to leverage a schedule mechanism as it can reduce significant cost.

In our particular frame of reference with this setup, the Standard_D4_v2 is the most economical choice between the other D-series machines. More info on Windows 10 multi session scalability can be found [here]({{site.baseurl}}/microsoft-azure-windows-10-enterprise-multi-session-scalability/){:target="_blank"}.

## Conclusion
Since the release of Windows Virtual Desktop (WVD) there is an increase in popularity and demand for cloud in many organizations. As mentioned in the previous post, in our opinion this is mainly because of Windows 10 multi session.

This research did not focus on any specific Windows 10 multi session optimization. Currently the Citrix Optimizer does not have a specific template available for Window 10 Multi session. If or when these are released, it is expected to see even higher numbers in regard to user density with performance improvements.

By optimizing the Window 10 multi session VMs there is not only an increase in performance, but also an increase in user density. Cost reduction on the compute costs is achieved by cutting down on the amount of VMs needed to host users. When setting up a business case this may be a strong motivator for migrating to a cloud workspace or DaaS solution.

For these platforms, significant savings in running costs can be realized by optimizing and with that reducing the amount of VMs that are needed to accommodate the users. In our particular frame of reference 24% cost reduction can be achieved by only optimizing the VM.

<a href="{{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-conclusion.png" data-lightbox="conclusion">
![conclusion]({{site.baseurl}}/assets/images/posts/062-azure-cost-saving-by-optimizing-wvd-workloads-in-citrix-cloud/062-azure-cost-saving-conclusion.png)
</a>

When you combine the optimizations with technologies such as [Citrix Autoscale](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops-service/manage-deployment/autoscale.html){:target="_blank"} to shutdown or even remove unused resources, even greater cost reductions can be achieved without sacrificing performance or user experience.

Are you using Windows 10 multi session in production already? Leave your experience in the comments below or share them on the [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Markus Spiske](https://unsplash.com/@markusspiske?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/euro?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}.