---
layout: post
toc: true
title:  "Is performance guaranteed on an Azure VM at all times?"
hidden: false
authors: [leee]
reviewers: [esther, ryan, eltjo]
categories: [ 'Azure' ]
tags: [ 'Azure', 'Compute', 'SKU', 'Cost', 'Cloud']
image: assets/images/posts/110-is-performance-guaranteed-on-an-azure-vm-at-all-times/110-is-performance-guaranteed-on-an-azure-vm-at-all-times.png
---
Azure is a shared public cloud, by definition it means it is utilized by multiple companies all using multiple services at the same time, when running workloads on-premises it is best practice to isolate EUC workloads on separate HyperVisors/Physical Servers. By nature EUC workloads have the potential to be highly resource intensive and unpredictable, it’s not a good idea to share resources with infrastructure workloads. In public cloud scenario’s this cannot be controlled.

Azure’s underlying physical resources are not consistent across all VM SKUs. Azure lists that there are variations within the Azure VM SKUs that could influence the performance, scalability and user experience when used for EUC purposes.

This article aims to delve into this scenario.

## Considerations
If you are running an end user computing environment virtually on-premises then you may have considered resource utilization and contention during the design phase. This would have gone as far down as the physical hardware running hypervisors, depending on different hypervisors there may be different considerations. Things that are usually commonly considered:

- Shared Infrastructure 
  - Storage IOPs
  - CPU Usage
  - Memory Consumption
- Busy Periods
  - Login/Logoff Periods
   - Storage IOPs
   - CPU Usage
 - End of Month/Quarter/Year
   - Report Generation
- Security / Monitoring
  - Anit-Virus / Security Agent Overheads
  - Monitoring or Auditing Agents

These are some common items that are required to be factored into any on-premises solution before sizing any hardware to be purchased or configured. However, when talking about public clouds, these considerations, lead to a couple of questions:

How do we do this in a public cloud environment?

Do we need to do this in a public cloud environment?

Due to the nature of public cloud you never see the underlying hardware performance, are presented everything as PaaS (Platform as a Service). This type of architecture means you cannot really tell how well your VM is performing when using Compute services as you only see the VM performance metrics. Also because this being a platform as a service, you have no control over the performance other than changing SKUs.

We recently conducted research about different <a href="https://www.go-euc.com/is-it-benefical-for-you-to-upgrade-your-azure-computer-sku-to-the-next-version/" target="_blank">Azure Compute SKUs and how performance differs between different versions</a>. This may be worth a read to understand some of the nuances between Azure VM SKUs and how that relates to the underlying hardware.

## Testing Methodology

The methodology used is different compared to our standard. The goal is to have a benchmark that can run independently without any required infrastructure to compare the differences in performance and length of time taken to complete a set of tasks. Multiple solutions were explored and in the end the decision was made to create a bespoke benchmark for this research project.. This method does not simulate a user workload but focuses primarily on testing the compute and storage capabilities.

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
  * Read the contents of all these files
  * Compress all these files using normal compression
  * Decompress the archive created using normal compression
  * Compress all these files using maximum compression
  * Decompress the archive created using maximum compression
  * Compress all these files using ultra-compression
  * Decompress the archive created using ultra-compression
  * Remove all files used

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

The main reason timings of completion for specific tasks were selected as the overall measure of performance is because we cannot gauge any resource contention on a physical level. Simply measuring time to completion gives us an indication if performance is consistent. 

These tests will be run continuously for a 24 hour period, the timings for each task will be logged at the end of each run. The tests are then repeated, times between these tests will then be compared during the various time windows to see if at any point in that period there is a pattern. The Azure compute SKU used in this test is the Standard_D2ds_v5 SKU. The Standard D2ds_v5 SKU was selected because the D series SKU is one of the most popular and the processor applied to the v5 SKU is always the same. All testing is performed in the Azure UK South region and the virtual machine in question is using premium SSD storage. 

Performance details for the Azure SKU in question can be found here:
<a href="https://learn.microsoft.com/en-us/azure/virtual-machines/ddv5-ddsv5-series#ddsv5-series" target="_blank">Ddv5 and Ddsv5-series - Azure Virtual Machines | Microsoft Learn</a>

