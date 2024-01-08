---
layout: post
toc: true
title:  "Performance impact of Microsoft Office 2021 LTSC"
hidden: false
authors: [krishan]
reviewers: [omar, jeff, bas, sven, tom, ryan, eltjo]
categories: [ 'Office' ]
tags: [ 'Office', '2019', '2021', '2016']
image: assets/images/posts/091-performance-impact-of-microsoft-office-2021-ltsc/performance-impact-of-microsoft-office-2021-ltsc-feature-image.png
---
Microsoft released Office 2021 LTSC on October 5th, 2021. Microsoft Office is a popular software suite, widely used by both consumers and organizations. It is most well-known for programs such as Word, Excel, PowerPoint and Outlook.

LTSC, which stands for Long-Term Servicing Channel, is a term that is also used with Windows 10 and Windows Server on-premises editions. This article covers the notable differences between the two other editions, as well as the performance impact of the LTSC version compared to Microsoft Office 2021.

This release is the most recent perpetual or non-subscription based Office version of Microsoft. This release is an LTSC version that will not receive any new features. However, the monthly security and quality updates will be released. More information can be found [here](https://docs.microsoft.com/en-us/officeupdates/update-history-office-2021){:target="_blank"}.

There are some differences between Office 2021 LTSC and previous Office versions. They are:

  * Co-authoring document is not available in Office 2021 LTSC.
  * Modern Comments is not available in Office 2021 LTSC.
  * See who is working in our document is not available in Office 2021 LTSC.
  * Visual Refresh is not available, solely for Office 2021 and Office 365.
  * Sheets View is not available in Office 2021 LTSC.
  * Link to a slide is not available in Office 2021 LTSC.

## What's new in Office 2021 LTSC
Before covering the results, some of the new features are summed up:

  * XLOOKUP function in Excel.
  * Dynamic arrays in Excel
  * LET, XMATCH function in Excel.
  * New and improved Record Slide Show.
  * Instant Search to quickly find emails.
  * Dark Mode in Word.
  * Performance improvements in Word, Excel, PowerPoint and Outlook.

For a complete overview of all the new features and improvements, please read the following article: [What's new in Office 2021 - Microsoft](https://support.microsoft.com/en-us/office/what-s-new-in-office-2021-43848c29-665d-4b1b-bc12-acd2bfb3910a#:~:text=In%20Office%202021%2C%20you'll,features%2C%20and%20so%20much%20more!){:target="_blank"}.

## Infrastructure and configuration
This research has taken place on the GO-EUC infrastructure, which is described [here](https://www.go-euc.com/architecture-and-hardware-setup-overview-2020/){:target="_blank"}. All Windows 10 21H2 deployments are created using a similar MDT deployment, including all required software. Conform best practices, the latest Windows updates are applied, including the recommended optimization template of the latest available Citrix Optimizer version.

The following scenarios are part of this research:
  * Office 2016 build 16.0.4266.1001, as the baseline;
  * Office 2019 Version 2112 Build 14729.2026;
  * Office 2021 LTSC Version 2108 Build 14332.20204.

This research has been executed with [LoadGen](https://www.loadgen.com/){:target="_blank"} performance tooling using the following testing [methodology](https://www.go-euc.com/insight-in-the-testing-methodology-2020/){:target="_blank"}.

## Expectations and results
As with each Microsoft Office release, new features are added that could have an impact on performance and user experience. Interestingly, Microsoft claims performance improvements should be seen in Word, Excel, PowerPoint and Outlook.

Based on this claim, it is naturally expected that this Office version will have a positive performance impact compared to other editions. And testing should, of course, produce results consistent with this claim.

To clarify let’s take a look at the hypervisor performance results.

{% include chart.html type='line' data_file='assets/data/091-performance-impact-of-microsoft-office-2021-ltsc/host-cpu-util.json' %}

{% include chart.html type='bar' data_file='assets/data/091-performance-impact-of-microsoft-office-2021-ltsc/host-cpu-util-compare.json' %}

The results show a difference in performance impact at the host CPU level. Comparing Office 2021 LTSC with the baseline Office 2016, there is a six percent performance degradation. A more compelling result is the comparison between Office 2019 and Office 2021 LTSC. Based on the above-shown result, the CPU utilization of Office 2019 is 18 percent more than Office 2021 LTSC.

The result is not as expected and is contrary to the statement Microsoft made about performance improvements. It depends on how performance improvements is clarified. If the UI is more responsive or quicker, then there is a performance improvement, which could come at resource cost like CPU. When upgrading from Office 2019 to Office 2021 LTSC this percentage should be taken into account. This could have a performance impact in a VDI environment. Of course, it depends on how the environment is sized.

{% include chart.html type='line' data_file='assets/data/091-performance-impact-of-microsoft-office-2021-ltsc/host-memory.json' %}

{% include chart.html type='bar' data_file='assets/data/091-performance-impact-of-microsoft-office-2021-ltsc/host-memory-compare.json' %}

Comparing the memory results, the performance impact is slightly decreased when compared to Office 2016. Compared to Office 2019, the performance is negatively impacted by two percent. That two percent is small, meaning the performance impact on memory is neglectable.

{% include chart.html type='line' data_file='assets/data/091-performance-impact-of-microsoft-office-2021-ltsc/host-reads.json' %}

{% include chart.html type='line' data_file='assets/data/091-performance-impact-of-microsoft-office-2021-ltsc/host-writes.json' %}

{% include chart.html type='bar' data_file='assets/data/091-performance-impact-of-microsoft-office-2021-ltsc/host-storage-compare.json' %}

The results outlined in the above stated graphs and chart depend on which Office version the comparison is made. When Office 2021 LTSC is compared to the baseline Office 2016, the Commands/Sec and Reads/Sec increase. This also applies to Writes/sec.

So moving from Office 2016 to Office 2021 LTSC could have a performance impact in a VDI environment. Now the first two counter (host storage reads and writes) are memory counters and most likely (if sized right) won’t have a performance impact. For Writes/sec this could be noticeable, but it highly depends on the storage configuration. With “spinning disk”, the writes could be noticeable. With the current caching, storage techniques, and possibly all-flash configurations, the Writes/sec will not have a (performance) impact on the end-user experience.

A more surprising and positive result is comparing Office 2019 and Office 2021 LTSC. The performance impact is almost neglectable based on the results, and an end-user won’t notice.

## Conclusion
As many consumers and organizations widely use Microsoft Office, it is interesting to see which performance impact it could have on a VDI environment. It is important to know that Office 2021 LTSC is supported on Windows Server 2022 and Office 365 is not yet. For more information please look at [Windows and Office configuration support matrix](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE2OqRI){:target="_blank"}.

The data shows some results that are not expected. More specifically, the CPU Utilization slightly increased when Office 2016 (baseline) and Office 2021 LTSC were compared. The CPU Utilization comparison between Office 2019 and 2021 LTSC is surprising. The difference between these versions is 18 percent, where Office 2021 LTSC is using more CPU resources. That’s relatively high, and it is unknown which component or new features are responsible for the increased CPU usage.

Microsoft states the following on their [website](https://support.microsoft.com/en-us/office/what-s-new-in-office-2021-43848c29-665d-4b1b-bc12-acd2bfb3910a){:target="_blank"}:

> Experience improved performance, stability, and speed across Word, Excel, PowerPoint, and Outlook.

It depends on which point of view “performance improvements” has been made. If several actions/calculations in Word, Excel, PowerPoint, and Outlook are faster in Office 2021 LTSC, these improvements may come at a resource cost, like CPU and Memory. This is shown in the data, especially at the CPU Host Utilization level.

Nonetheless the increased usage does not say anything about the user experience. And it also does not mean that increased CPU usage is a bad thing. If the end-user experience is at least the same or even better then there is a performance improvement like Microsoft stated. But it should be kept in mind that it will come at some resource costs based on the data.

When Office 2021 is compared to the two previous versions, the memory usage has increased a few percent. This percentage is so small that this could not impact your environment.

Storage metrics increased approximately 8 to 17 percent. Although these percentages could be high, it depends on the memory and storage configuration in your environment. When sized right, these increases will not impact your environment.

**Disclaimer:** These results are based on our context, described in the infrastructure and configuration section, and might differ when implemented in production because of the application landscape, plugins, and other factors. Therefore, it is always important to validate this in your environment in a controlled manner by using [LoadGen](https://www.loadgen.com){:target="_blank"} for example.

Overall the performance on resources usage has been slightly increased, meaning Office 2021 uses more resources. Keep in mind that it does not say anything about the perceived user experience.

Do you see the same results in your environment? Please share your experience below or on the [Slack Channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Sid Suratia](https://unsplash.com/@sid_suratia?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/train-office-blur?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
