---
layout: post
toc: true
title:  "The impact of managing user profiles with FSLogix"
hidden: false
authors: [omar]
categories: [ 'microsoft', 'profiles' ]
tags: [ 'FSLogix', 'microsoft', 'profiles' ]
image: assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-feature-image.png
---
Microsoft acquired the FSLogix solutions in November 2018. The FSLogix acquisition dovetails with Microsoft’s announced Windows Virtual Desktop (WVD), a cloud-based service that offers a Windows 10 experience “optimized” for virtual desktop infrastructure (VDI) and Office 365 ProPlus. But what is the impact of using FSLogix Profile Containers in a VDI scenario? This research will focus on the performance impact and user experience of FSLogix Profile Containers in a VDI scenario.

## The different Windows User profile types
Before we start, it is important to understand the different Windows profile types. The user profile is a very important part of managing and delivering a virtual desktop. In a previous {{site.title}} research the different profiles types were researched and can be found [here]({{site.baseurl}}/performance-difference-between-user-profiles){:target="_blank"}. Go read [this](https://james-rankin.com/features/the-history-of-the-windows-user-profile-in-euc-environments-1994-2019){:target="_blank"} article, author James Rankin, if you need a history into Windows profiles.

Some of the challenges associated with user profiles that may occur are:

  * Multiple configurations of VDI management (hybrid). Persistent, non-persistent and a semi-persistent set of configurations. For example, Outlook Cache Data;
  * Microsoft roaming profile configurations can become quite hefty over time. Spending time configuring specific environment exemptions to address challenges;
  * Microsoft roaming profile corruptions due to the multiple different use cases, operating systems and split of profiles across multiple endpoints;
  * Logon times in VDI environments can become pretty nasty at times, specifically if the profile grows in size;
  * Each image refresh in a VDI environment would, in theory, introduce a reset of the desktop that had been configured as semi-persistent. For example, heavy Outlook users.

Profiles evolve over the different versions of Windows. It’s very likely that end users will move between Windows operating systems and versions (desktop and server). That means that IT has profile version challenges to consider, where a single Windows profile can’t be used across all platforms or devices. Some profiles cannot be shared between different operating systems. Both Windows roaming profiles and FSLogix do not provide the ability to roam settings between these versions. In order to do so, a user environment management (UEM) solution is required.

## FSLogix, the new Windows User profile manager
Profile Container have gone mainstream with the Microsoft acquisition of FSLogix, making Profile Container available to practically everyone. Microsoft also announced a new licensing model for the entire FSLogix suite, including Profile Container.

FSLogix is a simple, easy basic profile management solution to roam user profiles between different devices. The FSLogix Profile Container is more comprehensive compared to the standard roaming profile. A functional difference between the two is that a Profile Container persists all Windows settings and applications, regardless of where they are stored in the user profile (settings stored outside of the user profile can be redirected and persisted with FSLogix App Masking rules). Whereas with a Microsoft roaming profile it is not possible to roam all settings for Windows and applications even for popular applications like Microsoft OneDrive, Teams or even Outlook. When FSLogix is implemented there are multiple tools available to migrate the profile data. Next to the standard tools there are additional scripts available to migrate data from other 3th party solutions. When running a full cloud or hybrid environment, FSLogix provides the possibility to store the Profile Container in cloud storage solutions like an Azure storage account or AWS S3 storage. FSLogix has an active community which may be valuable for additional questions and tweaks.

For more information about FSLogix I recommended to read the following articles: FSLogix website [here](https://fslogix.com/products/profile-containers){:target="_blank"} and Microsoft’s website [here](https://docs.microsoft.com/en-us/fslogix/overview){:target="_blank"}.

More articles can be found here: [Aaron Parker’s stealthpuppy.com](https://stealthpuppy.com){:target="_blank"} (search for “FSLogix” in the post sections) and [james-rankin.com](https://james-rankin.com/category/fslogix){:target="_blank"}.

## Configuration and infrastructure
The goal of the research is to validate the impact of a default Windows roaming versus a default FSLogix installation. And because the size of the user profile impacts the results of the test, we tested with different sizes of user profiles.

This research will contain the following four scenarios:

  * Using a Windows roaming user profile which is the baseline;
  * Using FSLogix Profile Container, 2.9.6964.52690;
  * Using a large Windows roaming user profile;
  * Using a large FSLogix Profile Container.

The size of the user profiles in each scenario is:

  * Each Windows roaming profile is approximately 10.7MB in size, with 134 Files and 112 Folders;
  * Each FSLogix Profile Container is approximately 160MB in VHDX file size;
  * Each Windows roaming profile large is approximately 1.17GB in size, with 4.386 Files and 175 Folders;
  * Each FSLogix Profile Container large is approximately 1.44GB in VHDX file size.

The virtual desktops are configured with 2 vCPUs and 4GB memory, delivered using Citrix, running Windows 10 1809 and are fully optimized using the Citrix Optimizer. It is very important to know this research is done in a stateless environment which means all changes are discarded after each session’s logoff or during each reboot process. More about the {{site.title}} lab environment can be found [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. The default testing methodology is used for this research which is described [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

> **Please note** that these are standard basic setups without exception on certain folders and/or files. It is recommended and a common practice to include exclusions. This approach is similar to other profile management solutions; the same types of exclusions will apply.

## The expectation and results
FSLogix is known for improving the logon times which has a benefit for the user experience. But because FSLogix requires an agent which includes a filter driver there is a small impact expected compared to the baseline. When it comes to large profiles, FSLogix should really show a significant improvement in both logon times and storage resources.

In order to show the impact one of the used metrics is the Login VSI VSImax. This provides a clear indication of the user capacity of the environment. The Login VSI baseline provides insights into the user experience (responsiveness) of the session.

<a href="{{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The Login VSI results show that the default Microsoft roaming scenarios consume lesser resources in comparison to the FSLogix scenarios. Resulting in a capacity decrease of at least 27% for FSLogix. The Login VSI baseline also shows degradation in responsiveness, resulting in a slower user experience.

It is always important to confirm the Login VSI results using other metrics and therefore performance data from the hypervisor is collected. The GO-EUC lab environment is CPU limited and the CPU results should be similar to the Login VSI results.

<a href="{{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-cpu.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-cpu-compare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It is clear that a ‘large’ profile consumes more CPU resources. However, running the default FSLogix setup shows that the CPU resources are no different than from a very large Windows roaming profile. This is not as expected. It does not get any better either if the FSLogix container ‘grows’. Depending on how ‘big’ (large) in size the container is, more CPU resources are required.

The roaming profile functionality is a native feature within the Windows operating system. When using a large profile with a lot of small files, each individual file needs to be copied, which shows an effect of 18% on the CPU Utilization. Although the FSLogix agent is processing an individual profile container it does show it require even more resources when using a large profile container.

On the other hand, knowing that the FSLogix agent only needs to process its profile container once, whereas a Windows roaming scenario goes through the entire user profile ‘folder’, we should see a performance boost at the storage level when it comes to the large scenarios.

<a href="{{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-strorage-compare.png" data-lightbox="storage-compare">
![storage-compare]({{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-strorage-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

FSLogix shows a measurable boost in performance when it comes to storage resources. We almost see the opposite of the CPU results in comparison with the storage results. The large Windows roaming profile scenario shows an increasable impact as expected.

We should see similar results if we compare the scenarios from a network perspective. Namely, from a Windows roaming profile scenario: ‘copying’ and ‘receiving’ the entire profile from a network share will impact network resources. Whereas, FSLogix has less impact on receiving the container, as it is a copy of an entire profile in a single file (container).

<a href="{{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-nice-received.png" data-lightbox="nic-received">
![nic-received]({{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-nice-received.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-nic-transmitted.png" data-lightbox="nic-transmitted">
![nic-transmitted]({{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-nic-transmitted.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-nic-compare.png" data-lightbox="nic-compare">
![nic-compare]({{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-host-nic-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

Nonetheless, both Windows and FSLogix also show a measurable increase in both receiving as transmitting the profile back. The results show, that a bigger profile will consume more network resources for each scenario. The impact difference between a small and a large Microsoft roaming profile is massive in comparison to FSLogix.

One of the first things that a user will notice when they launch their virtual desktop is the logon time. Slow logons are one of the most reported end-user issues when it comes to virtual desktops, which has a huge influence on the overall user experience. Therefore, the average logon time is a key metric to measure the performance of the virtual desktop from the standpoint of the end user. For an end user a slow logon almost always equals to a slow desktop experience, so it’s important to have the logon times as low as can be.
At logon, the user profile is loaded. So, a quick loading time will result in a better user experience. The difference should be noticeable in logon times as mentioned in the introduction.

<a href="{{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-logon-times.png" data-lightbox="logon">
![logon]({{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-logon-times.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-logon-times-compare.png" data-lightbox="logon-compare">
![logon-compare]({{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-logon-times-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The impact on the logon times is huge when we compare the average logon time from the entire test.

For large amounts of profile data, FSLogix Profile Container do a particularly good job improving logon times out of the box, mainly because of how they handle the data volumes. Windows shows an increase in logon time of 148%.

The logon times are negatively influenced if the server reaches its saturation point. Comparing the first 24 minutes provides a more realistic perspective.

<a href="{{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-logon-times-24min.png" data-lightbox="logon-24min">
![logon-24min]({{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-logon-times-24min.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-logon-times-24min-compare.png" data-lightbox="logon-24min-compare">
![logon-24min-compare]({{site.baseurl}}/assets/images/posts/026-the-impact-of-managing-user-profiles-with-fslogix/026-fslogix-logon-times-24min-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

FSLogix shows no real differences in comparing the small versus a large container. Keep in mind that there is a default overhead of FSLogix on the logon times that is not affected by large profiles. Which has a huge benefit on the user experience.

FSLogix is stable and very consistent in both scenarios. Whereas Windows, does exactly what we would expect. A very large Windows roaming profile will impact logon times by a factor 2. A VDI with FSLogix’ Profile Container clearly benefits from decreased logon times in comparison to a large Windows roaming profile.

## Conclusion
The user profile can be a challenging component in a VDI scenario. Applications like Office 365 or OneDrive are not designed to run in a stateless context which can result in a sub optimal user experience. FSLogix is one of the solutions that is built by design for these use-cases, resulting in a better user experience.

The results show that both the large Windows roaming profile and FSLogix Profile Container scenarios have a big impact on capacity. With a clear dependence on the ‘size’ of your user profile, the larger the profile, the greater the impact will be.

FSLogix does show better performances at the storage level. Especially on write actions, FSLogix is doing well in both scenarios, and on reads if we compare only the larger scenarios.

Logon times are an important part of user experience and FSLogix shows a big improvement when it comes to login times with larger profiles.

To summarize, FSLogix is not a performance booster and focusses specific on use-cases like indexing of Office 365, OneDrive and other profile type applications. Based on these results it is important to validate the impact in your own environment to avoid unexpected capacity issues when implementing FSLogix.

If you want to share your insights on using FSLogix Profile Container or would like to discuss our findings, please reach to us or join the [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Sergei Akulich](https://unsplash.com/@sakulich?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/seattle?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
