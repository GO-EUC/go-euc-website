---
layout: post
toc: true
title:  "What Azure storage solution to use for your FSlogix profiles"
hidden: false
authors: [ryan, tom, eltjo]
categories: [ 'FSLogix' ]
tags: [ 'Citrix', 'Azure', 'Storage', 'NetApp']
image: assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-feature-image.png
---
Since the acquisition of FSLogix, Microsoft has decided to include FSLogix in the majority of the Office365 offerings. This move resulted in a great adoption of FSLogix as it is for almost everybody available. One of the design recommendations is to ensure the profiles are stored as close as possible. When moving to Azure cloud, it is therefore recommended to use Azure storage services, but which one should you choose? This research will compare various Azure storage configurations to store the FSLogix profiles.

> Disclaimer: This research intends to validate the performance difference between the various storage solutions and is not aimed as a scalability research into the saturation point of the tested solutions.

## FSLogix
FSLogix is a profile container solution, designed to roam user profiles and settings between different devices and/or sessions. The FSLogix Profile Container is a more advanced solution, compared to the classic Microsoft roaming profile. A functional difference between the two is that a Profile Container persists all Windows settings and applications, regardless of where they are stored in the user profile by mounting a virtual disk to the user's session at session startup and redirecting the user profile to this virtual disk.
Eligibility for using the FLogix profile container is included in most Office365 offerings including:

  * Microsoft 365 E3/E5
  * Microsoft 365 F1/F3
  * Microsoft 365 Business
  * Windows 10 Enterprise E3/E5 and Windows 10 Education A3/A5
  * Windows 10 VDA per user
  * Remote Desktop Services (RDS) Client Access License (CAL) and Subscriber Access License (SAL)

FSLogix solutions may be used in any public or private data center, as long as a user is properly licensed.

## Available storage solutions
There are several different storage options available for the profile containers in Windows Virtual Desktop and Citrix Cloud environments on the Microsoft Azure platform service.

The two native Azure solutions comprise Azure Files and the new Azure NetApp Files offering from NetApp. If a self-managed solution is preferred, a Windows Fileserver option with Storage Spaces Direct can be considered. The latter option is out of scope for this particular research, however.

