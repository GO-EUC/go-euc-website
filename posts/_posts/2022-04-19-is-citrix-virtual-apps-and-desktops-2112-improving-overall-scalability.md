---
layout: post
toc: true
title:  "Is Citrix Virtual Apps and Desktops 2112 improving overall scalability?"
hidden: false
authors: [ryan]
reviewers: [eltjo, silas, gerjon]
categories: [ 'CVAD' ]
tags: [ 'CVAD', 'LTSR', 'CR', '1912', '2106', '2109', '2112']
image: assets/images/posts/086-is-citrix-virtual-apps-and-desktops-2112-improving-overall-scalability/is-cvad-2112-improving-overall-scalability-feature-image.png
---
With the Citrix Virtual Apps and Desktops 2112 release on the 13th of December 2021, Citrix has introduced significant HDX improvements, as shown in the [previous research](https://www.go-euc.com/significant-hdx-improvements-with-cvad-2112/){:target="_blank"}. This release also introduces graphics CPU consumption reduction, which should improve the overall scalability, but does it? This research will look at the CVAD 2112 release in terms of scalability.

## Citrix HDX protocol improvements
The release notes mention the following graphics related improvements:

HDX graphics improvements

  * Frame rates now run up to 120 FPS at 1080p and 60+ FPS at 4K resolution.
  * Graphics CPU consumption has been reduced, improving overall scalability.

Source: [Citrix Virtual Apps and Desktops 7 2112](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/whats-new.html){:target="_blank"}

As showcased in the [previous research](https://www.go-euc.com/significant-hdx-improvements-with-cvad-2112/){:target="_blank"}, GO-EUC can confirm significant improvements in the Citrix HDX protocol. To recap:

<i>“For graphics-related workloads in 3D-Pro use cases, release 2112 Citrix has made impressive improvements compared to the previous releases. Citrix has outdone themselves with this release and delivered on their HDX graphics improvements.”</i>

For more details, please read the complete research [here](https://www.go-euc.com/significant-hdx-improvements-with-cvad-2112/){:target="_blank"}.

The scope of the previous research was the graphics 3D pro workload capabilities but did not take the overall scalability into account. So therefore, GO-EUC will see how CVAD 2112 is handled in a scalability context.

## Setup and configuration
This research took place on the [GO-EUC infrastructure](https://www.go-euc.com/architecture-and-hardware-setup-overview-2020/){:target="_blank"}. No NVIDIA vGPU capabilities are added to the virtual machines, as this is focused on the overall scalability. Windows 10 21H1 is the default operating system configured with 2vCPU’s and 4GB of memory. As the best practices describe, Windows 10 is optimized using the recommended template from the Citrix Optimizer.

The following scenarios are included in this research:

  * CVAD 1912 CU4, as the baseline
  * CVAD 2106
  * CVAD 2109
  * CVAD 2112

All scenarios are executed using the GO-EUC testing methodology, which is described in detail [here](https://www.go-euc.com/insight-in-the-testing-methodology-2020/){:target="_blank"}.

## Expectations and results
As stated, this research is focused on scalability. Based on the improvement in Graphics CPU consumption as this has been reduced, it is expected to see an overall improvement in the scalability.

To confirm this improvement, let's first focus on the hypervisor performance results.

{% include chart.html type='line' data_file='assets/data/086-is-citrix-virtual-apps-and-desktops-2112-improving-overall-scalability/host-cpu.json' %}

{% include chart.html type='bar' data_file='assets/data/086-is-citrix-virtual-apps-and-desktops-2112-improving-overall-scalability/host-cpu-compare.json' %}

These results show there is minimal to no difference between the tested versions. The results are not as expected and are the first indication that the release notes are not entirely correct.

{% include chart.html type='line' data_file='assets/data/086-is-citrix-virtual-apps-and-desktops-2112-improving-overall-scalability/host-mem.json' %}

{% include chart.html type='bar' data_file='assets/data/086-is-citrix-virtual-apps-and-desktops-2112-improving-overall-scalability/host-cpu-compare.json' %}

The memory footprint between the various versions is similar and shows a minimal increase.

{% include chart.html type='line' data_file='assets/data/086-is-citrix-virtual-apps-and-desktops-2112-improving-overall-scalability/host-storage-reads.json' %}

{% include chart.html type='line' data_file='assets/data/086-is-citrix-virtual-apps-and-desktops-2112-improving-overall-scalability/host-storage-writes.json' %}

{% include chart.html type='bar' data_file='assets/data/086-is-citrix-virtual-apps-and-desktops-2112-improving-overall-scalability/host-storage-compare.json' %}

There is a notable difference in both reads and writes. However, depending on the storage configuration, this will be unnoticed from a user experience perspective. This behavior cannot be directly clarified but won't affect the stability negatively but will require further investigation.

{% include chart.html type='line' data_file='assets/data/086-is-citrix-virtual-apps-and-desktops-2112-improving-overall-scalability/session-fps.json' %}

{% include chart.html type='bar' data_file='assets/data/086-is-citrix-virtual-apps-and-desktops-2112-improving-overall-scalability/session-fps-compare.json' %}

The previous research showed significant improvement in the session FPS compared to the earlier versions. These results indicate a different pattern primarily caused by the outliers in the 1912 results. For some reason, the 1912 VDA tests consistently produced more FPS at the end of the video, resulting in a higher average, which directly impacts the results.

{% include chart.html type='line' data_file='assets/data/086-is-citrix-virtual-apps-and-desktops-2112-improving-overall-scalability/session-rtt.json' %}

{% include chart.html type='bar' data_file='assets/data/086-is-citrix-virtual-apps-and-desktops-2112-improving-overall-scalability/session-rtt-compare.json' %}

It is essential to know a high round trip time will negatively influence the user experience as there is a higher delay in interaction with the session. The results show a decrease in RTT for all versions. As the difference might be 9%, the absolute difference is only 2ms, which any user will not directly notice.

## Conclusion
The previous Citrix VDA research showed a signification improvement in the user experience when using the latest VDA version. The release notes states there is an overall performance improvement in scalability, but the general conclusion states busted ([MythBusters](https://en.wikipedia.org/wiki/MythBusters){:target="_blank"} reference).

It is essential to take the scope of this research into account, as it is focused on scalability without any GPU acceleration. There are several important factors; first, this research is based on the GO-EUC knowledge worker workload, which does not contain any heavy GPU application. Secondly, this research did not have any GPU acceleration, and it is a fully CPU-based scenario.

However, based on the improvement Citrix has added, it is expected to see an improvement when GPU content is part of the workload. GO-EUC often states that without data, you are just another person with an opinion, so this is on the backlog to be researched in the future.

Are you using CVAD 2112 in your environment and seeing overall improvements? Please share your experience in the comments or on the [World of EUC Slack channel](https://goeuc.slack.com){:target="_blank"}.

Photo by [i yunmai](https://unsplash.com/@yunmai?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/scale?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
