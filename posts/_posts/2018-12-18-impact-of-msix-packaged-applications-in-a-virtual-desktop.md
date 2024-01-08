---
layout: post
toc: true
title:  "Impact of MSIX packaged applications in a virtual desktop"
hidden: false
authors: [ryan]
categories: [ 'microsoft', 'MSIX' ]
tags: [ 'App-V', 'MSIX', 'Microsoft' ]
image: assets/images/posts/007-impact-of-msix-packaged-applications-in-a-virtual-desktop/007-msix-feature-image.png
---
When delivering a virtual desktop environment, it’s not about the desktop itself, it is all about the applications. There are different packaging and distribution solutions to ensure the applications are delivered to the users. Microsoft is investing in a new packaging format called MSIX. With the Windows 10 1809 release, you can use MSIX packages. But what is the impact using MSIX packages in a VDI scenario? This research will cover the performance impact of MSIX in a virtual desktop environment.

## What is MSIX?
MSIX is an open source package format created by Microsoft. The goal of MSIX is to create one standard for all the applications which will replace traditional MSI installers, setups and AppX (Microsoft Store) apps. MSIX is based on a container solution which isolates the application from the operating system. This is very similar to an existing solution called Microsoft App-V.

When uninstalling an application there will be files and registry settings left behind which can cause performance issues over time. With both MSIX and App-V the package can be removed not leaving anything behind on the system. Distributing the packages allows organizations to quickly deliver and revoke packages which increases the agility within the organization. Another advantage is the isolation, that allows different versions of the same application to run simultaneously on the same system without any conflicts.

Microsoft is intending to move the vendors towards the new packaging format where IT can apply customization on these vendor MSIX packages. Microsoft already tried this strategy with the universal apps, also known as UWP packages, but didn’t succeed. Making the MSIX solution open source helps with adoption in the market but time will tell if it is going to be a success.

