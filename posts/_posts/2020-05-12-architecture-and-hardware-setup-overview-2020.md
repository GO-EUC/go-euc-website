---
layout: post
toc: true
title:  "Architecture and hardware setup overview 2020 – Current"
hidden: false
authors: [ryan, eltjo]
categories: [ 'infrastructure' ]
tags: [ 'infrastructure', 'platform' ]
image: assets/images/posts/000-architecture-and-hardware-setup-overview-2020/000-architecture-and-hardware-setup-overview-2020-feature-image.png
---
This post provides insight into the GO-EUC research environment in terms of hardware and basic architecture. As an independent and open community platform, it is important to provide the correct context and details of the setup used. This way everyone has the opportunity to replicate our research setup and confirm or challenge our findings.

## Platform
As a research platform, the control over the hardware is very important as results can be influenced by many various factors, so therefore the hardware needs to be a stable factor in the research environment. Right from the start, the intention was to invest in dedicated hardware, but due to limited resources, GO-EUC was limited to renting hardware at OVH. The current hardware was donated to GO-EUC which allowed us to further innovate the platform. Thanks to our sponsors LoadGen and Tricitat as they made this possible.

Although the hardware is a generation older, it still provides the stable platform GO-EUC requires. As the technologies advance faster and faster, GO-EUC is always on the lookout for a hardware sponsor opportunity to stay up to par with the latest technologies in the end-user computing sector.

## Hardware
The current research environment consists of five dedicated servers located in our own private small datacenter in the Netherlands. The resources are split into two separate roles, infrastructure servers, and worker servers.

| Role | Model | CPU | Mem | Disk | GPU |
|:---- | :---- | :-- | :-- | :--- | :-- |
| Infrastructure | HPE DL380 Gen 9 | 2x Intel Xeon E5-2640 v3 (2.60 GHz) | 256GB | 1.46TB SSD | NA |
| Infrastructure | HPE DL380 Gen 9 | 2x Intel Xeon E5-2640 v3 (2.60 GHz) | 256GB | 1.46TB SSD | NA |
| Infrastructure | HPE DL380 Gen 9 | 2x Intel Xeon E5-2667 v4 (3.20 GHz) | 256GB | 1.46TB SSD | Tesla M10 |
| Worker | HPE DL380 Gen 9 | 2x Intel Xeon E5-2640 v3 (2.60 GHz) | 256GB | 1.46TB SSD | NA |
| Worker | SuperMicro SYS-6029U-TR4 | 2x Intel Xeon Gold 6148 (2.40 GHz) | 512GB | 1TB SSD | 4x Tesla T4 |

<br>

![hardware-overview]({{site.baseurl}}/assets/images/posts/000-architecture-and-hardware-setup-overview-2020/hardware-servers-overview.png)
<p align="center" style="margin-top: -30px;" >
  <i>GO-EUC hardware</i>
</p>

**Update: January 2021**

Since January 2021, the SuperMicro worker has been added to the GO-EUC environment.
Thanks to NVIDIA provided the GPU capabilities in the form of four Tesla T4 and one Tesla M10 GPU boards as of January 2021.

## Infrastructure
As the name states, the infrastructure servers contain all infrastructure-related roles, which include among others: domain controller, file server, management server, LoadGen servers, remote gateway. By default, the infrastructure is hosted on the VMware vSphere version 6.7 or later.

LoadGen is the primary solution for generating load on the environment, which uses simulated end-points. In the distribution of the capacity, it is important to eliminate all outside interference. Therefore, the simulated end-points are located on a dedicated server.

## Workers
The workers are dedicated servers that will be used for hosting the VDI or RDS scenarios. As shown in the hardware overview table, one worker server does not have GPU capabilities. Depending on the research the appropriate worker is used for the research, by default, this is the one without the GPU.

**Update: January 2021**

Since January 2021, the default worker has been moved to the SuperMicro server as this was added to the GO-EUC environment.

The use of the worker server may vary as not all researches will be using the local workers as the workload might be moved to the cloud. If this is the case, it would be mentioned in the specific research.

The workers are by default configured with VMware vSphere version 6.7 or higher and are configured using the high performance power profile by default. Some configurations might vary depending on the researches.

## Cloud
As the technologies are evolving towards the cloud it is important for GO-EUC to have cloud capabilities. The default strategy is using the hybrid-cloud approach using a site-to-site VPN from the cloud platform to the GO-EUC environment. This strategy enables the usage of the on-premises resources to generate the load using existing automation.

## Update strategy
It is important to stay up to date with the GO-EUC environment, and therefore we strive to use the latest version of solutions and technologies that are used. This might vary over time due to the many releases of various software. As stated in the testing methodology, during the research no updates will be applied in between the tests to ensure consistency of the results throughout the duration of the research. This might vary depending on the topic.