Performance details for the Azure Premium SSD disks can be found here:
<a href="https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types#premium-ssd-size" target="_blank">Select a disk type for Azure IaaS VMs - managed disks - Azure Virtual Machines | Microsoft Learn</a>

In our particular case, the Standard_D2ds_v5 VM is using a Premium SSD that is 128GB in size.

| Premium SSD Size | P10 |
| --- | -------------- |
| Disk size in GiB | 128 |
| Base provisioned IOPS per disk | 500 |
| Base provisioned Throughput per disk | 100 MB/s |
| Max burst IOPS per disk | 3,500 |
| Max burst throughput per disk | 170 MB/s |
| Max burst duration | 30 min |

## Hypothesis & Result

The expectation of someone paying for a public cloud service is that the necessary policies are put in place to ring fence resources and for hardware to not be over-provisioned to a point where it may impact performance. In reality, this may not be possible on such a large scale where thousands of companies are sharing the same physical hardware. There is no way for Microsoft to understand what type of workload you are running. The expectation is that there is some inconsistency in performance due to the nature of multiple disparate workloads.

The test results collected have been reviewed to analyse the response times for all tests within a given time period and then to group those response times by the time period. All results are an average of the particular time period.

Testing was performed starting on a Friday evening at 10pm GMT through to 9pm the following day and repeated for 5 days. The first hour and last hour of testing are excluded, as tests are repeated and the execution no longer begins on the hour, this therefore rules out the results as they are not consistent for each and every run.

Test run days of the week:
- Friday > Saturday
- Saturday > Sunday
- Sunday > Monday
- Monday > Tuesday
- Tuesday > Wednesday

{% include chart.html scale='auto' type='line' data_file='assets/data/110-is-performance-guaranteed-on-an-azure-vm-at-all-times/saturday-line.json' %}

{% include chart.html scale='auto' type='line' data_file='assets/data/110-is-performance-guaranteed-on-an-azure-vm-at-all-times/sunday-line.json' %}

{% include chart.html scale='auto' type='line' data_file='assets/data/110-is-performance-guaranteed-on-an-azure-vm-at-all-times/monday-line.json' %}

{% include chart.html scale='auto' type='line' data_file='assets/data/110-is-performance-guaranteed-on-an-azure-vm-at-all-times/tuesday-line.json' %}

{% include chart.html scale='auto' type='line' data_file='assets/data/110-is-performance-guaranteed-on-an-azure-vm-at-all-times/wednesday-line.json' %}

These graphs generally show a consistent execution time with a very small variance between data points.

### Analysis

The expectation when sharing physical hardware across any enterprise is always, at some point you will impact performance due to resource contention. In public cloud environments you could almost say that it would be more than probable. Based on the collected results the initial hypnosis is busted as it shows a consistent and reliable performance.

{% include chart.html scale='auto' type='line' data_file='assets/data/110-is-performance-guaranteed-on-an-azure-vm-at-all-times/summary.json' %}

The above graph depicts the total average execution time of all tests for the entire period of 24 hours. There is a small increase in execution speed over the weekend period with a slow ramp up to the middle of the week. That being said, the variance in these numbers of fractions of a second.

## Conclusion
Public Cloud is being adopted in may areas to support business growth and flexibility, as a consumer you have no influence on how your workloads or provisioning may influence performance. Based on historical reference and recommended best practices from on-premises deployments it would seem logical that Public Cloud may not do a great job managing all these mixed workloads, that was the original hypothesis.

It’s highly impressive that public cloud providers are able to guarantee such a consistent performance profile for a virtual machine during any period of the day and week. As a business it gives a level of comfort to understand that using the latest virtual SKU can provide consistent performance.

There is  a difference in execution response times during the weekends and the weekdays but the performance impact to a user is negligible. It’s more than likely that a user would not notice a perceivable difference.

The results gathered are from a single VM at a single point in time, it is possible that it was a period in time where there was no contention and everything was great. The results may change for multiple VMs in different regions or with different applications in play. Make sure you perform your own testing and judge situations based on your own scenarios also.

Photo generated by AI.