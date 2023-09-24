---
layout: post
toc: true
title:  "Analyzing Image Quality in Windows 365 Cloud PC: HTML5 Webclient vs. Remote Desktop Client"
hidden: false
authors: [eltjo]
reviewers: [benny, ryan]
categories: [ 'Microsoft' ]
redirect_from:
  - /Analyzing-Image-Quality-in-Windows-365-Cloud-PC/
tags: [ 'Windows365', 'cloudpc', 'Cloud pc', 'Microsoft RDP', 'image quality', 'RDP Shortpath']
image: assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/analyzing-image-quality-in-windows-365-cloud-pc.png
---
Microsoft's Windows 365 Cloud PC service offers users the flexibility to access their Windows environment from anywhere, using either a web client or the Microsoft Remote Desktop Client. But how do these two methods compare in terms of image quality, particularly when it comes to text sharpness in applications like Microsoft Word and Excel?

When working for a client via a Microsoft Windows365 Cloud PC recently, I noticed that in my Word document that I was working on, the text in Word appeared to be blurry. At that time I was making use of the HTML5 webclient to access my Cloud PC. This made me wonder about the impact of the connection used for the image quality. My speculation at the time was that using the full client would result in a better inage quality.

In this article, we delve into a detailed comparison of these two access methods, specifically around the quality of the user experience they deliver. Our findings reveal significant differences in image quality between the two, with implications for user comfort and productivity. Whether you're a user considering which method to use, or an IT professional planning a Windows 365 deployment, this article will provide valuable insights to guide your decision.


## Introduction
Windows 365 is a cloud-based service that automatically creates a new type of Windows virtual machine (Cloud PCs) for end users. Each Cloud PC is assigned to an individual user and is their dedicated Windows device. Windows 365 provides the productivity, security, and collaboration benefits of Microsoft 365. A Cloud PC is a highly available, optimized, and scalable virtual machine providing end users with a rich Windows desktop experience. It’s hosted in the Windows 365 service and is accessible from anywhere, on any device.

