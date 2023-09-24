---
layout: post
toc: true
title:  "Citrix Policy Templates"
hidden: false
authors: [eltjo]
categories: [ 'citrix' ]
tags: [ 'citrix', 'policy', 'template' ]
image: assets/images/posts/031-citrix-policy-templates/031-citrix-policy-feature-image.png
---
Citrix ships Citrix Virtual Apps and Desktops (CVAD) with several built-in policy templates that can be used as a starting point for setting up the polices in a CVAD environment. These policy templates can be used to optimize the environment and user experience. When using these templates, it is important to have a solid insight into the performance and scalability impact of these templates.

This post serves as an updated version to the original post, revised with the new insights.

Back in 2018, we published a prior research about the impact of these different Citrix scalability templates.
Following the Login VSI post mention [here]({{site.baseurl}}/important-influence-of-citrix-login-vsi-on-the-results){:target="_blank"}, that research was also impacted by the Login VSI progress bar. This also gave us the opportunity to update the research with a new Windows 10 build and VDA version.

## Configuration and infrastructure
Since the original post, the infrastructure used was updated with the latest Windows 10 updates and the VDA versions.

Below is a breakdown of the components that have been changed since the original post:

| Original post                         | Updated post                               |
| :-----------------------------------: | :----------------------------------------: |
| Windows version 10 build 1709	        | Windows version 10 build 1809              |
| VDA version 7.15 CU2	                | VDA version 7 1811                         |
| Full Login VSI Progress bar visible   | Login VSI modification on the progress bar |

