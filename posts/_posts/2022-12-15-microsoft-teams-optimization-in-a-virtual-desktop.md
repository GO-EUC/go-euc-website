---
layout: post
toc: true
title:  "Microsoft Teams optimization in a virtual desktop"
hidden: false
authors: [ryan, eltjo]
reviewers: [esther]
categories: [ 'Microsoft Teams' ]
tags: [ 'Microsoft Teams', 'AVD', 'Citrix', 'CloudPC', 'UX']
image: assets/images/posts/092-microsoft-teams-optimization-in-a-virtual-desktop/092-microsoft-teams-optimization-in-a-virtual-desktop-feature-image.png
---
Microsoft Teams has become the de facto standard for corporate communication and collaboration within many organizations. That being said, many of you using Microsoft Teams in a virtualized environment know it is one of the most challenging applications. The Microsoft Teams desktop client is a resource-demanding application based on Electron, which uses Chromium for rendering and was never designed with VDI environments in mind. Microsoft Teams supports chat, collaboration, calling, and meeting functionality in a virtualized environment on Azure Virtual Desktop, Citrix, and VMware platforms.

This research will dive into all details around the user experience of the Microsoft Teams running various virtualized environments.

## Optimizing Microsoft Teams on a virtual desktop
Before covering the results, it is important to have a clear understanding of the optimization in Microsoft Teams; what it is, how it works and why we use it. The implementation is different per virtual desktop solution, but in general the applied optimizations will offload the active Teams' call media stream to the (local) compatible endpoint device. The endpoint device then will decode the stream, render it locally and display it seamlessly on top of the virtual session. This way, all decoding effort will take place at the endpoint, leaving more compute power available for the virtual desktop. When using Teams in a non-optimized configuration, the audio and video streaming experience might not be optimal, and users could experience delays and reduced quality.

The big benefit of using this method is that many endpoints have GPU capabilities and are not affected by other user activities. However, when using an endpoint with limited resources the user experience will be negatively affected.

