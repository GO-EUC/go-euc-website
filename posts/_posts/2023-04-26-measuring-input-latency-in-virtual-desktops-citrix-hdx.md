---
layout: post
toc: true
title:  "Measuring Input Latency in Virtual Desktops: Citrix HDX"
hidden: false
authors: [ ryan, eltjo]
reviewers: [silas, sven-j, tom]
categories: [ 'NVIDIA' ]
tags: [ 'NVIDIA LDAT', 'Click-to-Photon', 'Citrix HDX', 'Microsoft RDP', 'VMware Blast', 'Latency']
image: assets/images/posts/097-measuring-input-latency-in-virtual-desktops-citrix-hdx/measuring-input-latency-in-virtual-desktops-citrix-hdx.png
---
This is the last article of this series which is all about measuring the input latency using the NVIDIA LDAT. In the previous article, [VMware Blast](https://www.go-euc.com/measuring-input-latency-in-virtual-desktops-vmware-blast/){:target="_blank"} was covered while this article will focus on Citrix’s HDX protocol. Again, for those who are new to this series, it is recommended reading the [introduction and baseline](https://www.go-euc.com/measuring-input-latency-in-virtual-desktops-introduction-and-baselines-of-the-nvidia-ldat-research/){:target="_blank"} first.

## Summary of the introduction and baseline
Input latency is defined as the delay between a user’s input and the corresponding action or response on the target system. Measured in milliseconds (ms), high latency can significantly degrade the overall user experience.

The baseline results indicate that latency is determined not only by system or network components but also by the monitor used by the end user. The refresh rate of the monitor is one of the factors that can improve the user experience. The initial [research](https://www.go-euc.com/measuring-input-latency-in-virtual-desktops-introduction-and-baselines-of-the-nvidia-ldat-research/){:target="_blank"} concluded that a higher refresh rate, on average, result in a better user experience, if the endpoint can deliver the required performance. However, there may be a diminishing return effect when moving from 120Hz to 144Hz, as the improvement in latency is not as substantial as with the change from 60Hz to 120Hz.

## Setup and configuration
The same methodology as described in the [introduction article](https://www.go-euc.com/measuring-input-latency-in-virtual-desktops-introduction-and-baselines-of-the-nvidia-ldat-research/){:target="_blank"} is applied to the results in this article. At the time of this research, the latest available Citrix CVAD version, version 2212, was deployed using the default automation. The infrastructure is deployed with the recommended infrastructure specifications, which can be found in the [Citrix documentation](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/system-requirements.html){:target="_blank"}.

The endpoint setup is also described in the introduction article, and for the Citrix Workspace app for Windows the latest version is used, which is version 2212 as of writing.

The goal of this research is to showcase the out-of-the-box experience using Citrix HDX, and therefore, no policies for the HDX protocol were modified and all settings were kept default apart from the frame rate. The framerate was adjusted from the default setting (30 FPS) to 60 FPS for one of the scenarios. It is also essential to note that no GPU acceleration was used for this research.

The following scenarios are tested in this research:
  * Baseline 144Hz
  * Baseline 60Hz
  * Citrix HDX (Default)
  * Citrix HDX (60 FPS)
  * Microsoft RDP (Default)

Microsoft RDP is the default protocol available on all Windows devices. Recently, Microsoft introduced several improvements to the RDP protocol, but these are only available in their Azure Virtual Desktop (AVD) offering.In this research, the default Microsoft RDP protocol, without the improvements, was used as a reference for all tests and charts.

## Hypothesis and results
As shown in the [previous article](https://www.go-euc.com/measuring-input-latency-in-virtual-desktops-vmware-blast/){:target="_blank"}, introducing a remoting factor will increase the overall latency. When using Citrix HDX, it is therefore expected that this will be also noticeable in the results when using Citrix. Again, just like in the previous article, comparing to Microsoft RDP, it is expected that Citrix HDX will outperform Microsoft RDP, as Citrix’s protocol uses more advanced encoding techniques for example.

{% include chart.html type='line' data_file='assets/data/097-measuring-input-latency-in-virtual-desktops-citrix-hdx/citrix.json' %}

{% include chart.html type='hbar' data_file='assets/data/097-measuring-input-latency-in-virtual-desktops-citrix-hdx/citrix-compare.json' %}

Like the [previous research](https://www.go-euc.com/measuring-input-latency-in-virtual-desktops-vmware-blast/){:target="_blank"}, there is a significant difference between the baseline, 144Hz, and the remoting protocols. This is primarily due to both the remoting and rendering frame rate of the protocol.


A higher configured frame rate generally means that screen updates will be displayed faster than with a lower configured frame rate. Modern protocols, like Citrix HDX, can dynamically adjust the frame rate according to the type of content shown. With dynamic content, the remoting protocol will always attempt to render changes at the highest configured frame rate.

By default, Citrix HDX is configured with a maximum of 30 FPS. Please note that all Citrix HDX results are collected using 144Hz.

The framerate can be adjusted to a maximum of 60 FPS in the settings, and up to 120 FPS with a registry setting.

As Microsoft RDP does not have a way to adjust the FPS, it will not be included in the following comparison.

{% include chart.html type='line' data_file='assets/data/097-measuring-input-latency-in-virtual-desktops-citrix-hdx/citrix-60fps.json' %}

{% include chart.html type='hbar' data_file='assets/data/097-measuring-input-latency-in-virtual-desktops-citrix-hdx/citrix-60fps-compare.json' %}

The data shows a substantial decrease in latency (lower is better) when adjusting the FPS from 30 to 60 FPS.

It’s evident that increasing the framerate from 30 FPS to 60 FPS has significantly reduced the average end-to-end latency. The average latency for the Citrix HDX with 60 FPS is 58 ms, which is around 45% lower than the average latency for the default 30 FPS setting (106 ms).

This improvement can be attributed to the increased framerate, which allows for more frequent screen updates and therefore, quicker response times for the end-users inputs. With lower latency, users will experience smoother and more responsive interactions in a VDI environment.

Comparing the two settings in more detail, the 60 FPS configuration has a lower median latency, which is consistent with the lower average latency observed earlier. Additionally, the standard deviation is smaller for the 60 FPS setting, which means that the latency measurements are more consistent and less spread out, compared to the 30 FPS setting.
Please note for this research only 100 measurements were done, which is a relatively small sample size. The spread and the distribution of the data should be even more consistent with an increased sample size. More information about the median and how to handle outliers can be found in the following article: [Stuck in the middle, an introduction into statistical analysis for GO-EUC](https://www.go-euc.com/stuck-in-the-middle/){:target="_blank"}

For the 30 FPS run the outcome is fairly consistent across all runs, however there are a few outliers in each run. Overall, the distributions are relatively consistent, though. The presence of outliers suggests that occasional spikes in latency might occur. The consistency data across the runs show that the 30 FPS Citrix HDX setting provides a stable overall performance in terms of latency.

For the 60 FPS runs overall, the performance is consistent across all runs, with no significant differences in data distribution.

The standard deviations for each of the 5 runs vary only slightly. This means the variance of the data within each run is not significantly different. The overall standard deviation is 7.328, that indicates that there is some variability in the data, but it is not extremely high.

Overall, the latency values are relatively close to each other across all of the performed runs, which indicates that the performance is fairly consistent across the board.

## Conclusion
This three part research series has delved into the input latency of virtual desktops, specifically focusing on measuring input latency using NVIDIA LDAT for the two most predominant remoting protocol players in the market, VMware Blast and Citrix HDX. A key aspect of the user experience in a virtual desktop environment is input latency, which can significantly impact overall satisfaction and user experience.

The Citrix HDX protocol's out-of-the-box experience was evaluated using default settings, and it was found that increasing the frame rate from 30 FPS to 60 FPS dramatically reduced the average end-to-end latency. With a 45% reduction in latency, users experience smoother and more responsive interactions in the virtual desktop environment, which is crucial for optimal performance and user satisfaction.

The comparison of the 30 FPS and 60 FPS configurations highlights the importance of fine-tuning virtual desktop settings to deliver the best possible user experience. A higher frame rate ensures more frequent screen updates, resulting in quicker response times to end-user inputs. But that will always come with a cost; the downside of using a higher frame rate is an increase in both VDI as well as endpoint CPU latency and an inevitable increase in bandwidth consumption.

As mentioned in the previous post, while remoting protocols inherently introduce additional latency, proper configuration and optimization can significantly improve the user experience even further. For more information, please refer to the relevant Citrix documentation: [HDX - Citrix Virtual Apps and Desktops 7 2303](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/technical-overview/hdx.html){:target="_blank"} and [Design Decision: HDX Graphics Overview - Citrix Tech Zone](https://docs.citrix.com/en-us/tech-zone/design/design-decisions/hdx-graphics.html){:target="_blank"}

This last part also concludes this research series on latency in VDI environments. If you like this content, please leave a comment below.

Photo by <a href="https://unsplash.com/@comparefibre?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText" target="_blank">Compare Fibre</a> on <a href="https://unsplash.com/photos/8xnaQKWjDrM?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText" target="_blank">Unsplash</a>
