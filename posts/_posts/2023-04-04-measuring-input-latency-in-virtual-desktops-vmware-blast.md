---
layout: post
toc: true
title:  "Measuring Input Latency in Virtual Desktops: VMware Blast"
hidden: false
authors: [ eltjo, ryan]
reviewers: [esther, patrick]
categories: [ 'NVIDIA' ]
tags: [ 'NVIDIA LDAT', 'Click-to-Photon', 'Citrix HDX', 'Microsoft RDP', 'VMware Blast', 'Latency']
image: assets/images/posts/097-measuring-input-latency-in-virtual-desktops-vmware-blast/measuring-input-latency-in-virtual-desktops-vmware-blast.png
---
The previous article provided an overview of latency as one of the key factors when it comes to user experience. This research series focuses on assessing latency in virtual desktops using NVIDIA's LDAT tool. This article is the second in the series and presents an analysis of latency for the VMware Blast protocol, which is part of the VMware Horizon solution.

For those who are new to this topic, it is recommended to read the [introduction and baseline](https://www.go-euc.com/measuring-input-latency-in-virtual-desktops-introduction-and-baselines-of-the-nvidia-ldat-research/){:target="_blank"} first.

## Summary of the introduction and baseline
Input latency is defined as the delay between a user's input and the corresponding action or response on the target system. Measured in milliseconds (ms), high latency can significantly degrade the overall user experience.

The baseline results indicate that latency is determined not only by system or network components but also by the monitor used by the end user. The refresh rate of the monitor is one of those factors that can improve the user experience. The [previous research](https://www.go-euc.com/measuring-input-latency-in-virtual-desktops-introduction-and-baselines-of-the-nvidia-ldat-research/){:target="_blank"} concluded that a higher refresh rate results in a better user experience if the endpoint can deliver the required performance. However, there may be a diminishing return effect when moving from 120Hz to 144Hz, as the improvement in latency is not as substantial as with the change from 60Hz to 120Hz.

## Setup and configuration
The [previous research](https://www.go-euc.com/measuring-input-latency-in-virtual-desktops-introduction-and-baselines-of-the-nvidia-ldat-research/){:target="_blank"} described the methodology applied for executing this research series. The latest available version of VMware Horizon was used, which was version 2212 at the time of the research. A new infrastructure was deployed using the recommended specifications from the VMware documentation using the GO-EUC automated deployments.

The endpoint specification is described in [previous research](https://www.go-euc.com/measuring-input-latency-in-virtual-desktops-introduction-and-baselines-of-the-nvidia-ldat-research/){:target="_blank"}, and the VMware Horizon Client version is 2212, which was the latest version available at time of testing.

The goal of this research is to showcase the out-of-the-box experience when using VMware Blast. Consequently, no policies for the Blast protocol were applied, and all settings were kept at default, except for the frame rate, which was set to 60 FPS (compared to the 30 FPS default setting). It is also essential to note that no GPU acceleration was used in the configuration.

The research tested the following scenarios:

  * Baseline 144Hz
  * Baseline 60Hz
  * VMware Blast (Default)
  * VMware Blast (60 FPS)
  * Microsoft RDP (Default)

Microsoft RDP is the default protocol available in all Windows devices. Recently, Microsoft introduced several improvements to the RDP protocol, but these are only available in their Azure Virtual Desktop (AVD) offering. In this case, the default Microsoft RDP, without the protocol improvements, was used as a reference for all tests and charts.

## Hypothesis and results
The [initial research](https://www.go-euc.com/measuring-input-latency-in-virtual-desktops-introduction-and-baselines-of-the-nvidia-ldat-research/){:target="_blank"} tested latency from a local device. In this part of the series a remoting factor, in the form of VMware Horizon, was introduced. It is expected that introducing a remoting factor will increase overall latency, as additional network components are involved between the end-user and the remote desktop they are interacting with. Based on experience, the hypothesis is that VMware Blast will outperform Microsoft RDP, as VMware's protocol incorporates more advanced encoding techniques.

{% include chart.html type='line' data_file='assets/data/097-measuring-input-latency-in-virtual-desktops-vmware-blast/vmware.json' %}

{% include chart.html type='hbar' data_file='assets/data/097-measuring-input-latency-in-virtual-desktops-vmware-blast/vmware-compare.json' %}

The configured frame rate in the remoting protocol settings significantly impacts latency.

A higher configured frame rate generally means that screen updates will be displayed faster than with a lower configured frame rate. Modern protocols can dynamically adjust the frame rate according to the type of content shown. With dynamic content, the remoting protocol will always attempt to render changes at the highest configured frame rate.

By default, VMware Blast is configured to target 30 FPS as the maximum rendered frame rate. Please note, that all VMware Blast results are collected using 144Hz.

As Microsoft RDP does not have a way to adjust the FPS, it will not be included in the comparison.

{% include chart.html type='line' data_file='assets/data/097-measuring-input-latency-in-virtual-desktops-vmware-blast/vmware-60fps.json' %}

{% include chart.html type='hbar' data_file='assets/data/097-measuring-input-latency-in-virtual-desktops-vmware-blast/vmware-60fps-compare.json' %}

The data shows a substantial improvement in latency when adjusting the FPS from 30 to 60 FPS.

The charts shows that the default VMware Blast configuration (running at 30 FPS) offers lower latency than Microsoft RDP. Furthermore, when VMware Blast is configured with a 60 FPS frame rate, there is an even more significant decrease in latency.

The average latency for VMware Blast when configured with 60 FPS is 53 ms lower than the default VMware Blast configuration. This is a 45% reduction in average latency, which means a  significantly more responsive and smoother user experience.

Also there is a 41.8% reduction in minimum latency that shows that the best-case scenario for the user experience is significantly improved when the frame rate is increased to 60 FPS.

Overall, the mean latency values are relatively close to each other across all of the performed runs, which indicates that the performance is fairly consistent.

Not shown here, but for VMware Blast with 60 FPS, the maximum latency values show significant variation, but there were no apparent reasons found behind this.

## Conclusion
It is expected that using a virtual desktop will increase latency due to the introduction of network components between the end-user and their desktop. Additionally, the remoting protocol itself will introduce extra latency. This is also the case when using VMware Blast. Comparing VMware Blast to Microsoft RDP, the data shows that using VMware Blast delivers a better user experience in terms of latency.

This research also showed that by adjusting the FPS, it is possible to decrease latency up to a certain cutoff point. As there are numerous options to adjust protocol settings, it is possible to further fine-tune the protocol to reduce latency even more. These optimizations usually come at a cost, primarily in terms of bandwidth usage or CPU usage on the VDI side. For more information, please read the [VMware Blast Extreme Optimization Guide](https://techzone.vmware.com/resource/vmware-blast-extreme-optimization-guide){:target="_blank"}.

Another way to decrease the latency is by adding a vGPU to the virtual desktop. This allows the encoding done by the remoting protocol to be offloaded from the CPU to the GPU of the virtual desktop which will reduce latency as the overall experience will be smoother. However, this is not yet tested or validated as of yet  by GO-EUC, so definitely something for the research backlog.

In the next and final publication of the series, Citrix HDX results will be presented. Be sure to [follow GO-EUC](https://twitter.com/g0_euc){:target="_blank"} to stay updated.

Photo by <a href="https://unsplash.com/@comparefibre?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText" target="_blank">Compare Fibre</a> on <a href="https://unsplash.com/photos/PAOv9-7VBMI?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText" target="_blank">Unsplash</a>