There are two ways an end user can access their Windows365 Cloud PC, by using the web client at [https://windows365.microsoft.com](https://windows365.microsoft.com){:target="_blank"} and by using the Microsoft Remote Desktop Client.

When using the webclient Microsoft has set the following requirements:
  * Supported operating systems: Windows, macOS, ChromeOS, Linux
  * A modern browser like Microsoft Edge, Google Chrome, Safari, or Mozilla Firefox (v55.0 and later).

In this article the Microsoft Remote Desktop client for Windows from the Microsoft Store was used. This client has the following requirements:
  * Operating systems: Windows 10 1703 or later
  * CPU: 1 GHz or faster processor
  * RAM: 1024 MB
  * Hard drive: 100 MB or more
  * Video: DirectX 9 or later with WDDM 1.0 driver. Teams audio and video offloading on Cloud PC benefits from a dedicated Graphics Processing Unit (GPU) within your physical endpoint device.


## Setup and configuration

The setup for this article was kept as simple as possible, with two scenarios:
  * The baseline, using the Windows-based Microsoft Remote Desktop Client
  * HTML5 based Webclient

The goal of this article is to compare the image quality between the HTML5 webclient and the full Remote Desktop Client for Windows. For that reason, the results for the webclient were compared to the baseline scenario using the full client.

The browser used for the tests was Microsoft Edge version: Version 114.0.1823.51 (Official build) (64-bit), running on a Windows 11 end point. The same endpoint was used for both tests.

The latest version Microsoft Remote Desktop Client available at time of writing was version 10.2.3012.0.
For the Remote Desktop Client, all settings were left as default.

<a href="{{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/remotedesktopclientversion.png" data-lightbox="clientversion">
![clientversion]({{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/remotedesktopclientversion.png)
</a>

The Cloud PC used was a Cloud PC Enterprise with 2vCPU, 8GB of memory and 128GB of storage. The Cloud PC ran Windows 10 21H2 with OS Build 19044.3086.

All tests were run a total of 5 times and the best result for each test was used for the comparisons in the results. There was very little variance between the 5 runs.

## Analysis

As mentioned previously, the predetermined hypothesis is that the using full Remote Desktop client will exhibit a higher quality image as when using the webclient. For this reason the Remote Desktop client was chosen as the baseline.

<a href="{{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/Word1_Cloudpcwindowsclient_cropped.png" data-lightbox="clientversion">
![clientversion]({{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/Word1_Cloudpcwindowsclient_cropped.png)
</a>

<p align="center" style="margin-top: -30px;" >
  <i>Word Baseline (Full client)</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/Word1_Cloudpcwebclient_cropped.png" data-lightbox="clientversion">
![clientversion]({{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/Word1_Cloudpcwebclient_cropped.png)
</a>

<p align="center" style="margin-top: -30px;" >
  <i>Word webclient</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/Excel1_Cloudpcwindowsclient_cropped.png" data-lightbox="clientversion">
![clientversion]({{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/Excel1_Cloudpcwindowsclient_cropped.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Excel baseline (Full client)</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/Excel1_Cloudpcwebclient_cropped.png" data-lightbox="clientversion">
![clientversion]({{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/Excel1_Cloudpcwebclient_cropped.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Excel webclient</i>
</p>

Upon visual inspection of the image quality, it is abundantly clear that the text in the second image is much sharper and the colors are significantly less washed out in case of the Word portion of the workload. For the Excel portion, the visual differences are much harder to discern by eye.

{% include chart.html scale='true' type='hbar' data_file='assets/data/101-analyzing-image-quality-in-windows-365-cloud-pc/word-psnr-compare.json' %}

{% include chart.html scale='manual' scale_min='0.8' scale_max='1.05' type='hbar' data_file='assets/data/101-analyzing-image-quality-in-windows-365-cloud-pc/word-perceived-image-quality.json' %}

{% include chart.html type='hbar' data_file='assets/data/101-analyzing-image-quality-in-windows-365-cloud-pc/excel-psnr-compare.json' %}

{% include chart.html scale='manual' scale_min='0.8' scale_max='1.05' type='hbar' data_file='assets/data/101-analyzing-image-quality-in-windows-365-cloud-pc/excel-perceived-image-quality.json' %}


In this article the MS-SSIM metric was used in tandem with the 'regular' SSIM metric to determine the perceived image quality of the text elements.

For these tests, it is important that the text in the images often contains fine details, such as the edges of letters, that can be more apparent at higher resolutions. These details can be lost or distorted during the encoding due to compression or scaling, which could lead to a loss of details and therefore impact the overall sharpness of the text. Because MS-SSIM evaluates similarity at multiple scales, it's more likely to capture these changes in sharpness than SSIM, which operates at a single scale.

MS-SSIM works by downscaling the images being compared and computing the SSIM value at each scale. By using this method, MS-SSIM can capture changes in structural similarity that may be more clear at different scales or resolutions.

The SSIM value itself is computed based on three components: luminance similarity, contrast similarity, and structural similarity, just like the 'regular' SSIM Metric. These components are then combined into a single index that measures the overall similarity between the two images. In MS-SSIM, this process is repeated at all these multiple scales. The resulting SSIM values for each scale are then combined into a single MS-SSIM value.

For the perceived image quality metrics used, SSIM (Structural Similarity Index Measure) and  MS-SSIM (Multiscale SSIM), the scale ranges from -1 to 1 where higher results are better Generally speaking, scores above 0.98  are considered good enough in terms of visual quality although that is always a matter of opinion and may vary person to person.

In the case of the PSNR or peak signal-to-noise ratio metric, typical values for lossy image compression are between 30 and 50dB and here also higher is better. Values over 40dB are considered very good and below are generally accepted as unacceptable low quality.

<a href="{{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/Word1_fullscreen_Cloudpcwindowsclient_cropped.png" data-lightbox="clientversion">
![clientversion]({{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/Word1_fullscreen_Cloudpcwindowsclient_cropped.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Word Full screen baseline (Full client)</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/Word1_fullscreen_Cloudpcwebclient_cropped.png" data-lightbox="clientversion">
![clientversion]({{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/Word1_fullscreen_Cloudpcwebclient_cropped.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Word Full screen webclient</i>
</p>

When viewing the results for the full screen comparison, the SSIM values are higher than the cropped images. This is an expected result as the fullscreen screencaptures have a lot of whitespace which naturally results in a higher score.

These results also suggest that the full-screen images preserved structural similarity better than the text-only images, but all four images showed noticeable differences from the original according to the PSNR metric. This can be attributed to factors like compression, scaling, or other processing applied to the images by the remoting protocol which are more apperant in the text-only images.


Futhermore, the result seems to suggest that the webclient is rendering the images using chroma subsampling whereas the full client does not, although we could not find any official sources to confirm this.

A related link to the Microsoft Documentation for AVD seems to suggest that by default Microsoft is using YUV 4:2:0 and only switches to 4:4:4 when using a gpu accelerated AVD host and configuring Configure fullscreen video encoding: [https://learn.microsoft.com/en-us/azure/virtual-desktop/enable-gpu-acceleration#configure-fullscreen-video-encoding](https://learn.microsoft.com/en-us/azure/virtual-desktop/enable-gpu-acceleration#configure-fullscreen-video-encoding){:target="_blank"}

*“This policy setting prioritizes the H.264/AVC 444 graphics mode for non-RemoteFX vGPU scenarios. When you use this setting on the RDP server, the server will use H.264/AVC 444 as the codec in an RDP 10 connection where both the client and server can use H.264/AVC 444.”*

Note: Microsoft recommends using a vGPU when enabling this policy but at the time of writing vGPU accelerated Cloud PC’s are not available.

There are a couple of other factors that could account for the difference in quality. The webclient uses a TCP connection whereas the full client uses UDP as the underlying protocol.

For the UDP connections of the full cliënt ms uses what's called RDP shortpath. The main difference between the default TCP connection and rdp shortpath is that the default connection uses a gateway  using reverse connect. RDP shortpath uses a direct path that way the protocol can in theory deliver improved connection reliability, lower latency, and higher available bandwidth.

More information about RDP shortpath can be found on the MS documentation site here: [https://learn.microsoft.com/en-us/azure/virtual-desktop/rdp-shortpath?tabs=public-networks#key-benefits](https://learn.microsoft.com/en-us/azure/virtual-desktop/rdp-shortpath?tabs=public-networks#key-benefits){:target="_blank"}

Lastly, there was also a difference in reported available bandwidth with the webclient capping out at 9.5mbps and the full cliënt reaching bandwidth in excess of 150mpbs over the same connection during the tests. This difference in bandwidth could be attributed to the previous point about RDP Shortpath. Using RDP Shortpath could have resulted in a higher available bandwidth for the client.

Both these factors could have an impact on the measured quality. In any case, under the same circumstances, the quality difference measured is significant.

**UPDATE:**

In order to rule out these two variables, additional tests were performed. We used a Apple MacBook Pro with the Mac version of the remote desktop client. The internet connection used was deliberately congested to simulate high latecy and low available bandwidth. The Mac version of the remote desktop client, at the time of writing, does not have RDP shortpath capabilities and/or the used network did not facilitate UDP connections and therefore was forced to use TCP. The available bandwidth during testing was around 2.5Mbps. The Mac full client showed the same quality as the Windows full client and thereby effectively ruling out these two variables (UDP shortpath and/or available bandwidth) as influencing variables on the results.

<a href="{{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/macbookproreference.jpg" data-lightbox="clientversion">
![clientversion]({{site.baseurl}}/assets/images/posts/101-analyzing-image-quality-in-windows-365-cloud-pc/macbookproreference.jpg)
</a>

## Conclusion

Microsoft documentation for Cloud PC is still pretty sparse, especially underneath the End-User experience documentation section where there currently only two topics, one for End-user hardware requirements and how to access a Cloud PC. The documentation for AVD is more detailed and elaborate, however in terms of documentation around user experience there is also room for improvement in our opinion.

Users have two connection choices when it comes to connecting to their Windows365 Cloud PC: using the webclient and using the full Remote Desktop client.

In conclusion, there are significant differences in image quality between the HTML5 web client and the Microsoft Remote Desktop Client. Our tests, which focused on the sharpness of text in applications like Microsoft Word and Excel, show that the Full Remote Desktop Client on Windows provides a noticeably superior image quality. The text appears sharper and less washed out, leading to a more comfortable and potentially more productive user experience.
Generally speaking the text is easier on the eyes when using the full client. Now this is not to say that the image quality when using the webclient is bad, however it is a matter of personal opinion if this is in any way detrimental to the overall user experience.


When comparing the image quality in typical Office worker scenarios, the image quality when using the full Remote Desktop Client is significantly better compared to the webclient. This becomes most apparent when examining the sharpness of text when using Microsoft Word and Microsoft Excel. Overall the text quality appears to be blurry and washed out when using the webclient and text appears much sharper when using the full (Windows) client.
This experience is backed up by the perceived image quality metrics, where in all cases the full client scores better compared to the webclient.

While the web client offers the convenience of access from any device with a modern browser, end users who prioritize image quality, particularly for text-intensive workloads, will find the Remote Desktop Client to be a better option.

It is important to note that image quality is just one aspect of the user experience. Depending on the specific use case and personal preferences, some users may still prefer the flexibility of the web client. That being said, personally after seeing the results I switched to using the full webclient to access my Cloud PC.

As Microsoft continues to develop and refine the Windows 365 solutions, we hope to see improvements in the web client's image quality. Until then, users and IT professionals should consider these findings when deciding which access method to use for their Windows 365 Cloud PC environments.

Other scenarios that might be interesting and are being considered are a comparison between CloudPC in combination with Citrix's HDX Plus webclient and the Citrix Workspace App.

We hope this reasearch was informative, leave a comment, share this article and please let us know if you have any questions.

Special thanks goes out to Dr. Benny Tritsch for his help and insightful comments!

Photo by <a href="https://unsplash.com/@redzeppelin?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Red Zeppelin</a> on <a href="https://unsplash.com/photos/zlb7Td_HN8U?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