More information on the testing platform can be found [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. For more insights into the testing methodology please review the following [post]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

The built-in Citrix scalability templates can be used as a starting point to configure the Citrix Virtual Apps and Desktops environment for specific uses cases. More information about all the different built-in template can be found [here](https://docs.citrix.com/en-us/advanced-concepts/implementation-guides/hdx-policy-templates.html){:target="_blank"}.

In this research, just like in the original post, we’ve focused on the ‘High Server Scalability’ policy template and the ‘Very High Definition User Experience’ policy template. Both represent two opposite sides of the spectrum; the ‘High Server Scalability’  template focuses on maximizing the server’s scalability while the ‘Very High User Definition’ template will ensure maximum user experience.

Other built-in templates include templates for the Legacy OSes running Windows 2008 R2 and Windows 7 and older, and templates that optimize for the environment for endpoints in remote locations for instance.

The policy templates set the values below as following:

| Setting | Default value | High Server Scalability | Very High User Definition Experience |
| :-----: | :-----------: | :---------------------: | :----------------------------------: |
| Multimedia conferencing | Allowed | Prohibited | Allowed |
| Dynamic windows preview | Enabled | Not Configured | Enabled |
| Legacy graphics mode | Disabled | Not Configured | Disabled |
| Use asynchronous writes | Disabled | Not Configured | Disabled |
| Desktop wallpaper | Allowed | Prohibited | Allowed |
| Menu animation | Allowed | Prohibited | Allowed |
| View window contents while dragging | Allowed | Allowed | Allowed |
| Audio quality	| High – High definition audio | Medium – optimized for speech | High – high definition audio |
| Flash video fallback prevention | Not Configured | Only small content | Not Configured |
| Flash video fallback prevention error *.swf | http://domainName.tld/samplePath/error.swf | http://domainName.tld/samplePath/error.swf | Not Configured |
| Optimization for Windows Media multimedia redirection over WAN | Allowed | Prohibited | Not Configured |
| Windows Media fallback prevention | Not Configured | Play all content only on client | Not Configured |
| Target minimum frame rate | 10 fps | 8 fps | 10 fps |
| Target frame rate | 30 fps | 16 fps | 30 fps |
| Visual quality | Medium | Medium | High |
| Extra color compression | Disabled | Disabled | Disabled |
| Use video codec for compression | Use when preferred | Do not use video codec | For the entire screen |
| Framehawk display channel | Disabled | Disabled | Not Configured |
| Preferred color depth for simple graphics | 24 bits per pixel | Not configured | 24 bits per pixel |
| Auto-create client printers | Auto-create all client printers | Auto-create the client’s default printer only | Auto-create all client printers |
| Direct connections to print servers | Enabled | Not Configured | Enabled |
| Universal print driver usage | Use universal printing only if requested driver is unavailable | Use universal printing only | Use universal printing only if requested driver is unavailable |
| Universal printing print quality limit | No Limit | Not configured | No Limit |

The main difference for the templates is in the video codecs used. The default settings ‘Use video codec for compression’ is ‘Use when preferred’:

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-usevideocodecforcompression.png" data-lightbox="use-videocodec-for-compression">
![use-videocodec-for-compression]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-usevideocodecforcompression.png)
</a>

If ‘Use when preferred’ is selected, the system dynamically decides on which codec to use, based on various factors. The results may vary between versions as the selection method is enhanced by Citrix with each consequent VDA release.

The ‘High Server Scalability’ template, on the other hand, does not use a video codec. In this case, a combination of still image compression and bitmap caching is used. ‘Do not use’ is generally applied to environments where there is a need to optimize for server CPU load and for cases that do not have a lot of server-rendered video or other graphically intense applications.

The ‘Very High Definition User Experience’ template is based on the default settings except for the ‘Visual Quality’ settings and the ‘Video codec for compression’. For an in-depth look into the impact with using the Visual Quality settings please review the corresponding research [here]({{site.baseurl}}/the-true-difference-between-citrix-visual-quality-profiles){:target="_blank"}.

With the ‘Very High Definition User Experience’ policy template, the codec is set to ‘For the entire screen’. Here the video codec will be applied as the default codec for all content (some small images and text can be optimized and sent losslessly).

## The results
As is customary in our posts the first metric that we report on is the Login VSI VSImax.

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

Right off the bat, and just like in the original post, the ‘High Server Scalability’ template delivers on its name and shows a 10 percent increase in scalability, whereas using the Very High Definition User Experience’ template, you will be delivering the best user experience for your users, but at a cost: a 16% decrease in server scalability.

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As we can see from the Login VSI Baseline there is no huge deviation in the overall responsiveness of the sessions.

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-hostcpu.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-hostcpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-hostcpu-comparison.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-hostcpu-comparison.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The Host CPU metrics confirm the Login VSI VSImax numbers by showing a decrease in CPU utilization for the ‘High Server Scalability’ template and, as expected, an increase in CPU utilization for the Very High Definition User Experience’ template. The high server scalability is the most frugal in terms of CPU consumption.

From 40 minutes and on for the ‘Very High Definition User Experience’ template, the Host CPU is congested (a state where the Hosts CPU is nearing 100% CPU usage) which will impact the other metrics, especially the protocol metrics such as RTT, as well. This will have a negative impact on the overall user experience. In order to cancel out this aspect for the other metrics, we will also report the metrics of the first 20 minutes of the workload, where no host saturation has occurred yet.

In the original post, we had some strange results for the storage metrics. For the updated runs the data is more consistent.

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-hostreads-comparison.png" data-lightbox="reads-compare">
![reads-compare]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-hostreads-comparison.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-hostwrites-comparison.png" data-lightbox="writes-compare">
![writes-compare]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-hostwrites-comparison.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-hostcommands-comparison.png" data-lightbox="commands-compare">
![commands-compare]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-hostcommands-comparison.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The storage load of the ‘High Server Scalability’ template when comparing the storage metrics is significantly lower than both other scenarios. As the writes are roughly equal, we can attribute this to the lower reads on the storage subsystem. The drop in the reads per seconds is unexplained as of yet.

### Protocol metrics
Within the Citrix ICA protocol, the metric framerate is reported. These are the number of frames per second send over the protocol from the desktop perspective. In general, a higher framerate will increase the user experience as this makes the experience smoother.

Consider that we applied the modification to the VSI progress bar as explained [here]({{site.baseurl}}/important-influence-of-citrix-login-vsi-on-the-results).

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-fps.png" data-lightbox="fps">
![fps]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-fps.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-fps-comparison.png" data-lightbox="fps-compare">
![fps-compare]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-fps-comparison.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-cpuforencoding.png" data-lightbox="cpu-encoding">
![cpu-encoding]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-cpuforencoding.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-cpuforencoding-comparison.png" data-lightbox="cpu-encoding-compare">
![cpu-encoding-compare]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-cpuforencoding-comparison.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The FPS and CPU for Encoding metrics that are shown above are not comparable to the original post, due to the fact that we hide Login VSI progress bar during the tests in this updated research. Overall this will result in a lower average FPS count across the whole duration of the workload.

When using the ‘Very High Definition User Experience’ template the minimum and target framerate are configured higher compared to the default settings and the ‘High Server Scalability’ policy template, with resp. 10 and 30 FPS compared to 8 and 16 FPS in the other two scenarios.

This all means that when we look at the CPU for Encoding, which is defined as ‘The time that the Hosts CPU is busy with encoding the video output that will be sent to the client’, the metric shows a massive increase of 170% when using the ‘Very High Definition User Experience’ template.  As stated earlier, the ‘Very High Definition User Experience’ template set the ‘video codec for compression’ setting to ‘For the entire screen’ and setting this policy activates full-screen H.264 encoding.

Combined with the higher FPS settings this will result in the entire screen being encoded and an increase in the number of frames that need to be encoded by the host, resulting in the 170% increase for CPU for Encoding in the ‘Very High Definition User Experience’  scenario.

Because with the ‘High Server Scalability’ template no encoding is used, the CPU cycles needed are minimal compared to both other scenarios.

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-bandwidth.png" data-lightbox="bandwidth">
![bandwidth]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-bandwidth.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-bandwidth-comparison.png" data-lightbox="bandwidth-compare">
![bandwidth-compare]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-bandwidth-comparison.png)
</a>

Citrix states the following about bandwidth usage for the ‘Very High User Definition’ template:

