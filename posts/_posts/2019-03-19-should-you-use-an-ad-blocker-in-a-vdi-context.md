---
layout: post
toc: true
title:  "Should you use an ad blocker in a VDI context?"
hidden: false
authors: [ryan]
categories: [ 'browsers' ]
tags: [ 'adblock', 'ads', 'pfsense', 'PiHole' ]
image: assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-feature-image.png
---
Nowadays most websites use all kind of advertisements on their pages. A lot of consumers use plugins to block these advertisements but this not very common in enterprise environments. Should enterprise organizations use an ad blocker in a VDI environment? This research will cover the true performance benefit using an ad blocker in a VDI environment.

## What is an ad blocker?
For most companies, advertisements shown on their website are one of the income sources. Those companies reserve space on their website to show ads where the most times from external advertising company. The advertisements are often shown based on your browsing history and geolocation. In most cases, the companies are paid based on the number of views and refers. There are different kinds of ads like banners, pictures, animations, popups and sometimes videos.

> **Please note:** for some companies, the advertisements are the primary business model. If you want to support these companies, you should consider disabling the ads blocker on their websites

<a href="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-website-with-ad.png" data-lightbox="site-ads">
![site-ads]({{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-website-with-ad.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-website-without-ad.png" data-lightbox="site-without-ads">
![site-without-ads]({{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-website-without-ad.png)
</a>

There are multiple ways to block these advertisements where the most popular is a browser-based plugin, shown in the example above. The plugin will scan the webpage code and block all the elements from the advertisements on the website as it loaded.

Another method is central DNS based blocking from your firewall. This method will return a single pixel instead of the advertisement. From a management perspective, this might have a preference as this can be maintained centrally.

Both methods use public filter lists that remove most advertisements from international webpages, including unwanted frames, images, and objects. These are maintained dynamically ensuring new advertisements are blocked. The most common and popular filter list is from Easylist.

More information about ad blocking can be found [here](https://en.wikipedia.org/wiki/Ad_blocking){:target="_blank"}.

## Setup and scenarios
The goal of this research is to see the performance benefits when using an ad blocker in a VDI environment. This includes the following scenarios:

  * Default without any ad blocking, which is the baseline;
  * Brower based ad blocking, using ADBlock Plus;
  * Central DNS based ad blocking, using PFSense.

There are many ad blocking plugins where ADBlock Plus is one of the popular ones. In general, it is expected to see similar results as the same methods are used. In both ad blocking scenarios, the Easylist filter list is used.

Login VSI provides offline websites to simulate web-based behavior. As the advertisements in those websites are offline as well it is not possible to measure the true impact. Therefore, real websites are included in the workload using the following sites:

  * BBC.com;
  * BrianMadden.com;
  * 3 YouTube videos.

As Internet Explorer does not allow to use an ad blocker plugin the default browser has been switched to Google Chrome. The default KnowledgeWorker workload is used with some modifications to use Google Chrome and the real internet sites. This workload represents “normal” working behavior where the impact of ads can be measured besides using the default applications. When using internet content only the impact would be different. The workload and testing methodology are both described [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

This research has taken place on the {{site.title}} lab environment which is described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}.

## Expectation and results
Advertisements need to be transferred to the client and often includes animations which require resources to process. Therefore, it is expected to see an improvement in load when blocking the advertisements.

A perfect indicator to see the capacity impact is the Login VSI VSImax. The VSImax represents the sweet spot before the server reaches the saturation point. More about the VSImax can be found [here](https://www.loginvsi.com/blog-alias/login-vsi/481-calculating-maximum-virtual-desktop-capacity-vsimax-explained){:target="_blank"}.

<a href="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The VSImax shows a huge improvement when using the DNS based ad blocking with a 47% as the browser based is only an 8% improvement. The huge difference between both ad blocking scenarios is a surprise because I expected similar results.

<a href="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The baseline shows also an improvement which makes sense. The baseline is based on the lowest results where some sessions already have the browser open. As the ad blocking scenarios has less to process results in a lower baseline.

Based on the VSImax results the CPU utilization should show a similar difference.

<a href="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-cpu.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-cpu-compare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It clearly shows processing advertisements requires a lot of CPU resources. As browsers cache the website on disk there should be a difference from a storage perspective but not as huge as the CPU.

<a href="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-reads-compare.png" data-lightbox="reads-compare">
![reads-compare]({{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-reads-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-writes-compare.png" data-lightbox="writes-compare">
![writes-compare]({{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-writes-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It shows there is a small improvement but not as huge as with the CPU results, which is as expected.

As this scenario uses the internet as a source for the webpages and ads instead of static content local on the VDI it is also interesting to cover the network traffic results.

<a href="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-nic-transmitted.png" data-lightbox="nic-transmitted">
![nic-transmitted]({{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-nic-transmitted.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-nic-transmitted-compare.png" data-lightbox="nic-transmitted-compare">
![nic-transmitted-compare]({{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-nic-transmitted-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-nic-received.png" data-lightbox="nic-received">
![nic-received]({{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-nic-received.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-nic-received-compare.png" data-lightbox="nic-received-compare">
![nic-received-compare]({{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-nic-received-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It is important to understand that the network results includes all traffic which includes infrastructure traffic as well. As internet usage is a small part of everything the difference is not really noticeable. It is unclear why the DNS based blocking scenario has a higher transmit which has a huge influence on the comparison. Results are validated and showed this behavior consistently.

## Conclusion
Advertisements are integrated into almost every website and are often experienced as annoying by end users. As a lot of consumers using plugin-based blockers which is not fully adopted in the enterprise.

Even from a security perspective, it is recommended to block advertisements. The results from this research show there is huge performance improvement when blocking the advertisements centralized. Based on these results we recommend implementing this kind of ad blocking in your environment.

It is important to understand the results are based on only two websites with three YouTube video’s and could have even more effective in a production environment where more internet content is used.

The plugin-based ad blocking showed some improvements but is not as effective as the DNS based blocking. A plugin-based blocker still needs to receive and process the advertisements as this is not required using the DNS method.

<a href="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-host-nic-received-compare.png" data-lightbox="nic-received-compare">
> <div style="height: 115px;"> <img style="width: 100px; float: left; margin-right: 15px; margin-top: 15px" src="{{site.baseurl}}/assets/images/posts/018-should-you-use-an-ad-blocker-in-a-vdi-context/018-ad-blocker-erik-bakker.png"/> A special thanks to <a href="https://twitter.com/bakker_erik" target="_blank">Erik Bakker</a> as he helped out with this specific research. </div>
</a>

Want to share your thought about this topic, leave them the comments below or get involved by joining the World of EUC community at the [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Yucel Moran](https://unsplash.com/photos/XJGJh_d0y4g?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/ads?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
