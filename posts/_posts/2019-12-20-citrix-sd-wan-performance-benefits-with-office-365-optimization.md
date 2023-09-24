---
layout: post
toc: true
title:  "Citrix SD-WAN performance benefits with Office 365 optimization"
hidden: false
authors: [bas, ruud]
categories: [ 'citrix', 'microsoft', 'office' ]
tags: [ 'citrix', 'office 365', 'SD-WAN', 'microsoft'  ]
image: assets/images/posts/041-citrix-sd-wan-performance-benefits-with-office-365-optimization/041-citrix-sd-wan-feature-image.png
---
With the rise of cloud, new challenges arise to maintain and improve user experience. Citrix SD-WAN promises great improvement of user experience compared to using the traditional WAN and networking infrastructure. In this research the impact of Citrix SD-WAN will be compared to traditional networking.

## What is Citrix SD-WAN?

Before the wide use of cloud and SaaS services, networks were built with the idea that all data is in one central location. Networks between different sites and locations were built to transport data from a location to the central point in the datacenter and would then be routed to the destination.

With the adoption of Cloud and SaaS services this model starts to squeak. This is because Cloud and SaaS are built with the idea that resources are accessible from the internet and not via indirect paths.
Using indirect paths for Cloud and SaaS services causes bandwidth congestion and longer Round Trip Time, degrading the overall user experience.

A Software-defined wide area network (SD-WAN) is defined as a virtual WAN architecture, in which the control of network connections, application flows, policies, security mechanisms and general administration is separated from the underlying hardware. Everything is managed in software on centralized consoles instead of at the physical locations of individual edge devices and infrastructures. A SD-WAN connects end users to virtually any application hosted on any location (cloud, on premises) via the best available or most feasible transport service. That could be an MPLS, broadband, cellular or even a satellite link. SD-WAN combines all available transports services and combines it in a so called ‘virtual-path’.

SD-WAN is a powerful solution for organizations with multiple sites or a hybrid datacenter (aren’t we all hybrid?). An example of a hybrid solution is Microsoft Office 365 that benefits greatly from a local breakout. WAN is crucial for the modern workplace.

## What do we investigate?
The research is done on the Citrix SD-WAN research environment which is described [here]({{site.url}}/sd-wan-network-architecture-setup-2019){:target="_blank"}. This research focuses on the performance differences between backhauling Microsoft Office 365 OneDrive (SharePoint) traffic through the datacenter over Citrix SD-WAN (note: this is an already, partially optimized virtual path – UDP) and using the Office365 optimization feature in Citrix SD-WAN. This feature will enable Citrix SD-WAN to recognize, prioritize and directly breakout this traffic to the internet and subsequently to the nearest Microsoft Office365 front door.

The research scenarios are as following:

  * Backhaul traffic through the datacenter
  * Local breakout for Office365 traffic

The scenarios have been done on the following Azure tenants:

  * West Europe
  * Canada East
  * Southeast Asia

The results that are used in this research are download time and Round Trip Time (RTT).

The download time is how long a user has to wait before all data is transferred.

The RTT is the time between a user initiating a network request and receiving the response. RTT is measured in milliseconds (mss) and is also referred to as the latency. A high RTT has a significant impact on the user experience as it will let the application or website feel “laggy” or unresponsive.

Especially with cloud hosted services the aim is to reduce the RTT as much as possible for the best user experience.

To establish the baseline, data is first transferred through the backhaul scenario. The data collected by using the local breakout is then compared to the baseline.

## Expectation and Results
It is expected that, when Office 365 optimization is enabled, there is a decrease in round trip time (RTT) of a half and a slight decrease of download time. This because the geographical distance between MCN and branch is around 140 km / 87 miles.

The distance between both sites and the Microsoft Office 365 Point of Presence (POP) is also around 140 km / 87 miles. This means that the path that the traffic will take is shortened by 140 km/ 87 miles when using the local breakout to the internet.

### Microsoft OneDrive West Europe

