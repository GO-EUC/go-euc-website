---
layout: post
toc: true
title:  "Using Citrix Cloud from a performance perspective"
hidden: false
authors: [eltjo, ryan]
categories: [ 'citrix' ]
tags: [ 'citrix', 'cloud' ]
image: assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-feature-image.png
---
It is almost two years that Citrix is offering their Cloud solution and they are really pushing the envelope. While the adoption is still a bit sparse, there are some customer that are already migrated but there are many organizations that are still postponing the migration. There are various reason to or not to migrate to Citrix Cloud, but this research will focus on the performance impact using Citrix Cloud.

## Citrix Cloud
When you onboard onto Citrix Cloud and sign in for the first time, you have the option to choose a region. At the time of writing three regions are available:

  * United States
  * European Union
  * Asia Pacific

<a href="{{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-region-select-v2.png" data-lightbox="region">
![region]({{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-region-select-v2.png)
</a>

While all Citrix Cloud services are globally available, be aware that not all services have a dedicated presence in each region and are US based only.

For more information check out the geographical considerations when choosing a region: [https://docs.citrix.com/en-us/citrix-cloud/overview/signing-up-for-citrix-cloud/geographical-considerations.html](https://docs.citrix.com/en-us/citrix-cloud/overview/signing-up-for-citrix-cloud/geographical-considerations.html){:target="_blank"}

Since we are located in the EU, we suspected the brokering from the Citrix Cloud US location would have a significant impact on the brokering times, and in the result on the time to desktop. But Citrix claims there is only a minimal impact:

> Are there performance impacts if I’m in one region and use a service in another region?
>
> Citrix Cloud Services are designed to be used on a global basis. For example, customers in the US that have users and Cloud Connectors in Australia will see minimal impact from latency

## Configuration and infrastructure
The goal of this research is to validate the most common Citrix Cloud scenario’s we have seen at customers. This will be a minimal Citrix Cloud implementation for Citrix Virtual Apps and Desktops Service. The Citrix Delivery Controllers will be used from Citrix Cloud but the StoreFront services will be running on-premises. This way the brokering will be done through Citrix Cloud. The NetScaler services are out of scope for this specific research as the launchers are in the same datacenter. This also allows us to fully focus on the brokering times by Citrix Cloud.

This research took place in our lab which is described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. In order to connect with Citrix Cloud, a so called Cloud Connector is required. Two separate machines were created on the infrastructure host with the Cloud Connector roles installed and a dedicated Resource location was created in Citrix Cloud. The Cloud Connectors have been installed and configured with the Citrix recommended settings:

[https://docs.citrix.com/en-us/citrix-cloud/citrix-cloud-resource-locations/citrix-cloud-connector/installation.html](https://docs.citrix.com/en-us/citrix-cloud/citrix-cloud-resource-locations/citrix-cloud-connector/installation.html){:target="_blank"}

As the initial Cloud instance was created in the US, this allowed us to incorporate this as an additional scenario. The specified scenarios are as followed:

  * Full on-premises as the baseline;
  * Citrix Cloud located in the US;
  * 0Citrix Cloud located in the EU.

Tests are running in a stateless VDI scenario using Windows 10 1809 configured with 2vCPU and 4GB memory. It is important to understand VDI’s are running on a dedicated host in the GO-EUC lab, not in Citrix Cloud itself.

The default testing methodology is used which is described in full detail [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Unexpected encountering
All tests are fully automated and because of Citrix Cloud, it required some additional modification in the scripts. It took a while as some functions like Get-DesktopMachine are not working from the central management server. All the details regarding the issues with Citrix Cloud Remote PowerShell SDK are described at Ryan’s personal blog which you can read [here](https://www.logitblog.com/inconsistencies-with-citrix-cloud-remote-powershell-sdk){:target="_blank"}.

As a Cloud offering, Citrix Cloud is an evergreen solution. Functionality will be added to Citrix Cloud first and will be added to the Virtual Apps and Desktop solution afterward. This means that Citrix Cloud is continuously updated.

Citrix also fully manages the Cloud Connectors. In a production environment with more than one Cloud Connector this will not impact the environment, but as the updates are managed by Citrix it may cause the automation scripts to break as changes are made. It is important to take this into account when creating automation for Citrix Cloud.

## Results
In the specified configuration it is not expected there is a huge difference in capacity perspective as the measurements are done within the desktop. The difference should be noticeable in logon times as the brokering is done by Citrix Cloud via the Cloud Connectors to the Delivery Controllers in Citrix Cloud.

Login VSI is our default tool to generate the load on the environment. A key metric produced by Login VSI is the VSImax which reflects the maximum capacity of the environment.

<a href="{{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

There is a small difference between the scenarios with a slight increase in the VSImax when using Citrix Cloud EU.

To get a full overview of the performance impact not only the VSImax is important, but also the other hosts metrics that are collected need to be taken in to account.


<a href="{{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-host-cpu.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-host-cpu-compare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There is no difference in the host CPU utilization.

<a href="{{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-host-reads-compare.png" data-lightbox="reads-compare">
![reads-compare]({{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-host-reads-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-host-writes-compare.png" data-lightbox="writes-compare">
![writes-compare]({{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-host-writes-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There is a small difference from a storage perspective. It shows at the beginning of the test there is a slightly higher bump in both Citrix Cloud scenarios compared to on-premises scenario. Please note that in the latest iteration of the Cloud Connectors the Local Host Cache is enabled by default and in our environment, we always disable the LHC because the environment will always be available when running tests. This might explain the minor increase in commands per second.

As mentioned in the introduction there will be an expected impact on the user logon as the brokering will be done by Citrix Cloud.

<a href="{{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-logon-times.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-logon-times.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-logon-times-compare.png" data-lightbox="writes-compare">
![writes-compare]({{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-logon-times-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There is an apparent impact on the user logon times. It is expected the Citrix Cloud US scenario takes a bit longer as the distance to the datacenter is way further from our own datacenter.

With the average latency to Azure measured from [http://www.azurespeed.com/](http://www.azurespeed.com){:target="_blank"} being around 150 ms to 200 ms to the West US and West Central US regions and the average latency to the West Europe latency averaging around 30 ms some delay might be inevitable and the 12 and 16 percent increase in logon times are understandable.

When we shift focus to the launchers, it will become obvious that from the client perspective there is no performance penalty in choosing Citrix Cloud over an on-premises environment.

<a href="{{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-launcher-cpu.png" data-lightbox="launcher-cpu">
![launcher-cpu]({{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-launcher-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

For the network data transferred from the launcher to the VDI, it makes no difference if the connections are brokered via the Cloud Connectors to the Delivery Controllers at Citrix Cloud, or directly via the local on-premises Delivery Controllers.

<a href="{{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-launcher-nic.png" data-lightbox="launcher-nic">
![launcher-nic]({{site.baseurl}}/assets/images/posts/013-using-citrix-cloud-from-a-performance-perspective/013-citrix-cloud-launcher-nic.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Connections from the launchers are local due to the fact that the VDI’s are also in the same datacenter and therefore are in very close proximity to the launchers. When using external launchers (or clients) in that are not local to the datacenter where the VDI’s are hosted in contrast, all connections and data between the client and the VDI will flow from the client to Citrix Cloud (Netscaler-Storefront) and then to the VDI’s in the datacenter through the Cloud Connectors. In that use case, the logon time penalty will most likely be much more significantly higher.

Conclusion
Using Citrix Cloud comes with pros and cons. During this research, we experienced some unexpected behavior using the Citrix Cloud remote PowerShell SDK. More information can be found on [Logit Blog](https://www.logitblog.com/inconsistencies-with-citrix-cloud-remote-powershell-sdk){:target="_blank"}.

As expected, when moving the Delivery Controller in the Cloud will impact the logon times. There is no real capacity impact as the VDI component are still on-premises the XML communication is done via the Cloud Connectors.

Because Citrix Cloud is a PaaS offering there is less overhead on the infrastructure because most of the backend services will be handled to Citrix Cloud and do not require local servers to host them. This advantage will be even more apparent when using the Storefront and NetScaler services of Citrix.

We expected the US Citrix Cloud offering to have a higher latency impact. With the US only having a slightly higher logon times compared to the EU.

We advise customers to always choose a region closest to their own location.

From an administrative perspective using the web interface to communicate with the Citrix Studio instance for Citrix Virtual Apps and Desktops requires a lot of patience as it is often very slow. This shows Citrix have chosen a shortcut in the Cloud offering by creating Studio in an HTML5 Citrix connection instead of a native HTML 5 interface.

If you want to contribute or voice your opinion about this research or out other researches a great place to start is to join the Slack community right [here](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Jason Wong](https://unsplash.com/photos/o_SMqtT8bpU?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/cloud?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
