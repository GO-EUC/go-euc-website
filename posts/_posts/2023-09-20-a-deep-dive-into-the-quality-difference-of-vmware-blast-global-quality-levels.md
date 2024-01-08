---
layout: post
toc: true
title:  "A deep dive into the quality difference of VMware Blast Global Quality Levels"
hidden: false
authors: [ryan]
reviewers: [esther, bas]
categories: [ 'VMware' ]
tags: [ 'VMware', 'Horizon', 'Blast', 'BlastCodec', 'image quality']
image: assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/global-quality-levels-feature-image.png
---
Over the past few years, VMware has made significant advancements in their Blast protocol. This is highly beneficial, as most of these improvements focus on enhancing the protocol's performance and user experience, as the protocol is the core aspects of the product. One noteworthy enhancement is the implementation of global quality levels, which will be explored further in this article.

## Improvements in Blast
Over the past few years, VMware has dedicated significant effort to refining the Blast protocol. This commitment is evident in the comprehensive list of enhancements documented in the release notes. Below is a summarized table of the release notes concerning the updates related to the Blast protocol:

|Version|Release note|
|---|:--|
|2006|Blast Codec is enabled by default.|
|2006|VMware Blast uses the client's current topology when starting a connection to the agent machine.|
|2006|With the VMware Blast protocol, you can use two 8K displays.|
|2006|The Blast Codec Quality group policy setting enables you to set the minimum and maximum values of the Quantization Parameter (QP), which controls the image quality of the remoted display when using Blast Codec compression.|
|2103|Client and Agent improvements to reach and sustain high frame rates|
|2103|Improved client overload detection and agent feedback loop|
|2103|Improved frame rate smoothness|
|2103|The Allow H.264 Decoding group policy setting configures H.264 decoding for the VMware Blast protocol.|
|2103|The Allow H.264 high color accuracy group policy setting configures high-color accuracy mode for H.264 decoding.|
|2106|5K and 8K client display resolutions are now supported (Blast only).|
|2106|Horizon supports NVIDIA Ampere A40 and A10 GPUs with Blast supporting H.265, H.264, and Graphics offload.|
|2106|Blast Extreme implements High Dynamic Range (HDR) encoding, which expands the range of brightness in a digital image to provide a more realistic depiction of a scene.|
|2106|The Blast Extreme decoder supports 10-bit 4:4:4 video on Intel integrated GPUs.|
|2111|Multiple audio output devices are now supported with Windows Media Multimedia Redirection (MMR) when using the Windows client with the Blast protocol.|
|2111|The Encoder Image Cache Size (KB) group policy setting sets the maximum size of the encoder image cache.|
|2203|The Encoder CPU Controller dynamically scales down or up the maximum frames per second that Blast Extreme displays according to recent average system CPU usage.|
|2206|VMware Blast now detects the presence of a vGPU system and applies higher quality default settings.|
|2206|The Blast CPU controller feature is now enabled by default in scale environments.|
|2206|VVC-based USB-R is enabled by default for non-desktop (Chrome/HTML Access/Android) Blast clients.|
|2206|Physical PC (as Unmanaged Pool) now supports Windows 10 Education and Pro (20H2 and later) and Windows 11 Education and Pro (21H2) with the VMware Blast protocol.|
|2303|Media optimization for Microsoft Teams offers individual application sharing in VDI and RDSH desktop sessions for VMware Blast display protocol (Windows clients).|
|2303|This release supports AV1 encoding on desktops with Intel ATS-M GPUs for more efficient compression and high-quality video streaming.|