More in-depth information on the different available storage solutions for FSlogix with Azure, see the official FSlogix documentation: [Storage FSLogix profile container Windows Virtual Desktop - Azure - Microsoft Docs](https://docs.microsoft.com/en-us/azure/virtual-desktop/store-fslogix-profile){:target="_blank}.

## Azure Files
Microsoft Azure Files service is a fully managed file share in the cloud that is accessible via the Server Message Block (SMB) or Network File System (NFS) protocol. Azure file shares can be mounted concurrently by cloud and on-premises deployments.

Azure Files shares are deployed into storage accounts, which are top-level objects that represent a shared pool of storage within an Azure subscription. The Azure Files offering comes in two performance tiers, Standard and Premium.

|   | Azure Files Standard | Azure Files Premium |
|:--| :------------------- | :------------------ |
| Minimum file share size | No minimum | 100GB |
| Maximum file share size | 100 TB (with large file share feature enabled) | 100 TB (with large file share feature enabled) |
| Maximum request rate (Max IOPS) | 1000 or 100 requests per 100 ms, default | Baseline IOPS: 400 + 1 x provisioned GB * IOPS bursting: Max (4000, 3 x Baseline IOPS) * |
| Maximum ingress bandwidth | Up to 60 MiB/sec | 40 MB/s + 0.04 x provisioned GB |
| Maximum egress bandwidth | Up to 60 MiB/sec | 60 MB/s + 0.06 x provisioned GB |

*Up to a max of 100,000 IOPS

More information on the performance tiers: [Azure Files scalability and performance targets - Microsoft Docs](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-scale-targets){:target="_blank"}.

At the time of writing, Azure Files shares are available in all current Azure regions.

## Azure Netapp Files
Azure NetApp Files (ANF) is a highly available and enormously scalable platform for creating cloud-based file-share environments by NetApp. ANF is sold and supported by Microsoft and is not a 3rd party marketplace offering.

ANF is divided into capacity pools that can consist of one or more volumes as schematically depicted below:

<a href="{{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-netapp-files-storage-hierarchy.png" data-lightbox="azure-netapp-files-storage-hierarchy">
![azure-netapp-files-storage-hierarchy]({{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-netapp-files-storage-hierarchy.png)
</a>

The maximum throughput levels for ANF are determined by the Service levels. Service levels are an attribute of a capacity pool. Service levels are defined and differentiated by the allowed maximum throughput for a volume in the capacity pool based on the quota that is assigned to the volume.

ANF comes in three service levels: Standard, Premium, and Ultra. In fact, all 3 service levels are hosted on the same hardware, and the chosen tier will have pros and cons. As an example given, the following calculation was based on the requirement to host 1TiB on ANF:

<a href="{{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-netapp-calc-volume-1.png" data-lightbox="netapp-calc-volume-1">
![netapp-calc-volume-1]({{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-netapp-calc-volume-1.png)
</a>

As shown in the picture above, all 3 tiers will have different pricing and throughputs. In addition, the amount of bandwidth needed is also adjustable. In the example below a minimum bandwidth of 200MiB/s was selected.

<a href="{{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-netapp-calc-volume-1-throughput-200.png" data-lightbox="069-netapp-calc-volume-1-throughput-200">
![069-netapp-calc-volume-1-throughput-200]({{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-netapp-calc-volume-1-throughput-200.png)
</a>

In this case, Premium is the most viable option, as it has the lowest cost overhead. The performance between the tiers is identical expect on for throughput, as this is limited per tier. The maximum of bandwidth for Premium and Ultra is 4500MiB/s and Standard, according to the calculator 1600MiB/s.

For more specific details, consult the Azure Netapp Files documentation: [Performance considerations for Azure NetApp Files - Microsoft Docs](https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-performance-considerations){:target="_blank"}

Source: [TCO ANF - NetApp](https://cloud.netapp.com/azure-netapp-files/tco){:target="_blank"}.

The service level of an existing volume can be changed dynamically by moving the volume to another capacity pool that uses the service level required for the volume. This in-place service-level change for the volume does not require data to be migrated and does not impact access to the volume.

ANF might not be available in all Azure regions yet, please consult: [Azure products by region - Microsoft Azure for more information on availability.](https://azure.microsoft.com/en-ca/global-infrastructure/services/?products=netapp){:target="_blank"}

Apart from regional availability, Microsoft requires that you have been granted access to the Azure NetApp Files service. To request access to the service, see Submit a waitlist request for accessing the service: [Submit a waitlist request for accessing the service -  Microsoft Docs](https://docs.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-register#waitlist){:target="_blank"}

More information on Azure NetApp files: [Azure File Storage Service For Enterprise Workloads - NetApp](https://cloud.netapp.com/azure-netapp-files){:target="_blank"}.

## Setup and configuration
This research has taken place in the GO-EUC lab environment in combination with Microsoft Azure. Using a site-to-site VPN the on-premises resources are made available to the Azure subscription, where multiple roles are leveraged as Active Directory and the LoadGen infrastructure. Desktops are delivered with Citrix Cloud, using a Windows 10 build 20H2 multi-session VDA which is optimized using the recommended template of the Citrix Optimizer.

A single Cloud Connector was deployed in the Azure subscription as a one Cloud Connector is sufficient for handling the number of sessions launched during the runs in the research: [Scale and size considerations for Cloud Connectors - Citrix](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops-service/install-configure/resource-location/cc-scale-and-size.html){:target="_blank"}

An on-premises LoadGen configuration is used which means the user sessions are simulated using the existing GO-EUC lab infrastructure as described [here](https://www.go-euc.com/architecture-and-hardware-setup-overview-2020/){:target="_blank"}.

In addition to the normal application set used in other research, we’ve added the FSlogix agent version 2009 (2.9.7621.30127) with the following configuration:

| Policy | Value |
| :----- | :---- |
| Delete local profile when FSLogix Profile should apply | Enabled |
| Enabled | Enabled |
| Set Outlook cached mode on successful container attach | Enabled |
| VHD location | UNC path depending on the sceanrio |
| Virtual disk type	| VHDX |


In total 100 users are simulated on 20 AVD machines based on the DS3v2 SKU. To avoid hitting the maximizing the CPU utilization only 5 users are active on a single AVD machine. This is based on our previous research: [What is the best Azure Virtual Machine size for WVD using Citrix Cloud? - GO-EUC](https://www.go-euc.com/what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/){:target="_blank"}.

Performance data from each individual AVD machine is collected during the research.

The following scenarios are included in this research:
  * Azure Files Standard
  * Azure Files Premium
  * Azure NetApp File Premium

As the NetApp offerings are bandwidth limited it has been decided to test a single NetApp offering as all storage levels are delivered using the same physical hardware. In theory, this means there are no performance differences between the offerings depending on the configured size. GO-EUC worked in close collaboration with NetApp on the configuration. For more information on available configurations, please consult the [NetApp sizing calculator](https://anftechteam.github.io/calc/){:target="_blank"}.

Because all Azure storage solutions have dynamic bandwidth limitations the following sizes are used in this research:

### Azure Files Standard
By default Azure Files Standard is by default limited to 60 MiB/sec for both ingress and egress, which can not be adjusted by increasing the volume size. For this scenario, a volume of 1 TiB is used. For this scenario, the large File share feature was left at the default value of 'disabled'.
Source: [Azure Files scalability and performance targets - Microsoft Docs](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-scale-targets){:target="_blank"}

### Azure Files Premium
Based on the ingress the default 40 MiB/sec + 0.04 * provisioned GB. A volume size of 3.2 TB is configured resulting in a 168 MiB/sec ingress and 252 MiB/sec egress. The maximum throughput for this scenario will be the lowest number, which is 168 MiB/sec.
Source: [Azure Files scalability and performance targets - Microsoft Docs](https://docs.microsoft.com/en-us/azure/storage/files/storage-files-scale-targets){:target="_blank"}

Azure Files Premium Multichannel SMB was not available in West-Europe, so in our testing, this was not active.
### Azure NetApp Files Premium
The Azure NetApp File was configured using the medium size capacity pool of 4TiB with a volume of 3.2TiB, resulting in a theoretical throughput of 200 MiB/sec. Like mentioned before, all NetApp tiers are provided on the same hardware, which should in theory result in the same performance.

Azure NetApp files support multi channel and SMB Multichannel is enabled by default for ANF volumes.

The default testing methodology was used for this research which is described [here](https://www.go-euc.com/insight-in-the-testing-methodology-2020/){:target="_blank"}. Because as part of the initial run the FSLogix profile was created, the data for the initial run been excluded from all scenarios.

## Expectation and results
Based on previous research, [The impact of managing user profiles with FSLogix - GO-EUC](https://www.go-euc.com/the-impact-of-managing-user-profiles-with-fslogix/){:target="_blank"}, and initial estimation both Azure Files Premium and Azure NetApp Files should have enough throughput to facilitate the 100 FSLogix profiles. It is expected to see a higher disk queue length when using Azure Files Standard considering the throughput limitation of 60 MiB/sec. This might result in higher logon times for the Azure Files Standard compared to the other scenarios.

The GO-EUC workload is CPU heavy, which in previous researches often resulted in a CPU bottleneck. As mentioned in the setup and configurations section, hitting this bottleneck needs to be prevented as this can influence and skew the results. This can be confirmed by analyzing the CPU utilization of each individual machine.

<a href="{{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-cpu-wvds.png" data-lightbox="host-cpu-wvds">
![host-cpu-wvds]({{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-cpu-wvds.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Please note, this is the average CPU utilization of the selected runs as per the default testing methodology. This does show no CPU bottleneck has been reached for these scenarios. To make this comparison between all scenarios, an average has been taken of all the available machines.

<a href="{{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-cpu-util.png" data-lightbox="host-cpu">
![host-cpu]({{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-cpu-util.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>


<a href="{{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-cpu-util-compare.png" data-lightbox="host-cpu-compare">
![host-cpu-compare]({{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-cpu-util-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There is a minute difference between the scenarios that might be caused by the logical disk queueing, which will be covered later.

The focus of this research is to evaluate the performance of the tested storage solution measured from the VM perspective. The logical disk metrics that are available in perfmon will include all FSLogix profiles located on the Azure storage solution. It is expected to see a similar pattern in both read and write activity.

<a href="{{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-reads.png" data-lightbox="disk-reads">
![disk-reads]({{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-writes.png" data-lightbox="disk-writes">
![disk-writes]({{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-disk-compare.png" data-lightbox="disk-compare">
![disk-compare]({{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-disk-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As expected is the overall pattern similar. The difference is clearly caused by the peaks but will not be noticeable from an end-user perspective.

To confirm the throughput and latency the metric Logical Disk Queue Length should show a noticeable difference.

<a href="{{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-disk-queue.png" data-lightbox="disk-queue">
![disk-queue]({{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-disk-queue.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-disk-queue-compare.png" data-lightbox="disk-queue-compare">
![disk-queue-compare]({{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-disk-queue-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There are multiple factors that can influence the Logical Disk queue length. First, the amount of IOPs the underlying storage solution can handle. Secondly, this is caused by the bandwidth limitation, which will result in queueing.

The data from the logon times are an important metric, as this is normally the first interaction that an end-user will have with the environment. In a multi-user OS, it is recommended to compare the initial logon times of the first percentage of users to showcase the cleanest comparison between the storage solutions tested.

<a href="{{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-logon.png" data-lightbox="logon">
![logon]({{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-logon.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-logon-compare.png" data-lightbox="logon-compare">
![logon-compare]({{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-logon-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Both Azure Premium storage as ANF shows a 10 to 11 percent decrease in logon times. These results are not affected by any possible bandwidth limitations of the underlying storage system.

<a href="{{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-cost.png" data-lightbox="cost">
![cost]({{site.baseurl}}/assets/images/posts/069-what-azure-storage-solution-to-use-for-your-fslogix-profiles/069-azure-storage-fslogix-cost.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

From a cost perspective, Azure Storage standard is the most cost efficient solution but does come with a performance penalty. While ANF is the better performing solution of Azure Premium, when sizing a storage solution it is important to take the bandwidth limitation into account, as this will have an effect on the cost. In this case, the ANF costs are significantly higher than Microsoft's solutions.

## Conclusion
With the transition to the cloud, it is becoming a common practice to implement Fslogix as the default profile solution. There is a variety of storage solutions available in Microsoft Azure and depending on the requirements and workload. The following conclusion is based on FSLogix in an Azure AVD context and does not take any other storage workloads into account. As described in the setup and configuration, this is done using the GO-EUC workload with a total of 100 simulated users distributed over 20 AVD machines.

A conclusion can be formed from multiple perspectives. Based on the best performance, Azure NetApp Files is the best option, with Azure Files Premium in close second place. When the data is extrapolated to larger scale environments, it is exceedingly likely NetApp will outperform Azure Files premium. Now, this is a theoretical execution and may vary due to other decencies or limitations. This is primarily based on the disk queue length as this is the most reliable metric to measure the performance of the storage system from a user perspective.

Based on this research taking both cost and performance into consideration, it is not recommended to use Azure File Standard for storing the FSLogix profiles in an AVD context on this size or larger.
To summarize, size does matter and it is therefore very important to take the required bandwidth into account when selecting the appropriate storage solution for the FSLogix profiles. When the bandwidth limit is reached it will have a tremendous impact on the overall performance and user experience.

Photo by [Vincent Botta](https://unsplash.com/@0asa?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/storage?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
