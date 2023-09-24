---
layout: post
toc: true
title:  "Maximizing server scalability with Citrix Policy templates"
hidden: false
authors: [eltjo]
categories: ['citrix']
tags: [ 'citrix', 'ICA', 'RDA' ]
image: assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-feature-image.png
---
Citrix delivers XenApp and XenDesktop with several built-in policy templates that can be used as a starting point for setting up the polices in a XenApp or XenDesktop deployment. These policy templates can be used to optimize the environment and the user experience.

As Ryan concluded in his research post “Performance difference of Citrix ICA Visual Quality profiles”, the impact of a high user setting on the Server side scalability is negligible.

> The Visual Quality Policy setting allows you to improve the quality of the image sent through the ICA protocol. The overall impact on capacity is none which means switching from a Low to High Visual Quality setting does not affect the overall user density on the servers.
>
> Source: [{{site.baseurl}}performance-difference-of-citrix-ica-visual-quality-profiles/]({{site.baseurl}}performance-difference-of-citrix-ica-visual-quality-profiles){:target="_blank"}

But what if wanted to boost server side scalability? How much would using the built in Citrix policy template “High server scalability” gain us in terms of user density per server?

This blog post explores the performance differences between the two Citrix supplied policy templates “Very high definition user experience” and “High Server scalability”.

> **Disclaimer:** These results have been affected by the Login VSI progress bar and results may be different in practice. For more information please read the following [post]({{site.baseurl}}/important-influence-of-citrix-login-vsi-on-the-results){:target="_blank"}.

## Testing scenario
We suspected that the “Use videocodec for compression” within the HDX Graphics Encoder policy setting would have the biggest impact on the server side scalability. This settings is enabled by default, and with the “Very high definition user experience” policy template, but is disabled in the “High Server scalability” policy template.

<a href="{{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-policy-codec-compression.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-policy-codec-compression.png)
</a>

In order to confirm that theory we’ve tested three scenario’s:

  * The first run will be our default run. A scenario without a template and therefore with all settings kept on default;
  * The second run will be a similar run to the on in Ryan’s post with the “Very high definition user experience” template policies;
  * Thirdly we tested the “High Server scalability” policy template.

### Very High Definition User Experience Policy Template
This template is provided to ensure maximum user experience. A close look at this template shows it enforces default values except “High visual quality” and “Best Quality printing”, which set these values higher than the default.

#### Computer policies

| Setting                 | Value    |
| :---------------------: | :------: |
| Multimedia conferencing | Allowed  |
| Dynamic windows preview | Enabled  |
| Legacy graphics mode    | Disabled |

#### User policies

| Setting | Value |
| :-----: | :---: |
| Use asynchronous writes | Disabled |
| Desktop wallpaper | Allowed |
| Menu animation | Allowed |
| View window contents while dragging | Allowed |
| Audio quality | High – high definition audio |
| Flash video fallback prevention | Not Configured |
| Windows Media fallback prevention | Not Configured |
| Target minimum frame rate | 10 fps |
| Target frame rate | 30 fps |
| Visual quality | High |
| Extra color compression | Disabled |
| Use video codec for compression | For the entire screen |
| Preferred color depth for simple graphics | 24 bits per pixel |
| Auto-create client printers | Auto-create all client printers |
| Direct connections to print servers | Enabled |
| Universal print driver usage | Use universal printing only if requested driver is unavailable |
| Universal printing print quality limit | No Limit |
| Universal printing optimization defaults | ImageCompression=BestQuality; HeavyweightCompression=False; ImageCaching=True; FontCaching=True; AllowNonAdminsToModify=False |

On a side note: the very high user definition template will require a recent version of the Citrix Receiver (or it’s latest iteration, the Citrix workspace app) otherwise the settings in the template may have an inverse effect on the performance.

### High Server Scalability template
This template balances user experience and server scalability. It offers a good user experience while increasing the number of users you can host on a single server. In comparison to the “Very high definition user experience” policy template, this template does not use video codec for compression of graphics and prevents server side multimedia rendering.

#### Computer policies

| Setting                 | Value    |
| :---------------------: | :------: |
| Multimedia conferencing | Prohibited |

#### User policies

