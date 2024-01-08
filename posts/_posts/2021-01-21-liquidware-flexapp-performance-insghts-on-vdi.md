---
layout: post
toc: true
title: "Liquidware FlexApp performance insights running on a VDI environment"
hidden: false
authors: [gerjon, tom]
categories: [ 'Liquidware' ]
tags: [ 'Liquidware', 'FlexApp', 'Layering']
image: assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-feature-image.png
---
Application layering is a technique that is becoming widely used in, mostly, virtual desktop environments. This technique solves one of the big issues in desktop environments, which is how to deal with the changing application landscape. Application layering makes it possible to add applications to an already running desktop. This gives IT admins the flexibility to only update applications and not the complete image of the desktop. It gives users the possibility to have applications accessible in their desktop environment without having to wait for IT the install these apps or redeploy the desktop.

When adding extra software to an IT environment, there is always a chance for a performance penalty. In this research will focus on quantifying the performance impact of Liquidware FlexApp in a VDI environment for the users.

## What is Liquidware FlexApp
FlexApp layering instantly delivers applications to any Windows desktop environment on demand. Applications are delivered to users independent of the Windows operating system version or delivery platform. The solution supports VDI and DaaS desktops such as Microsoft WVD, Citrix, VMware Horizon, Nutanix Xi Frame, Amazon WorkSpaces and physical desktops ([Application Layering - Liquidware FlexApp](https://www.liquidware.com/products/flexapp){:target="_blank"}). This can be done in a per machine or per user context. The applications are packaged via FlexApp packager. The packages are then stored in vhd(x) format on a file share, stored on Azure Blob storage, Azure files or an Amazon S3 bucket so they can be connected to the client via GPO or ini file.

This research will focus on answering the following questions:

> Is there a performance penalty when using Liquidware FlexApp compared to locally installed applications and is the penalty different when connecting the layers apps per machine or per user.

and

> Is there a performance difference between connecting layered apps per application or attaching a combined layer with all applications.

## Infrastructure and configuration
This research has taken place on the GO-EUC infrastructure which is described [here](https://www.go-euc.com/architecture-and-hardware-setup-overview-2020/){:target="_blank"}. The same baseline image was used for each scenario. The machines were provisioned with Citrix Virtual Apps & Desktops version 1909 and the infrastructure used VDA 1912. The test machines were deployed using Citrix MCS with a default configuration of 2vCPU’s and 4GB of memory.

Windows 10 1909 is the default operating system which is, optimized using the default settings from the Citrix optimizer tool. only the FlexApp runtime version 1.1.0, Office 2016, and FlexApp client were deployed on the image, except when testing with all applications locally installed then all applications were deployed locally. The applications that were packaged for testing are Adobe Reader and Google Chrome.

During testing the packaging of Microsoft Office 2016 there were some issues with the packaging. After contacting Liquidware their best practice is not to package Microsoft Office but to deploy it in the image. So the best practice from the vendor was used.

For testing, at the time of the test, the latest available version of the Liquidware FlexApp client-tools (version 6.8.3R2-Hotfix) was used. This version was used to be sure that none of the known bugs would tamper with the result of the tests. As per best practice from Liquidware, the base image used for testing and the packager had the Liquidware runtime installer version 1.1.0 installed.

Also, the best practices as described by Liquidware regarding the configuration of windows defender were implemented. These can be found [here](https://liquidwarelabs.zendesk.com/hc/en-us/articles/210628383-Antivirus-slows-logon-while-scanning-of-ProfileUnity-Program-Files-and-directories-){:target="_blank"}.

Four different scenarios were tested:

  * ‘No FlexApp’ without FlexApp used
  * ‘FlexApp PerApp’ at user login, each app in its own FlexApp package
  * ‘FlexApp CombinedApp’ at user logon, all applications in one FlexApp package
  * ‘FlexApp PerMachine’ at system boot, each application in its own FlexApp package

The scenarios ran via the LoadGen solution and the standard testing methodology was used, which is described [here](https://www.go-euc.com/insight-in-the-testing-methodology-2020/){:target="_blank"}.

As mentioned earlier, Google Chrome and Adobe reader were packaged in a separate FlexApp container and a combined container. Microsoft Office is installed in the base image, as this is the best practice from Liquidware.

## Expectations and results
When executing this kind of researches there is always an expectation. Based on experience, adding filter drivers and extra software to an operating system will result in higher resource utilization. The expectation would be that adding the applications on machine boot would give the lease impact.

Also, the documentation of FlexApp states a 2-4 second logon delay. Below is the excerpt of the documentation.

> Application Playback Considerations ProfileUnity’s FlexApp Technology layers in application packages in parallel to the user login process without impacting user login speeds. It generally takes 2-4 seconds to layer in each package and make it ready for use. In cases where 10 or more FlexApp packages are assigned to a user, it is possible for the login process to finish and the desktop to be ready before all the FlexApp packages have been layered in leaving a user waiting for their applications to appear.
>
> Source: [ProfileUnity™ with FlexApp™ Technology: FlexApp Packaging Console Manual (liquidware.com)](https://www.liquidware.com/content/pdf/documents/support/Liquidware-ProfileUnity-FlexApp-Packaging-Console-Manual.pdf){:target="blank"}

During the tests, multiple performance data sources are collected. As usual, the hypervisor data is a good starting point, as this provides a clear indication of the performance impact on scalability.

<a href="{{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-cpu.png" data-lightbox="host-cpu">
![host-cpu]({{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-cpu-compare.png" data-lightbox="host-cpu-compare">
![host-cpu-compare]({{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Looking at the CPU utilization when using the different FlexApp packages, the first thing that stands out is: Yes adding FlexApp to the virtual environment adds extra CPU load on the hypervisor. Connecting the FlexApp volumes on boot is less CPU consuming than adding them on a per user basis.

Next to the CPU utilization is it very important to take the storage into account. Once a storage bottleneck is reached, it is most likely the entire VDI won’t respond to any input. Therefore when implementing a solution like FlexApp it is very important to ensure the bottleneck is not reached.

<a href="{{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-reads.png" data-lightbox="host-reads">
![host-reads]({{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-writes.png" data-lightbox="host-writes">
![host-writes]({{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-storage-compare.png" data-lightbox="host-storage-compare">
![host-storage-compare]({{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-storage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Both Reads/sec and Writes/sec (number of reads and writes the VMware Host does to the underlying infrastructure), it’s evident that using the per machine FlexApp container gives a lot less strain on the underlying infrastructure. Using the CombinedApp container gives the most storage activities to the underlying infrastructure. Even though the file server is located on a separate host there is still a significant increase in both reads and writes on the workload host. This might be caused by the mounting of the disk done by the FlexApp agent.

Based on the storage behavior, it is interesting to further investigate the network activities from the hypervisor perspective.

<a href="{{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-network-send.png" data-lightbox="host-network-send">
![host-network-send]({{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-network-send.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-network-received.png" data-lightbox="host-network-received">
![host-network-received]({{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-network-received.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-network-compare.png" data-lightbox="host-network-compare">
![host-network-compare]({{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-host-network-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

One of the other things that is really interesting is the impact the application layering has on the network. The first thing that stands out is that for some reason there is less traffic send out of the hypervisor to the backend infrastructure when using FlexApp. But overall the send data volume is not that high.

When looking at the data received by the hypervisor there is a big difference between using FlexApp and not using FlexApp in the environment. But to put things in perspective the data load never exceeds 90 Megabit per second so network congestion is not very likely to occur.

## File Server
As the FlexApp packages are served from a file server, it is important to take the file server performance into account.

<a href="{{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-fileserver-reads.png" data-lightbox="fileserver-reads">
![fileserver-reads]({{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-fileserver-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-fileserver-reads-compare.png" data-lightbox="fileserver-reads-compare">
![fileserver-reads-compare]({{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-fileserver-reads-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There are some important notes to take into account. The file server is used by multiple solutions, including the automation framework of GO-EUC. Additionally, the No FlexApp scenario does not provide any FlexApp package from the file server and is, therefore, way lower in comparison with the other scenarios.

When mounting the FlexApp packages machine based, the load is significantly less compared to the other scenarios due to the timing of the mounting activity.

<a href="{{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-fileserver-writes.png" data-lightbox="fileserver-writes">
![fileserver-writes]({{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-fileserver-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-fileserver-writes-compare.png" data-lightbox="fileserver-writes-compare">
![fileserver-writes-compare]({{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-fileserver-writes-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There is some difference in the write activities from the file server perspective, but please note the overall activity is very low. The results show the FlexApp packages are only used read-only.

In general, when using FlexApp is important to not only take the performance impact on the hypervisor into account, but the file server is an important factor as well.

## User logon times
One of the key metrics, at least for the user’s standpoint, is the logon time of the environment. As stated by the documentation from Liquidware adding FlexApp to the VDI environment will add an extra delay in logon times. To quantify that statement, the test also included the login time of the sessions.

<a href="{{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-session-logon.png" data-lightbox="session-logon">
![session-logon]({{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-session-logon.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-session-logon-comparison.png" data-lightbox="session-logon-compare">
![session-logon-compare]({{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-session-logon-comparison.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-session-logon-comparison-seconds.png" data-lightbox="session-logon-compare-seconds">
![session-logon-compare-seconds]({{site.baseurl}}/assets/images/posts/032-liquidware-flexapp-performance-insghts-on-vdi/032-liquidware-flexapp-session-logon-comparison-seconds.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As learned from previous researches, logon times are heavily affected by the available resources. To have a clean comparison it is recommended to compare based on the first 20 minutes as the server was not saturated at that point.

The data shows adding FlexApp to the VDI environment will, as stated by Liquidware, add extra login time to the user session. The results show when using different package strategy will have an effect on the logon times, as the individual packages have the highest logon times based on the first 20 minutes results. This does make sense, as multiple packages are mounted during user logon. The machine-based mounting does show improved logon time, but still shows an increase of 18 seconds.

## Conclusion
Liquidware FlexApp provides the ability to deliver applications in a flexible matter. It can be used in various scenarios, including on-premises VDI or RDSH, to cloud workspaces and even physical desktops.

> We continue to innovate and stay many steps ahead of the competition with our adaptive workspace management solutions regardless the platform you will use now or in the future.
>
> Liquidware

Using FlexApp is a strategy that provides flexibility in your environment, but as this research shows, does require additional resources. There are multiple ways to package an application that will have an effect on the overall performance. Based on the results it is recommended to take this into account when implementing FlexApp in a virtual desktop environment.

As the packages are provided via a file server, it is important to take the additional reads into account. Depending on the size of your environment and the number of packages, there will be a significant increase in the reads on the file server. As Liquidware does support cloud storage this might be a consideration. Please note, this is not validated in this research, so the impact of latency is unknown.

As stated in the documentation the logon times will increase when using FlexApp. The results show these are a bit higher than expected but can be reduced based on the packaging strategy. It is important to understand the GO-EUC researched are quite extreme where the resources are pushed to the limit. Therefore it is very important before implementing a solution to validate the impact in your own context and use a monitoring solution to see the effect in production.

Unfortunately, this dataset did not include the application start times and perhaps an additional research will be started in the future. If you have any comments or questions about this research, please leave a comment below or reach out at the [World of EUC Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Kelly Sikkema](https://unsplash.com/@kellysikkema?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText){:target_"blank" on [Unsplash](https://unsplash.com/s/photos/packages?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText){:target="_blank"}
