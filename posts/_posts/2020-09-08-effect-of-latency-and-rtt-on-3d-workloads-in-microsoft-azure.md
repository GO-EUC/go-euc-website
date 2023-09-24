---
layout: post
toc: true
title:  "The effect of latency and RTT on 3D workloads in Microsoft Azure"
hidden: false
authors: [ryan]
categories: [ 'NVIDIA' ]
tags: [ 'NVIDIA', 'Azure', 'Citrix Cloud', 'Windows 10', 'AMD Radeon']
image: assets/images/posts/063-effect-of-latency-and-rtt-on-3d-workloads-in-microsoft-azure/063-effect-of-latency-and-rtt-on-3d-workloads-in-microsoft-azure.png
---
It is possible to deliver very intensive graphical workloads in a virtualized environment using vGPUs from NVIDIA, AMD or Intel. When moving these workloads to a centralized location most certainly will introduce network latency, since the remoting protocol needs to travel the wire. What is the effect of latency in these kinds of scenarios? This research will show the effect of moving a heavy 3D workload, like a racing simulator, to a virtualized environment.

## Cloud Gaming
In the past few years there have been several major vendors that provide game services that allow you to stream block buster games to any device. Google with Stadia, Microsoft with xCloud and NVIDIA with GeforceNow. For example, the services may differ in games and delivery methods, they have all one bottleneck in common: latency. The fact is, when moving a workload to a virtualized environment at another location, even if it is at the same physical location, you always introduce network latency. In the case of cloud gaming, this results in input lag or delay. Depending on the type of game, this might be experienced as annoying or when the latency is very high, not playable at all.

Now what is latency? Network latency is how long it takes for something sent from a source host to reach a destination host. Depending on the destination location the latency will increase.

<a href="{{site.baseurl}}/assets/images/posts/063-effect-of-latency-and-rtt-on-3d-workloads-in-microsoft-azure/063-azure-latency.png" data-lightbox="azure-latency">
![azure-latency]({{site.baseurl}}/assets/images/posts/063-effect-of-latency-and-rtt-on-3d-workloads-in-microsoft-azure/063-azure-latency.png)
</a>

