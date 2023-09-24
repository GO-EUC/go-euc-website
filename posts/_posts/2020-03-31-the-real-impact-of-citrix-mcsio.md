---
layout: post
toc: true
title:  "The real impact of Citrix MCSIO"
hidden: false
authors: [tom]
categories: [ 'citrix' ]
tags: [ '1906', 'citrix', 'MCS', 'MCSIO' ]
image: assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-feature-image.png
---
When delivering a virtual desktop environment, fast storage is one of the key components to achieve a great user experience. Back in the days it was common to use techniques like RAM caching to leverage the fast memory to store data. But does this really provide any benefit? This research will focus on the Citrix Virtual Apps and Desktops Machine Creation Services (MCS) Storage Optimization (MCSIO) performance benefits.

## What is MCSIO
Nowadays with all the fast solid state or NVMe storage drives, storage should not be a bottleneck anymore. Although these types of drives are fast, internal memory is still faster.
Citrix’ Machine Creation Services (MCS) provides a functionality called MCSIO which stand for storage optimization. This functionality reduces the storage load, as it creates a cache in memory that can overflow when full to a disk. This is also known as a two-tier caching system. During the Machine Catalog creation, if configured, this overflow disk is created.

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-catalog-setup.png" data-lightbox="catalog-setup">
![catalog-setup]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-catalog-setup.png)
</a>

MCSIO provisioned machines have an additional driver to intercept and manage storage operations. Since the Citrix Virtual Apps & Desktops version 1903, both Citrix Provisioning (PVS) and MCS share the same driver.
For more information please visit the Citrix documentation [here](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/install-configure/machine-catalogs-create.html){:target="_blank"}.

## Infrastructure and configuration
The research has taken place in the {{site.title}} lab environment which is described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. Based on the requirements of Windows 10, the VM is configured with 2vCPU, 4GB memory, and a 64GB disk. The desktops are delivered using Citrix Virtual Apps and Desktops using MCS running with the Citrix VDA version 1906.2. As Login VSI requires a Microsoft Office, version 2016 x64 is installed within the VM. Where there is MCSIO configured, a 10GB disk is added.

In order to test the improvement of MCSIO, the following scenarios are executed:
  * Default without MCS IO configured, as the baseline
  * MCSIO with 256MB RAM cache
  * MCSIO with 512MB RAM cache

Each scenario is tested using the default testing methodology which is described in detail [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}. As it is a best practice, each deployment is fully updated and optimized using the Citrix Optimizer with the corresponding template.
Scalability is an important factor in the researches on {{site.title}}, but in order to see the behaviour and load of the VM this research is done using a single VM and user.

To ensure the MCSIO cache is used, the default workload has been modified. To generate file load, 256MB of .pst files are copied during the progression of the workload. The used workload in this research can be found [here]({{site.baseurl}}/assets/files/039-the-real-impact-of-citrix-mcsio/KnowledgeWorker_RDA_filecopy.txt){:target="_blank"}.

## Expectations and results
As MCSIO is using a cache in memory, it is expected to see a reduction in storage load. Although this should improve the experience, a filter driver is used and it may have an impact on CPU performance.

This research is focusing on a single VM and user, however, the impact and differences from a host perspective should still be a noticeable.

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-host-cpu.png" data-lightbox="host-cpu">
 ![host-cpu]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-host-cpu-compare.png" data-lightbox="host-cpu-compare">
![host-cpu-compare]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There is no noticeable difference on the CPU utilization. This shows the MCSIO filter driver has no impact on the CPU utilization. This will definitely have a positive impact on the overall user capacity.
As MCSIO is a storage optimization technology, it is expected to see a difference on both reads and writes activities.

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-host-reads.png" data-lightbox="host-reads">
![host-reads]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-host-writes.png" data-lightbox="host-writes">
![host-writes]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-host-storage-compare.png" data-lightbox="host-storage-compare">
![host-storage-compare]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-host-storage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

This is where MCSIO truly shows the benefits. There is a big reduction on the read activities, and a massive improvement on the write activities. As the cache size increases, the load on writes reduces. The data can be stored in memory and so there is less written on the overflow disk. It is important to understand this is very depending on the storage load produced by the workload. As this is a simulated scenario, the benefit in a production scenario may vary.

