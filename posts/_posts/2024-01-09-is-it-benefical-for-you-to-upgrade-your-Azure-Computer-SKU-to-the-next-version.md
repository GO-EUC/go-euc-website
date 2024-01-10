---
layout: post
toc: true
title:  "Is it beneficial for you to upgrade your Azure VM SKU to the next version?"
hidden: false
authors: [leee]
reviewers: [esther, sven-j, ryan, eltjo]
categories: [ 'Azure' ]
tags: [ 'Azure', 'Computer', 'SKU', 'Cost', 'Cloud']
image: assets/images/posts/107-azure-SKU-version-tresting-2024/azure_SKU_performance.png
---
Azure has a wide range of different stock-keeping units, better known as SKUs. A SKU refers to a specific version or offering of a resource that is available in Azure. The SKUs are linked to specific characteristics or capabilities of the specific offering. In the case of the Virtual Machine series, these are directly linked to the number of CPUs, Memory, Disk, and, in some cases, GPUs. In Microsoft Azure, SKU stands for Stock-Keeping Unit. It is used to refer to different shapes of the product, such as A series to NV series.

In the context of Azure Virtual Machines, SKU refers to the different sizes and options available for the virtual machines that can be used to run apps and workloads. The available SKUs are categorized into general purpose, compute optimized, memory optimized, storage optimized, GPU, and high performance compute SKUs. Each SKU is optimized for different workloads based on CPU-to-memory ratio, disk throughput, and network performance.


## Understanding the difference in SKU versions
Before diving into the results, let's break down the version of the Virtual Machines SKUs. Each series has a different version, denoted with a version number at the end of the name. In this research, we are using the D series. The D series virtual machines vary mainly on the CPU type that may be allocated, this means that the virtual machine may actually be running on different hardware.

This research is focused on the general-purpose VMs in D-series. These General-purpose VMs feature a balanced CPU-to-memory ratio, making them ideal for a variety of use cases, ranging from web servers to VDIs, for example.

