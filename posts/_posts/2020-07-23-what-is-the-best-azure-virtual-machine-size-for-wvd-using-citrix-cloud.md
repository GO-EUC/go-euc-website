---
layout: post
toc: true
title:  "What is the best Azure Virtual Machine size for WVD using Citrix Cloud?"
hidden: false
authors: [patrick]
categories: [ 'Azure' ]
tags: [ 'WVD', 'Azure', 'Citrix Cloud', 'Windows 10 multi-session']
image: assets/images/posts/060-what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/060-best-azure-vm-size-feature-image.png
---
With the release of the Windows Virtual Desktop service (WVD) on Azure, Microsoft has released a new Windows 10 operating system which can host multiple user sessions on the same virtual machine. Microsoft calls this operating system “Microsoft Windows 10 Enterprise multi-session”. This new Windows 10 multi-session operating system is only allowed to run on the Microsoft Azure-platform. But, what is the best virtual machine size for the WVD workload? This research will answer that specific question.

## Microsoft Azure Virtual Machine SKU Sizes
When building an on-premises platform, there are variety of options regarding the hardware. The most efficient and fancy hardware could be selected for optimizing EUC workloads and the user experience. This is what is done for the last decennia and knowing best.

When using an Infrastructure-as-a-Service (IaaS) from a cloud platform, there is no control what happens at the platform level. The cloud provider manages the platform and gives the customer some compute and storage choices (SKUs). The downside of this approach is that the customer is limited to the hardware of the underlying cloud platform. In example, the choice of CPU-types on the Azure-platform are limited. The advantage of this IaaS approach is that the customer does not need to manage the whole virtualization stack since this is the responsibility of the cloud service provider.

With the Azure lock-in of Windows 10 multi-session, the choice of hardware resources is limited to the virtual machine and storage SKUs available on the Azure platform. For this research the following SKUs are selected for validation:

  * D4s_v3
  * DS3_v2
  * F4S_v2
  * B4ms

### D4s_v3
The Dsv3-series VM is, from a vCPU and vMEM-ratio, a good candidate for EUC workloads. The number of cores compared to the virtual memory is in balance and usable for a EUC workloads. This virtual machine is using hyperthreading, so all the vCores are scheduled on the lCores of the physical CPU. There is a vCore to core overcommit ratio of 2 vCPUs to 1 Core.

> The Dsv3-series support premium storage and run on the Intel® Xeon® Platinum 8272CL processor (second generation Intel® Xeon® Scalable processors), Intel® Xeon® 8171M 2.1GHz (Skylake), Intel® Xeon® E5-2673 v4 2.3 GHz (Broadwell), or the Intel® Xeon® E5-2673 v3 2.4 GHz (Haswell) processors with Intel Turbo Boost Technology 2.0 and **feature Intel® Hyper-Threading Technology**. The Dsv3-series sizes offer a combination of vCPU(s), memory, and temporary storage well suited for most production workloads.
>
> [Source](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/windows/){:target="_blank"}

### DS3_v2
The Dsv2-series VM is the older brother of the Dsv3 series VM. It uses the same underlying CPUs as the Dsv3-series. The only difference here is that hyperthreading is not used on the physical CPU. This VM has less vMEM compared to the Dsv3-series. There is a vCore to core overcommit ratio of 1 vCPUs to 1 Core.

> The Dsv2-series virtual machines run on the Intel® Xeon® Platinum 8272CL processor (second generation Intel® Xeon® Scalable processors), Intel® Xeon® 8171M 2.1GHz (Skylake), Intel® Xeon® E5-2673 v4 2.3 GHz (Broadwell), or the Intel® Xeon® E5-2673 v3 2.4 GHz (Haswell) processors with the Intel Turbo Boost Technology 2.0. The D1-5 v2 sizes offer a balanced combination of vCPU(s), memory, and local disk for most production workloads.
>
> [Source](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/windows/){:target="_blank"}

### F4S_v2
The F-series VM is optimized for Compute workloads and therefore has a lower vCPU to vMEM ratio compared to the previous D-series specified above. This VM has a vCore to core overcommit ratio of 2 vCPUs to 1 Core.

