---
layout: post
toc: true
title:  "Browser Performance Impact 2020"
hidden: false
authors: [omar]
categories: [ 'browsers' ]
tags: [ 'microsoft edge chromium', 'mozilla firefox', 'google chrome', 'browsers']
image: assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-feature-image.png
---
Six months ago, on January 15, Microsoft released the new GA Chromium-based Edge browser. With that offering this research will serve as an updated re-comparison version to the original post, revised with the new industry browsers.

The browser is becoming more and more important. But which browser will gain prominence, is it worthwhile changing a browser in 2020 and what is the impact in a VDI environment running one of the browsers?

This research focuses on performance, user experience and the user density impact of the most used browsers in VDI environments.

## Browser enterprise introduction
The right browser can still make a huge difference to the way the internet is experienced and it is becoming more and more important. The most important task of a browser in a VDI environment remains the same, namely the workspace, surfing the web, playing videos from the web and accessing enterprise web applications.

In late 2018 there was the big news: Microsoft’s Edge embraced Chromium, the same engine that powers Google Chrome. That means two of the three most used enterprise browsers are Chromium-based.

The aim of this research is still the same as the previous research which can be found [here]({{site.baseurl}}/browser-performance-impact){:target="_blank"}.

## What’s new
For more information on Microsoft’s Edge Chromium, Mozilla’s Firefox and Google’s Chrome browsers feature list and comparisons, please check out the vendors website listed below.

**Microsoft Edge Chromium**

Microsoft has built its Edge browser from scratch, taking the most basic form of Chromium as its starting point. With that change, now both of the leading enterprise browsers run on the same engine. Which could accelerate progress for enterprise- and mobile sites, as developers can devote their resources in a more concentrated way. That change appears to be focused on the enterprise area, providing interoperability with enterprise-centric software. Hopefully, Microsoft, doesn't rely on advertising in comparison to Google.

In the context of innovation and a glance at the future, it is a great move by Microsoft.

> <div style="text-align:center;">
> If you can't beat them, you join them
> </div>

<div style="text-align:center;">
CEO Satya Nadella, Microsoft
</div>

<br>

> <div style="text-align:center;">
> Microsoft Edge is on a mission to create the best browser for enterprises: rock-solid fundamentals, intelligent security, the most productive and secure end-user experience, flexible manageability; and deep integration with Microsoft 365. The new Chromium based version of Microsoft Edge is ready for business.
> </div>

