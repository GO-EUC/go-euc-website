---
layout: post
toc: true
title:  "The performance impact of Citrix session watermark"
hidden: false
authors: [eltjo]
categories: [ 'Citrix' ]
tags: [ 'Citrix', 'CVAD', 'watermark']
image: assets/images/posts/068-citrix-session-watermark/068-citrix-session-watermark-feature-image.png
---
The text-based session watermark is a built-in Citrix Virtual Apps and Desktops functionality that creates a text overlay in the Citrix sessions that can assist in the deterrence and tracking of data theft.

Enabling the Text-based session watermark feature can potentially bring negative effect to the end user experience of the session, but Citrix has no definitive numbers published on the magnitude or the extend of the impact.

In this research, GO-EUC will focus on quantifying the impact of the text-based session watermark feature in CVAD.

## Background information
Session watermarking was introduced in CVAD 7.16 as an experimental feature and later on added to the feature list of CVAD 7.17 in 2018.

The Text-based session watermark feature (hereafter abbreviated to watermark) is supported on both single and multiuser OS's, on both Desktop and Server OS and requires a minimum of Virtual Delivery Agent version 7.17.

As the name implies this feature allows administrators to add a transparent text-based watermark to the session of the users.

Traceability when information from Citrix sessions has leaked. The feature functions just like the watermark features of Adobe Acrobat PDF for example by _‘superimposing’_ a semi-transparent text overlay over the entire session of the end users.

{% include youtube.html id="0NR6ugrpjlE" %}

This watermark will therefor also show up in pictures and screenshots taken from a user's session.

Be aware that the watermark labels on pictures and screenshots taken from a session could be removed, distorted, modified or falsified using a variety of methods.

Technically the session watermark process works as following:

1.  Thinwire generates the watermark picture based on the information from the Citrix policies
2.  Thinwire alpha blends (sometimes called alpha compositing) the watermark image with the session graphics to create the appearance of transparency
3.  Thinwire does the encoding of the newly created image and sends the image to the endpoint
4.  The endpoint decodes the image and displays the images containing the session graphics with the transparent watermark image to the user.

There are a couple of limitations, such as the fact that screen captures taken from within the VDA will not include the watermark.

* Session watermarks are not supported in sessions where Local App Access, Windows media redirection, MediaStream, browser content redirection, and HTML5 video redirection are used. To use session watermark, ensure that these features are disabled.
* Session watermark is not supported and doesn’t appear if the session is running in full-screen hardware accelerated modes (full-screen H.264 or H.265 encoding).
* Session watermark supports only Thinwire and not the Framehawk or Desktop Composition Redirection (DCR) graphic modes.
* If you use Session Recording, the recorded session doesn’t include the watermark.
* If you use Windows remote assistance, the watermark is not shown.

Source: [https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/graphics/session-watermark.html](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/graphics/session-watermark.html){:target="_blank"}

The textual information to displayed for the watermark is configurable and can include the following information:

* Client IP address
* Connection time
* Logon username
* VDA hostname
* VDA IP address

There are two style options available, one where they overlay is in the center of the Session and one where the information is on the 4 corners of the session:

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/068-citrix-session-watermark-example.png" data-lightbox="watermark-example">
![watermark-example]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/068-citrix-session-watermark-example.png)
</a>

## Setup and configuration
For this research there are two scenarios defined:

* The first scenario is our baseline with the default settings where the session watermark disabled.
* Second scenario the session watermark is enabled.

In the second scenario were the text-based watermark is enabled the following policies have been set:

| Setting | Value |
| :------------- | :----------------- |
| Enable session watermark | Enabled |
| Include connection time | Enabled |
| Include logon user name | Enabled |
| Include VDA host name | Enabled |
| Include VDA IP address | Enabled |
| Session watermark style | Multiple |

All other Citrix policies were kept at default; This means the _'video codec for compression'_ setting was left at the default _'Use video codec when preferred'_ setting and _'Visual quality'_ was also left at default (medium).

Please note that the setting we defined do not align with Citrix best practices and are for the evaluation of the performance impact only. It is not recommended that you set these policies in a production environment without testing.

This will result in a configuration that will have a user experience similar to the example below:

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/068-citrix-session-watermark-example.png" data-lightbox="watermark-example">
![watermark-example]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/068-citrix-session-watermark-example.png)
</a>

This research has taken place on the GO-EUC infrastructure, which is described here. Windows 10 1809 is used as the default deployment, configured with 2vCPU's and 4GB memory. The VDIs are delivered using Citrix MCS, running version 2003. The default applications are installed, including Microsoft Office 2016. The image is fully patched and optimized with Citrix Optimizer, using the default template and recommended settings.