<a href="{{site.baseurl}}/assets/images/posts/041-citrix-sd-wan-performance-benefits-with-office-365-optimization/041-citrix-sd-wan-west-europe-download.png" data-lightbox="europe-download">
![europe-download]({{site.baseurl}}/assets/images/posts/041-citrix-sd-wan-performance-benefits-with-office-365-optimization/041-citrix-sd-wan-west-europe-download.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>
As expected, there is a decrease in download time when enabling Office 365 optimization on Citrix SD-WAN. When looking at the different file sizes there is only a difference between the 1 KB and 1 MB files compared to larger file sizes. That is because the time difference for 1 KB and 1 MB is 0.1 seconds or less whereas with the 1 GB files it is over a minute.

For the two smaller files sizes the difference between backhauling traffic through a datacenter is smaller than expected. The reason for this is that every file is downloaded in a single session and in a single packet. After each download of the file, the client will create a new session to download the next file. It may be interesting to further investigate if “path” selection impacts the smaller downloads.

For file sizes larger than 1MB we see a decrease of around 15% when Citrix SD-WAN Office 365 optimization is enabled.
<a href="{{site.baseurl}}/assets/images/posts/041-citrix-sd-wan-performance-benefits-with-office-365-optimization/041-citrix-sd-wan-west-europe-rtt.png" data-lightbox="europe-rtt">
![europe-rtt]({{site.baseurl}}/assets/images/posts/041-citrix-sd-wan-performance-benefits-with-office-365-optimization/041-citrix-sd-wan-west-europe-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>
The RTT is significantly lower when using Citrix SD-WAN Office365 optimization. The improvement is higher than expected. This decrease in RTT is noticeable for end users, the interaction with files feels interactive instead of laggy.

### Microsoft OneDrive Canada East
<a href="{{site.baseurl}}/assets/images/posts/041-citrix-sd-wan-performance-benefits-with-office-365-optimization/041-citrix-sd-wan-canada-east-download.png" data-lightbox="canada-download">
![canada-download]({{site.baseurl}}/assets/images/posts/041-citrix-sd-wan-performance-benefits-with-office-365-optimization/041-citrix-sd-wan-canada-east-download.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>
The Canada East tenant shows the same pattern as the West Europe tenant for downloading the data. The only small deviation is within the 1 KB and 1 MB files that score slightly better compared to the West Europe tenant. Within the data collected there is no obvious reason for this.

Comparing the overall download time with the West Europe tenant, the Canada East tenant is slightly slower.
<a href="{{site.baseurl}}/assets/images/posts/041-citrix-sd-wan-performance-benefits-with-office-365-optimization/041-citrix-sd-wan-canada-east-rtt.png" data-lightbox="canada-rtt">
![canada-rtt]({{site.baseurl}}/assets/images/posts/041-citrix-sd-wan-performance-benefits-with-office-365-optimization/041-citrix-sd-wan-canada-east-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>
The RTT improvement and thus user experience improvement is equal to that of the West Europe tenant.

### Microsoft OneDrive Southeast Asia
<a href="{{site.baseurl}}/assets/images/posts/041-citrix-sd-wan-performance-benefits-with-office-365-optimization/041-citrix-sd-wan-sourtheast-asia-download.png" data-lightbox="asia-download">
![asia-download]({{site.baseurl}}/assets/images/posts/041-citrix-sd-wan-performance-benefits-with-office-365-optimization/041-citrix-sd-wan-sourtheast-asia-download.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>
The Southeast Asia tenant shows the same pattern and results as the West Europe and Canada East tenant for download time.

The only thing standing out is the drop of the 1 KB. There is no explanation within the data set collected.

Comparing the overall download time with the Western Europe tenant and the Canada East tenant, the Southeast Asia tenant is slightly slower.
<a href="{{site.baseurl}}/assets/images/posts/041-citrix-sd-wan-performance-benefits-with-office-365-optimization/041-citrix-sd-wan-sourtheast-asia-rtt.png" data-lightbox="asia-rtt">
![asia-rtt]({{site.baseurl}}/assets/images/posts/041-citrix-sd-wan-performance-benefits-with-office-365-optimization/041-citrix-sd-wan-sourtheast-asia-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>
The RTT improvement and thus user experience improvement is equal to that of the Western Europe tenant and Canada East tenant.

## Conclusion
Based on the research done with Citrix SD-WAN and Microsoft Office 365 OneDrive we can conclude that the Office365 optimization has an overall positive impact on the user experience.

Citrix SD-WAN reduces the time that end users have to wait for data being transferred, but the biggest improvement is that of the Round Trip Time. This is highly noticeable for the end user as this is what makes an interaction feel smooth and responsive instead slow and laggy.

Beside the user experience improvement, there is also a benefit for the business because not all the traffic is transported back to the datacenter so dedicated lines between locations and the datacenter can be scaled down.

Citrix SD-WAN Office 365 optimization helps in overcoming current day network challenges when using (Hybrid) Cloud and SaaS.

This research is an indication on the possibilities with Citrix SD-WAN but can fluctuate because of different variables that we cannot control. Variables such as ISP overbooking, Azure load and Microsoft Office365 load.

Questions or comment about this research? Leave them below in the comments or ask them on the [Slack Channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Florian Steciuk](https://unsplash.com/@flo_stk?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