| Setting | Value |
| :-----: | :---: |
| Desktop wallpaper | Prohibited |
| Menu animation | Prohibited |
| View window contents while dragging | Allowed |
| Audio quality | Medium – optimized for speech |
| Flash video fallback prevention | Only small content |
| Flash video fallback prevention error *.swf | http://domainName.tld/samplePath/error.swf |
| Optimization for Windows Media multimedia redirection over WAN | Prohibited |
| Windows Media fallback prevention | Play all content only on client |
| Target minimum frame rate | 8 fps |
| Target frame rate | 16 fps |
| Visual quality | Medium |
| Extra color compression | Disabled |
| Use video codec for compression | Do not use video codec |
| Framehawk display channel | Disabled |
| Auto-create client printers |Auto-create the client’s default printer only |
| Universal print driver usage | Use universal printing only |
| Universal printing optimization defaults |ImageCompression=StandardQuality; HeavyweightCompression=False; ImageCaching=True;
FontCaching=True; AllowNonAdminsToModify=False |

## Defining a user density score
In addition to other metrics outlined below, the first metric that we use to benchmark the user densitity is the Login VSI VSImax score. The VSImax the defacto industry standard metric and is a calculated score to determine the saturation point of the VDI environment. The saturation point (VSImax) is defined as the session count before the threshold was reached.

