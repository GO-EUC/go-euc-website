---
layout: post
toc: true
title:  "Measuring Input Latency in Virtual Desktops: Introduction and Baselines of the NVIDIA LDAT Research"
hidden: false
authors: [ryan, eltjo]
reviewers: [mick, silas, esther, gerjon, tom]
categories: [ 'NVIDIA' ]
tags: [ 'NVIDIA LDAT', 'Click-to-Photon', 'Citrix HDX', 'Microsoft RDP', 'VMware Blast', 'Latency']
image: assets/images/posts/097-measuring-input-latency-in-virtual-desktops-introduction-and-baselines-of-the-nvidia-ldat-research/measuring-input-latency-in-virtual-desktops-introduction-and-baselines-of-the-nvidia-ldat-research-feature-image.png
---
Optimizing the user experience is of utmost importance in virtual desktop environments to achieve maximum productivity. At GO-EUC, three key factors are given priority in enhancing the user experience. The three key factors are: visual quality, audio quality, and input latency. While [prior research](https://www.go-euc.com/microsoft-teams-optimization-in-a-virtual-desktop/){:target="_blank"} has focused on evaluating visual and audio quality, testing input latency presents a unique challenge due to the numerous factors that influence it. In this research series, the use of the NVIDIA LDAT tool will be explored to measure latency accurately in a virtual desktop. The first publication of this series will cover the overall introduction and baselines of the NVIDIA LDAT research.

## Defining Latency
Latency in remoting protocols refers to the duration taken for a user's input, such as a mouse click or keypress on a keyboard, to be transmitted from their local device to a remote device and for the resulting output to be sent back to the user's device and displayed to the end-user. This delay is mainly caused by the physical distance between the user's device and the remote device, as well as by the network infrastructure in between, and any data processing that occurs during transmission. Such data processing can include encryption, compression, or other data transformations that need to be done before or after the data has been transmitted, either on the remote server or the end-user's device.

Latency is typically measured in milliseconds (ms), with lower numbers indicating a faster response time. It can significantly impact the user experience, particularly for applications that require real-time interaction, such as video conferencing or online gaming. High latency can cause a noticeable delay between a user's input and the resulting response on the screen, which can make it challenging to interact with the application in real-time. Additionally, high latency in multimedia or audio/video applications can also affect the user experience, leading to noticeable delays or interruptions in video or audio playback or audio and video running out of sync.

Input latency specifically refers to the delay between a user's input, such as clicking a button or a keypress on a keyboard, and the resulting response on the screen. This delay is caused by several factors, including the polling speed of the device, the processing time of the device, the speed of the network connection, and the performance of the software applications that are running. In order to mesure this, there is a method called click-to-photon. Click-to-photon measures the total latency between a user's input and the resulting visual output on the screen, which includes the input latency and any additional delays caused by the display hardware or software. Examples could include the time it takes for the display to refresh or for the software to render the graphics.

For task worker productivity applications, such as word processing or spreadsheet software, a latency of 50-100 milliseconds may be acceptable, as this level of latency may not be noticeable to most users and should not significantly affect productivity. However, for applications that require more precise interaction, such as gaming, video conferencing, or graphic design, lower input latency is generally preferred, with a latency of less than 50 milliseconds being considered ideal. It is important to note that each person's tolerance to latency differs, and some people are more susceptible to the effects of high latency than others.

## What is NVIDIA LDAT?
There are various methods available to measure input latency such as high-speed cameras, specialized software applications, and tools such as NVIDIA's LDAT. The [Latency Display Analysis Tool (LDAT)](https://www.nvidia.com/en-us/geforce/news/nvidia-reviewer-toolkit/){:target="_blank"} is a measuring device that accurately measures latency using a luminance sensor. This sensor can effectively detect and measure the light emitted by a physical display.

To showcase the capabilities of the tool, Linus Tech Tips produced an informative video.

<iframe width="560" height="315" src="https://www.youtube.com/embed/26DbJ3E4YKI" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

LDAT is a valuable tool for measuring input latency, In gaming, this refers to the time it takes for a mouseclick to be visible for the user. While this metric may not be relevant for the average gamer, it holds significant importance in competitive gaming.

The hardware part of the LDAT tool is relatively simple, consisting primarily of the luminance sensor that can detect changes in light intensity. This sensor measures the click-to-photon latency by measuring the time between the simulated mouse click and the detected change in luminous intensity by the sensor. In the gaming context this can be a muzzle flash in a first person shooter.

Several factors can influence the results of input latency, such as the display quality, refresh rate, operating system, game engine, or remoting protocol used in corporate environments. In a virtual desktop environment, the remoting protocol is responsible for presenting and interacting with the desktop or application. As this is presented over the network or internet it will increase latency. LDAT can effectively measure the end-to-end latency when interacting with the virtual desktop as well.

It is important to note that the results provided by LDAT can only be compared within the same context and cannot be compared to other publications or results. This is because numerous components, including the computer, network capabilities, and physical display, could potentially influence the results.

Unfortunately, the LDAT tool is not for sale and NVIDIA only makes LDAT available for journalists and select few.

## Alternatives to the NVIDIA LDAT
There are several alternative ways to measure latency, one straightforward option is to use a high-speed camera, such as those commonly found on modern smartphones. These cameras can record video at exceptionally high frame rates, potentially up to 480 or 960 frames per second depending on the make and model phone. When using this method, it is crucial to record at the camera's native frame rate without upscaling, as this can affect the accuracy of the results.

A straightforward and budget-friendly approach to replicate mouse clicks or keyboard presses is to employ a [Makey Makey](https://makeymakey.com/){:target="_blank"} circuit board. This device functions by using closed loop electrical signals to transmit a keyboard stroke or mouse click signal to the computer, and it is connected via alligator clips and a USB cable. Furthermore, the Makey Makey provides an illuminated LED when the simulated mouse click or keyboard press is initiated.

In order to determine the latency, record a video of the screen and the keyboard, mouse or Makey Makey. After recording, analyze the video footage frame-by-frame, and count the frames from when the user input occurred to the first frame where the corresponding response appeared on the screen. This method provides a precise measurement of the latency.

It is important to note this method can be relatively inefficient, as it is prone to errors from the user, cumbersome and time consuming

An alternative can be to create a homebuilt solution using a programmable microcontroller board such as Adafruit Trinket M0 and a Stemma QT compatible light, RGB, or LUX sensor like the TCS34725:

[Adafruit Trinket M0 - for use with CircuitPython & Arduino IDE : ID 3500 : $8.95 : Adafruit Industries, Unique & fun DIY electronics and kits](https://www.adafruit.com/product/3500){:target="_blank"}

[RGB Color Sensor with IR filter and White LED - TCS34725 : ID 1334 : $7.95 : Adafruit Industries, Unique & fun DIY electronics and kits](https://www.adafruit.com/product/1334){:target="_blank"}

The Adafruit Trinket is equipped with native USB support and can operate as a Human Interface Device (HID) such as a keyboard or mouse, allowing it to send simulated mouse or keypress signals. By using CircuitPython, the microcontroller can be programmed to log the duration between the simulated keypress or mouse click, and the light sensor can be utilized to detect variations in luminosity, which is comparable to NVIDIA's LDAT.

## Setup and configuration
The monitor utilized for measuring input latency is the Iiyama G-Master GB2560HSU-B1, featuring a TN LCD screen with a maximum refresh rate of 144Hz and a rated response time of 1ms. A faster monitor response time can contribute to reduced input latency, as it reduces the time required for the display to process and display the input signal. This response time is typically measured as the "Gray to Gray" (GtG) unit, which refers to the time taken for a pixel to transition from one gray level to another. However, GtG is not a standardized metric as different vendors use different measurement methods.

It is important to note that achieving low input latency involves multiple factors, and simply increasing the display's refresh rate may not be sufficient to reduce input latency if other components such as input devices or the computer itself are not capable of processing input commands quickly. Additionally, the polling rate of an input device can also affect input latency, with a higher polling rate resulting in a more responsive input experience. However, the effect of polling rate on input latency is not always linear, as other factors such as the device's CPU processing time, software and firmware latency, and the response time of the computer's operating system and applications can also contribute to input latency.

To ensure optimal performance, the endpoint machine used as the baseline for measurement includes an AMD Ryzen 7 5700x processor and NVIDIA RTX 3070 TI GPU.

The following scenarios are included in the overall research:

  * Baseline 144Hz
  * Baseline 120Hz
  * Baseline 60Hz
  * Citrix HDX on 144Hz
  * VMware Blast on 144Hz
  * Microsoft RDP on 144Hz

In this introductory section, we will be discussing the baseline results. In later parts of the series, we will cover the results for Citrix and VMware separately.

To perform the testing, we used the LDAT measuring device along with testing software that was set to run in full screen mode and change the background color upon interaction. We collected data with a 1-second delay between each shot, and we conducted a total of 100 shots. Each scenario was executed five times, and we calculated the total average of these five runs.

## Baseline results
It is expected that a higher refresh rate will result in a lower click-to-photon result.

{% include chart.html type='line' data_file='assets/data/097-measuring-input-latency-in-virtual-desktops-introduction-and-baselines-of-the-nvidia-ldat-research/baseline.json' %}

{% include chart.html type='hbar' data_file='assets/data/097-measuring-input-latency-in-virtual-desktops-introduction-and-baselines-of-the-nvidia-ldat-research/baseline-compare.json' %}

The data shows that for 144Hz, the mean latency is 20.98 ms, compared to a mean latency of 24.39 ms for 120Hz and finally a mean latency of 52.19 ms for 60Hz.

From these values, it is clear that higher refresh rates will result in lower latency values. This is expected because a higher refresh rate means that the display is updating more frequently, and therefore reducing the time it takes for information to appear on screen.

Delving further into the data, the 144Hz refresh rate offers the lowest mean and median latency values compared to the 120Hz and 60Hz refresh rates. This could indicate that, on average, the 144Hz refresh rate provides faster response times and therefore, in general, a more responsive end-user experience.

However, it's important to note that there might be a diminishing return effect when moving from 120Hz to 144Hz, as the improvement in latency is not as high as when changing from 60Hz to 120Hz.

A higher refresh rate enables faster display updates, resulting in a smoother experience. The following website serves as a good demonstration, although the real difference is noticeable when using a higher Hz screen:

[UFO Test: Multiple Framerates](https://testufo.com){:target="_blank"}.

## Next steps
This post presents the first part of a series that aims to showcase measuring latency with the NVIDIA LDAT tool.

During the research, it was discovered that simply purchasing a high refresh rate screen may not necessarily lead to a lower latency. [Previous studies](https://www.go-euc.com/the-delivered-user-experience-of-thin-clients/){:target="_blank"} at GO-EUC have demonstrated that the endpoint is a crucial factor. Specifically, one of the endpoint devices used during the research was unable to provide the full potential of 144Hz, resulting in no significant difference between 144Hz and 120Hz. As a result, the decision was made to use a full-blown desktop as the endpoint device to ensure there were no limitations in performance.

In the following parts, the results of the remoting protocols, Citrix HDX, VMware Blast and Microsoft RDP, will be discussed.

Photo by <a href="https://unsplash.com/@redaquamedia?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText" target="_blank">Denny Müller</a> on <a href="https://unsplash.com/photos/JyRTi3LoQnc?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText" target="_blank">Unsplash</a>