> The F-series virtual machines feature 2-GiB RAM and 16 GiB of local SSD temporary storage per CPU core and are optimized for compute intensive workloads. The F-series sizes are based Intel® Xeon® Platinum 8272CL processor (second generation Intel® Xeon® Scalable processors), Intel® Xeon® 8171M 2.1GHz (Skylake), Intel® Xeon® E5-2673 v4 2.3 GHz (Broadwell), or the Intel® Xeon® E5-2673 v3 2.4 GHz (Haswell) processor. These virtual machines are suitable for scenarios like batch processing, web servers, analytics, and gaming.
>
> [Source](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/windows/){:target="_blank"}

### B4ms
The Bs-series VM is a cost-efficient burstable virtual machine. Customers can benefit from the CPU banking and crediting model of this burstable VM when the CPU is not utilized intensively. This VM is a good candidate for applications with a high memory and low CPU demands. Although this VM is not recommended for regular EUC workloads.
More information about the burstable VM rules can be found [here](https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-b-series-burstable){:target="_blank"}.

No overcommit ratio for Bs-series VMs is documented by Microsoft.

> Bs-series are economical virtual machines that provide a low-cost option for workloads that typically run at a low to moderate baseline CPU performance, but sometimes need to burst to significantly higher CPU performance when the demand rises. These workloads don’t require the use of the full CPU all the time, but occasionally will need to burst to finish some tasks more quickly. Many applications such as development and test servers, low traffic web servers, small databases, micro services, servers for proof-of-concepts, build servers, and code repositories fit into this model.
>
> [Source](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/windows/){:target="_blank"}