In case of Azure, the latency to various datacenter locations can be validated on [Azure Speed website](https://www.azurespeed.com/){:target="_blank"}. As shown in the example above, as the location is based from the Netherlands, the latency in West Europe is low. Moving to the United States, latency is increased as the distance between the source and destination increases.

Besides latency, another important factor is round trip time (RTT), also known as round trip delay. RTT is the time required for a signal pulse or packet to travel from a specific source to a specific destination and back again. It is important to understand the time between host and destination can differ from destination to host. Therefore, it is important to take this into account.

In general, it is a fact that when moving a workload to a remote location, you always introduce input delay caused by latency and RTT, which cannot be easily resolved.

The goal of this research is to show the effect of the latency in an intense graphics workload that is provided from the cloud.

## Setup and configuration
The approach to this research is considerably different compared to other researches on GO-EUC. In this case a racing simulator is used to generate the graphics intense workload. Assetto Corsa Competizione is selected racing simulator.

{% include youtube.html id="CYncAnd31Q8" %}

The game is configured with graphics settings on high without a frame limit, so the maximum frames are shown based on the machine performance. For the local session a dedicated game pc is used whereas for the remote session a NV6 machine delivered by Citrix Cloud is used and, in this case, the same Game PC is used as the remote endpoint.

Specification details:

| Game PC (local) | NV6 Promo (remote) |
| :------------- | :----------------- |
| €900,- for life | €674.09 per month |
| 6 core with 16GB memory | 6vCPU with 56GB memory |
| AMD Ryzen 5 3600 (3.6GHz) | Intel Xeon E5-2690 v3 (2.6GHz) |
| 1TB NVMe SSD (2x) | 340GB Standard SSD |
| AMD Radeon RX 5700 | NVIDIA TESLA M60 |
| Max 1.725GHz with 8GB GGDR6 | Max 1.178GHz with 8GB GGDR5 |

Both machines are running Windows 10 1909 Pro and the NV6 machine is optimized using Citrix Optimizer using the recommended template. Citrix VDA 1912 is installed on the remote machine.

For the remote session the following Citrix policies where configured:

| Policy | Value |
| :------------- | :----------------- |
| Target frame rate  | 60 fps |
| Visual quality | Build to Lossless |
| Use video codec for compression | For active changing regions |
| Use hardware encoding for video codec | Enabled |
| Optimize for 3D graphics workload | Enabled |
| Client USB device redirection | Allowed |
| Client USB device redirection rules | Allow: #all ok |

The policy are based on the best practices from Citrix which can be found [here](https://docs.citrix.com/en-us/tech-zone/design/design-decisions/hdx-graphics.html#3d-workload){:target="_blank"}. The Azure machine NV6 has a NVIDIA M60, so therefore H.265 encoding cannot be used as this is not supported. This means H.264 is used, which is the default by Citrix. In this research Citrix Cloud is used and unfortunately Citrix EDT (UDP) is not available at the time of this research, so therefore a TCP connection is by default.

The machine is hosted in the West Europe Azure region, which is the closed location to the game pc. A hybrid configuration is used with the GO-EUC environment to use the on-premises identities.

The remote session is connected from the game pc, using the Citrix Workspace app version 1911. The [Radeon RX 5700](https://www.amd.com/en/products/graphics/amd-radeon-rx-5700){:target="_blank"} does have both H.264 & H.265 decode and encode capabilities. The internet connection for the game pc is a 250Mbit download with a 25Mbit upload, which is a low latency consumer cable connection. In fact, the Netherlands is the top leading countries in the European union with high speed internet connections in the Dutch households.

## Track and car setup
This race has taken place on the legendary track Zandvoort located in the Netherlands using the racing mode hotlaps. When using hotlap mode the tire wear is reset after completing a lap, ensuring that all laps are in the same conditions. Talking about conditions, the weather is set to sunny with a 28 Celsius temperature and the track temperature of 37 degrees.

The car is a Mercedes SLS AMG GT with the aggressive setup configuration, which is a default setup in the game. The transmission is configured to manual without stability control. The car is driven using a Thrustmaster TR300RS using the F1 add-on with the force feedback set to 100%.

<a href="{{site.baseurl}}/assets/images/posts/063-effect-of-latency-and-rtt-on-3d-workloads-in-microsoft-azure/063-remote-race-car-review.gif" data-lightbox="car-gif">
![car-gif]({{site.baseurl}}/assets/images/posts/063-effect-of-latency-and-rtt-on-3d-workloads-in-microsoft-azure/063-remote-race-car-review.gif)
</a>

In order to see the difference a total of 11 laps are driven. The slowest lap is removed from the results.

## Results
It is expected to see at least a difference, as the remote session does introduce RTT delay and therefore input delay. The following video is a side to side compare of the fastest lap of each session.

{% include youtube.html id="WIJJur09Nxg" %}

It is clear there is a difference in experience when remoting a game, especially with the feeling in the wheel, which contains a small delay, but more about that a bit later. The result of the fastest lap shows a difference of almost a second, which is mainly caused by the delay in input but also the framerate compared to the local session. As explained in the setup and configuration, there is no framerate limitation in a game perspective. This means the FPS is based on the performance the machine. In case of the remote session, Citrix does limit the framerate in the remoting protocol. As the video shows, there is a clear difference between both sessions.

There is never a perfect lap, although the comparison is the fastest lap of both sessions, it doesn’t mean this lap contains all fastest sectors. Based on all results it is possible to calculate the fastest potential lap time based on combining all fastest sector times. This is shown in the potential result.
The red marked times is the slowest lap which are excluded from the result. The green time is the fasted lap of the session where the purple are the fasted sectors.

<b>Remote Session</b>

<table width="437">
<tbody>
<tr>
<td width="63">
<strong>Lap</strong>
</td>
<td width="76">
<strong>Sector 1</strong>
</td>
<td width="75">
<strong>Sector 2</strong>
</td>
<td width="75">
<strong>Sector 3</strong>
</td>
<td width="75">
<strong>Time</strong>
</td>
<td width="75">
<strong>Delta</strong>
</td>
</tr>
<tr>
<td width="63">
1
</td>
<td width="76">
00:32.928
</td>
<td width="75">
00:34.479
</td>
<td width="75">
00:32.943
</td>
<td width="75">
01:40.350
</td>
<td width="75">
00:00.942
</td>
</tr>
<tr>
<td width="63">
2
</td>
<td width="76">
00:32.628
</td>
<td width="75" style="color: white; background-color: purple">
00:34.014
</td>
<td width="75">
00:32.940
</td>
<td width="75">
01:39.582
</td>
<td width="75">
00:00.174
</td>
</tr>
<tr>
<td width="63">
3
</td>
<td width="76" style="color: white; background-color: darkred">
00:40.770
</td>
<td width="75" style="color: white; background-color: darkred">
00:34.440
</td>
<td width="75" style="color: white; background-color: darkred">
00:32.949
</td>
<td width="75" style="color: white; background-color: darkred">
01:48.159
</td>
<td width="75" style="color: white; background-color: darkred">
00:08.751
</td>
</tr>
<tr>
<td width="63">
4
</td>
<td width="76">
00:33.129
</td>
<td width="75">
00:34.776
</td>
<td width="75">
00:33.114
</td>
<td width="75">
01:41.019
</td>
<td width="75">
00:01.611
</td>
</tr>
<tr>
<td width="63">
5
</td>
<td width="76">
00:32.673
</td>
<td width="75">
00:34.683
</td>
<td width="75" style="color: white; background-color: purple">
00:32.532
</td>
<td width="75">
01:39.888
</td>
<td width="75">
00:00.480
</td>
</tr>
<tr>
<td width="63">
6
</td>
<td width="76">
00:32.742
</td>
<td width="75">
00:40.296
</td>
<td width="75">
00:32.562
</td>
<td width="75">
01:45.600
</td>
<td width="75">
00:06.192
</td>
</tr>
<tr>
<td width="63">
7
</td>
<td width="76">
00:32.967
</td>
<td width="75">
00:35.376
</td>
<td width="75">
00:32.670
</td>
<td width="75">
01:41.013
</td>
<td width="75">
00:01.605
</td>
</tr>
<tr>
<td width="63">
8
</td>
<td width="76" style="color: white; background-color: purple">
00:32.415
</td>
<td width="75">
00:34.392
</td>
<td width="75">
00:32.601
</td>
<td width="75" style="color: white; background-color: limegreen">
01:39.408
</td>
<td width="75">&nbsp;</td>
</tr>
<tr>
<td width="63">
9
</td>
<td width="76">
00:35.124
</td>
<td width="75">
00:34.887
</td>
<td width="75">
00:33.261
</td>
<td width="75">
01:43.272
</td>
<td width="75">
00:03.864
</td>
</tr>
<tr>
<td width="63">
10
</td>
<td width="76">
00:32.583
</td>
<td width="75">
00:34.221
</td>
<td width="75">
00:33.573
</td>
<td width="75">
01:40.377
</td>
<td width="75">
00:00.969
</td>
</tr>
<tr>
<td width="63">
11
</td>
<td width="76">
00:33.039
</td>
<td width="75">
00:34.353
</td>
<td width="75">
00:32.697
</td>
<td width="75">
01:40.089
</td>
<td width="75">
00:00.681
</td>
</tr>
<tr>
<td width="63">
Average
</td>
<td width="76">
00:33.023
</td>
<td width="75">
00:35.148
</td>
<td width="75">
00:32.889
</td>
<td width="75">
01:41.060
</td>
<td width="75">
00:01.835
</td>
</tr>
</tbody>
</table>

Potential fastest lap: 01:38.961

<b>Game PC</b>

<table width="437">
<tbody>
<tr>
<td width="64">
<strong>Lap</strong>
</td>
<td width="75">
<strong>Sector 1</strong>
</td>
<td width="75">
<strong>Sector 2</strong>
</td>
<td width="75">
<strong>Sector 3</strong>
</td>
<td width="75">
<strong>Time</strong>
</td>
<td width="75">
<strong>Delta</strong>
</td>
</tr>
<tr>
<td width="64">
1
</td>
<td width="75">
00:32.580
</td>
<td width="75">
00:33.936
</td>
<td width="75">
00:33.081
</td>
<td width="75">
01:39.597
</td>
<td width="75">
00:02.103
</td>
</tr>
<tr>
<td width="64">
2
</td>
<td width="75" style="color: white; background-color: darkred">
00:32.502
</td>
<td width="75" style="color: white; background-color: darkred">
00:35.823
</td>
<td width="75" style="color: white; background-color: darkred">
00:32.619
</td>
<td width="75" style="color: white; background-color: darkred">
01:40.944
</td>
<td width="75" style="color: white; background-color: darkred">
00:03.450
</td>
</tr>
<tr>
<td width="64">
3
</td>
<td width="75">
00:32.124
</td>
<td width="75">
00:33.753
</td>
<td width="75">
00:33.207
</td>
<td width="75">
01:39.084
</td>
<td width="75">
00:01.590
</td>
</tr>
<tr>
<td width="64">
4
</td>
<td width="75">
00:32.160
</td>
<td width="75">
00:33.303
</td>
<td width="75">
00:32.490
</td>
<td width="75">
01:37.953
</td>
<td width="75">
00:00.459
</td>
</tr>
<tr>
<td width="64">
5
</td>
<td width="75">
00:32.475
</td>
<td width="75">
00:33.960
</td>
<td width="75">
00:32.493
</td>
<td width="75">
01:38.928
</td>
<td width="75">
00:01.434
</td>
</tr>
<tr>
<td width="64">
6
</td>
<td width="75" style="color: white; background-color: purple">
00:32.037
</td>
<td width="75">
00:33.246
</td>
<td width="75">
00:32.514
</td>
<td width="75">
01:37.797
</td>
<td width="75">
00:00.303
</td>
</tr>
<tr>
<td width="64">
7
</td>
<td width="75">
00:32.070
</td>
<td width="75">
00:34.023
</td>
<td width="75">
00:32.259
</td>
<td width="75">
01:38.352
</td>
<td width="75">
00:00.858
</td>
</tr>
<tr>
<td width="64">
8
</td>
<td width="75">
00:32.214
</td>
<td width="75">
00:33.744
</td>
<td width="75">
00:32.577
</td>
<td width="75">
01:38.535
</td>
<td width="75">
00:01.041
</td>
</tr>
<tr>
<td width="64">
9
</td>
<td width="75">
00:32.166
</td>
<td width="75">
00:33.198
</td>
<td width="75" style="color: white; background-color: purple">
00:32.130
</td>
<td width="75" style="color: white; background-color: limegreen">
01:37.494
</td>
<td width="75">&nbsp;</td>
</tr>
<tr>
<td width="64">
10
</td>
<td width="75">
00:32.313
</td>
<td width="75" style="color: white; background-color: purple">
00:33.192
</td>
<td width="75">
00:32.304
</td>
<td width="75">
01:37.809
</td>
<td width="75">
00:00.315
</td>
</tr>
<tr>
<td width="64">
11
</td>
<td width="75">
00:32.418
</td>
<td width="75">
00:33.330
</td>
<td width="75">
00:32.475
</td>
<td width="75">
01:38.223
</td>
<td width="75">
00:00.729
</td>
</tr>
<tr>
<td width="64">
Average
</td>
<td width="75">
00:32.256
</td>
<td width="75">
00:33.569
</td>
<td width="75">
00:32.553
</td>
<td width="75">
01:38.377
</td>
<td width="75">
00:00.981
</td>
</tr>
</tbody>
</table>

Potential fastest lap: 01:37.359

| Lap | Time |
|:--- | :---- |
| Difference best lap |  00:01.914 |
| Difference potential lap |  00:01.602 |

Besides the potential fastest lap, there is still a difference of 1.602 seconds between the local and remote session. This shows the RTT and latency does have a negative effect.

Another important fact, when comparing the delta of both sessions, there is clear difference in the consistency. On the game pc, the difference between the laps, shown in the delta column, is less compared to the remote session.

As a driver, it took some time to adapt to the delay, especially the braking points. After a lap of two the mind learns to understand the delay. Once the car is losing control, it was way more difficult to retake control as shown in this video.

{% include youtube.html id="NUjyBWAkStw" %}

In case of a multiplayer, the disadvantage of the delay will affect your performance compared to the others. As the other player might be unpredicted, this might resolve in crashes, as the RTT influence the

Now in case of a racing game, the effect of both RTT and input delay is acceptable, but in case of a first-person shooter this is way different. In a shooter it is all about the response time to hit the target so fast as possible, especially in multiplayer. This require fast human reaction time with hand and eye coordination for the aim. Adding the additional delay will affect both factors and your performance, resulting in a [bottom fragger](https://www.urbandictionary.com/define.php?term=Bottom%20Frag){:target="_blank"}.

## Conclusion
Multiple large organization are creating cloud gaming platform, allowing people without heavy machines experience high end games. Now these platforms all cope with the RTT and latency, which can have a negative effect on your experience.

RTT and latency is all depending on your own internet connection, protocol (TCP or UDP) and distance to the datacenter. There are multiple options to help you reduce RTT, for example selecting the datacenter closest to your location will reduce both RTT and latency. Even when the server is located at the exact same location, as it is remoting to a server over the network, latency and RTT is introduced. Most protocols have the ability to use UDP, which will reduce RTT, so this might be viable option. At last, using WAN optimizer helps prioritize the all network traffic to ensure the bandwidth is used optimal, which improves the latency and RTT.

In case of a racing simulation, the RTT and latency have a negative experience on the result. The delay in input is very noticeable but the human brain can handle the input delay after a couple laps. Nevertheless, the RTT and input delay still influence the lap times resulting in a difference of 1.5 to 2 seconds.

Although playing a racing game this is not a realistic scenario in the corporate environment, the findings still applies. In case of a designer using an application like AutoCAD, input delay will influence the experience. A delay of a couple of milliseconds could result in a highway moving 50 meters away from the intended location. In the end, this will take additional time take can take up hours over time.

Therefore, it is always important to validate the experience together with the user and explain the effect of RTT and latency. Although this might be the downside, this still enables designers to work remotely, which nowadays is very important for our health.

Want to know more about this topic? Feel free to leave a comment below or start the conversation on the [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Spencer Davis](https://unsplash.com/@spencerdavis?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
