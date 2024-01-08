---
layout: post
toc: true
title:  "Effect of cumulative updates on Windows 10 in a VDI environment"
hidden: false
authors: [ryan]
categories: [ 'microsoft', 'windows 10' ]
tags: [ '1709', '1803', '1809', 'cumulative updates', 'windows 10', 'microsoft' ]
image: assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-feature-image.png
---
Every month Microsoft releases a cumulative update for Windows 10 and other supported operating systems. These updates contain improvements and fixes that will improve the quality of Windows 10. But do these updates have an impact on the performance in a VDI context? This research will compare different cumulative updates on different Windows 10 builds.

## More about Cumulative Updates
Every month Microsoft releases cumulative updates for Windows 10, Windows 10 LTSB, Windows Server 2016 & 2019. These updates are distributed with Windows updates but can also be found in the Windows Update Catalog.

[https://www.catalog.update.microsoft.com/Search.aspx?q=cumulative%20update%20for%20Windows%2010](https://www.catalog.update.microsoft.com/Search.aspx?q=cumulative%20update%20for%20Windows%2010){:target="_blank"}

Every update has a KB id and contains details of all the changes of the specific update, for instance: [https://support.microsoft.com/en-us/help/4490481/windows-10-update-kb4490481](https://support.microsoft.com/en-us/help/4490481/windows-10-update-kb4490481){:target="_blank"}

## Configuration and scenarios
The goal of this research is to show the impact of the cumulative updates on different Windows 10 builds. As over time a lot of cumulative updates are released and therefore the scope has been limited to the following builds:

  * Windows 10 build 1709;
  * Windows 10 build 1803;
  * Windows 10 build 1809.

The following cumulative releases are included in this research:

| Date              | Windows   | Build         | URL                                                                                        |
| :---------------: | :-------: | :-----------: | :----------------------------------------------------------------------------------------: |
| March 1, 2019     | 1809      | 17763.348     | [KB4482887](https://support.microsoft.com/en-us/help/4482887/windows-10-update-kb4482887){:target="_blank"}  |
| February 19, 2019 | 1803      | 17134.619     | [KB4487029](https://support.microsoft.com/en-us/help/4487029/windows-10-update-kb4487029){:target="_blank"}  |
| February 19, 2019 | 1709      | 16299.1004    | [KB4487021](https://support.microsoft.com/en-us/help/4487021/windows-10-update-kb4487021){:target="_blank"}  |
| January 22, 2019  | 1809      | 17763.292     | [KB4476976](https://support.microsoft.com/en-us/help/4476976/windows-10-update-kb4476976){:target="_blank"}  |
| January 15, 2019  | 1803      | 17134.556     | [KB4480976](https://support.microsoft.com/en-us/help/4480976){:target="_blank"}                              |
| January 15, 2019  | 1709      | 16299.936     | [KB4480967](https://support.microsoft.com/en-us/help/4480967){:target="_blank"}                              |
| December 19, 2018 | 1809      | 17763.195     | [KB4483235](https://support.microsoft.com/en-us/help/4483235){:target="_blank"}                              |
| December 19, 2018 | 1803      | 17134.472     | [KB4483234](https://support.microsoft.com/en-us/help/4483234){:target="_blank"}                              |
| December 19, 2018 | 1709      | 16299.847     | [KB4483232](https://support.microsoft.com/en-us/help/4483232){:target="_blank"}                              |
| December 5, 2018  | 1809      | 17763.168     | [KB4469342](https://support.microsoft.com/en-us/help/4469342){:target="_blank"}                              |
| November 13, 2018 | 1803      | 17134.407     | [KB4467702](https://support.microsoft.com/en-us/help/4467702){:target="_blank"}                              |
| November 27, 2018 | 1709      | 16299.820     | [KB4467681](https://support.microsoft.com/en-us/help/4467681){:target="_blank"}                              |

Each cumulative update will be compared in the own build version, with the oldest update as the baseline. This way it shows if there is an impact with newer updates. The updates have been downloaded and installed individually on a clean Windows 10 release. As the cumulative updates include previous updates, only the latest cumulative update is installed. No additional updates for Microsoft Office 2016 have been installed.

The desktops are delivered using Citrix Virtual Desktops version 1811 using VM’s with 2 vCPUs and 4GB memory. This research has taken place in the {{site.title}} lab environment, described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}, using our default testing methodology described [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Expectations and results
As the changes in the cumulative updates contain fixes, improvements and security related patches it is expected there is only a minimal impact. This is very important for an enterprise environment, as big capacity changes can have a huge influence on the services.

One of the default metrics used in almost every research is the Login VSI VSImax which reflects the overall capacity. More information about the VSImax can be found [here](https://www.loginvsi.com/blog-alias/login-vsi/481-calculating-maximum-virtual-desktop-capacity-vsimax-explained){:target="_blank"}. As this research contains 12 scenarios, each Windows 10 version is compared in individual charts.

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-vsimax.png" data-lightbox="vsimax-1809">
![vsimax-1809]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-vsimax.png" data-lightbox="vsimax-1803">
![vsimax-1803]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-vsimax.png" data-lightbox="vsimax-1709">
![vsimax-1709]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

Overall, there is minimal change in the VSImax results in all versions. All the Windows 10 versions show a drop in capacity and an increase with the latest update. The biggest drop in capacity is Windows 10 1803 with a 5% decrease in capacity.

The Login VSI baseline is an indicator if there is any change in the overall response times. A lower baseline reflects a more responsive experience.

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-baseline.png" data-lightbox="baseline-1809">
![baseline-1809]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-baseline.png" data-lightbox="baseline-1803">
![baseline-1803]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-baseline.png" data-lightbox="baseline-1709">
![baseline-1709]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Windows 10 1809 has an improvement in the baseline, where the other version has minimal to no change. Overall this is positive as it shows when patching Windows 10 the response times remain stable where Windows 10 1809 even improves.

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-host-cpu.png" data-lightbox="cpu-1809">
![cpu-1809]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-host-cpu-compare.png" data-lightbox="cpu-1809-compare">
![cpu-1809-compare]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-host-cpu.png" data-lightbox="cpu-1803">
![cpu-1803]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-host-cpu-compare.png" data-lightbox="cpu-1803-compare">
![cpu-1803-compare]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-host-cpu.png" data-lightbox="cpu-1709">
![cpu-1709]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-host-cpu-compare.png" data-lightbox="cpu-1709-compare">
![cpu-1709-compare]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Windows 10 1809 shows a consistent increase in CPU utilization as the other versions show a small difference. Although the increase is small it would be important to keep track to ensure it is not climbing with newer updates. This way capacity issues can be avoided.

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-host-reads.png" data-lightbox="reads-1809">
![reads-1809]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-host-reads-compare.png" data-lightbox="reads-1809-compare">
![reads-1809-compare]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-host-reads-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-host-reads.png" data-lightbox="reads-1803">
![reads-1803]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-host-reads-compare.png" data-lightbox="reads-1803-compare">
![reads-1803-compare]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-host-reads-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-host-reads.png" data-lightbox="reads-1709">
![reads-1709]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-host-reads-compare.png" data-lightbox="reads-1709-compare">
![reads-1709-compare]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-host-reads-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There seems to be a big improvement in the storage reads/sec for both Windows 10 1809 and Windows 10 1803 except for Windows 10 1709. It is not clear what is causing the huge improvement. This shows the storage reads/sec are not consistent with each update. Something to take into account when updating the VDI environment.

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-host-writes.png" data-lightbox="writes-1809">
![writes-1809]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-host-writes-compare.png" data-lightbox="writes-1809-compare">
![writes-1809-compare]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1809-host-writes-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-host-writes.png" data-lightbox="writes-1803">
![writes-1803]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-host-writes-compare.png" data-lightbox="writes-1803-compare">
![writes-1803-compare]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1803-host-writes-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-host-writes.png" data-lightbox="writes-1709">
![writes-1709]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-host-writes-compare.png" data-lightbox="writes-1709-compare">
![writes-1709-compare]({{site.baseurl}}/assets/images/posts/023-effect-of-cumulative-updates-on-windows-10-in-a-vdi-environment/023-cu-update-1709-host-writes-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The storage writes don’t show the huge improvements as the reads/sec. Both windows 10 1809 and Windows 10 1803 are improving where the Windows 10 1709 shows higher writes in the latest update. When storage resources are limited, it is recommended to take the fluctuation in account to avoid major storage issues.

## Conclusion
Installing the latest updates is one of the many best practices when creating a VDI environment. Microsoft releases a new cumulative update each month for the different Windows 10 release which contains fixes, improvements and security fixes. Until today it was not clear if the cumulative updates of Windows 10 have a performance impact.

It is important to have a minimal to no change in the performance impact when updating. A huge difference can have a big impact on the services provided to the users.

The results show there is only a minimal impact on the overall capacity when installing cumulative updates. As the capacity limit of {{site.title}} lab environment is CPU related we did notice a change in storage activity for both Windows 1809 and 1803. The improvement is only noticed in reads/sec which results in a lower hit on storage resource utilization.

This does indicate installing cumulative updates may have an impact on some resources. Therefore, it is important to always validate the impact before deploying in production.

As the updates are released every month, should we do this as a recurring topic? Please share your thought below or share it in the World of EUC [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Manasvita S](https://unsplash.com/photos/9q5vptiE2TY?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/month?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
