---
layout: post
toc: true
title:  "The effect of input latency when introducing a NVIDIA vGPU in Citrix HDX"
hidden: false
authors: [ryan]
reviewers: [esther, leee]
categories: [ 'NVIDIA' ]
tags: [ Citrix, HDX, LDAT, NVIDIA ]
image: assets/images/posts/108-the-effect-of-input-latency-when-introducing-a-nvidia-vgpu-in-citrix-hdx/the-effect-of-input-latency-when-introducing-a-nvidia-vgpu-in-citrix-hdx-feature-image.png
---
Input latency is one of the key variables that greatly impacts the user experience, especially in a virtual desktop. Higher input latency results in a longer response time between a user's action (e.g., the click of a mouse button) and seeing the result (a change on the screen). A [previous research series](https://www.go-euc.com/measuring-input-latency-in-virtual-desktops-introduction-and-baselines-of-the-nvidia-ldat-research/){:target="_blank"} explored the effect of input latency in various virtual desktop environments. Multiple factors can positively influence the input latency in a virtual desktop; one of those is the use of a vGPU. In theory, adding a vGPU will reduce the latency and, as a result, positively affect the user experience. This research will explore this theory and put it to the test.

## The definition of input latency
Let's quickly recap the definition of input latency. In general, input latency is the time between performing an action, such as interacting with a physical device (e.g, the click of a mouse button), and the system receiving that action. The system then executes that action and presents a result (typically on the screen) that the user receives. The time between presenting the result on the screen and receiving it by the user is (again) affected by latency.

The importance of latency depends on the context. In the case of general use of a computer, such as browsing the web or typing and reading a document, input latency is less of an important factor. In the case of professional gaming, input latency is one of the most important factors, as a delay in the input latency can make a team lose their match.
A previous research series has taught us that the refresh rate of a screen has a major effect on the input latency, as this will show the screen updates faster than a lower refresh rate screen. With a virtual desktop, a remoting protocol is introduced, which will introduce additional input latency.

Please consider reading the entire NVIDIA LDAT series if you’d like to learn more about this topic:

[Measuring Input Latency in Virtual Desktops: Introduction and Baselines of the NVIDIA LDAT Research](https://www.go-euc.com/measuring-input-latency-in-virtual-desktops-introduction-and-baselines-of-the-nvidia-ldat-research/){:target="_blank"}

[Measuring Input Latency in Virtual Desktops: VMware Blast](https://www.go-euc.com/measuring-input-latency-in-virtual-desktops-vmware-blast/){:target="_blank"}

[Measuring Input Latency in Virtual Desktops: Citrix HDX](https://www.go-euc.com/measuring-input-latency-in-virtual-desktops-citrix-hdx/){:target="_blank"}

## Methodology
Just like in previous research, the [NVIDIA LDAT](https://developer.nvidia.com/nvidia-latency-display-analysis-tool){:target="_blank"} device is used, as this is a reliable way to measure input latency by simulating input and detecting luminance change on the screen. The previous research used the default testing software of LDAT, a full-screen application that changes the background color from gray to white, like a quick flash. This approach has a negative side effect when testing with a virtual desktop. Screen changes are relatively easy to process for the remoting protocol as there are little to no updates on the screen, which contradicts the goals of this research.
As the goal is to gain more insights into the effects of latency on-screen outputs when using a remote protocol, a small Windows application, referred to as GO-EUC Analysis Tool (GOAT), is created for this research. GOAT generates a white flash on the entire screen so the luminance sensor of the LDAT can detect it. Unlike the default LDAT test tool, this small Windows application doesn’t run in full screen, which allows it to show different content while measuring with LDAT. This should better represent a realistic user scenario.

A side-effect of using an alternative test tool is that it impacts the overall response times. The default LDAT software is consistently faster than the GOAT test tool ( a C# based application created in Windows Presentation Foundation (WPF)). As the difference in response times is consistent it will not affect the overall comparison. However, as the methodology differs, the results cannot be compared to the previous research.

## Hypothesis
This research intends to validate the hypothesis that the use of a vGPU in a virtual desktop environment will lower input latency and, as a result, improve the user experience. The assumption is that a vGPU will increase the execution of processes requiring the specific instruction set of a GPU, offload protocol encoding capabilities to dedicated silicon, and as a result, improve the responsiveness of a virtual desktop.

## Scenarios
With the tests, the aim is to see the effect on input latency when introducing a vGPU. The test methodology has been expanded with a new tool (GOAT), which allows insights into what happens to the input latency while having other screen content active (such as simultaneously playing a video).

This research is broken down into the following configurations:
  * Baseline - a physical system
  * Default/No vGPU - a virtual desktop (using Citrix) without a vGPU
  * vGPU - A virtual desktop (using Citrix) with a vGPU

The device specification is as follows:

| Physical | Virtual |
| :------- | :------ |
| AMD Ryzen 7 5800 3,8GHz 8-Core | 8 vCPU’s - AMD EPYC 7542 2,9GHz 32-Core |
| 16GB Memory | 16GB Memory |
| NVIDIA GeForce RTX 3070Ti (8GB) | NVIDIA RTX6000 ADA (Q8 - 8GB) |
| 2TB NVME SSD | 128GB SSD (NVME) |

In each configuration, the following scenarios are tested:
  * Default, no other content is presented on the screen beside the GOAT test-tool.
  * YouTube video, a [YouTube video](https://www.youtube.com/watch?v=LXb3EKWsInQ){:target="_blank"} (running on 4K 60FPS) is running alongside the GOAT test-tool.
  * Car Visualizer, a [Car Visualizer](https://carvisualizer.plus360degrees.com/threejs/){:target="_blank"}*, is running alongside the GOAT test-tool.

> Note that Car Visualizer is a GPU-intense application, so this scenario could not be measured on a scenario without a vGPU configuration.

The averages are taken of multiple tests running in various configurations. As we’re able to change the frames per second (FPS) with the testing setup, all scenarios are executed in 30, 60, and 120 FPS. The results are an average of 100 individual measurements.

This scenario runs on the latest releases at the time of this research, which is Citrix Virtual Apps & Desktops 2308 with the Citrix Workspace app 2311. The following Citrix policies are configured:

| Policy | Value |
| :----- | :---- |
| Optimized for 3D graphics workload | Enabled |
| Use hardware encoding for video codec | Enabled |
| Use video codec for compression | For the entire screen |
| Visual quality | Build to lossless |

## Results
The first test scenario defines the baseline, which gives the response times measured when a desktop is in a steady state and there is no content on the screen apart from the GOAT application.

{% include chart.html scale='auto' type='line' data_file='assets/data/108-the-effect-of-input-latency-when-introducing-a-nvidia-vgpu-in-citrix-hdx/30fps-steady-state.json' %}

{% include chart.html scale='auto' type='line' data_file='assets/data/108-the-effect-of-input-latency-when-introducing-a-nvidia-vgpu-in-citrix-hdx/60fps-steady-state.json' %}

{% include chart.html scale='auto' type='line' data_file='assets/data/108-the-effect-of-input-latency-when-introducing-a-nvidia-vgpu-in-citrix-hdx/120fps-steady-state.json' %}

{% include chart.html scale='auto' type='bar' data_file='assets/data/108-the-effect-of-input-latency-when-introducing-a-nvidia-vgpu-in-citrix-hdx/compare-steady-state.json' %}

The baseline results show the effect of introducing a virtual desktop, which runs remotely and needs to transport the input/output over a network connection. The remote connection introduces more latency which results in higher latency and more variation (jitter).

In a steady state, the input latency is lower in a virtual desktop without vGPU. Introducing a vGPU actually increases the input latency slightly, which conflicts with the hypothesis. However,  the results show a more consistent latency when using a vGPU.

The second scenario measures the input latency while a YouTube video is playing alongside the GOAT testing tool.

{% include chart.html scale='auto' type='bar' data_file='assets/data/108-the-effect-of-input-latency-when-introducing-a-nvidia-vgpu-in-citrix-hdx/compare-youtube.json' %}

The difference is in line with the hypothesis and shows that latency is lower while playing a video when a vGPU is present. Interestingly, with a 30 FPS configuration, the difference in input latency is minimal which is not fully expected and conflicts with the overall hypothesis. One theory is that modern processors have optimized instruction sets for video playback.

The test utilizing the Car Visualiser only applies to configurations using a vGPU as this software requires a GPU to run.

{% include chart.html scale='auto' type='bar' data_file='assets/data/108-the-effect-of-input-latency-when-introducing-a-nvidia-vgpu-in-citrix-hdx/compare-car-visualizer.json' %}

There is a clear difference in the FPS configuration. As expected, the baseline is way lower which is as expected as this is a physical machine without a remoting protocol. The vGPU configuration shows a clear distinction between the various FPS configurations where a higher FPS will positively affect the input latency.

## Conclusion
Input latency is one of the key metrics that greatly impact the overall user experience, especially in a virtual desktop. Higher latency results in a longer response time between a user's action (e.g., the click of a mouse button) and seeing the result (a change on the screen). The amount of latency that is considered “acceptable” depends on the user's context and might vary between user personas. Therefore, it is essential to understand the user workload to ensure you can deliver the best latency for the user. But in general, lower and more consistent latency is always better.

Does a vGPU reduce the input latency? It depends. In a steady state - where only the GOAT test tool was active on the system - no benefits were observed. The reason behind this is, at this stage, unclear and will require some future investigations. As the differences are minimal, there will be no noticeable difference for the user, and therefore, there will be no negative effect on the user experience.

In case of input latency while displaying content, having a vGPU will have a positive effect. But again, this will be noticeable when the framerate is increased above the default 30 FPS.

Did you experience any effect of input latency difference when switching to a vGPU configuration? Share your experiences in the comments below.

Photo by <a href="https://unsplash.com/@fakurian?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash" target="_blank">Milad Fakurian</a> on <a href="https://unsplash.com/photos/blue-orange-and-yellow-wallpaper-E8Ufcyxz514?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash" target="_blank">Unsplash</a>
