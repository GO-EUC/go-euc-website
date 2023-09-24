---
layout: post
toc: true
title:  "Microsoft Azure Windows 10 Enterprise multi-session scalability"
hidden: false
authors: [ryan]
categories: [ 'microsoft', 'azure' ]
tags: [ '1909', 'azure', 'd2_v2', 'WVD', 'windows 10 multi-session' ]
image: assets/images/posts/054-azure-windows10-multi-session-scalability/054-azure-windows10-multi-session-feature-image.png
---
With the introduction of Windows Virtual Desktop (WVD) there is an increase in demand for the Windows 10 Enterprise multi-session edition. As the name states, this edition allows having multiple remote sessions on a single Windows 10 machine. This research will focus on the scalability of Windows 10 Enterprise multi-session on various Azure machines.

## Windows 10 Enterprise multi-session
Windows 10 Enterprise multi-session, formerly known as Windows 10 Enterprise for Virtual Desktops (EVD), is a new Remote Desktop Session Host that allows multiple concurrent interactive sessions, which previously only Windows Server could do. This capability gives users a familiar Windows 10 experience while IT can benefit from the cost advantages of multi-session and use existing per-user Windows licensing instead of RDS Client Access Licenses (CALs). For more information about licenses and pricing, see Windows Virtual Desktop pricing.

Windows 10 Enterprise multi-session, versions 1809 and later are supported and are available in the Azure gallery. These releases follow the same support life-cycle policy as Windows 10 Enterprise, which means the spring release is supported for 18 months and the fall release for 30 months.

Windows 10 Enterprise multi-session can’t run in on-premises production environments because it’s optimized for the Windows Virtual Desktop service for Azure. It’s against the licensing agreement to run Windows 10 Enterprise multi-session outside of Azure for production purposes. Windows 10 Enterprise multi-session won’t activate against on-premises Key Management Services (KMS).

Source: [https://docs.microsoft.com/en-us/azure/virtual-desktop/windows-10-multisession-faq](https://docs.microsoft.com/en-us/azure/virtual-desktop/windows-10-multisession-faq){:target="_blank"}

## Infrastructure and configuration
As Windows 10 Enterprise multi-session is only supported on Microsoft Azure, the setup and approach are a bit different compared to standard researches. The easiest way to test Windows 10 Enterprise multi-session running in Azure, is to create a hybrid-cloud configuration. This is realized using a site-to-site VPN which allows using both on-premises as cloud resources. Besides the Gateway VPN, a single Windows 10 Enterprise multi-session VM is hosted in Azure. All other required infrastructure components, like Active Directory, DNS and DHCP, Login VSI and file servers are hosted on-premises. The on-premises infrastructure is described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}.

Windows 10 Enterprise 1909 multi-session is used as the default operating system using the Azure Marketplace. All required Login VSI applications including, Microsoft Office 2016 x64 are installed using a post-OS installation task sequence in MDT.

The machine is running in a stateful scenario without any cleanup actions. This means all local profiles remain persistent in the VM. For this research, RDP is used as the standard remoting protocol.

When creating a Windows 10 virtual machine in Azure, the default size is D2_v2. Based on the default, we included the following scenarios in this research:

  * Standard D2_v2, as the baseline;
  * Standard D3_v2;
  * Standard D4_v2;
  * Standard D5_v2.

All specifications of the virtual machines can be found in the following table:


| Type          | vCPUs         | Memory | Throughput IOPs | Estimated Cost a month |
| ------------- |:-------------:| :-----:|:---------------:| :---------------------:|
| D2_v2         | 2             | 6      | 8x500           | €85.33                 |
| D3_v2         | 4             | 14     | 16x500          | €170.66                |
| D4_v2         | 8             | 28     | 32x500          | €341.31                |
| D5_v2         | 16            | 56     | 64x500          | €682                   |

Source: [https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-general](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-general){:target="_blank"}

Our testing methodology, as described [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}, applies to this research. Because of limited credits in Azure 4 test runs are configured. As the VM is a persistent machine, the first initial run is marked as a profile creation run. The profile creation run is not included in the data for this research.