GO-EUC uses a custom workload and content library, that are described in detail [here](https://www.go-euc.com/insight-in-the-testing-methodology-2020){:target="_blank"}.

## Results
As Citrix states in the documentation, enabling the session watermark feature could result in a degradation of the user experience. In our case we’ve, with the settings that have been configured we expect a degradation in scalability as well as an increase in bandwidth usage.

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-host-cpu.png" data-lightbox="host-cpu">
![host-cpu]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-host-cpu-compare.png" data-lightbox="host-cpu-compare">
![host-cpu-compare]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Host CPU usage does not suffer from the session watermark significantly. Overall the impact is only measured at 1% across the board. Because the main limitation in the GO-EUC lab is CPU, this CPU constraint means there should be no measurable impact on the user density when using the session watermark feature.

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-fps.png" data-lightbox="session-fps">
![session-fps]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-fps.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-fps-compare.png" data-lightbox="session-fps-compare">
![session-fps-compare]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-fps-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

Now with FPS the initial expectation was that the watermark could have an impact on the FPS counts, but there is no discernible in- or decrease in FPS.

Because the session watermark is added _before_ Thinwire encoding, it appears to have no impact on FPS, and therefore should most likely have only a minimal to no impact on the user experience. (apart from the fact that users will notice the watermark). As there is no way to adjust the opacity of the session watermark at this moment, the watermark could be experienced somewhere between barely noticeable to frustratingly visible by an end user like shown in the video above.

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-rtt.png" data-lightbox="session-rtt">
![session-rtt]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-rtt-compare.png" data-lightbox="session-rtt-compare">
![session-rtt-compare]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-rtt-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-latency.png" data-lightbox="session-latency">
![session-latency]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-latency.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-latency-compare.png" data-lightbox="session-latency-compare">
![session-latency-compare]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-latency-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The session round trip time and latency metrics show seemingly irreconcilable differences, as is clearly visible around 36 minutes of the test. There are no clear indications that data is invalid and the data is consistent across all 10 runs without any outliers in any of the runs. The averages are also compared from the different sessions, and these numbers also seem consistent.

At the moment the speculation is that the differences in the data might be related to the polling interval of Remote Display Analyzer (RDA) tooling that is used to analyze the protocol data, but at this point there isn’t a conclusive answer as of yet and such analysis would go beyond the scope of this research.

For these 'corrected' charts we've corrected the data by removing outliers (3 datapoints in total) from the measurements.

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-rtt-corrected.png" data-lightbox="session-rtt-corrected">
![session-rtt-corrected]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-rtt-corrected.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-rtt-corrected-compare.png" data-lightbox="session-rtt-corrected-compare">
![session-rtt-corrected-compare]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-rtt-corrected-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Coincidentally the data in the comparison is exactly the same if we had used the 95th percentile in this case.

Due to the way how Thinwire reduces bandwidth consumption, the data for the bandwidth consumption is as expected.

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-bandwidth.png" data-lightbox="session-bandwidth">
![session-bandwidth]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-bandwidth.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-bandwidth-compare.png" data-lightbox="session-bandwidth-compare">
![session-bandwidth-compare]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-bandwidth-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The Thinwire protocol reduces bandwidth by employing an algorithm that detects duplicate images and uses caching and buffering in order to avoid having to re-send these images. Because the watermark is created and superimposed on the image </i>before<i> the Thinwire encoding happens, the effectiveness of the algorithm in detecting duplicate regions will be affected.

The bigger the area is that the watermark covers, the bigger this impact will be, and this results in a higher bandwidth usage as shown in the bandwidth usage charts.

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-cpu-for-encoding.png" data-lightbox="session-cpu-for-encoding">
![session-cpu-for-encoding]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-cpu-for-encoding.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-cpu-for-encoding-compare.png" data-lightbox="session-cpu-for-encoding-compare">
![session-cpu-for-encoding-compare]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-cpu-for-encoding-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Because the Thinwire codec has a more difficult time in detecting and encoding the images, the CPU for Encoding is also increased when using a watermark. This could be potentially be countered by adding a vCPU to the VDA, were it not that the watermark feature is not supported yet with hardware encoding.

The most important aspect of the watermark will most likely in most real-world scenarios be the impact that the session watermark has on the endpoint device. In the case of the GO-EUC lab, the LoadGen bots, from which the performance data is collected, represent the endpoint devices.

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-endpoint-cpu.png" data-lightbox="endpoint-cpu">
![endpoint-cpu]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-endpoint-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-endpoint-cpu-compare.png" data-lightbox="endpoint-cpu-compare">
![endpoint-cpu-compare]({{site.baseurl}}/assets/images/posts/068-citrix-session-watermark/063-citrix-session-watermark-endpoint-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The observed impact on the LoadGen bots is significant. It should go without saying, that the more the watermark covers parts of the screen or region, the bigger the impact will be. This is also the reason why Citrix recommends not more than 2 elements.

The endpoint impact could potentially negatively affect the user experience, if the endpoint is not capable of decoding the images fast enough. For more information on the real user experience from different endpoints and the shortcomings, consult the delivered user experience of thin clients playlist on the [GO-EUC YouTube channel](https://www.youtube.com/playlist?list=PLof9ZpIRuTnF_k7dVk1hMPEkkL8jmJ895){:target="_blank"}.

## Preliminary conclusion
Results show that the impact of a session watermark on the VDA side is only minimal, but there is a clear increase in bandwidth, which is expected and in line with Citrix recommendations.

The data shows that the impact of a session watermark is minimal on the VDA sized. The main impact is on the endpoints and the bandwidth used.

The impact on the VDA size might be further mitigated when Citrix add support for Hardware encoded session and offloads the overlaying of the watermark to the GPU.

These results are very much dependent on the type of watermark, the amount of text but also on the video encoding method. In this research the video encoding was left at default which is 'let the system decide'. Using ‘for actively changing regions’ as the video encoding method might reduce the impact, whilst 'for the entire screen' will most probably have a higher impact on both the VDA as on the endpoints were it not for the fact that 'For the entire screen' is not supported with the session watermark at the time of writing.

Another option would be to integrate the session watermark in the video stream with by using stenography, but that technology is known to be very CPU heavy.

Furthermore, please note it is not that difficult to bypass the session watermark with photo editing tools like Adobe Photoshop, keep in that in mind when considering using session watermark in a production environment.

Are you using the text-based session watermark feature you Citrix environments? Please let us know and discuss below or in the [Slack Channel](https://worldofeuc.slack.com){:target="_blank"}.