More information about the VSImax can be found on the [Login VSI website](https://www.loginvsi.com/blog-alias/login-vsi/481-calculating-maximum-virtual-desktop-capacity-vsimax-explained){:target="_blank"}.

<a href="{{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

When looking at the VSImax result in the graph please note that the conclusion shows a somewhat distored picture as we reached VSImax with the “Very high definition user experience” template at 69 session, but VSImax was not reached with the “High Server scalability” template. This means we could have fit more VDI’s on the host before saturation with the “High Server scalability” template.

<a href="{{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-host-cpu-util.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-host-cpu-util.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Compared to the “Very high definition user experience” template both the Default settings and the “High Server scalability” template show a 10 and 11 percent drop in host CPU usage. This is the benefit of using the “High Server scalability” instead over the “Very high definition user experience” template in terms of user density. A lower overall CPU host usage means that we can fit more VDI’s on the host and thus increase the userdensity of the host.

A congested CPU will lower the consolidation ratio and can degrade the overall of performance of the host resulting in a reduced user experience.

<a href="{{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

In the reads per second metric the “Very high definition user experience” template show a considerable increase that is not mirrored in the writes per second metric. For the writes per second the data for the “Very high definition user experience” is almost to the default settings scenario and the “High Server scalability” template. Futhermore the reads per second data measured across all 10 runs in the scenario “Very high definition user experience” is not consistent.

Because these two metrics cannot be reconciled with each other, this has to be investigated furhter to find out more about what caused this particular aspect of the scenario.

<a href="{{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-rda-fps.png" data-lightbox="fps">
![fps]({{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-rda-fps.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-rda-fps-bar.png" data-lightbox="fps-compare">
![fps-compare]({{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-rda-fps-bar.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The Frames per second metric show a clear increase in FPS and average PFS both the default scenario and the “Very high definition user experience” template compared to the “High Server scalability” template.

<a href="{{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-rda-encoding.png" data-lightbox="cpu-encoding">
![cpu-encoding]({{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-rda-encoding.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As predicted (and inline with the FPS metrics), the CPU usage for encoding is significantly higher when using the “Very high definition user experience” template, due to the fact that the CPU has encode the H2.64 stream that is send to the client. Also the minimum and target framerate are configured higher than with the default settings scenario and the “High Server scalability” policy template.

Arround 41 minutes into the scenario videocontent will be played and in consequence the CPU for Encoding shows in increase in both the default settings scenario as wel as with the the “Very high definition user experience” template.

Moreover the “Very high definition user experience” template is configured to use the “For the entire screen” encoding method, while the default in XenDesktop 7.15 is to use “For actively chancing regions”.

Interestingly the bandwith metrics show a contrasting result:

<a href="{{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-rda-bandwidth.png" data-lightbox="bandwidth">
![bandwidth]({{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-rda-bandwidth.png)
</a>

Here the “High Server scalability” has the highest overall bandwidth usage.

We suspect that this had to do with the fact that bitmap caching is used with the “High Server scalability” policy template and the H.264 encoding  used in the other two scenario’s was more efficient with bandwidth.

The bandwith spike at the 20 minute mark is the point in the workload where Powerpoint is started, slides are added and there is a lot of scrolling through the generated presentation.

The ICA round trip time (RTT) is another important measurement for the user experience and is defined by Citrix as:

> The elapsed time from when the user hits a key or mouse button until the response is displayed back at the end point.

This metric can be thought of as a measurement of the screen lag that a user experiences while interacting with an application hosted in the VDI environment. A high RTT equals a high latency and this will negatively affect the user experience.

<a href="{{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-rda-rtt.png" data-lightbox="rtt">
![rtt]({{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-rda-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The ICA Round trip time spike around the 44 minute mark with the “Very high definition user experience” template, is most likely due to the videocontent being played at that time in the scenario, but on average the ICA RTT with the “Very high definition user experience” template has the highest ICA RTT with average an increase of 30% compared to the default settings. Surprisingly the “High Server scalability” template also incurs an 20% increase in the ICA RTT compared to the same default settings.

<a href="{{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-launcher-cpu-util.png" data-lightbox="launcher-cpu">
![launcher-cpu]({{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-launcher-cpu-util.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

In comparison to the “High Server scalability” template, switching to the “Very high definition user experience” policy template has a 40% CPU impact on the endpoints. Even compared to the default settings there is a 30% CPU penalty in comparison to the “High Server scalability” template.

Keep in mind that the launchers in these scenario’s start multiple sessions each, whereas a regular endpoint in a business scenario will typically only launch a single session.

High CPU usage on the endpoint can have a significant impact as this will result in a busier endpoint. And in the case where the endpoint is resource constrained will result in a significant reduction in user experience.

## Conclusion
When using the “High Server scalability”  instead of the “Very high definition user experience” policy template, the overall impact as measured in the VSImax score, there is a 6,7% increase in server scalability at the cost of a diminished user experience.

<a href="{{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-conclusion.png" data-lightbox="conclusion">
![conclusion]({{site.baseurl}}/assets/images/posts/003-maximizing-server-scalability-with-citrix-policy-templates/003-ctx-scalability-conclusion.png)
</a>

The host CPU statistics confirm these findings and show, on average, that there is a 11 percent drop in the hosts CPU usage with the “High Server scalability”  policy template. Most likely the difference will be in the CPU encoding of the h.264 encoding. We’ll dive into that in a follow up post in the near future (see “What’s next” for more details).

Daniel Feller did a similar test back in 2016 with XenDesktop 7.7 and Windows 10 and concluded a 7 to 8% increase in user density between the two tested templates: [here](https://virtualfeller.com/2016/01/27/xendesktop-7-7-and-windows-10){:target="_blank"}, whereas our research show a slighly higher impact on the hosts.

The biggest differences though are seen on the endpoints. Here there is drop of 40 percent when switching from the “Very high definition user experience” to the “High Server scalability” policy template. In the case where the resource on the endpoint are limited or constrained, this will significantly impact the user experience in a negative fashion.

To sum up, in an environment where performance is key it might be worth sacrificing the user experience in order to achieve maximum user density at the cost of a diminished experience for the end user. When sizing the endpoint in the cases where a high user experience is required, always investigate and continuously monitor the sizing in order to make sure the endpoints are not undersized.

## What’s next

> **Disclaimer:** These results have been affected by the Login VSI progress bar and results may be different in practice. For more information please read the following post.

The results warrant some additional research. As we concluded we suspect the h.264 encoding to be the biggest consumer of CPU resources on the VDI’s. We can put that theory to the test by running an additional test with the “High Server scalability” Policy template with the “Use video codec for compression” setting enabled, or run test with the “Very high definition user experience” policy template with the setting turned off.

Also we ran these scenario’s with XenDesktop 7.15 CU2. Citrix has stated in a post that from version 7.18 and onward, you’re best off leaving all settings to the default, and let the system dynamically deceide what to use:

> “Do I need to deliver 3D/CAD-style workloads?”
>
> No: Don’t set any graphics policies — leave everything at their defaults (I know that might be difficult for some of you who love to know what all the knobs and buttons do!).
>
> Source: [https://www.citrix.com/blogs/2018/10/02/what-graphics-policies-do-i-need-and-when/](https://www.citrix.com/blogs/2018/10/02/what-graphics-policies-do-i-need-and-when){:target="_blank"}

For questions you can always reach out or leave a comment below.

Photo by [Victor Rodriguez](https://unsplash.com/@vimarovi?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/train-new-york?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