As this research has taken place with a single VM, this allowed to capture performance data within a VM.

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-cpu.png" data-lightbox="vm-cpu-">
![vm-cpu-]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-cpu-compare.png" data-lightbox="vm-cpu-compare">
![vm-cpu-compare]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Within the VM there is no noticeable difference, which is as expected based on the host CPU utilization.
Based on the host storage metrics, it is expected to see a similar pattern from within the VM.

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-reads.png" data-lightbox="vm-reads">
![vm-reads]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-writes.png" data-lightbox="hvm-writes">
![hvm-writes]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-storage-compare.png" data-lightbox="vm-compare">
![vm-compare]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-storage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The results are opposite from expected. The collected storage metrics are the total from all the disks, which included the overflow disk from MCSIO. But within the VM there is a noticable increase in writes. This metric does include the disk activities and add them together. As the 256MB scenario should produce more writes on the overflow disk, it does makes sense.

Although the VM disk does not show any improvement the MCSIO cache and overflow disk are definitely used. In order to validate this, there are dedicated performance counters that provide insight in the MCSIO memory and disk usage.

As MCSIO has an overflow to disk, it is interesting to see the difference in the used memory by the cache. Please note, the baseline is missing as this scenario does not contain MCSIO and therefore these performance counters.

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-ram-cache.png" data-lightbox="vm-ram-cache">
![vm-ram-cache]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-ram-cache.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-ram-cache-compare.png" data-lightbox="vm-ram-cache-compare">
![vm-ram-cache-compare]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-ram-cache-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The charts show that the cache is used in both cases. It makes sense as the 512MB has more room, the cache size is way bigger. An important note, in both scenarios the cache is fully utilized.

Now it is possible to see both read and writes activities in the MCSIO memory cache.

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-ram-reads.png" data-lightbox="vm-ram-reads">
![vm-ram-reads]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-ram-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-ram-writes.png" data-lightbox="vm-ram-writes">
![vm-ram-writes]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-ram-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-ram-compare.png" data-lightbox="vm-ram-compare">
![vm-ram-compare]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-ram-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

There is a spike in the MCSIO cache in the 512MB scenario, which is consistent in each induvial run. This spike is obviously influencing the average for the MCS RAM Read/sec comparison, but at this point it is not clear what is causing the spike. Now please note: the scale of the reads/sec are very low, although there is a big difference in comparisons, this is just an absolute difference of <u>0.06</u> reads/sec.

The writes in the memory are almost identical. It is very clear when the file copies are taking place, that this is causing spikes during the tests. As the same number of files are used in both scenario the results are the same, which is as expected.

Now the same metrics are available for the overflow disk.

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-file-reads.png" data-lightbox="vm-file-reads">
![vm-file-reads]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-file-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-file-writes.png" data-lightbox="vm-file-writes">
![vm-file-writes]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-file-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-file-compare.png" data-lightbox="vm-file-compare">
![vm-file-compare]({{site.baseurl}}/assets/images/posts/039-the-real-impact-of-citrix-mcsio/039-citrix-mcsio-vm-file-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The same spike is visible in the reads from the overflow disk. For the file writes, as the cache size differs, there is a clear difference in the metrics. As the cache of the 256MB is utilized earlier compared to the 512MB cache, this will result in more overflow to disk writes. Therefore, the difference is clearly visible on the host perspective.

One important note, the workload is heavy on writing data but does not generate a lot of read activities. Please take this in account as this will very differ in a real-life scenario.

## Conclusion
In an environment where resources are shared, it is always important to reduce the impact on the components. MCSIO allows to leverage the fast memory which will reduce the storage load.

This research proofs the benefits of MCSIO as there is a great reduction in the load on the storage system. Even with the default configuration, which is using a 256MB with a 10GB overflow disk, there is already a big advantage. In our particular frame of reference, the larger the memory cache, the less there has to be written to disk. In theory even, if you size the cache large enough you can reduce the write activities to zero.

There is a clear difference when looking from a hypervisor or VM perspective. When validating the use of MCSIO it is important to take a look at the specific metrics that are available in the VM.

Even when having very fast storage in place, there is still a benefit using MCSIO as it reduces the storage load. Additionally, as the overflow disk is persistent, it does provide the opportunity to leverage this to store persistent data. It is important to keep the growth of the overflow disk in mind to avoid running out of storage capacity. Another important factor to take into account is the memory allocated for the cache. This memory is claimed by the MCSIO driver and will not be available for the operating system. It is important to have enough memory resources available.

Please take into account this is a simulated scenario and results may vary in production. Therefore, it is highly recommended to monitor the actual MCSIO usage, as our conclusion may be different in a production environment.

Do you use Citrix MCSIO in your environment? Please share your experience or thoughts in the comment below or at the [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Markus Spiske](https://unsplash.com/@markusspiske?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/western?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}.
