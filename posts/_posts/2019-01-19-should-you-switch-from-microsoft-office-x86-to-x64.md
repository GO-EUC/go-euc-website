---
layout: post
toc: true
title:  "Should you switch from Microsoft Office x86 to x64?"
hidden: false
authors: [ryan]
categories: [ 'microsoft', 'office' ]
tags: [ 'microsoft', 'office', 'x86', 'x64' ]
image: assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-to-x64-feature-image.png
---
A couple weeks ago Microsoft announced the switch for the default installation of Office from x86 to x64. Within VDI deployments it has always been common to deploy an x86 version of Office. What is the difference between these architecture versions and is there any impact? This research will cover the performance impact difference between x86 and x64 of Microsoft Office.

## Microsoft announcement
As mentioned in the introduction Microsoft announced they are switching the default installation to x64 architecture.
<a href="{{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-default-installation-settings-microsoft.png" data-lightbox="office-installation">
![office-installation]({{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-default-installation-settings-microsoft.png)
</a>

Twitter message from Jesper Nielsen (MVP):

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Starting mid-january <a href="https://twitter.com/Microsoft?ref_src=twsrc%5Etfw">@Microsoft</a> will start installing <a href="https://twitter.com/Office?ref_src=twsrc%5Etfw">@Office</a> ProPlus and Office 2019 with 64-bit as the default setting. Previously, the default setting was 32-bit at installation <a href="https://t.co/gIqO8y1zbo">pic.twitter.com/gIqO8y1zbo</a></p>&mdash; Jesper Nielsen [MVP] (@dotJesper) <a href="https://twitter.com/dotJesper/status/1080128173537480705?ref_src=twsrc%5Etfw">January 1, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Once you click install from the Office365 portal it will now install the x64 version of Office by default. It is still possible to switch to the x86 architecture. With the current processor architectures and the amount of memory consumed in device nowadays, it makes sense to switch to x64. Microsoft already made the decision with Windows 10 to only provide x64 version and have dropped the x86.
The advantage using x64 bit version of Office is the amount of memory that can be consumed. When using extreme large Excel sheets there is probably a preference for the x64 version. Of course, there is also a downside. In many organizations, there are many applications and specific plugins that integrate with Office. There is a chance some of these integrations or plugins may not work. When migrating it is recommended to validate if all those plugins and integrations still work.

## Configuration and infrastructure
This research has taken place on our infrastructure which is described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. The goal is to see the impact switching from x86 to x64 bit version of Office. This resulted in the following scenarios:

  * Microsoft Office 2016 x86 as the baseline test;
  * Microsoft Office 2016 x64.

As shown in our previous Microsoft Office compare [post]({{site.baseurl}}/office-2019-performance-impact){:target="_blank"}, we have specifically chosen for Microsoft Office 2016 as these provide reliable results. This has nothing to do with Microsoft Office but with the benchmarking tool used in {{site.title}} named Login VSI.

Both test scenarios have been tested on Windows 10 1809 configured with 2vCPU and 4GB memory. The desktop delivery solution is Citrix Virtual Apps & Desktops running version 1808.2. The desktops are running in a stateless scenario, so all changes within the desktop are discarded before the next test.
Our default testing methodology is applied which is described [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Results
When testing scenarios like these there is always an expectation of the outcome. For this research, the expected result is a slightly higher load using x64. As this architecture has the capabilities to consume more resources.
As mentioned, Login VSI is used and one of the key metrics is the VSImax. More information about the VSImax can be found on the Login VSI website [here](https://www.loginvsi.com/blog-alias/login-vsi/481-calculating-maximum-virtual-desktop-capacity-vsimax-explained){:target="_blank"}.

<a href="{{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The VSImax results show there is no difference between Microsoft Office x86 and x64. This means when migrating there is no capacity impact.
Another valuable metric is the Login VSI baseline. This show how responsive the desktop is in an optimal state with a minimal load.

<a href="{{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The baseline also shows no difference between both scenarios. Based on the VSImax and baseline results we also expect there is no difference in the host CPU utilization as the capacity limitation is CPU bounded in the {{site.title}} lab.

<a href="{{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-host-cpu-util.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-host-cpu-util.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

This confirms the VSImax results. One of the benefits of x64 is it can consume more memory, so this is also an interesting metric to validate.

<a href="{{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-host-free-mem.png" data-lightbox="memory">
![memory]({{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-host-free-mem.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-host-free-mem-compare.png" data-lightbox="memory">
![memory]({{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-host-free-mem-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The results show x64 consumes on average 23% more memory. It is interesting to see over time there is no difference between the scenarios. Other key metrics that are always covered are the storage metrics.

<a href="{{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-host-reads-compare.png" data-lightbox="reads-compare">
![reads-compare]({{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-host-reads-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-host-writes-compare.png" data-lightbox="writes-compare">
![writes-compare]({{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-host-writes-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

For both reads/sec and writes/sec there is a small improvement of 4%.
An important factor in user experience are the applications start times. If an application takes longer to start it can result in negative user experience.

<a href="{{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-appstarts.png" data-lightbox="app-start-compare">
![app-start-compare]({{site.baseurl}}/assets/images/posts/017-should-you-switch-from-microsoft-office-x86-to-x64/017-office-x86-x64-appstarts.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

For most of the applications in the Microsoft Office suite, the application start times improve with a couple percent except for Microsoft Excel.
Microsoft Outlook x64 shows the biggest improvement in the application start times with an improvement of 16%.

## Conclusion
Microsoft shows x86 architecture is becoming legacy. First Windows 10 that is only available in x64 architecture and now the default installation of Microsoft Office as well. This research shows migrating from Microsoft Office x86 to x64 has no performance impact on capacity but shows a small improvement in the application start times. From a performance perspective, there is no reason to not migrate. There are always some plugins and integrations from other applications that might not work with x64. Therefore, it is very important to validate all those applications and plugins to ensure they work as expected.

Photo by [Launde Morel](https://unsplash.com/photos/KzzrxritpVk?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