> **Beware**, the used setup and configuration running a hybrid-cloud scenario is not supported by the product Login VSI and might violate your license agreement. In order to research these kind of configurations it is recommended to consult [Login VSI](https://www.loginvsi.com/contact){:target="_blank"}.

## Expectations and results

It is expected when increasing the resources of a VM, the user density increases as well. The estimated cost per month could make a big difference, so this will be interesting to take a look at.

The metric to measure the scalability of a system is the Login VSI VSImax.

<a href="{{site.baseurl}}/assets/images/posts/054-azure-windows10-multi-session-scalability/054-azure-windows10-multi-session-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/054-azure-windows10-multi-session-scalability/054-azure-windows10-multi-session-vsimax.png)
</a>

Please note, the Login VSI VSImax results are published in absolute numbers instead of percentages as the session launched various per VM size. The results are as expected when the VM size with the resources increases this is reflected in the scalability.

Another interesting metric is the Login VSI baseline, which provides an indication of the responsiveness of the session.

<a href="{{site.baseurl}}/assets/images/posts/054-azure-windows10-multi-session-scalability/054-azure-windows10-multi-session-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/054-azure-windows10-multi-session-scalability/054-azure-windows10-multi-session-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>


Results are similar to the Login VSI VSImax, when the resources increase the response times are improving. This makes sense, the Login VSI baseline is based on the 15 lowest response samples, which are collected from the first couple of sessions that are using the system. At the start of the test, the system is not saturated and therefore there are more than enough resources available for the users, resulting in better response times.

It is interesting to see that D4_v2 has the best response times. This could indicate a sweet spot for the Login VSI baseline calculations.

Besides the Login VSI baseline, the frames per second (FPS) is another metric that provides an indication about the user experience.

<a href="{{site.baseurl}}/assets/images/posts/054-azure-windows10-multi-session-scalability/054-azure-windows10-multi-session-session-fps.png" data-lightbox="fps">
![fps]({{site.baseurl}}/assets/images/posts/054-azure-windows10-multi-session-scalability/054-azure-windows10-multi-session-session-fps.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/054-azure-windows10-multi-session-scalability/054-azure-windows10-multi-session-session-fps-compare.png" data-lightbox="fps-compare">
![fps-compare]({{site.baseurl}}/assets/images/posts/054-azure-windows10-multi-session-scalability/054-azure-windows10-multi-session-session-fps-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>
Both D4_v2 and D5_v2 have the highest frame rate during the workload. In reference to the Login VSI baseline results, the D4_v2 has the best “user experience” with the configured workload.

Based on the Login VSI VSImax results it possible to create a calculation for a use case. In order to provide 1000 users a desktop, how many VMs are required?

<a href="{{site.baseurl}}/assets/images/posts/054-azure-windows10-multi-session-scalability/054-azure-windows10-multi-session-vms.png" data-lightbox="sizing">
![sizing]({{site.baseurl}}/assets/images/posts/054-azure-windows10-multi-session-scalability/054-azure-windows10-multi-session-vms.png)
</a>

Most cloud-based services like Azure and AWS have a pay-per-use model. Within this model, the running costs consist of primarily compute costs. Therefore, it is important to follow the scale up, and scale out principle. Based on the Login VSI VSImax we know using a D5_v2 has more capacity and therefore can host more users. Using this size of VM does make it harder to deallocated as it is harder to drain the VM of users.

Based on the estimated cost a month and the amount of VMs required to host 1000 users, it is possible to get an estimate compute cost as well.

<a href="{{site.baseurl}}/assets/images/posts/054-azure-windows10-multi-session-scalability/054-azure-windows10-multi-session-cost.png" data-lightbox="cost">
![cost]({{site.baseurl}}/assets/images/posts/054-azure-windows10-multi-session-scalability/054-azure-windows10-multi-session-cost.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/054-azure-windows10-multi-session-scalability/054-azure-windows10-multi-session-cost-compare.png" data-lightbox="cost compare">
![cost compare]({{site.baseurl}}/assets/images/posts/054-azure-windows10-multi-session-scalability/054-azure-windows10-multi-session-cost-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>
It is interesting to see, bigger is not always better. In our context, D4_v2 is the most efficient size based on a cost perspective. Converting the results into a percentage shows that the differences between selecting a D4_v2 and D5_v2 have a 30% cost increase difference. This shows how important it is to validate the VM sizes in Azure, as it could save serious money.

## Final thought
With the rise of Windows Virtual Desktop (WVD) in Azure, the cloud is becoming very popular in many organizations. In our opinion, this is mainly because of the introduction of Windows 10 Enterprise multi-session, which allows you to run multiple users on a single Windows 10 instance. This provides the same benefits as a traditional terminal server or remote desktop server host (RDSH), but keeps the compatibility, supportability and the look and feel of Windows 10.

This research has shown it is important to understand the workload when moving to the cloud. Running resources in the cloud will be charged, so it is key to find the right balance between scaling up and scaling out.

Size does matter and selecting the correct VM size for your workload can save you serious money each month. Based on the workload used in this research, the D4_v2 seems like the sweet spot in terms of scalability and estimated cost in our situation.

Please note, the estimated compute cost is only for running the VMs. There will be additional costs for other services that are used in Azure. Another way to reduce the cost is to leverage auto-scaling technology that will shut down and decommission unused resources.

There is some doubt within the community regarding the reliability of the performance of Azure, as it is not always consistent. This is not noticed, nor proven during this research, but it may be interesting to validate this in an upcoming research. What do you think? Please, let us know in the comments below.

Want to share more about your experience with scalability and performance on Azure, join the Slack channel right [here](https://worldofeuc.slack.com){:target="_blank"} and start the interaction!

Photo by [Lucas Clara](https://unsplash.com/@lux17?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/cloud-scale?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
