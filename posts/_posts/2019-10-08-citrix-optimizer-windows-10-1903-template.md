---
layout: post
toc: true
title:  "Citrix Optimizer Windows 10 1903 Template"
hidden: false
authors: [ryan]
categories: [ 'citrix', 'microsoft', 'windows 10' ]
tags: [ 'windows 10', '1809', '1903', 'CTXO', 'citrix' ]
image: assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-feature-image.png
---
A couple of months ago we did a research with the new Windows 10 1903 build. While the new Windows build was already released the Citrix Optimizer template was not available yet. In this research the new Citrix Optimizer Windows 10 1903 template will be validated from a performance perspective.

## The Citrix Optimizer Windows 10 1903 template
For those who don’t know what the Citrix Optimizer is, it is recommend reading the following articles.

  * [https://www.citrix.com/blogs/2017/12/05/citrix-optimizer/](https://www.citrix.com/blogs/2017/12/05/citrix-optimizer){:target="_blank"}
  * [https://www.go-euc.com/citrix-optimizer-version-2-breakdown/]({{stite.baseurl}}/citrix-optimizer-version-2-breakdown){:target="_blank"}

Because the 1903 template wasn’t available at the time writing [previous research]({{stite.baseurl}}/moores-law-of-windows-10-1903){:target="_blank"}, Citrix advised to use the 1809 template. The results from that research showed a big impact on user density. Before reviewing the results, it is important to understand what has changed in the template.

Comparing to the previous template, Windows 10 1809,  we noticed nothing is removed and the following items are added.


| Type | Name                   	         | Description                                                                                           |
| :--: | :---------------------------------: | :----------------------------------------------------------------------------------------------------:|
| UWP  | Microsoft.WindowsCommunicationsApps | Disable Windows Mail and Calendar functionality.                                                      |
| UWP  | Microsoft.HEIFImageExtension	     | Adds support for High Efficiency Image File (HEIF) format, usually with .heif extension.              |
| UWP  | Microsoft.VP9VideoExtensions	     | Adds support for video codec VP9 (part of WebM project by Google).                                    |
| UWP  | Microsoft.WebpImageExtension	     | Adds support for image format WebP.                                                                   |
| UWP  | Microsoft.ScreenSketch	Removes      | “Snip & Sketch” application. Provides functionality of Snipping Tool with additional improvements.    |

The table shows only UWP apps included in the template that will be removed from the operating system. Based on [this research]({{stite.baseurl}}/citrix-optimizer-version-2-breakdown){:target="_blank"} we already learned removing the UWP apps have a big impact on capacity, so we should see an improvement in user density.

## Infrastructure & configuration
This research has taken place on the {{site.title}} lab environment which is described [here]({{stite.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. The default configuration is used which is 2vCPU’s with 4GB memory. Citrix Virtual Apps & Desktops 1906 is used for both the infrastructure and the VDA’s. The desktops are created using Citrix MCS. All Login VSI required applications are installed including Microsoft Office 2016 x64 with the latest Windows updates.

For this research two scenarios are defined:

  * Windows 10 1809, OS build 17763.737, as the baseline;
  * Windows 10 1903, OS build 18362.356.

Both scenarios are optimized using the Citrix Optimizer version 2.5 with the recommended templates. The Windows 10 1903 template is not included in this Citrix Optimizer version but can be downloaded from the marketplace. The upcoming 2.6 release will include the template by default.

Each scenario is tested according our default testing methodology which is described [here]({{stite.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Expectations and results
Before covering the new results, it is important to understand the difference from previous research. Comparing the same data showed a signification impact comparing Windows 10 1809 with 1903.

<a href="{{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-prev-vsimax.png" data-lightbox="vsimax-previous">
![vsimax-previous]({{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-prev-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The results from this research showed that deploying Windows 10 1903 and optimized with the Windows 10 1809 template will not result in an optimal user density. You can find the full research [here]({{site.baseurl}}/moores-law-of-windows-10-1903){:target="_blank"}.

As more UWP apps are removed using the new template it is expected so see an improvement in the results. Both researches use a fully updated Windows 10 but as this research has been executed more recent the latest cumulative updates are applied. This could make a difference as Microsoft is continuously adding security and bug fixes including improvements.

Like the previous research using the Login VSI VSImax it is possible to validate the user density between both scenarios. The Login VSI baseline provides an indication of the difference in the overall response times.

<a href="{{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There is a small decrease in both capacity and user experience based on the Login VSI VSImax & baseline. Comparing these new results to the previous research it is a huge improvement.

It is always important to verify the Login VSI results using other metrics from the environment. Therefore, data from the hypervisor is collected as well, which includes metrics as CPU utilization and storage utilization.

Based on the VSImax we should so similar pattern in the CPU utilization as the GO-EUC environment is CPU constrained.

<a href="{{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-host-cpu.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-host-cpu-compare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

A higher CPU utilization means less users can be hosted on the environment. There is a small increase in the CPU utilization which is also reflected in the VSImax results.

Although most environments already have SSDs it is still important to understand the impact on storage, especially running on shared storage. A big increase in load could result in catastrophic storage outages which should be avoided at any time.

<a href="{{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-host-storage-compare.png" data-lightbox="storage-compare">
![storage-compare]({{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-host-storage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

These results show there is small decrease in both reads and writes. Previous research showed a huge increase in storage resource utilization. This shows applying the right optimization will have a positive effect, but based on previous research it is not expected.

Logon times are important in a VDI environment and have big effect on the first user experience. When the logon times are increasing it is likely to have a negative effect on the users experience.

<a href="{{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-logon.png" data-lightbox="logon">
![logon]({{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-logon.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-logon-compare.png" data-lightbox="logon-compare">
![logon-compare]({{site.baseurl}}/assets/images/posts/040-citrix-optimizer-windows-10-1903-template/040-win1903-logon-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

### Conclusion
We already know that each Windows 10 version requires specific optimizations to get the optimal user density, and user experience. Previous results showed a significant impact comparing Windows 10 1809 with the latest Windows 10 1903 when using the 1809 optimization template.

In the meantime, Citrix has released a new template for Windows 10 1903 with promising results. There is still a small impact but not as huge as with the previous research.

[Martin Zugec](https://twitter.com/MartinZugec){:target="_blank"} shared additional optimization will be included in an upcoming template update and they are continuing to improve existing templates.

One of the best practices is to ensure all the latest Windows update are installed. Yes, this template does provide an improvement, but we do believe the performance benefits could be attributed to Windows updates. Maybe we should do another cumulative update research to validate this, what do you think?

This research does confirm that you should be very careful applying the right optimizations, as it can make a big difference in user density and perceived user experience. The trend, Moore’s law of Windows 10, continues as each Windows 10 builds still requires more resources.

Are you already trying out Windows 10 1903 in your environment? Share your experience in the [Slack Channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Luca Micheli](https://unsplash.com/@lucamicheli?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/seattle?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