Source: [VMware Horizon 8 2303 Release Notes](https://docs.vmware.com/en/VMware-Horizon/8-2303/rn/vmware-horizon-8-2303-release-notes/index.html){:target="_blank"}

Please be aware that the list extracted from the release notes focuses specifically on Blast-related updates.

## What is the Blast Encoders Global Quality setting?
These days using a video encoder in remoting protocols has become the standard for protocol vendors.

But before diving into the specific configuration, it is crucial to grasp the concept of a video encoder. Video encoders are not solely designed for remoting protocols; their most common application lies in video content delivery, as seen in platforms like YouTube or Netflix. The video encoder serves as a software component when no dedicated GPU is available, relying on the CPU for processing. Alternatively, when a GPU is present, the encoder is integrated into the GPU as a feature, such as NVENC for NVIDIA-based GPUs. The encoder processes raw video material and applies compression techniques to reduce its size, resulting in lower bandwidth requirements while still maintaining an acceptable level of image quality.

Although remoting protocols and platforms like Netflix and YouTube use the silmilar encoding technologies, their use cases differ significantly. Simplifying it, a remoting protocol also transmits a stream of images, similar to a video, which is decoded at the receiving endpoint. However, remoting protocols additionally provide interactive capabilities. The complexity of encoders lies in the content they handle. Some encoders excel at graphical object rendering, while others perform better with text-based content. Thus, finding a universal encoder solution that caters to all scenarios proves challenging. Moreover, certain encoders such as HEVC and AV1 are too computationally heavy to support real-time usage in VDI scenarios unless implemented in hardware, such as with modern dedicated GPUs. Exploring encoders and their distinctions is way too much for this research and can be an entire dedicated article.

With the basic understanding of encoders, let's examine how this concept relates to the Blast Encoders Global Quality setting. The specific policy description from the VMware documentation is as follows:

_“This setting controls the remoted display image quality level across all Blast encoders.”_

  * _The level selected is mapped across all the codecs, updating the maximum QP value for H.264, maximum QP value for the Blast code, and the low JPEG quality in the Adaptive encoder according to the value selected._

  * _The Encoder Global Quality Level takes values from 1 to 5. A lower value indicates lower quality and a higher value indicates higher quality. The higher the quality level the more bandwidth used and potentially higher latency when regions of the screen are changing often, when scrolling on the screen for example. The default value is 1 (balanced). The quality mapping can be overridden with respective encoders' QP values._


Source: [VMware Blast Policy Settings](https://docs.vmware.com/en/VMware-Horizon/2303/horizon-remote-desktop-features/GUID-220442CF-EA01-470E-A381-1BED9BC0B81C.html){:target="_blank"}

The Blast Encoders Global Quality policies offer a one-click quality settings for the protocol across various encoders, such as H.264, BlastCodec, and JPEG (when the adaptive encoder is selected). These settings range from 1 to 5, with 1 representing the lowest quality and 5 representing the highest quality. By utilizing these global quality policies, users can easily adjust the overall quality without the need to individually tweak each setting. It's important to note that increasing the quality setting will consume more bandwidth. However, this particular research will focus solely on showcasing the differences in quality or, in other words, the impact of compression, without delving into the variations in bandwidth.

<a href="{{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/global-quality-policy.png" data-lightbox="global-quality-policy">
![global-quality-policy]({{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/global-quality-policy.png)
</a>

### Color accuracy
In addition to its other configuration options, the Blast protocol offers the ability to adjust the color accuracy mode. By default, Blast uses YUV 4:2:0 compression when using H.264, HVEC or AV1 codecs, which utilizes chroma subsampling, as the default encoder setting.

Chroma subsampling is a type of compression that reduces the color information in video and images in favor of luminance data in order to reduce bandwidth usage. The algorithm aims to do that without significantly affecting picture quality.

However, Blast also provides the option to switch to YUV 4:4:4 compression and disable chroma subsampling. This is the default in a CPU scenario when the protocol is configure to use the BlastCodec. This feature is referred to as High Color Accuracy (HCA) by VMware. The advantage of utilizing HCA is that it enhances the clarity of text by eliminating the "watercolor effect" that can occur when using YUV 4:2:0 compression.

## Setup and scope
The research was run within the GO-EUC platform, which is described in detail here. For testing purposes, VMware Horizon 8 version 2303 was utilized on both the server and client sides, as it was the most up-to-date version available at the time.

The primary research question centered around examining the visual degradation that could result from adjustments made to the Blast Encoders Global Quality setting specifically for text-based workloads. Consequently, the focus was only on determining the image quality and did not consider factors such as bandwidth utilization or other performance metrics.

The specific objective was to determine how the quality of text-based workloads, particularly in Microsoft Word, is affected within a VMware environment in relation to the Encoder Global Quality Levels.

The focus of the research is on the five different levels of the Blast Encoders Global Quality setting. These have been separated in four sections:

  * Complete, both text and photo
  * Photo only
  * Text only
  * Text only with high color accuracy

The methodology to quantify the visual quality is done by using SSIM, MS-SSIM and PSNR. It is important to consider that these metrics provide a single score to represent the overall quality of an image. To address this, the images were cropped into specific regions, and the analysis was conducted on a per-region basis, as specified above. One region focused on the test portion of the Word document, while another region examined the embedded images within the document.

The baseline reference is a source image not delivered using VMware Blast. There is no protocol compression applied to the baseline image.

## Analysis
There two ways that increasing the quality levels will be of impact, firstly the increase in the quality level settings will most likely increase the image quality as descrbined by VMware. As an additional result, the change will probably also increase bandwidth and network usage, which as stated above, is not in scope of this research.

The global quality levels have the following characteristics: raising the quality level will modify various encoder settings, which should lead to an improved picture quality generated by the encoder in use. This increase in quality is expected to have a higher perceived quality, as measured by the SSIM, MS-SSIM and PSNR.

It is important to understand that the effect of the quality level depends on the content shown on the screen. In the case of still content, the protocol has the ability to quickly change to the highest quality, as no screen updates are required. In this research, the focus is on the quality level in a document, so it is expected that the protocol had enough time to switch to the highest quality, overruling the global quality setting.

### Complete, both text and photo results

{% include chart.html scale='manual' scale_min='0.8' scale_max='1.05' type='hbar' data_file='assets/data/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/complete-ssim.json' %}

{% include chart.html scale='auto' type='hbar' data_file='assets/data/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/complete-psnr.json' %}

Both SSIM and MS-SSIM are non-linear metrics that evaluates visual image degradation. In general, both scores ranging from 0.98 to 1 indicate minimal visual image degradation and are considered visually lossless.

The results match the hypothesis that is stated above, showing a increase in quality when increasing the global quality level. Please note that the complete comparison contains both text and photo content. Therefore it is interesting to further investigate how the quality behaves on the individual sections.

### Text only

{% include chart.html scale='manual' scale_min='0.8' scale_max='1.05' type='hbar' data_file='assets/data/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/text-ssim.json' %}

{% include chart.html scale='auto' type='hbar' data_file='assets/data/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/text-psnr.json' %}

Baseline:

<a href="{{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/text-baseline.png" data-lightbox="text-baseline">
![text-baseline]({{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/text-baseline.png)
</a>

Quality level 1:
<a href="{{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/text-level-1.png" data-lightbox="text-level-1">
![text-level-1]({{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/text-level-1.png)
</a>

Quality level 5:
<a href="{{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/text-level-5.png" data-lightbox="text-level-5">
![text-level-5]({{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/text-level-5.png)
</a>

During visual inspection, the quality difference between Quality level 1 and 5 is quite apparent, especially in the first line with the orange letters on the green background. However, the difference is considerably less noticeable in the second line with regular text. It is important to note that this Word document was intentionally designed to challenge the protocol and is particularly difficult to encode.

When visually inspecting the text based images, the differences between Quality levels 2 to 5 are almost negligible.

Overall, the SSIM, MS-SSIM, and PSNR values for Quality level 1 are the lowest. This corresponds to the visual observation that the text is difficult to read at this quality level, especially with the color backgrounds.

For Quality levels 2 to 5, the values are quite similar, which aligns with the visual observations.

While SSIM, MS-SSIM, and PSNR are widely used metrics to quantitatively measure perceived image quality, these metrics do not always align with visual perception. This suggests that SSIM may not capture the specific distortions affecting text clarity in the test images.

All three metrics are considered full reference metrics, meaning they compare a test image to a baseline or reference image. This method is effective for comparing overall image quality. However, in specific cases such as text clarity, these metrics may fall short. This is because they were primarily designed for evaluating natural images.

Video codecs like H.264 are optimized for compressing video content, and generally place less emphasis on preserving text clarity and sharpness. This is why text can often appear blurry or washed out when compressed using video codecs, especially at lower quality settings.

### Photo only results
As explained the SSIM is primarily designed for evaluating natural images, based on this it is expected to see a clearer difference in the photo only section. However, this is also depending on the protocol compression and how the image is delivered to the endpoint.

{% include chart.html scale='manual' scale_min='0.8' scale_max='1.05' type='hbar' data_file='assets/data/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/photo-ssim.json' %}

{% include chart.html scale='auto' type='hbar' data_file='assets/data/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/photo-psnr.json' %}

Altough the difference are minimal there is still increase in the quality when increasing the global quality level higher, which is matching the hyptosisis.

Baseline:

<a href="{{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/photo-baseline.png" data-lightbox="photo-baseline">
![photo-baseline]({{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/photo-baseline.png)
</a>

Quality level 1:
<a href="{{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/photo-level-1.png" data-lightbox="photo-level-1">
![photo-level-1]({{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/photo-level-1.png)
</a>

Quality level 5:
<a href="{{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/photo-level-5.png" data-lightbox="photo-level-5">
![photo-level-5]({{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/photo-level-5.png)
</a>

When visually analysing the results it hard to detect the visual difference between the images and the baseline. As the scores are very close to 1.000, this shows that the difference are in the very small detail which hard to notice by end users.

### High color accuracy (HCA) - Text only results
{% include chart.html scale='manual' scale_min='0.8' scale_max='1.05' type='hbar' data_file='assets/data/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/text-hca-ssim.json' %}

{% include chart.html scale='auto' type='hbar' data_file='assets/data/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/text-hca-psnr.json' %}

Switching to HCA on QP level 1 does not improve the legibility of the text as shown.
<a href="{{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/text-hca-level-1.png" data-lightbox="text-hca-level-1">
![text-hca-level-1]({{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/text-hca-level-1.png)
</a>

At QP Level 2 with HCA the difference is much more noticeable especially on the red text with the blue background.
<a href="{{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/text-hca-level-2.png" data-lightbox="text-hca-level-2">
![text-hca-level-2]({{site.baseurl}}/assets/images/posts/099-a-deep-dive-into-the-quality-difference-of-vmware-blast-global-quality-levels/text-hca-level-2.png)
</a>

When discussing visual quality, it is referring to the perceived visual quality. In the provided images, it is true that the lettering on some of the lines may not appear as sharp when zoomed in. However, when viewed on a medium-sized monitor from a distance of 1 meter, the perceived quality of the text may not be as poor. Remoting protocol vendors like VMware and Citrix often describe this as "visually lossless." Although the compression used is technically lossy, the end result for the end-user should still appear visually lossless in terms of perceived image quality.

Additionally, it is important to consider that the images presented are stills captured from recordings. Each still frame will only be visible to the end-user for a specific duration, such as 33.3 milliseconds at 30 fps or 16.7 milliseconds when using 60 fps.

## Conclusion
As a side note this research also showcases the challenging nature of quantifying the differences in visual quality. In this context, the measured SSIM metrics show only very minimal differences. Adjusting current testing methodology could mitigate some of the shortcoming of the current methods. That being said, the current methodology is not wrong, but perhaps in some use cases it could benefit from improvements like region or segment-based analysis or the addition of additional and more modern metrics.

When put to visual analysis, the differences are more noticeable around sharp edges in the text, especially on the colored backgrounds in the text based comparisons.

It is interesting to conclude that the VMware Blast protocol is able to come very close to the baseline on text based content, showing it can deliver a good quality.

Even though the differences are minimal, to get the best and most accurate results will be achieved by using the visual quality level of 5. Please note that this research did not do any analysis on the bandwidth usage with the different quality profiles. So therefore, it is recommended when adjusting the quality level in your own environment to evaluate step by step to fully understand the overall impact, as the behaviour might be different based on your workload.

There is no significant difference in the “High color accuracy”, which is the setting that will use the YUV 4:4:4 color space instead of 4:2:0. Source: [VMware Blast Policy Settings](https://docs.vmware.com/en/VMware-Horizon/2206/horizon-remote-desktop-features/GUID-220442CF-EA01-470E-A381-1BED9BC0B81C.html){:target="_blank"}.

There are other approaches for determining the quality of the text in images, like creating or using specialized machine learning models, or using OCR (Optical Character Recognition) or SWT (Stroke Width transform) to extract the text and measuring the successful percentage of the operation compared to the baseline image, but these techniques are complex and time consuming and are out of the scope of this research.

Therefore, on the contrary to previous researches where the conclusion was based on quantitative data, the conclusion presented in this research will be mainly based on the available observational data.

It can be concluded that increasing the quality levels, will increase the image quality as described by VMware but as an auxiliary result, the change will probably also increase bandwidth, network usage and might affect the overal performance.

Photo by <a href="https://unsplash.com/@cheaousa?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText" target="_blank">Ousa Chea</a> on <a href="https://unsplash.com/photos/gKUC4TMhOiY?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText" target="_blank">Unsplash</a>
