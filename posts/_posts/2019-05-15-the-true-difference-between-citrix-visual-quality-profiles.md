---
layout: post
toc: true
title:  "The true difference between Citrix Visual Quality profiles"
hidden: false
authors: [ryan]
categories: [ 'citrix' ]
tags: [ 'citrix', 'visual quality', 'allways lossless', 'build to lossless', 'VDA' ]
image: assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-feature-image.png
---
The visual quality of a Citrix session has a huge influence on the user experience. Last year we published a research about the Citrix visual quality profiles with interesting results. This research is an updated version covering the true difference between the Citrix visual quality profiles including always lossless and build to lossless.

## Reflecting on previous research
Last year in September, the first research about the [visual quality profiles]({{site.baseurl}}/performance-difference-of-citrix-ica-visual-quality-profiles){:target="_blank"} had been published. There are a couple of reasons to redo the same research. The first research focused on the main settings, Low, Medium, High, and High with EDT. Both Always lossless and Build to lossless were not included to keep the scope of the research small. The new research allows us to include other options to provide a complete overview.

An additional reason to redo this research is because due to the recent discoveries of Citrix and Login VSI, which are explained [here]({{site.baseurl}}/important-influence-of-citrix-login-vsi-on-the-results){:target="_blank"}. Although the Citrix VDA version is the same for all scenarios it is important to validate the results to ensure the previous conclusions remain the same. This also allows to validate the results using a more recent Citrix VDA version.

## What is the visual quality setting?
The visual quality setting is a Citrix user policy that allows controlling the quality of the images sent from the virtual desktop to the user device. There are five different visual quality settings:

  * Low;
  * Medium – Offers the best performance and bandwidth efficiency in most use cases;
  * High – Recommended if you require visually lossless image quality;
  * Build to lossless – Sends lossy images to the user device during periods of high network activity and lossless images after network activity reduces. This setting improves performance over bandwidth-constrained network connections;
  * Always lossless – When preserving image data is vital, select Always lossless to ensure lossy data is never sent to the user device. For example, when displaying X-ray images where no loss of quality is acceptable.

For more information please see the Citrix documentation site: [https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/policies/reference/ica-policy-settings/visual-display-policy-settings.html](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/policies/reference/ica-policy-settings/visual-display-policy-settings.html){:target="_blank"}

## Infrastructure and configuration
This research has taken place on the {{site.title}} infrastructure which is described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. Windows 10 1809 was used with the Citrix Optimizer optimization using the default Windows 10 1809 template by Citrix. The default VM configuration is 2vCPU with 4GB of memory. The desktops are running Citrix VDA 1811.1 with Microsoft Office 2016. Besides the visual quality policies, there are no other Citrix policies configured which mean all settings are default.

This research includes the following scenarios:

Visual quality medium, used as the baseline;
Visual quality low;
Visual quality high;
Visual quality high with EDT;
Visual quality always lossless;
Visual quality build to lossless.
More information about Citrix Enlightened Data Transport (EDT) can be found [here](https://docs.citrix.com/en-us/xenapp-and-xendesktop/7-15-ltsr/technical-overview/hdx/adaptive-transport.html){:target="_blank"}. This research is done using our standard testing methodology which is described detail right [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Expectations and results
Previous research shows us the server capacity is not affected by using the different quality profiles. It is expected to see some effect of both always lossless and build to lossless from a capacity perspective. There should be a noticeable difference in the protocol and launcher perspective.

To get an idea of the impact on capacity and overall responsiveness within the session the metrics VSImax and baseline are used which are provided by Login VSI. More information and details about the VSImax and baseline can be found [here](https://www.loginvsi.com/documentation/index.php?title=Login_VSI_VSImax){:target="_blank"}.

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It is good to see similar results compared to previous research. As expected, there is a slight drop in capacity using the always lossless and build to lossless quality setting. This is as expected as both settings send by default lossless images to the client device. The baseline shows the responsiveness within the session remains the same. Please note, these measurements are done within the desktops and do not include the quality of the remoting protocol.

Let’s validate these resulting using other metrics from the host perspective.

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-host-cpu.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-host-cpu-compare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It shows the capacity is affected by the CPU resources confirming the VSImax results.

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-host-storage-compare.png" data-lightbox="storage-compare">
![storage-compare]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-host-storage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There is no difference from a storage perspective which is as expected. As all information is sent over the protocol the images are processed by CPU and not stored on disk.

To see the difference from a protocol perspective the tool Remote Display Analyzer is used. A key metric from a protocol perspective is the frames per second, also known as FPS. These are the number of images send over the protocol. A high amount of FPS generally results in a smooth experience but please note, from a protocol perspective it is a difficult metrics as it is depended on the amount of activity within the session.

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-fps.png" data-lightbox="fps">
![fps]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-fps.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-fps-compare.png" data-lightbox="fps-compare">
![fps-compare]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-fps-compare.png)
</a>

The results show small differences between the scenarios except for build to lossless which has a consistent higher FPS during the entire workload.

In order to send the image of the protocol, it needs to be processed. This encoding process takes CPU resources. Please note, the following chart only contains the CPU usage for the encoding process.

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-cpu.png" data-lightbox="cpu-encoding">
![cpu-encoding]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-cpu-compare.png" data-lightbox="cpu-encoding-compare">
![cpu-encoding-compare]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It is clear both always lossless and build to lossless requires more CPU to encode the images. This is especially true in the multimedia section. Using GPU technology may reduce the encoding on the CPU as these tasks can be offloaded to GPU.

The round trip time (RTT), which is also known as latency will have an effect on the user experience. A high RTT will result in a delayed response which is also known as lag.

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-rtt.png" data-lightbox="rtt">
![rtt]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-rtt-compare.png" data-lightbox="rtt-compare">
![rtt-compare]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-rtt-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The RTT shows a similar pattern as the previous metric were both always lossless and build to lossless have a higher RTT. Nowadays bandwidth should not be a real problem with the capacity in the modern world. Scenarios like branch offices come often with a lower bandwidth which makes this very important.

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-bandwidth.png" data-lightbox="bandwidth">
![bandwidth]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-bandwidth.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-bandwidth-compare.png" data-lightbox="bandwidth-compare">
![bandwidth-compare]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-rda-bandwidth-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Results show there is a difference in each scenario but again both always lossless and build to lossless will consume more bandwidth. Now consuming more bandwidth is not a bad thing, it shows it will consume the available bandwidth to provide the most optimal quality. But it is clear in a WAN scenario where the bandwidth is limited both are not the best option.

Last research showed some important results from the launcher perspective, which reflects the endpoint. The most important metric is the CPU as the images require to be decoded on the endpoint to receive the images.

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-launcher-cpu.png" data-lightbox="launcher-cpu">
![launcher-cpu]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-launcher-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-launcher-cpu-compare.png" data-lightbox="launcher-cpu-compare">
![launcher-cpu-compare]({{site.baseurl}}/assets/images/posts/027-the-true-difference-between-citrix-visual-quality-profiles/027-visual-quality-launcher-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It is interesting to see the high scenario requires less CPU compared to the medium. Like previous research using EDT requires more CPU which is again confirmed in this research. For both always lossless and build to lossless it requires way more endpoint CPU resources. It is important to take this in account especially when using Thin Clients which often come with fewer resources.

## Conclusion
The visual quality can be controlled using a Citrix policy which will control the quality of the image, which is sent over to the connecting device, also known as the endpoint.

The recommended way from Citrix is to leave the settings by default depending on the scenario as mentioned in the following post.

> **Do I need to deliver 3D/CAD-style workloads?**
>
> No: Don’t set any graphics policies — leave everything at their defaults (I know that might be difficult for some of you who love to know what all the knobs and buttons do!).”
>
> Yes: set the “Visual Quality” policy to “Build to Lossless”.
>
> Source: [https://www.citrix.com/blogs/2018/10/02/what-graphics-policies-do-i-need-and-when/](https://www.citrix.com/blogs/2018/10/02/what-graphics-policies-do-i-need-and-when){:target="_blank"}

The default visual quality setting from Citrix VDA version 7.18 and up is medium.

Comparing to previous research there are some differences. In general, the conclusion remains the same but using a recent VDA without the Login VSI progress bar shows some differences in the amount of FPS send over the protocol.

Results don’t show a clear and each visual quality settings applies to a different use-case. It does show there is a small change in the overall capacity using always lossless and build to lossless. The difference becomes clear in the protocol data but also on the endpoint.

Both always lossless and build to lossless shows a clear distinction compared to the other options. It shows these qualities consumes more resources from both the VDI resources and endpoint. Therefore, it is important to validate the impact when applying these options.

In this research using EDT did not show a clear benefit. This may have a more positive effect in a real world or WAN scenario as our connections are within the datacenter without any bandwidth constraints.

What do you use within your environment? Share them in the comments below or start the conversation at the [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Agence Olloweb](https://unsplash.com/photos/9wYdW55NbnY?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/lens?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