The following posts contain more information about MSIX:

  * [Microsoft.com](https://docs.microsoft.com/en-us/windows/msix/overview){:target="_blank"}
  * [Tmurgent.com](http://www.tmurgent.com/TmBlog/?p=2778){:target="_blank"}
  * [Logitblog.com](https://www.logitblog.com/hands-on-msix){:target="_blank"}
  * [Rorymon.com](https://www.rorymon.com/blog/how-to-create-an-msix-package-with-the-msix-packaging-tool){:target="_blank"}

## Configuration and infrastructure
This research will focus on the impact of MSIX. As MSIX has a similar container technology as Microsoft App-V and therefore it is interesting to include Microsoft App-V in the research. The following scenarios are tested:

  * Locally installed application;
  * App-V package local cached;
  * MSIX package.

MSXI does not have a distribution solution like Microsoft App-V so therefore the streaming methods are not included.

This research has taken place on the {{site.title}} platform which is described [here]({{site.title}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. Both MSIX and App-V have no additional infrastructure requirements for the defined scenarios.

One application will be delivered in the different formats. The PDF Reader is used as the default application as these are started multiple times during the workload. Now usually Adobe Reader DC is used but this application is not working properly with this version of MSIX. Therefore, Sumatra PDF is used as the default PDF Reader. More information about the issues with Adobe Reader DC are described on my personal blog [here](https://www.logitblog.com/hands-on-msix){:target="_blank"}.

Microsoft Windows 1809 is used as this is required for MSIX. The virtual desktops are configured with 2vCPUs and 4GB memory. Optimizations are applied using the Citrix Optimizer template 1803. Unfortunately, the optimizations applied in the virtual desktops were inefficient and therefore the Login VSI results cannot be used. This behavior is the same for all scenarios so still valid to compare the other collected metrics.

As always, the default testing methodology is used which is described [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Results
It is known from my previous publication at Project VRC that Microsoft App-V comes with an additional load on CPU which causes higher CPU utilization. As MSIX is based on the same technology it is expected to see a higher CPU utilization compared to a traditionally installed application.

<a href="{{site.baseurl}}/assets/images/posts/007-impact-of-msix-packaged-applications-in-a-virtual-desktop/007-msix-host-cpu-util.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/007-impact-of-msix-packaged-applications-in-a-virtual-desktop/007-msix-host-cpu-util.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

As expected, there is a higher CPU utilization using App-V which is related to the extra running services. It is interesting to see that the overhead of MSIX is lower. MSIX has no additional services which result in a comparable CPU utilization as the locally installed application.

The impact on storage should be minimal to none as there is no streaming or other distribution method used in any of the scenarios.

<a href="{{site.baseurl}}/assets/images/posts/007-impact-of-msix-packaged-applications-in-a-virtual-desktop/007-msix-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/007-impact-of-msix-packaged-applications-in-a-virtual-desktop/007-msix-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/007-impact-of-msix-packaged-applications-in-a-virtual-desktop/007-msix-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/007-impact-of-msix-packaged-applications-in-a-virtual-desktop/007-msix-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Confirmed, from a storage perspective there is no difference as in all scenarios the application and package are available locally. This will be different in an App-V streaming scenario, but that is out of scope in this research.

Application start times are an important factor for the user experience as a slow application start time will result in a negative user experience. When starting an application for the first time all the resources will be loaded into the memory. Starting the application for the second time will improve the start times as resources are still loaded into the memory.

Please note, the following chart is a combination of first time and second time application starts. Login VSI distributes the user over different segments in the workload. If an application is not closed in the previous segment it will be started without reporting the start times.

<a href="{{site.baseurl}}/assets/images/posts/007-impact-of-msix-packaged-applications-in-a-virtual-desktop/007-msix-vsi-appstart-first.png" data-lightbox="app-start-first">
![app-start-first]({{site.baseurl}}/assets/images/posts/007-impact-of-msix-packaged-applications-in-a-virtual-desktop/007-msix-vsi-appstart-first.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/007-impact-of-msix-packaged-applications-in-a-virtual-desktop/007-msix-vsi-appstart-first-bar.png" data-lightbox="app-start-first-compare">
![app-start-first-compare]({{site.baseurl}}/assets/images/posts/007-impact-of-msix-packaged-applications-in-a-virtual-desktop/007-msix-vsi-appstart-first-bar.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The results show there is a big difference between a locally installed application and both App-V and MSIX. Both App-V and MSIX are based on a container technology, also known as the bubble, which needs to be loaded. This will negatively impact the application start times.

<a href="{{site.baseurl}}/assets/images/posts/007-impact-of-msix-packaged-applications-in-a-virtual-desktop/007-msix-vsi-appstart-second.png" data-lightbox="app-start-second">
![app-start-second]({{site.baseurl}}/assets/images/posts/007-impact-of-msix-packaged-applications-in-a-virtual-desktop/007-msix-vsi-appstart-second.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/007-impact-of-msix-packaged-applications-in-a-virtual-desktop/007-msix-vsi-appstart-second-bar.png" data-lightbox="app-start-first-second">
![app-start-first-second]({{site.baseurl}}/assets/images/posts/007-impact-of-msix-packaged-applications-in-a-virtual-desktop/007-msix-vsi-appstart-second-bar.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Starting the application for the second time shows there is a smaller difference between the three scenarios. For both App-V and MSIX, there is a slight overhead. The difference between App-V and MSIX is interesting as it shows MSIX is more efficient in starting for the second time.

## Conclusion
Both MSIX and App-V comes with pros and cons. Both allow isolation, flexibility, and agility with delivering application, but both require specialists to create the packages. This may be different in the future as vendors will adopt the MSIX packaging format as there standard. Please note there still will be customizations involved which may require a specialist.

It’s clear Microsoft is working hard on MSIX but in the current state, it is not usable for many organizations. Organizations that are using App-V are already prepared to move to MSIX but at this stage, it is not recommended.

Container technology in the form of App-V and MSIX comes with an overhead but adds other benefits. Application start times will increase and therefore it is important to verify if the impact is not causing a bad user experience. For most of the applications, the impact will not be noticeable but there are always big and complex applications where the impact is bigger and notable for the users.

Photo by [Annie Spratt](https://unsplash.com/photos/rx1iJ59jRyU?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/wrapping?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