For more information about Azure Compute Units see the [Microsoft documentation](https://docs.microsoft.com/en-US/azure/virtual-machines/acu){:target="_blank"}.

## Microsoft Guidelines
According to the [Microsoft sizing guidelines](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/virtual-machine-recs?context=/azure/virtual-desktop/context/context){:target="_blank"} for Windows 10 multi-session, Microsoft recommends the following SKU-sizes for multi session operating systems: D2-4s_v3, F2-4s_v3 or NV6. Most of this SKUs are covered in this research.

## Infrastructure and configuration
Windows 10 1909 multi-session is used as the default operating system from the Azure Gallery. Microsoft recommends to always use the latest version for performance and reliability. All required applications including, Microsoft Office 2016 x64 are installed using a post-OS installation task sequence in MDT. Citrix VDA version 1912.1 LTSR is used, as this is the most commonly used version at the time of writing.

The machines used are created using Citrix Virtual Apps and Desktops Service from the Citrix Cloud offering, running in a non-persistent scenario. MSCIO is not part of this research and therefore MCSIO is not enabled. To channel the communication between Citrix Cloud and the Azure resource location, two Cloud Connectors are deployed, using the Standard D2_v3 SKU in Azure. The on-premises GO-EUC AD is leveraged for authentication by using a site-to-site VPN.

The default [testing methodology]({{site.baseurl}}/insight-in-the-testing-methodology-2020/) is used for this research.

## Expectations
For on-premises sizing there are different calculations for VDI- or SBC workloads. Since Windows 10 multi-session is a multi-session OS the SBC “rule of thumb” on-premises user density calculation is applied:

| SKU | Monthly Cost |  vCPU | CPU speed* | vMEM | Est. Users | Est. Bottleneck |
| :---| :----------- | :---- | :--------- | :--- | :--------- | :-------------- |
| D4S_v3 | € 147,74 | 4 | 2300 MHz | 16 GB | 11 | vCPU |
| B4ms | € 118,19 | 4 | 2300 MHz | 16 GB | 11 | vCPU |
| DS3_v2 | € 167,44 | 4 | 2300 MHz | 14 GB | 10 | vMEM |
| F4S_v2 | € 119,43 | 4 | 2300 MHz | 8 GB | 4 | vMEM |

\* Please note CPU speed can vary due to host placement in the Azure platform.

**Rule of thumb explained: Number of users based on CPU (multi-session)**

Medium-Heavy user weight = 800 MHz per user.

Number of users is = vCPU * CPU-speed / user-weight.

Example: D4S_v3 = 4 vCPU * 2300 MHz / 800 Mhz = 11,5 users (rounded: 11 users)

**Rule of thumb explained: Number of users based on memory (multi-session)**

Medium-Heavy user 1 GB per user.

Number of users = (Total MEM – 4 GB OS reservation) / user-weight.

Example: D4S_v3 = (16 GB – 4 GB OS reservation) / 1 = 12 users

**Lower user density due to hyperthreading and CPU exploit mitigations**

The expectation is that the overcommit ratio of 2 vCPU to 1 Core will have an impact on the user density on the Dsv3-series and Fsv2-series VMs. This is due to all the CPU mitigations released over the last couple of years. For more information aboutt the impact of various mitigation please see the following GO-EUC researches.

[The Impact of Spectre, Meltdown and L1TF in a virtualized RDSH environment](https://www.go-euc.com/the-impact-of-spectre-meltdown-and-l1tf-in-a-virtualized-rdsh-environment/){:target="_blank"}
[Impact MCEPSC vulnerability patch on VDI](https://www.go-euc.com/impact-mcepsc-vulnerability-patch-on-vdi/){:target="_blank"}

The Dsv2-series VM has a 1 vCPU to 1 Core overcommit ratio and is not using hyperthreading. The expectation is that the user density on the Dsv2-series VM is higher from a CPU perspective.

**Expectation of inconsistency in performance**

There is also an expectation of inconsistency in performance between the different runs. Each different SKU mentions that a virtual machine can run on different type of physical CPUs. Due to this, there is no control on what type of physical CPU the VM will run. Each physical CPU differs from a performance perspective and can have influence on the load test in this research.

## Results
Based on the expectations the user density can be validated based on CPU or MEM bottleneck.

<a href="{{site.baseurl}}/assets/images/posts/060-what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/060-best-azure-vm-size-user-density.png" data-lightbox="user-density">
![user-density]({{site.baseurl}}/assets/images/posts/060-what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/060-best-azure-vm-size-user-density.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

When investigating the user density, the rule of thumb for on-premises SBC-sizing still applies to Windows 10 multi-session on Azure. There is a little difference between the calculated density and the measured density on the Dsv3-series and B-series VMs. The D4s_v3 and B4ms can host two users less than expected. There is a possibility this is caused by fact that the Dsv3-series and B-series VMs are using hyperthreading.  The F4s_v2 VM is the only one hitting the virtual memory bottleneck and not CPU, which is as expected.

There is an expectation to see inconsistency between the runs. As multiple runs are executed, performance consistency can be investigated by comparing the CPU usage over multiple runs.

<a href="{{site.baseurl}}/assets/images/posts/060-what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/060-best-azure-vm-size-test-runs.png" data-lightbox="test-runs">
![test-runs]({{site.baseurl}}/assets/images/posts/060-what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/060-best-azure-vm-size-test-runs.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Same pattern means consistency</i>
</p>

During this research the CPU performance is consistent between the different runs.

Citrix MCS will power off and destroy the VM after each run and will rebuild and power on the VM at a new run. In theory the VM could be started on different virtualization hosts with different type of CPUs in the Azure West Europe datacenter.

<a href="{{site.baseurl}}/assets/images/posts/060-what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/060-best-azure-vm-size-cpu-util.png" data-lightbox="cpu-util">
![cpu-util]({{site.baseurl}}/assets/images/posts/060-what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/060-best-azure-vm-size-cpu-util.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

When investigating the average CPU Utilization patterns between the different Azure SKUs, the same pattern is noticeable. The Dsv2-series virtual machine shows a slightly lower CPU usage allowing one more user on the box.

For good user experience enough memory is important from a sizing perspective.

<a href="{{site.baseurl}}/assets/images/posts/060-what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/060-best-azure-vm-size-memory-gb.png" data-lightbox="free-memory-gb">
![free-memory-gb]({{site.baseurl}}/assets/images/posts/060-what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/060-best-azure-vm-size-memory-gb.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The F4s_v2 VM is the only SKU which has a bottleneck on the memory resources. It is recommended to have 4 GB memory available for a multi-user operating system. The F4s_v2 VM has reached this threshold after hosting 4 users, which was as expected based on the calculations.

The cost model for Microsoft Azure in is in this case pay per use. Performance is an important factor, but it is also important to evaluate the associated cost that comes with the VM. It is possible to calculate the costs for a 1000 user scenario on Azure, since the amount of users per VM is known.

The total IaaS cost for a Citrix MCS VM, will consist of VM compute and storage costs. Since Citrix MSC is using an Identity Disk (P1), this should be added besides the operating system disk (P10) cost. The disks used in this calculation are based on Azure Managed Disk Premium SSD. Please note, the prices are collected form the Azure pricing list, for both [compute](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/linux/){:target="_blank"} and [storage](https://azure.microsoft.com/en-us/pricing/details/managed-disks/){:target="_blank"}. These prices can vary per region and over time.

<a href="{{site.baseurl}}/assets/images/posts/060-what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/060-best-azure-vm-size-cost-247.png" data-lightbox="cost-247">
![cost-247]({{site.baseurl}}/assets/images/posts/060-what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/060-best-azure-vm-size-cost-247.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Based on experience it estimated a VM in a virtualized environment is used for 300 hours per month. As user might start early in the morning and some working late, it is expected to have the VM running for 15 hours per working day as it is a multi-session operating system.

<a href="{{site.baseurl}}/assets/images/posts/060-what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/060-best-azure-vm-size-cost-300hrs.png" data-lightbox="cost-300hrs">
![cost-300hrs]({{site.baseurl}}/assets/images/posts/060-what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/060-best-azure-vm-size-cost-300hrs.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The total costs for the D4s_v3 and DS3_v2 are almost equal. The price savings for the B4ms VMs is minimal compared to the D-series. Using the F4s_v2 VM will significantly increase the total cost.


## Conclusion
The same rule of thumb calculation for on-premises SBC user sizing is applicable to the Azure based Windows 10 multi-session workloads. In the end Azure is just somebody elses data center.

The D-series VM’s (D4S_v3 and DS3_v2) are the best VMs for multi-session workloads based on the user density results. The combination of these SKUs are better compared to an F-series VM (F4s_v2). The cost saving of a B-series VM (B4ms) is minimal. Is this worth the risk of having bad user experience when all the CPU-credits are burned? Based on the results, the Dsv2-series VMs (DS3_v2) can host the most user sessions and has the lowest cost in a 1000 user scenario. This could be explainable since the Dsv2-series VMs are not leveraging hyperthreading technology. Our winner in this research is the DS3_v2.

The CPU load on the Azure platform is showing a consistent pattern between the different runs, indicating that the performance on Azure is consistent during this research. Keep in mind that the test runs where executed at the same day. Based on this research it is not clear if the performance remains consistent on long term.

Not all the burstable VM CPU credits where used during the test. The B4ms is showing the same CPU load patterns as the DS4_v3. The assumption is that the performance is comparable between both SKUs as long there are CPU-credits available.

<a href="{{site.baseurl}}/assets/images/posts/060-what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/060-best-azure-vm-size-b-series-credits.png" data-lightbox="credits-b-series">
![credits-b-series]({{site.baseurl}}/assets/images/posts/060-what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/060-best-azure-vm-size-b-series-credits.png)
</a>

### New SKUs available!!
In the meantime, there are some new SKUs available on the Microsoft Azure platform. Some new SKUs are also very interesting for Windows 10 multi-session workloads. These new SKUs where not available in our Azure subscriptions during this research. A validation for this SKUs is in the pipeline, when these SKUs are available for GO-EUC.

For now, if you are doing a proof of concept with Windows 10 multi-session, besides the listed SKUs in this research, you might consider to test the following Virtual Machine SKUs, if available in your region or subscription:

  * Dd v4-series (Intel Platinum 8272CL @ 2,5 GHz)
  * Das v4-series (AMD EPYC 7452 @ 2,35 GHz)
  * NV/NVv3-series (GPU: NVIDIA Tesla M60)
  * NVv4-series (GPU: AMD Radeon Instinct MI25)

Are you using Windows 10 multi session in production already? Leave your experience in the comments below or share them on the [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

<span>Photo by <a href="https://unsplash.com/@teapowered?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText" target="_blank">Patrick Robert Doyle</a> on <a href="https://unsplash.com/?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText" target="_blank">Unsplash</a></span>