[Dv2 and Dsv2-series VMs](https://learn.microsoft.com/en-us/azure/virtual-machines/dv2-dsv2-series){:target="_blank"}, a follow-on to the original D-series, feature a more powerful CPU and optimal CPU-to-memory configuration, making them suitable for most production workloads. The Dv2-series is about 35% faster than the D-series. Dv2-series run on 2nd Generation Intel® Xeon® Platinum 8272CL (Cascade Lake), Intel® Xeon® 8171M 2.1 GHz (Skylake), Intel® Xeon® E5-2673 v4 2.3 GHz (Broadwell), or the Intel® Xeon® E5-2673 v3 2.4 GHz (Haswell) processors with the Intel Turbo Boost Technology 2.0. The Dv2-series has the same memory and disk configurations as the D-series.

The [Dv3 and Dsv3-series](https://learn.microsoft.com/en-us/azure/virtual-machines/dv3-dsv3-series){:target="_blank"} runs on 2nd Generation Intel® Xeon® Platinum 8272CL (Cascade Lake), Intel® Xeon® 8171M 2.1 GHz (Skylake), Intel® Xeon® E5-2673 v4 2.3 GHz (Broadwell), or the Intel® Xeon® E5-2673 v3 2.4 GHz (Haswell) processors. These series run in a hyper-threaded configuration, providing a better value proposition for most general-purpose workloads. Memory has been expanded (from ~3.5 GiB/vCPU to 4 GiB/vCPU) while disk and network limits have been adjusted per-core to align with the move to hyperthreading. The Dv3-series no longer has the high memory VM sizes of the D/Dv2-series. Those sizes have been moved to the memory-optimized Ev3 and Esv3-series.

The [Dv4 and Dsv4-series](https://learn.microsoft.com/en-us/azure/virtual-machines/dv4-dsv4-series){:target="_blank"} run on the Intel® Xeon® Platinum 8272CL (Cascade Lake) processors in a hyper-threaded configuration, providing a better value proposition for most general-purpose workloads. It features an all-core Turbo clock speed of 3.4 GHz.

The [Dv5 and Dsv5-series](https://learn.microsoft.com/en-us/azure/virtual-machines/dv5-dsv5-series){:target="_blank"} run on the 3rd Generation Intel® Xeon® Platinum 8370C (Ice Lake) processor in a hyper-threaded configuration. The Dv5 and Dsv5 virtual machine sizes don't have any temporary storage, thus lowering the entry price. The Dv5 VM sizes offer a combination of vCPUs and memory to meet the requirements associated with most enterprise workloads. For example, you can use these series with small-to-medium databases, low-to-medium traffic web servers, application servers, and more.

Source: [Azure VM sizes - General purpose - Azure Virtual Machines](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes-general){:target="_blank"}

## Setup and configuration
This research aims to explore the differences in performance when upgrading from one Azure VM SKU to another.
The following SKUs are included: Standard_DS2_v2 – 2 vCPU, 7GB RAM, Premium LRS
* Standard_D2s_v3 – 2 vCPU, 8GB RAM, Premium LRS
*	Standard_D2ds_v4 - 2 vCPU, 8GB RAM, Premium LRS
*	Standard_D2ds_v5 - 2 vCPU, 8GB RAM, Premium LRS 

The SKU codes are deemed to have similar specifications and will be tested using the same workload. The time taken to achieve parts of the workload will be recorded alongside performance metrics to determine which SKU performs the best.

All testing took place in the Azure UK South Data Center.

### Testing Methodology

The methodology used is different compared to our standard. The goal is to have a benchmark that can run independently without any required infrastructure to compare the differences in computing. As multiple solutions were explored, we decided to create our own bespoke benchmark. This method does not simulate a user workload but focuses primarily on testing the compute capabilities.

The benchmark used in this research is written in PowerShell, utilizing fsutil and 7zip to generate load using file writes, reads, and compression. The flow is as follows:

* Create a file of a specific size
  * The following file sizes are used: 4k, 16k, 32k, 128k, 512k, 10MB, 100MB, 500MB
* Copy this file x number of times
  * 4k – 1000
  * 16k – 500
  * 32k - 250
  * 128k – 150
  * 512k – 100
  * 10MB – 50
  * 100MB – 25
  * 512MB – 15
* For each of the above file sizes
  * Read the contents of all these files (Read)
  * Compress all these files using normal compression (Normal)
  * Decompress the archive created using normal compression (-Normal)
  * Compress all these files using maximum compression (Max)
  * Decompress the archive created using maximum compression (-Max)
  * Compress all these files using ultra-compression (Ultra)
  * Decompress the archive created using ultra-compression (-Ultra)
  * Remove all files used (Cleanup)

Compression and Decompression is being used because these tasks are CPU intensive tasks. As the variation between the virtual machine SKUs is the CPU model and speed, we derive a tangible difference in processing time between virtual machine SKUs.

For each step, the timings are measured, which are:
* Copy Files
* Read Files
* Compression_Normal
* Compression_Maximum
* Compression_Ultra
* Decompression_Normal
* Decompression_Maximum
* Decompression_Ultra
* Cleanup Files

These tests were run run on each VM SKU 10 times. Eventually, the results were averaged out for each test type.

At the end of each test, the VM is stopped and deallocated; the VM is then started back up before the next test run. This ensures a high likelihood that the VM will be relocated to a different physical server and/or rack within the Azure data center.

## Hypothesis & Result

Based on the specifications, there are minor changes in the CPU types, but overall, a performance improvement is expected with a higher version. Additionally, there will be an expected cost difference, as the newer SKU versions will have different prices. Generally new SKU versions are cheaper to run, the cheaper price is used as an incentive to consumers to migrate to new hardware and allow for decommissioning of old physical hardware within data centers.

### Analysis

Timing the different stages of each test gives us an idea of the time it takes for each VM SKU, on average, to complete the various stages.

{% include chart.html type='bar' data_file='assets/data/107-azure-SKU-version-tresting-2024/test-timings-per-vm-sku-ms.json' %}

The data shows that the Standard_D2ds_v5 SKU has a speed advantage even though the overall specification is the same with 2vCPU and 8GB of memory. All test methods leverage the advantage of the CPU being a faster CPU for the Standard_D2ds_v5. When reviewing the other virtual machine SKU test results, there are some unexpected outcomes, namely the Standard_DS2_v2, which can be linked to the SKU version as this is the oldest and, therefore, the slowest.

As explained in the introduction, each SKU has a range of CPUs, selected automatically by Azure. As a consumer of the service, you cannot influence which CPU your machine will be allocated. 

During this research, the different CPU models that were allocated in the VM were noted (see below). This is a direct result of the deallocation of the VMs, which could cause the VM to be relocated to the server with a different CPU configuration.

This table shows which processor model was allocated to each VM SKU test. 

| SKU | Processor Name | Count |
| --- | -------------- | ----- |
| Standard_D2ds_v5 | Intel(R) Xeon(R) Platinum 8370C CPU @ 2.80GHz | 10 |
| Standard_D2ds_v4 | Intel(R) Xeon(R) Platinum 8272CL CPU @ 2.60GHz | 10 |
| Standard_D2s_v3 |	Intel(R) Xeon(R) CPU E5-2673 v4 @ 2.30GHz |	6 |
| | Intel(R) Xeon(R) Platinum 8171M CPU @ 2.60GHz |	3 |
| | Intel(R) Xeon(R) Platinum 8272CL CPU @ 2.60GHz | 1 |
| Standard_DS2_v2 |	Intel(R) Xeon(R) CPU E5-2673 v4 @ 2.30GHz |	5 |
| | Intel(R) Xeon(R) Platinum 8171M CPU @ 2.60GHz |	1 |
| | Intel(R) Xeon(R) Platinum 8272CL CPU @ 2.60GHz | 4 |

The Standard_D2s_v3 and the Standard_DS2_v2 SKUs were allocated the same series of processors for several of their tests, whereas the Standard_D2ds_v4 and Standard_D2ds_v5 were allocated the same processor for all tests. Relating this to the measured results clarifies the timing differences.

| SKU | Processor Speed | Count |
| --- | -------------- | ----- |
| Standard_D2ds_v5 | 2793Mhz | 10 |
| Standard_D2ds_v4 | 2594Mhz | 10 |
| Standard_D2s_v3 |	2594Mhz |	1 |
| | 2295Mhz |	6 |
| | 2095Mhz | 3 |
| Standard_DS2_v2 |	2594Mhz |	4 |
| | 2295Mhz |	5 |
| | 2095Mhz | 1 |

Reviewing the speed of the processor for each of the SKU tests, we can see the number of tests that were run on a slightly slower CPU. These details are pulled directly from the virtual machine before tests are run.

What do the performance metrics say? Do they tally with what we are seeing?

{% include chart.html type='line' data_file='assets/data/107-azure-SKU-version-tresting-2024/average-cpu-usage-per-VM-SKU.json' %}

Noticeably, the Standard_D2ds_v4 and Standard_D2ds_v5 CPU metrics stop long before the other SKUs on the test because the workload is processed faster. However, there is a similar pattern of CPU usage between all SKUs. There is one outlier, the Standard_DS2_V2, as it hits the maximum CPU usage at the last measurement. This will greatly affect the timing as CPU cycles will be queued up.

{% include chart.html type='line' data_file='assets/data/107-azure-SKU-version-tresting-2024/disk-queue-length-per-VM-SKU.json' %}

The disk queue length shows the same pattern overall compared to the CPU. Again, the data shows that the Standard_D2ds_v4 and Standard_D2ds_v5 CPU metrics stop long before the other SKUs. There is a higher queue at the end of the test, which is related to the measurements and is a combination of CPU and disk usage. Therefore, the Standard_DS2_v2 has the highest outlier.

{% include chart.html type='bar' data_file='assets/data/107-azure-SKU-version-tresting-2024/total-test-time-per-vm-SKU-mins.json' %}

Also, the total timing of all measurements combined shows that the Startard_D2ds_v5 is the fastest SKU for this series. There is an outlier for the Standard_DS2_v2 because the VM SKU is allocated a processor model that is faster than the v3 SKU is sometimes allocated. See the table above.

### Costs
Costs are always contributing when running virtual machines in public cloud environments. Selecting the “correct” VM SKU for the use case is crucial. 

In this research, costs are considered a secondary factor. We still wanted to give you an overview, though. Let's break it down by showing the SKU cost per minute.

{% include chart.html type='bar' data_file='assets/data/107-azure-SKU-version-tresting-2024/retail-price-per-minute-per-SKU-usd.json' %}

The price per minute is not really as expected. The hypothesis is that the higher version is priced higher due to the newer CPU types, but the data shows this is false. Could this be related to the fact that Microsoft wants to move everyone to a newer SKU so they can lifecycle older hardware? There is no clear answer at this stage, so this will be something to validate at Microsoft.

The Standard_D2ds_v5 SKU is the same price as the Standard_D2ds_v4 machine, but you are always allocated a faster CPU for this VM SKU.

The Standard_D2ds_v4 is due to always run on the 8272CL processor, so you’ll get guaranteed performance from a CPU point-of-view.

The Standard_D2_v3 is the cheapest of all the models but can run on numerous processor models and, therefore, does not get the guaranteed performance. This is why the testing between the Standard_DS2_v2 and Standard_D2_v3 is contentious.
 
The total cost can be calculated based on the total running time and the retail price per SKU version.

{% include chart.html type='bar' data_file='assets/data/107-azure-SKU-version-tresting-2024/test-cost-per-VM-SKU-usd.json' %}

As expected, the Standard_D2ds_v5 has a lower total cost, as this can be related to the lower retail price and based on the total running time. As all measurements are completed faster, this directly influences the total cost. However, this does not reflect a real-life scenario where a user will have a VM powered all day.

## Conclusion
In Azure, most services have different stock-keeping units, also known as SKUs. These SKUs are linked to specific characteristics or capabilities of the specific offering. In the case of Virtual Machines, these are linked to different CPU types and are described on the Microsoft website.

It is essential to understand that when selecting a specific SKU, they will come with different types of CPUs. Each time you stop, deallocate, and start a machine, the machine could be equipped with a different CPU. Depending on your workload, selecting the correct SKU and version is essential to ensure consistency.

As an IT manager or administrator, you cannot guarantee the consistency of the CPU allocated to a virtual machine; it is, therefore, very important to research the SKU being used for the intended purpose. There are a number of Azure services that may help manage costs with virtual machines, such as; Azure Advisor and Autoscaling.

Based on this research, there is no doubt that the Standard_D2ds_v5 SKU will give the best performance for your money compared to the other versions of the Azure D-series SKUs. If you use a lower version of the v2/v3 variety, consider upgrading to the v4 and v5 SKUs to ensure reliable performance when deallocating and restarting your machines. For anyone using capacity management solutions and deallocating machines during non-business times, it’s critical to ensure consistent performance day-to-day.