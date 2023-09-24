---
layout: post
toc: true
title:  "Microsoft Windows 11 VDI performance short"
hidden: false
authors: [eltjo, omar]
categories: [ 'Windows 11' ]
tags: [ 'Windows 10', 'Windows 11', 'VDI','21h2','21h1']
image: assets/images/posts/079-windows-11-vdi-performance-short/079-windows-11-vdi-performance-short-feature-image.png

---
On August 31st 2021, Microsoft announced that Windows 11 will become available on October 5th, 2021. Microsoft will start the upgrade to Windows 11 on eligible devices, and pre-loaded devices will also become available for order with Windows 11 as standard. GO-EUC tested previous releases of Windows 10 and concluded that with each new release, there are performance, and therefore scalability implications. This GO-EUC Short will focus on the performance differences between the latest insider preview build 22000.100 in comparison to Windows 10.

## Background information
Windows 11 will be the first major update to the Windows operating platform since Windows 10 was launched in 2015. More details on the announcement can be found in the official announcement [blog post](https://blogs.windows.com/windowsexperience/2021/08/31/windows-11-available-on-october-5/){:target="_blank"}.

Possibly the biggest, but at least the most apparent change, is the new interface. With a redesigned Start menu which is now located in the middle of the screen by default, the new look is sleeker and more akin to the Mac-like interfaces from Apple.

Microsoft Teams will be integrated directly into the Windows taskbar for easier accessibility.

<a href="{{site.baseurl}}/assets/images/posts/079-windows-11-vdi-performance-short/079-windows-11-vdi-performance-short-desktop.png" data-lightbox="Windows 11">
![watermark-example]({{site.baseurl}}/assets/images/posts/079-windows-11-vdi-performance-short/079-windows-11-vdi-performance-short-desktop.png)
<p align="center" style="margin-top: -30px;" >
  <i>Image courtesy of Microsoft</i>
</p>

One of the more interesting highlights that the blogpost mentioned is:

> Windows 11 is optimized for speed, efficiency and improved experiences with touch, digital pen and voice input.

"Windows 11 is optimized for speed", in itself that is a bold statement, but the main question is: how does it compare to the previous Windows releases?

## Setup and testing methodology
For these preliminary tests, the Windows 11 Insider Preview build from the Microsoft Insider Dev Channel, Build 22000.100 was used. This built was announced on July 22, and was the latest available version at the time of testing. More information on this specific build can be found here: [https://blogs.windows.com/windows-insider/2021/07/22/announcing-windows-11-insider-preview-build-22000-100/](https://blogs.windows.com/windows-insider/2021/07/22/announcing-windows-11-insider-preview-build-22000-100/){:target="_blank"}

The Windows 11 build was tested and compared against Windows 10 in the following versions:
* Windows 10 version 20h2 as the baseline
* Windows 10 version 21h1

The standard workload and testing methodology was used, which is described [here](https://www.go-euc.com/insight-in-the-testing-methodology-2020/){:target="_blank"}.

Normally Remote Display Analyzer is used to collect the protocol data that is used for analysis. Protocol data includes framerate, bandwidth usage, and RTT for example. In this case, RDA wasn’t able to collect valid data for these metrics for the Windows 11 build.  As a result, the results in this research will not include any protocol data.
As a cautionary remark, because Windows 11 hasn’t been released, there is no official Citrix support for Windows 11 yet. As always Citrix will most likely offer Day 1 support when Windows 11 will be GA.

Consequently, there was no Citrix Optimizer template available yet, therfore Citrix Optimizer was used with the latest available template which was 20H2 at the time of testing.

Once Windows 11 is GA and the official Windows 11 Citrix Optimizer templates are available, the tests will be rerun and a complete research will be published.

## Preliminary results
To get an impression of the overall performance of Windows 11, the first metric to report on is the average CPU utilization.

<iframe title="CPU utilization" aria-label="Interactive line chart" id="datawrapper-chart-67188" src="https://datawrapper.dwcdn.net/67188/1/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="400"></iframe><script type="text/javascript">!function(){"use strict";window.addEventListener("message",(function(e){if(void 0!==e.data["datawrapper-height"]){var t=document.querySelectorAll("iframe");for(var a in e.data["datawrapper-height"])for(var r=0;r<t.length;r++){if(t[r].contentWindow===e.source)t[r].style.height=e.data["datawrapper-height"][a]+"px"}}}))}();
</script>

<p align="center">
  <i>Lower is better</i>
</p>

<iframe title="CPU comparison in %" aria-label="Column Chart" id="datawrapper-chart-U1aJj" src="https://datawrapper.dwcdn.net/U1aJj/1/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="400"></iframe><script type="text/javascript">!function(){"use strict";window.addEventListener("message",(function(e){if(void 0!==e.data["datawrapper-height"]){var t=document.querySelectorAll("iframe");for(var a in e.data["datawrapper-height"])for(var r=0;r<t.length;r++){if(t[r].contentWindow===e.source)t[r].style.height=e.data["datawrapper-height"][a]+"px"}}}))}();
</script>

<p align="center">
  <i>Lower is better</i>
</p>

The intial findings show that the trend of strong increases in the CPU utilization for each new Windows version, has been discontinued. The average CPU utilization for Windows 10 21H1 and Windows 11 is identical.

<iframe title="Available memory comparison in %" aria-label="Column Chart" id="datawrapper-chart-tC0nb" src="https://datawrapper.dwcdn.net/tC0nb/2/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="400"></iframe><script type="text/javascript">!function(){"use strict";window.addEventListener("message",(function(e){if(void 0!==e.data["datawrapper-height"]){var t=document.querySelectorAll("iframe");for(var a in e.data["datawrapper-height"])for(var r=0;r<t.length;r++){if(t[r].contentWindow===e.source)t[r].style.height=e.data["datawrapper-height"][a]+"px"}}}))}();
</script>
<p align="center">
  <i>Lower is better</i>
</p>

Memory consumption for Windows 11 does not show a significant change during our workloads compared to Windows 10, with a 3% increase from 20H2 to 21H1 and a 2% increase from 20H2 to Windows 11.

<iframe title="Storage comparison in %" aria-label="Grouped Bars" id="datawrapper-chart-ohZjv" src="https://datawrapper.dwcdn.net/ohZjv/2/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="496"></iframe><script type="text/javascript">!function(){"use strict";window.addEventListener("message",(function(e){if(void 0!==e.data["datawrapper-height"]){var t=document.querySelectorAll("iframe");for(var a in e.data["datawrapper-height"])for(var r=0;r<t.length;r++){if(t[r].contentWindow===e.source)t[r].style.height=e.data["datawrapper-height"][a]+"px"}}}))}();
</script>
<p align="center">
  <i>Lower is better</i>
</p>

The impact on storage however, is more significant with an increase of 13% compared to Windows 10 21H1 for the commands per second. In more detail, there is a significantly increased load in terms of writes of 15%. These patterns are observed during the whole of the test runs, and are consistent in each individual run.

## Preliminary conclusion
Despite the fact that Microsoft increased the system requirements for Windows 11, the initial findings show that there is only a small increase in resource utilization for Windows 11 compared to the previous Windows 10 builds 20H2 and 21H1.

The increase in load on the storage is significant, although with fast storage this will most likely not have a noticeable impact on user experience. This might however impact scalability and could have an impact on logon times during peak hours for example.

Big shoutout to Omar Bouhaj for setting up and running the tests.

Please let us know what you think of these preliminary results via social media or on our [World of EUC Slack channel](https://worldofeuc.slack.com){:target="_blank"}!
