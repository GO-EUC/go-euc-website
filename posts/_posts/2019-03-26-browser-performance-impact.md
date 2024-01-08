---
layout: post
toc: true
title:  "Browser Performance Impact"
hidden: false
authors: [omar]
categories: [ 'browsers' ]
tags: [ 'internet explorer', 'edge', 'firefox', 'chrome', 'browsers']
image: assets/images/posts/008-browser-performance-impact/008-brswr-feature-image.png
---
If you search for browser performance comparisons on the web, their main focus are usually the available features and performance from a physical dedicated machine. But what if the desktop is a virtual one?

Is it then worth changing a browser? A browser can make the internet easier, faster, safer and protect your privacy better. Google Chrome, Mozilla Firefox and Microsoft Edge have all improved significantly over the past years. But what is the impact in a VDI environment running one of the browsers?

This research focuses on the performance and capacity impact of the top most used browsers in a VDI environment.

## Browser introduction
Whether the use case is enterprise or consumer based, the web browser is a door to the information space we know as the internet, and they might have other uses as well. But in a VDI environment the main task of a browser is to browse the web, play videos from the web and access (enterprise) web applications.

This research goal is to show performance impact differences in a VDI environment, therefor we won’t review and compare the browser features. For more information for each specific browser feature list and comparisons, please check out the web or vendor’s website.

Choosing the right web browser can make a difference, whether the priority is faster performance or better security and if IT professionals conduct a web browser comparison for desktops, they’ll see that each browser brings something different.

Because web browsers are so integral to the end-user experience, it’s critical for IT professionals to understand what each browser offers in terms of management capabilities, security, performance, scalability and more.

The four browsers we tested are enterprise manageable. Each browser also offers a way to automatically open links and applications that are incompatible with legacy/third party, in an Internet Explorer window (aka Enterprise Mode).

From a security standpoint. Each browser support decent security features that protect you against phishing schemes and malware.

Furthermore, the tested browsers are compatible with web standards. And all four browsers are much faster and leaner than those of a few years ago and become even more so with each new build. A casual user probably won’t notice a difference in the rendering speed between today’s modern browsers.

## Infrastructure and configuration
The infrastructure used for this research is described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"} and uses {{site.title}}’s testing methodology which is posted [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}. The default workload used in GO-EUC’s testing methodology was modified for the comparisons. Instead of having multiple stand-alone browser instances open, the workload has multiple tabs open in one instance. The workloads can be downloaded below, for your reference, were “Web_Start Random” has been replaced with a “App_Start” function:

  * Workload [Microsoft Internet Explorer]({{site.baseurl}}/assets/files/008-browser-performance-impact/KnowledgeWorker__IE.txt){:target="_blank"};
  * Workload [Microsoft Edge]({{site.baseurl}}/assets/files/008-browser-performance-impact/KnowledgeWorker__Edge.txt){:target="_blank"};
  * Workload [Mozilla Firefox]({{site.baseurl}}/assets/files/008-browser-performance-impact/KnowledgeWorker__FireFox.txt){:target="_blank"};
  * Workload [Google Chrome]({{site.baseurl}}/assets/files/008-browser-performance-impact/KnowledgeWorker__Chrome.txt){:target="_blank"}.

Four different scenarios were tested:

  * Microsoft Internet Explorer, built-in OS. As baseline reference;
  * Microsoft Edge, built-in OS;
  * Mozilla Firefox Quantum, 63.0.1;
  * Google Chrome Enterprise, 70.0.3538.77.

All browsers were the most current production versions and kept at their default settings.

The tests were configured to use non-persistent desktops with Citrix Virtual Desktops (MCS), including Citrix VDA 7.18. Running Microsoft Windows 10 build 1709 with 2 vCPU, 4 GB RAM and Office 2016. Both Windows and Office are fully patched. Windows Defender was disabled, as this may influence the results with unexpected behavior.

Windows 10 was optimized with the default Citrix Optimizer 1709 template.

## The results
We tested the four most popular browsers in the enterprise area, as described above. And because Internet Explorer does not provide the feature updates, options, new tools, improvements or technology development like its competitors, the expectation is that Internet Explorer uses less resources in comparison. However, patches and updates are continually available for Internet Explorer.

The VSImax value refers to user capacity.

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-vsimax.jpg" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-vsimax.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

Compared to Internet Explorer, Firefox has the lowest impact on user capacity. Chrome has the highest impact with 8% less user capacity.

### Host CPU usage
Based on the VSImax results, the expectation is that the modern browsers will consume more CPU compared to Internet Explorer.

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-cpu.jpg" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-cpu.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-cpu-bar.jpg" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-cpu-bar.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As expected, Internet Explorer is the most efficient in CPU utilization and has the highest user capacity number. All scenarios correspond with the VSImax results.

### Host Memory usage
The memory footprint or consumption is also a very important key metric when comparing browsers.

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-memory.jpg" data-lightbox="memory">
![memory]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-memory.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-memory-bar.jpg" data-lightbox="memory-compare">
![memory-compare]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-memory-bar.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

Browsers can have either massive or frugal use of memory, even with multiple tabs open. The results show that Internet Explorer is also the most efficient in memory usage and demands less of your memory than equivalent pages would on Chrome or Firefox. Edge is the heaviest browser in terms of memory usage, so it’s not the best choice on machines with limited memory.