Microsoft has a [dedicated page](https://learn.microsoft.com/en-us/microsoftteams/teams-for-vdi){:target="_blank"} for the setup and configuration of Teams in VDI environments, which includes the requirements and best practices for usage and configuration.

As mentioned, although the approach is similar for optimizations, the implementations are different.

### Azure Virtual Desktop

<a href="{{site.baseurl}}/assets/images/posts/092-microsoft-teams-optimization-in-a-virtual-desktop/avd-teams-optimization.png" data-lightbox="avd-optimization">
![avd-optimization]({{site.baseurl}}/assets/images/posts/092-microsoft-teams-optimization-in-a-virtual-desktop/avd-teams-optimization.png)
</a>


Source: [Teams for Virtualized Desktop Infrastructure - Microsoft Teams - Microsoft Docs](https://docs.microsoft.com/en-us/microsoftteams/teams-for-vdi){:target="_blank"}
### Citrix DaaS

<a href="{{site.baseurl}}/assets/images/posts/092-microsoft-teams-optimization-in-a-virtual-desktop/citrix-teams-optimization.png" data-lightbox="citrix-optimization">
![citrix-optimization]({{site.baseurl}}/assets/images/posts/092-microsoft-teams-optimization-in-a-virtual-desktop/citrix-teams-optimization.png)
</a>

Source: [Optimization for Microsoft Teams - Citrix Virtual Apps and Desktops 7 2206](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/multimedia/opt-ms-teams.html){:target="_blank"}

## Applying Teams optimization
Applying the Teams optimization depends on the used solution and therefore it is recommended to check the vendor's documentation for solution specific optimizations instructions.

### Azure Virtual Desktop & CloudPC
For Azure Virtual Desktop, there are multiple steps required to ensure the Teams optimization is enabled. This starts with the prerequisites, which is ensuring Microsoft Teams is aware that it is installed in a virtual environment. This can be done by setting the following registry key:

```HKLM:\SOFTWARE\Microsoft\Teams\IsWVDEnvironment``` type ```DWORD``` with value 1.

<i>Note: This is also the registry key to disable the optimization (by setting the value to 0).</i>

The next step is to install the Remote Desktop WebRTC redirector service, which is the component responsible for the offloading, which can be downloaded [here](https://aka.ms/msrdcwebrtcsvc/msi){:target="_blank"}.

<i>Note: For AVD, it is important to ensure the prerequisites are in place, otherwise, the optimizations will not work. More information about AVD can be found [here](https://learn.microsoft.com/en-us/azure/virtual-desktop/teams-on-avd){:target="_blank"}.</i>

### Citrix
For Citrix, there are no prerequisites, and the optimization can be enabled by setting the following registry key:

```HKLM:\Software\Citrix\HDXMediaStream\MSTeamsRedirSupport``` type ```DWORD``` with value 1.

<i>Note: More information about Citrix can be found [here](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/multimedia/opt-ms-teams.html){:target="_blank"}.</i>

To validate if the Teams optimization is active you can either check the registry keys or you can check it in Microsoft Teams by navigating to about > version:

<a href="{{site.baseurl}}/assets/images/posts/092-microsoft-teams-optimization-in-a-virtual-desktop/teams-optimized.png" data-lightbox="teams-optimization">
![teams-optimization]({{site.baseurl}}/assets/images/posts/092-microsoft-teams-optimization-in-a-virtual-desktop/teams-optimized.png)
</a>

An alternative way to check for the Teams optimization is by using the [Remote Display Analyzer](https://rdanalyzer.com/){:target="blank"}, which is able to show if the optimization is enabled.

<a href="{{site.baseurl}}/assets/images/posts/092-microsoft-teams-optimization-in-a-virtual-desktop/rda-teams.png" data-lightbox="teams-rda">
![teams-rda]({{site.baseurl}}/assets/images/posts/092-microsoft-teams-optimization-in-a-virtual-desktop/rda-teams.png)
</a>

## The definition of User Experience
In contrast to most of the previous researches, this research will not be focused on performance or scalability, but rather on the user experience of the Teams desktop client. For this reason, some context is needed as to what the user experience is exactly.
Let’s start with the definition. According to the oxford dictionary, this is the definition of “user experience”:

> what it is like for somebody to use a particular product such as a website, for example how easy or pleasant it is to use. They seek to continuously improve the user experience of the games.

Source: [user experience - OxfordLearnersDictionaries.com](https://www.oxfordlearnersdictionaries.com/definition/english/user-experience?q=user+experience){:target="_blank"}

With this definition in mind, this means that certain well-chosen metrics are needed to quantify a qualitative measure like how easy or how pleasant it is to use. From our knowledge and experience, there are three main aspects that define quality in this frame of reference, being: Latency, Video quality, and audio quality. This research will focus on the latter two, video and audio quality.

Teams is primarily a communication tool for most organizations, and therefore predominantly used for meetings. Audio and video play a crucial part in the overall user experience and perceived quality perception.

Audio quality should need no explanation and should be an obvious choice, as vocal communication is our main form of communication.

With the recent pandemic, having video available that allow people to see their communication partner via a webcam greatly enhances the communications between communication parties as this allows us to 'read' our partner’s emotions and reactions (non-verbal communications).

For the quantification of the visual quality, structural similarity, also known as SSIM, will be used, while for audio, virtual speech quality objective listener (VisQOL). Both methods allow quantifying the quality of both visuals and audio.

### Structural similarity (SSIM)
The structural similarity index measure (SSIM) is a method for predicting the perceived quality of digital television and cinematic pictures, as well as other kinds of digital images and videos. SSIM is used for measuring the similarity between two images. The SSIM index is a full reference metric; in other words, the measurement or prediction of image quality is based on an initial uncompressed or distortion-free image as a reference.

Source: [Structural similarity - Wikipedia](https://en.wikipedia.org/wiki/Structural_similarity){:target="_blank"}

### ViSQOL (Virtual Speech Quality Objective Listener)
Many situations can result in poor or subpar audio quality in Teams, ranging from resource constraints on both the VDI and the endpoint to the use of unsupported microphone devices on a technical level. Other factors like background noise or distance to the microphone can also result in poor audio quality. Using audio and video recordings of the actual Teams call allows for analysis of both audio and video. To determine the perceived audio quality ViSQOL (Virtual Speech Quality Objective Listener) is used, which is an objective, full-reference metric for perceived audio quality. It uses a spectro-temporal measure of similarity between a reference and a test speech signal to produce a MOS-LQO (Mean Opinion Score - Listening Quality Objective) score. MOS-LQO scores range from 1 (the worst) to 5 (the best).

Source: [google/visqol: Perceptual Quality Estimator for speech and audio (github.com)](https://github.com/google/visqol){:target="_blank"}

## Setup and configuration
For the remote desktop solutions, the two most used solutions were chosen: Citrix DaaS (formally known as Citrix Virtual Apps & Desktops) and Microsoft's Azure Virtual Desktop, or AVD for short. These two were combined with Microsoft's latest offering, Windows 365 Cloud PC.

For Cloud PC, Windows 365 uses AV optimization provided by Azure Virtual Desktop to ensure optimal Teams experiences in Cloud PCs.

To summarize, the following solutions are included in this research:

  * Citrix DaaS
  * Azure Virtual Desktop
  * Windows 365 Cloud PC

In case of Windows 365 Cloud PC, the standard configuration has been used, which contains 2vCPUs, 8GB of memory, and 128 GB of storage. Both Citrix DaaS and Azure Virtual Desktop are hosted on a similar configuration, a D2S_v5 SKU, which contains 2vCPUs and 8GB of memory with premium SSD.

These specs meet the minimal requirements for Microsoft Teams to support both audio and video calls as explicitly stated on the plans and pricing page of Windows 365 Cloud PC

Please note that while the configuration is similar with regard to the vCPU count and the memory, there is no way of guaranteeing that the AVD and CloudPC SKUs have similar backend hardware. Microsoft does not state which hardware is used for these SKUs. More information can be found [here](https://learn.microsoft.com/en-us/windows-365/enterprise/cloud-pc-size-recommendations){:target="_blank"}.

The endpoint used for the tests is configured for high performance video and audio streaming, to ensure it does not impact any of the test results. It has the following specifications:

  * AMD Ryzen 7 5700x
  * NVIDIA Geforce RTX 3700 Ti
  * 16GB Memory
  * 2TB NVME SSD

The screen capture is handled by OBS and leverages an Elgato HD60s hardware capture card on a dedicated machine. This way, the recording is not influencing the performance of the endpoint in any way.

Consistency and reproducibility are huge factors in GO-EUC’s researches. In order to achieve this for a Microsoft Teams call, a virtual assistant is created. The platform [Synthesia](https://www.synthesia.io/){:target=_blank"} is used, which allows you to create AI-driven videos based on text input. This video is provided as webcam input by using the virtual camera plugin from OBS on another dedicated machine as the calling device. The audio from the video is redirected as a microphone input to include the audio by using a virtual audio cable. Please take into account that background noise reduction must be disabled, otherwise, the audio is not picked up.

A Microsoft Teams call is then setup as a direct call from the virtual assistant machine, running on-premises, to the virtual desktop, running in the Cloud. Once the call is established, the scenario is recorded. As this research is based on video content, all scenarios have been recorded a minimum of three times, and the best results are selected. Between each recording, the virtual assistant is reset to the starting point, but the call remains active.

For each virtual desktop solution, the following configuration scenarios are included:

  * Teams optimization enabled
  * Teams optimization disabled

This means a total of six scenarios.

<i>Note: Due to resource and time limitations, VMware Horizon was not included in this research.</i>

## Initial findings
Before diving into the results, right from the start, a behavior was noticed that negatively affected the user experience. When accepting the incoming call, it takes some time to build up the stream, resulting in a very blurry webcam stream. To better visualize this, the following video is a side-by-side comparison of the original file and capture

<iframe width="560" height="315" src="https://www.youtube.com/embed/WhZ6yl3pbCY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

This is also noticed in the SSIM results, as the first run shows a consistently lower score compared to the other runs.

{% include chart.html type='line' scale='false' data_file='assets/data/092-microsoft-teams-optimization-in-a-virtual-desktop/ssim-avd-timeline.json' %}

## Results
Analyzing those videos is a time consuming process, so therefore it has been decided to record the Teams call three times, where the best result is used for the charts and comparisons listed.

Lets first cover the quality difference between optimized and non-optimized. This is done by using the SSIM metric. Important to know, a result of 1 is an identical compare to the reference image, so therefore higher is better.

{% include chart.html type='hbar' data_file='assets/data/092-microsoft-teams-optimization-in-a-virtual-desktop/ssim-avd.json' %}

{% include chart.html type='hbar' data_file='assets/data/092-microsoft-teams-optimization-in-a-virtual-desktop/ssim-citrix.json' %}

{% include chart.html type='hbar' data_file='assets/data/092-microsoft-teams-optimization-in-a-virtual-desktop/ssim-cloudpc.json' %}

It is clear, using Teams optimization, no matter what virtual desktop solution is used, delivers the best webcam video quality.

{% include chart.html type='hbar' data_file='assets/data/092-microsoft-teams-optimization-in-a-virtual-desktop/ssim-compare-optimized.json' %}

As mentioned, the overall implementation of the Teams optimization is in general the same. These results show there is almost no difference between the virtual desktop solutions.

{% include chart.html type='hbar' data_file='assets/data/092-microsoft-teams-optimization-in-a-virtual-desktop/ssim-compare-not-optimized.json' %}

Now, these results do show a clear difference for the Cloud PC even though the sizing of the Cloud PC is the same. We are suspecting this is caused by a SKU, but this cannot be confirmed.

For audio the metric is also higher is better, only the scale is from 5 to 1, where 5 is identical to the reference.

{% include chart.html type='hbar' data_file='assets/data/092-microsoft-teams-optimization-in-a-virtual-desktop/mos-compare.json' %}

The results show Teams optimization is delivering the best audio quality compared to the original source.

## Conclusion
Based on this research, we can conclude that testing the user experience of Microsoft Teams is challenging. Especially when using SSIM, which is a full reference comparison that requires the exact same resolution and scale of the presented images to compare successfully. Even though Microsoft stated the webcam streams are not resized, adjustments in scale were noticed during this research.

Besides the minor adjustments in scale, it was also noticed that the layout of the interface buttons changed position depending on the Microsoft Teams installation. Even though this might not directly affect the user experience in a negative way it can be confusing for the end user.

Based on these results, it can be concluded that Teams optimization will deliver the best possible user experience when looking at the video and audio quality on all tested platforms. As this research does not take any performance metrics into account, it must be said that the endpoint does require enough resources in these cases. Please read the following article about endpoint performance.

When encountering problems, you can always validate if optimization is enabled by navigating to settings > about in Teams, as this will indicate if it is enabled. This can also be done using the [Remote Display Analyzer](https://rdanalyzer.com/){:target="_blank"}. Or you can check the registry at the following location:

| Solution | Registry | DWORD Value |
| :------- | :------- | :---------- |
| AVD      | ```HKLM:\Software\Microsoft\IsWVDEnvironment``` | 1 |
| Citrix   | ```HKLM:\Software\Citrix\HDXMediaSteam\MSTeamRedirSupport``` | 1 |

When preparing an AVD deployment, please ensure that the WebRTC requirement is installed before installing Teams; otherwise, the Teams installation would not use any optimizations.

Are you using Microsoft Teams in a virtual environment? Please let us know what your experience is in the comments below.

Photo by <a href="https://unsplash.com/@emilianocicero?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText" target="_blank">Emiliano Cicero</a> on <a href="https://unsplash.com/s/photos/webcam?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText" target="_blank">Unsplash</a>