> As mentioned in the built-in policy description, applying this template may consume more bandwidth and reduce user density per server.
>
> Source: [https://docs.citrix.com/en-us/advanced-concepts/implementation-guides/hdx-policy-templates.html](https://docs.citrix.com/en-us/advanced-concepts/implementation-guides/hdx-policy-templates.html){:target="_blank"}

Instead, the metric shows a significant decrease in bandwidth consumption when using the ‘Very High Definition User Experience’ template.

Sending over the bitmaps (note that no encoding method is used) with the ‘High Server Scalability’ template will result in a decrease in bandwidth consumption and a huge increase in ICA Round Trip Time.

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-rtt.png" data-lightbox="rtt">
![rtt]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-rtt-comparison.png" data-lightbox="rtt-compare">
![rtt-compare]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-rtt-comparison.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

With the ‘Very High Definition User Experience’ template, there are some unusual spikes in the Round Trip Time during the multimedia part of the workload (starting from the 40-minute mark and onward). This might have to do with the measurements, but the metrics are consistent across the other LoginVSI users (remember we only report the RDA metrics for the first user). The spikes are most likely caused by the fact that around 40 minutes the Host CPU usage is approaching CPU congestion.

If we compare the first 20 minutes of the workload (when there is no CPU congestion for the ‘Very High Definition User Experience’ template scenario yet) the ICA round trip time data is more on par with the expectations.

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-rtt-20min.png" data-lightbox="rtt-20min">
![rtt-20min]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-rtt-20min.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-rtt-20min-comparison.png" data-lightbox="rtt-20min-compare">
![rtt-20min-compare]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-rtt-20min-comparison.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

In the first 20 minutes of the workload, the Round Trip Time is significantly lower for the ‘Very High Definition User Experience’ template scenario. Using the ‘High Server Scalability’ template in this phase still results in a huge increase in Round Trip time. This will result in higher latency for the end-user and will negatively affect the user experience. In contrast to the original post where using the ‘High Server Scalability’ template “only” had an average increase of 30%, this time the average Round Trip Time has doubled to 61% compared to the default scenario.

### Launcher metrics
<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-launcher-cpu.png" data-lightbox="launcher-cpu">
![launcher-cpu]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-launcher-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-launcher-cpu-comparison.png" data-lightbox="launcher-cpu-compare">
![launcher-cpu-compare]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-launcher-cpu-comparison.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

In comparison to the default scenario and the ‘High Server Scalability’ template, switching to the ‘Very High Definition User Experience’ template has a 43% CPU impact on the endpoints. This is mostly noticeable throughout the multimedia part of the workload.

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-launcher-cpu-multimedia.png" data-lightbox="launcher-cpu-media">
![launcher-cpu-media]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-templates-launcher-cpu-multimedia.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Because the encoded stream needs to be decoded again at the endpoint, this will require much more processing power for the ‘Very High Definition User Experience’ template compared to the other scenario, specifically if we zoom in to the multimedia portion of the workload.

Keep that in mind when dealing with older endpoints, especially in scenario’s where the endpoints are resource-constrained.

Please note that our environment uses virtual Launchers. Most client devices nowadays can decode H.264 very efficiently and devices like the Citrix Ready workspace hub, which is based on the Raspberry Pi 3, have hardware-based H.264 decoding capabilities that can significantly reduce the stress on the endpoints CPU when decoding the H.264 streams.

These results are in line with the metrics from the original post where we also saw a 40% increase in endpoint CPU utilization with the ‘Very High Definition User Experience’ compared to the ‘High Server Scalability’ template scenario.

## Conclusion
While we cannot directly compare the results from the original post and the updates research (since a lot of parameters have changed), the original conclusion still stands:

> To sum up, in an environment where performance is key it might be worth sacrificing the user experience in order to achieve maximum user density at the cost of a diminished experience for the end user. When sizing the endpoint in the cases where a high user experience is required, always investigate and continuously monitor the sizing in order to make sure the endpoints are not undersized.

From both a host and the perspective of an end-point, delivering the highest definition experience to users will impact the scalability significantly. To quantify that, switching from the ‘High Server Scalability’ template to the ‘Very High Definition User Experience’ template will decrease server scalability by 26%.

<a href="{{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-conclusion.png" data-lightbox="conclusion">
![conclusion]({{site.baseurl}}/assets/images/posts/031-citrix-policy-templates/031-citrix-policy-conclusion.png)
</a>

The most common alleviation, using server GPUs, can potentially limit the overall impact at the datacenter side. The HDX policy setting ‘Use hardware encoding for video codec’ is selected by default. Using endpoints with faster CPUs and GPUs that can decode H.264, like the Raspberry Pi, can enhance the user experience from the end-points side of the equation.

As per best practice, if you don’t need to delivery 3D of CAD workloads, keep everything at default if you use a VDA 7.18 or later and let the system decide. You get the best balance between user experience and scalability.
Source: [https://www.citrix.com/blogs/2018/10/02/what-graphics-policies-do-i-need-and-when](https://www.citrix.com/blogs/2018/10/02/what-graphics-policies-do-i-need-and-when){:target="_blank"}

If you want to share your insights on using the built-in policy templates or would like to discuss our findings, please reach to us or join the [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Victor Rodriguez](https://unsplash.com/@vimarovi?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/metro?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}.