### Host Disk IO usage
On a physical device, e.g. dedicated machine, the browser disk usage is usually not affected that much or barely even noticed from the user’s perspective (newer devices). However, when sharing the disk usage over multiple desktops, it’s very important for VDI to use storage in the most efficient way to optimize virtual desktop performance and user experience.

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-cmds.jpg" data-lightbox="commands">
![commands]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-cmds.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Both Internet Explorer and Edge show similar overall disk usage trends. Firefox has a small increase of ~1.000 commands compared to Internet Explorer and Edge. While Chrome has a huge increase of at least ~5.500 commands. Only looking at the overall disk usage, such as the total commands, wont specifically show whether it’s a read or write command that causes the differences measured.

Now it is really interesting and important to compare and see which specific disk command, read versus write, causes those differences.

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-reads.jpg" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-reads.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Chrome shows that from 19 minutes in the workload the reads per second starts to increase and the trend seems to continue throughout the workloads run duration. Whereas Internet Explorer and Edge both match the total commands measured. Firefox measures a small rising trend, but this still doesn’t match the total commands measured, also the case with Chrome. This means that both Chrome and Firefox’s write footprint must be higher compared to Internet Explorer and Edge.

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-writes.jpg" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-writes.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Check and confirmed. As expected, we see similar solid stable disk usage trends and results from both Microsoft products. Firefox measures more writes then reads, Chrome has the same write footprint as Firefox but shows a clear impact when it comes to read activity.

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-disk-bar.jpg" data-lightbox="storage-compare">
![storage-compare]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-disk-bar.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Microsoft browsers show better storage utilization trends. Firefox comes in a solid second place, while Chrome has the biggest impact in reads with 129%. Both Firefox and Chrome show more write activities, at least 20% more compared to Microsoft.

### Host Network usage
Internet data, whether in the form of a web page, a downloaded file or an e-mail message, travels over a system known as a packet-switching network. Each data package, called a packet, is then sent off to its destination via the best available route. So, without a network a browser is useless, therefore it is interesting to see the network utilization from a browser perspective.

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-packetsreceived.jpg" data-lightbox="nic-received">
![nic-received]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-packetsreceived.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-packetstransmitted.jpg" data-lightbox="nic-transmitted">
![nic-transmitted]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-packetstransmitted.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

All browsers roughly receive the same number of packets. But Edge stands strong transmitting packets. 34% more transition compared to Internet Explorer.

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-network-bar.jpg" data-lightbox="nic-compare">
![nic-compare]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-network-bar.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

### Launcher CPU usage
Another key metric when comparing browsers is the usage from the endpoint’s perspective. Because in the case where the endpoint is resource constrained, can result in a significant reduction in user experience. The endpoint runs multiple sessions, whereas a regular endpoint in a business scenario will typically only launch a single session.

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-launchercpu.jpg" data-lightbox="launcher-cpu">
![launcher-cpu]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-launchercpu.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-launchercpu-bar.jpg" data-lightbox="launcher-cpu-compare">
![launcher-cpu-compare]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-launchercpu-bar.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Both Firefox and Chrome are more efficient in CPU utilization in comparison to Internet Explorer, whereas Edge has the highest impact on the endpoints.

### Launcher Network usage
The following graph shows how the endpoints network usage is with the different browser workloads.

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-launchernetwork.jpg" data-lightbox="launcher-nic">
![launcher-nic]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-launchernetwork.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-launchernetwork-bar.jpg" data-lightbox="launcher-nic-compare">
![launcher-nic-compare]({{site.baseurl}}/assets/images/posts/008-browser-performance-impact/008-brswr-launchernetwork-bar.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It clearly looks like Edge’s 13% impact on the endpoint’s CPU usage, shown in the Launcher’s CPU usage graphs, overlaps with the endpoints network usage. Meaning, more CPU is required to process the data.

## Conclusion
Based on this research test results, changing a browser shows a measurable performance decrease. In this specific scenario with the modified Login VSI workload, the impact on user capacity can be at least 8%. This context focuses only on the browser’s performance and user capacity impact, and not the user experience, the browsers features or security.

The continuously added features and functionalities of browsers require more compute resources in comparison to Internet Explorer. While each browser has its pros and cons, the conclusion is that the newer browsers are more resource intensive in comparison. The continuously process changes in performance may be different in each update. And to avoid unexpected performance or user capacity issues, continuously validation is required.

Google Chrome is the heaviest in terms of compute consumption. Chrome has the greatest impact in CPU and disk utilization, which results in 8% less user capacity in the VDI environment. Chrome gains some wins on network consumption and performance best when it comes to endpoint usage.

Firefox is giving a tough fight to Chrome and is more efficient in CPU and memory utilization. Firefox has the highest user capacity number compared to Chrome and Edge.

Edge is the heaviest browser in terms of memory and endpoint usage. Edge gains some wins in CPU terms.

Internet Explorer scores best in terms of scalability and performance but does not provide the features, options and improvements like its competitors. It only exists today because some companies need it for legacy applications or even third-party applications, including some of Microsoft’s own applications.

Last but not least, it is very important to validate your own browser setup, testing different configurations with tools like Login VSI is advisable if you want to be sure that you use the best configuration in your own situation.

If you have comments about this research or want to discuss other configurations, please [join](https://worldofeuc.slack.com){:target="_blank"} us on the World of EUC Slack channel.

Photo by [Florian Olivo](https://unsplash.com/photos/4hbJ-eymZ1o?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/html?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
