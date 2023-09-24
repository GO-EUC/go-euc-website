---
layout: post
toc: true
title:  "Performance difference of Citrix ICA Visual Quality profiles"
hidden: false
authors: [ryan]
categories: [ 'citrix' ]
tags: [ 'citrix', 'ICA', 'visual quality', 'protocol' ]
image: assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-profiles-feature-image.png
---
When delivering a virtual desktop environment, a great user experience has a huge effect on the success of your environment. There are many settings and optimization that can improve the overall performance and user experience. There are also many optimizations that can be applied within the remoting protocol. Within Citrix ICA there is a setting called Visual Quality. Which options are available and what is the effect of the various options? This research is focused on the performance difference between the Visual Quality settings within the Citrix ICA protocol.

> **Disclaimer:** These results have been affected by the Login VSI progress bar and results may be different in practice. For more information please read the following [post]({{site.baseurl}}/important-influence-of-citrix-login-vsi-on-the-results){:target="_blank"}.

## What is the Visual Quality setting?
The Visual Display section contains policy settings for controlling the quality of images sent from virtual desktops to the user device.

### Preferred color depth for simple graphics
This policy setting is available in VDA versions 7.6 FP3 and later. The 8-bit option is available in VDA versions 7.12 and later. This setting makes it possible to lower color depth at which simple graphics are sent over the network. Lowering to 8-bit or 16-bit per pixel potentially improves responsiveness over low bandwidth connections, at the cost of a slight degradation in image quality. The 8-bit color depth is not supported when the Use video codec for compression policy setting is set to For the entire screen. The default preferred color depth is 24-bits per pixel. VDAs fall back to 24-bit (default) color depth if the 8-bit setting is applied on VDA version 7.11 and earlier.

### Target frame rate
This setting specifies the maximum number of frames per second sent from the virtual desktop to the user device. By default, the maximum is 30 frames per second. Setting a high number of frames per second (for example, 30) improves the user experience, but requires more bandwidth. Decreasing the number of frames per second (for example, 10) maximizes server scalability at the expense of user experience. For user devices with slower CPUs, specify a lower value to improve the user experience. The maximum supported frame rate per second is 60.