For a complete list of features, check out the continuously updated page [here](https://www.microsoftedgeinsider.com/en-us/whats-new){:target="_blank"}.
Make also sure to get familiar with the tips given at this [link](https://microsoftedgetips.microsoft.com/en-us/all/?source=support){:target="_blank"}.

**Google Chrome**

For a complete list of features, check out this page [here](https://chromeenterprise.google/browser){:target="_blank"}.

**Mozilla Firefox**

For a complete list of features, check out this page [here](https://www.mozilla.org/en-US/firefox/enterprise){:target="_blank"}.

## Infrastructure and configuration
The infrastructure used for this research is described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"} and uses the testing methodology of GO-EUC that has been described [here]({{site.baseurl}}/insight-in-the-testing-methodology-2020){:target="_blank"}. The default workload used in GO-EUC’s testing methodology was modified to support the different browsers. The workloads can be downloaded below:

  * Workload [Microsoft Edge Chromium](https://github.com/RyanBijkerk/go-euc-workloads/raw/master/KnowledgeWorker_v2005.1_edge.lgs){:target="_blank"};
  * Workload [Google Chrome](https://github.com/RyanBijkerk/go-euc-workloads/raw/master/KnowledgeWorker_v2005.1_chrome.lgs){:target="_blank"};
  * Workload [Mozilla Firefox](https://github.com/RyanBijkerk/go-euc-workloads/raw/master/KnowledgeWorker_v2005.1_firefox.lgs){:target="_blank"}.

Three different scenarios were tested:

  * Microsoft Edge Chromium Enterprise, 83.0.478.45 (Official build, x64), as baseline reference;
  * Google Chrome Enterprise, 83.0.4103.97 (x64);
  * Mozilla Firefox Enterprise Extended Support Release, 68.9.0 (ESR, x64).

*Note:* the (new) websites used are not compatible with Internet Explorer (IE).

That is one of the reasons why in each scenario the default built-in OS IE was removed from the guest OS. In the second and third scenario the default built-in [legacy Edge](https://support.microsoft.com/en-us/help/4533505/what-is-microsoft-edge-legacy){:target="_blank"} was included in the guest OS. Also, in each scenario the specific Windows services to maintain and update the browsers are disabled.

All browsers were the most current production versions at the time of writing and were kept at their default settings. With the exception of changes to the OS and workload configuration.

The following OS changes were applied:

  * Microsoft’s Edge Chromium used a computer GPO to prevent the “First Time Run” wizard screen from appearing;
  * Mozilla’s Firefox used the customized [Autoconfig](https://support.mozilla.org/en-US/kb/customizing-firefox-using-autoconfig){:target="_blank"} file to disable "Firefox Privacy Notification" tab from opening when you start Firefox and to automatically enable and enforce "media" (videos). By default, Firefox will prevent media from playing automatically.

The following workload changes were applied:

  * Google’s Chrome used the following workload addon *"`--autoplay-policy=no-user-gesture-required <url-website-video>`”*. This modification will enable and enforce “media” to run automatically. Similar to Firefox, also Chrome, by default, will prevent media from auto playing.

The tests were configured to use non-persistent desktops with Citrix Virtual Apps & Desktops version 1909 (MCS) for both infrastructure and VDA. The Microsoft Windows 10 was built in 1909, 18363.836, with 2 vCPU, 4 GB RAM and Office 2016. Both Windows and Office are fully patched. Windows Defender, Windows updates and OneDrive are disabled, as this can affect the results with unexpected behavior.

*Note:* [Browser content redirection](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/multimedia/browser-content-redirection.html){:target="_blank"} for Citrix Virtual Apps & Desktops was kept at the default configuration. Resulting in a “Server fetch and server render” setup.

Windows 10 has been optimized with the Citrix Optimizer 1909 template.

## The results
While each browser is constantly improving in terms of features, functionality (options and tools), improvements and technological development, it is now expected that Edge’s Chromium will use fewer computing resources in comparison.

In this research, the user density is determined and calculated when the host reaches its highest CPU utilization rate (threshold). When the CPU threshold is reached, it is possible to calculate the active users on the system. This is not a recommended method because other factors may affect the user density of the environment. The GO-EUC environment is limited by the CPU, which is why this method is used.

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-user-density.png" data-lightbox="user-density-compare">
![user-density-compare]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-user-density.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

This new research indicates that, compared to Edge, both Chrome and Firefox show a high decrease in user density. The difference gets higher as the host load increases.

### Host perspective
Based on the results of user density, Edge's competitors are expected to consume a higher CPU utilization.

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-host-cpu.png" data-lightbox="host-cpu">
![host-cpu]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-host-cpu.png" data-lightbox="host-cpu-compare">
![host-cpu-compare]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

When sharing disk usage across virtual desktops, it is very important for VDI to use the storage in the most efficient way to optimize the virtual desktop performance, user experience and user density. Performance issues on storage can lead to a very poor user experience.

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-host-reads.png" data-lightbox="host-reads">
![host-reads]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-host-writes.png" data-lightbox="host-writes">
![host-writes]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-host-reads-writes.png" data-lightbox="host-reads-writes-compare">
![host-reads-writes-compare]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-host-reads-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

From a storage point of view, the results of Edge are clearly better compared to competitors.

Firefox's reads has the greatest impact. This can be caused by the configuration of the browser in the guest OS (customized [Autoconfig](https://support.mozilla.org/en-US/kb/customizing-firefox-using-autoconfig){:target="_blank"}). These changes were necessary for a fair comparison and to ensure that the workload was expected to run without unexpected influences.

All reads and writes correspond reasonably well to the total commands for each scenario.

In most cases a browser, unlike a website developer, is useless without a network and internet connection, so it is interesting to look at network utilization from a browser perspective.

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-host-nic-packets-received.png" data-lightbox="host-nic-packets-received">
![host-nic-packets-received]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-host-nic-packets-received.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-host-nic-packets-transmitted.png" data-lightbox="host-nic-packets-transmitted">
![host-nic-packets-transmitted]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-host-nic-packets-transmitted.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-host-nic.png" data-lightbox="host-nic-compare">
![host-nic-compare]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-host-nic.png)
</a>

The results of Firefox are clearly lower. Edge is strong in both receiving as sending packets.

*Note:* that this includes all network traffic to and from the LoadGen share, the Citrix Storefront connections etc. from multiple sessions. Although there is internet access, all used websites are located in the datacenter and the results shown is included in that traffic.

### Session perspective
From the perspective of the end user, it is interesting to analyze the performance usage of the remote protocol.

A primary indicator used to measure the user experience when rich 'media' are displayed in the guest OS next to the Frames Per Second is the CPU for encoding metric data. The (session) host that manages the rich media output is also accountable for rich media data with compression and decompression. Which may result in higher (session) host CPU utilization.

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-session-cpu-encoding.png" data-lightbox="session-cpu-encoding">
![session-cpu-encoding]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-session-cpu-encoding.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-session-cpu-encoding.png" data-lightbox="session-cpu-encoding-compare">
![session-cpu-encoding-compare]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-session-cpu-encoding.png)
</a>

With the emergence of rich media, encoding and transcoding are becoming increasingly important, also in VDI environments and especially in the guest OS. CPU encoding is focused on quality, with the goal of highest possible quality at lowest possible bitrate at a cost of encoding time.

The CPU for encoding tasks focuses on these important scenarios. Using GPU technology may reduce the encoding on the CPU as these tasks can be offloaded to GPU.

The frames per second (FPS) metric is also used to measure the user experience.  This is the frequency at which images appear on a display.

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-session-fps.png" data-lightbox="session-fps">
![session-fps]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-session-fps.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-session-fps.png" data-lightbox="session-fps-compare">
![session-fps-compare]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-session-fps.png)
</a>

There is a high difference in the reported FPS for the Firefox scenario. As a consequence, the variance in RTT, latency and bandwidth utilization is also higher.

Round Trip Time (RTT) is the elapsed time from when the user hits a key until the response is displayed back at the endpoint. The difference between the RTT and Session Latency is the application processing time on the (session) host. When both the RTT and Session Latency increases, this will lead to a deterioration of the user experience.

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-session-rtt.png" data-lightbox="session-rtt">
![session-rtt]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-session-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-session-rtt.png" data-lightbox="session-rtt-compare">
![session-rtt-compare]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-session-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Session Latency is the time from when a user executes a keystroke or mouse click to when it is processed on the (session) host.  It includes both network latency and any delay on the (session) host to process this request.

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-session-latency.png" data-lightbox="session-latency">
![session-latency]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-session-latency.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-session-latency.png" data-lightbox="session-latency-compare">
![session-latency-compare]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-session-latency.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The total latency for both Chrome and Firefox are higher compared to Edge. Even if the (session) host CPU utilization is not saturated.

Less bandwidth will still work, but the session performance may suffer because of it. More bandwidth will provide a better user experience.

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-session-bw.png" data-lightbox="session-bw">
![session-bw]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-session-bw.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-session-bw.png" data-lightbox="session-bw-compare">
![session-bw-compare]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-session-bw.png)
</a>

A high bandwidth network generally can deliver more information than a low bandwidth network given the same amount of a time. Low bandwidth scenarios can result in different compressions. For example, compression of the image quality delivered on the endpoint. This would impact the end user experience, as often the protocol becomes blurry or exhibits types of artifacts. Thus, in a WAN scenario where bandwidth is limited, the effect will influence the user experience, higher bandwidth consumption is not the best option.

### Endpoint perspective
Utilization from the perspective of the endpoint is also important to take into account. If the endpoint is limited in resource use, this can lead to a significant reduction in user experience.

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-endpoint-processor.png" data-lightbox="endpoint-processor">
![endpoint-processor]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-endpoint-processor.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-endpoint-processor.png" data-lightbox="endpoint-processor-compare">
![endpoint-processor-compare]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-endpoint-processor.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-endpoint-reads.png" data-lightbox="endpoint-reads">
![endpoint-reads]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-endpoint-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-endpoint-writes.png" data-lightbox="endpoint-writes">
![endpoint-writes]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-endpoint-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-endpoint-reads-writes.png" data-lightbox="endpoint-reads-writes-compare">
![endpoint-reads-writes-compare]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-endpoint-reads-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-endpoint-nic.png" data-lightbox="endpoint-nic">
![endpoint-nic]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-endpoint-nic.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-endpoint-nic.png" data-lightbox="endpoint-nic-compare">
![endpoint-nic-compare]({{site.baseurl}}/assets/images/posts/052-2020-browser-impact/052-2020-browser-impact-comparison-endpoint-nic.png)
</a>

Both the endpoint’s CPU and storage utilization the differences are negligible, resulting in a similar user experience.

The Bytes Total/sec counter determines how the NIC or Network Adapter performs. This counter must report high values to indicate a large number of successful transmissions.

The various browsers have a large number of succession rate. On the other hand, more CPU is required to process the data.

## Conclusion
Based on the research results of this new browser 2020, changing a browser in a VDI context indicates an improvement in both performance and user experience, resulting in a higher user density. In fact, the results of Microsoft’s Edge based Chromium indicate the best result.  On the other hand, the impact on user density can be at least 18%.

The context of this browser scenario focuses on the performance, the user experience and the impact on the user density of the browser, and not on the functions, features or security of the browser.

The constantly added features and functionalities of the newer browsers might require more computing resources. Edge shows the opposite in a positive way and is less resource-intensive.

Each browser has its advantages and disadvantages. The continuous process changes in performance can be different in each update. To avoid unexpected performance or user experiences and user density problems, continuous validation is needed.

Microsoft's new Edge approach appears to make a positive contribution to the browser area and to enterprise practice, particularly in a VDI context. It will appeal to IT professionals through its highly integrated management tools and specific focus on enterprise software. Edge aims to provide the best possible web experience as well as website compatibility and provide IT professionals with the tools they need to manage users. With Edge Chromium, IT professionals can use existing Microsoft tools to integrate and get the job done right.

Will Edge be inferior again, in terms of speed and ease of use, like IE used to be compared to its competitors? Time will tell. One thing's for sure, it's guaranteed to be a productivity advantage for enterprises. Enterprise companies need to reconsider their approach to choosing the right browser, and Edge can be a very good choice.

It is very important to validate your own browser setup or comparison in 2020, testing different configurations with tools such as LoadGen is recommended if you want to be sure you are using the best configuration in your own situation.

If you have comments about this research or want to discuss other configurations, please [join](https://worldofeuc.slack.com){:target="_blank"} us on the World of EUC Slack channel.

Photo by [Anh Tuan To](https://unsplash.com/@tuan1561?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/@tuan1561?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