### Visual quality
This setting specifies the desired visual quality for images displayed on the user device. By default, this setting is Medium.
To specify the quality of images, choose one of the following options:

  * Low
  * Medium – Offers the best performance and bandwidth efficiency in most use cases
  * High – Recommended if you require visually lossless image quality
  * Build to lossless – Sends lossy images to the user device during periods of high network activity and lossless images after network activity reduces. This setting improves performance over bandwidth-constrained network connections
  * Always lossless – When preserving image data is vital, select Always lossless to ensure lossy data is never sent to the user device. For example, when displaying X-ray images where no loss of quality is acceptable.

  Source: [https://docs.citrix.com/en-us/xenapp-and-xendesktop/current-release/policies/reference/ica-policy-settings/visual-display-policy-settings.html](https://docs.citrix.com/en-us/xenapp-and-xendesktop/current-release/policies/reference/ica-policy-settings/visual-display-policy-settings.html){:target="_blank"}

## Infrastructure and configuration
This research has taken place on the {{site.title}} platform which is described in the following [post]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. More information about the testing methodology is described [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}. The infrastructure components like Citrix Delivery Controller and Citrix Storefront are hosted on a separate server from the desktop pool. In this case, Citrix XenDesktop was used running Windows 10 1803 with the Citrix VDA 7.18. Each VM contains 2vCPU’s with 4GB of memory which is enough for the configured workload. The default Knowledge Worker workload is used including the small modifications as specified in the {{site.title}} infrastructure post.

There are many settings within the Citrix Policies that influence the user experience. As a base the “Very High Defenition User Experience” template is used which contains the following settings.

### Computer Policies

| Setting                 | Value    |
| :----------------------:|:--------:|
| Multimedia conferencing | Allowed  |
| Dynamic windows preview | Enabled  |
| Legacy graphics mode	  | Disabled |


### User policies

| Setting                                   | Value         |
| :----------------------------------------:|:------------:|
| Use asynchronous writes                   | Disabled     |
| Desktop wallpaper                         | Allowed      |
| Legacy graphics mode                      | Disabled      |
| Menu animation	                        | Allowed       |
| View window contents while dragging       |	Allowed     |
| Audio quality	                            | High – high definition audio |
| Flash video fallback prevention           |	Not Configured |
| Windows Media fallback prevention	        | Not Configured |
| Target minimum frame rate                 | 10 fps|
| Target frame rate	                        | 30 fps |
| Visual quality                            | High |
| Extra color compression                   |	Disabled |
| Use video codec for compression           | For the entire screen |
| Preferred color depth for simple graphics	| 24 bits per pixel |
| Auto-create client printers               | Auto-create all client printers |
| Direct connections to print servers       | Enabled |
| Universal print driver usage              | Use universal printing only if requested driver is unavailable |
| Universal printing print quality limit    | No Limit |
| Universal printing optimization defaults  | ImageCompression=BestQuality; HeavyweightCompression=False; ImageCaching=True; FontCaching=True; AllowNonAdminsToModify=False |

Within this research, we focus on the policy setting Visual Quality located in the computer section. This research consist of 4 separated scenario’s:
  * Visual Quality High using TCP, as the baseline;
  * Visual Quality Medium using TCP;
  * Visual Quality Low using TCP;
  * Visual Quality High using UDP.

For each scenario, only the policy is adjusted except for scenario 4 testing with UDP where the following UDP ports are allowed in the firewall 2598, 1494, 3224-3324. Both “Build to lossless” and “Always lossless” are not included in this phase as both options are for specific use cases.

Windows 10 image is optimized using the Citrix Optimizer with the 1803 template. During the tests Windows Defender is disabled this may influence the results with unexpected behavior. Citrix machine catalog is created using MCS in a stateless configuration using local profiles. At user logoff, the virtual machine is restored to the original state. To ensure consistent results each scenario contains 10 runs with a total time of 18 hours per scenario. All results published are an average of the 10 runs.

## The results
The primary benchmark solution is Login VSI which reports a baseline result and of course the VSImax. Results are published in percentages compared to the high scenario.

<a href="{{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As you can see there is no difference between the 4 scenarios from a Login VSI perspective. Based on the Login VSI results, the same pattern from the hypervisor perspective is expected. Results are published over time with the absolute number.

<a href="{{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-host-cpu-util.png" data-lightbox="host-cpu">
![host-cpu]({{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-host-cpu-util.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-host-reads.png" data-lightbox="host-reads">
![host-reads]({{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-host-writes.png" data-lightbox="host-writes">
![host-writes]({{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As expected there is no difference, which means increasing the visual quality has no impact on capacity.

To get an idea from the user perspective we use the tool Remote Display Analyzer to collect data from the protocol.  This is captured for each individual user. It’s important to know different users cannot be compared because the duration of the Login VSI workload is different for each user. Therefore the results published are from a single user, which is the first user that is active.

Within the Citrix ICA protocol, the metric framerate is reported. These are the number of frames per second send over the protocol from the desktop perspective. A high framerate will increase the user experience as it feels smooth. But please note, the metric is difficult to read as the amount of frames is depending on the activity within the session. When a user is idle no updated frames will be sent over the protocol.

<a href="{{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-rda-fps.png" data-lightbox="session-fps">
![session-fps]({{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-rda-fps.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-rda-fps-bar.png" data-lightbox="session-fps-compare">
![session-fps-compare]({{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-rda-fps-bar.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The results show there is no difference in the framerate in the scenarios. This has to do with the resources available within the VM which is enough for all scenarios.

Another important metric is the Round Trip Time also known as the latency. Even when the framerate is good, a high latency can kill the user experience. A high latency will result in delayed keystrokes from the endpoint to the sessions.

<a href="{{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-rda-rtt.png" data-lightbox="session-rtt">
![session-rtt]({{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-rda-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-rda-rtt-bar.png" data-lightbox="session-rtt-compare">
![session-rtt-compare]({{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-rda-rtt-bar.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The difference between the High, Medium and Low scenarios are minimal but switching to UDP result in a higher RTT. As these tests are done within the same datacenter the effect is not noticeable for a human, but in a WAN scenario, the impact can be higher. These findings are interesting as it conflicts with Citrix [publications](https://www.citrix.com/blogs/2018/01/02/improving-the-citrix-user-experience){:target="_blank"}. This may be worth to investigate further, what do you think?

During an open session, it will consume bandwidth in order to send and receive data between the session and the endpoint. Lower bandwidth will have an effect on the user experience as there is less room to send and receive information.

<a href="{{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-rda-bandwidth.png" data-lightbox="session-bandwidth">
![session-bandwidth]({{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-rda-bandwidth.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-rda-bandwidth-bar.png" data-lightbox="session-bandwidth-compare">
![session-bandwidth-compare]({{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-rda-bandwidth-bar.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The visual quality has an effect on the used bandwidth which is as expected. When using UDP there is less bandwidth consumed which confirms the best practices of Citrix.

Of course, it is also interesting to look from the endpoint perspective. Please note, a launcher hosts multiple sessions and this scenario there are 8 – 9 sessions on each launcher.

<a href="{{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-launcher-cpu-util.png" data-lightbox="launcher-cpu">
![launcher-cpu]({{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-launcher-cpu-util.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-launcher-cpu-util-bar.png" data-lightbox="launcher-cpu-compare">
![launcher-cpu-compare]({{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-launcher-cpu-util-bar.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Between the 3 scenarios, there is a minimal difference but comparing the UDP high to high there is an increase of 44% in CPU. To be clear, this is not from 8% CPU Utilization to 52% but from 8% to 12%. 44% of 8 is 3.52, which results in 12 rounded up.

From the launcher perspective, the total traffic sent through the network adapter is measured. Please note the following chart is not comparable to the ICA bandwidth as there are multiple sessions active in a single launcher and this includes traffic to the Login VSI share, Citrix Storefront etc.

<a href="{{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-launcher-nic-kbps.png" data-lightbox="launcher-nic">
![launcher-nic]({{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-launcher-nic-kbps.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-launcher-nic-kbps-bar.png" data-lightbox="launcher-nic-compare">
![launcher-nic-compare]({{site.baseurl}}/assets/images/posts/001-performance-difference-of-citrix-ica-visual-quality-profiles/001-visual-quality-launcher-nic-kbps-bar.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The difference between the High, Medium and Low scenario is minimal except for the UDP High scenario. For some reason this a 10% higher compared to the High scenario. This is unexpected behavior and may be further investigated in the future.

## Conclusion

> **Disclaimer:** These results have been affected by the Login VSI progress bar and results may be different in practice. For more information please read the following [post]({{site.baseurl}}/important-influence-of-citrix-login-vsi-on-the-results){:target="_blank"}

The Visual Quality Policy setting allows you to improve the quality of the image sent through the ICA protocol. The overall impact on capacity is none which means switching from a Low to High Visual Quality setting does not affect the overall user density on the servers. However, as there is no noticeable difference in the framerate it does have an effect on Round Trip Time and bandwidth. Using UDP result in less bandwidth send over the ICA protocol but during this research, the total traffic on the network adapter and the CPU utilization on the launcher (endpoint) increased. This is unexpected results and may require further investigation.

As some results are not as expected I hope this research provides a bit more insight into the performance impact of the Visual Quality Policy. If you have any comment or questions please leave them below.

Photo by [John Allen](https://unsplash.com/photos/QMaz1luQc24?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
