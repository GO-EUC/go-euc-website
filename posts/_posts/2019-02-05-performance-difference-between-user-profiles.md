---
layout: post
toc: true
title:  "Performance difference between user profiles"
hidden: false
authors: [ryan]
categories: [  'microsoft', 'profiles' ]
tags: [ 'profiles', 'microsoft', 'local', 'mandatory', 'roaming' ]
image: assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-feature-image.png
---
The user profile is a very important part for delivering a virtual desktop. It can have a huge impact on the overall user experience. But what are the options and are there any performance differences between the different profile methods? This research will focus on the performance impact of the different profile types available on Windows 10.

## The different profile types
It is important to understand the different profile flavors that are available in Windows 10. This has not changed in the last decade and consists of four types.

  * Local user profile;
  * Roaming user profile;
  * Mandatory user profile;
  * Temporary user profile.

### Local user profile
This profile type is stored locally on the hard disk of the computer or virtual machine. The local user profile is created during the first time that a user logs on to a computer. All the changes are made to the local user profile and are specific for the user and computer or virtual machine on which the changes are made. Using another computer or virtual machine will not contain the same changes as the settings are not synchronized between machines.

### Roaming user profile
The roaming profile is a copy of the local profile that is copied to another, usually central location. The profile is downloaded to any computer that a user logs onto on a network. The changes that are made to the roaming user profile are synchronized to the central location when the user logs off. Using another computer or virtual machine will contain the same changes that are made within the user profile as the profile is synchronized at user logon. Important note, version of the roaming user profile changes with the different versions of Windows. More information can be found here.

[https://docs.microsoft.com/en-us/windows-server/storage/folder-redirection/deploy-roaming-user-profiles#appendix-b-profile-version-reference-information](https://docs.microsoft.com/en-us/windows-server/storage/folder-redirection/deploy-roaming-user-profiles#appendix-b-profile-version-reference-information){:target="_blank"}

### Mandatory user profile
The mandatory user profile is a type of profile that administrators can use to apply a specific setting to the users. Only administrators can make changes to the mandatory user profile. All changes that are made by the user will be lost at user logoff as the profile will be discarded.

### Temporary user profile
The temporary profile is created each time when an error prevents the user’s profile from loading. Temporary profiles are deleted at the end of the session and all changes are discarded.

### Configuration and infrastructure
The goal of the research is to validate the impact of the different profile types. In a virtual desktop environment, it is common to use a user environment management (UEM) solution. This is used to apply adjustments and often synchronized specific settings within the user profile. As the goal is to validate the different profile types using a UEM solution is out of scope. This research will contain the following scenarios:

  * Using the default local user profile which is the baseline;
  * Using a roaming user profile;
  * Using a mandatory user profile from a share;
  * Using a mandatory user profile stored locally.

The temporary user profile is not included as this only occurs when there is something wrong that prevents the user’s profile from loading. In this research, no folder redirection is used. As always, the default infrastructure is used which is described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}.

All VM’s are configured with 2vCPU’s with 4GB memory delivered using Citrix running Windows 10 1809 and is fully optimized using the Citrix Optimizer. It is very important to know this research is done in a stateless environment which means all changes are discarded. The default testing methodology is used for this research which is described [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## The expectation and results
It is known roaming profiles is not recommended in a virtual desktop use-case. All settings will be synchronized to the central location which can grow over time. This is all depending on the number of applications and data stored in the profile. By default, there is limited control, so this will result in a higher load of the copy action and slower logon times. Using a local or mandatory profile should be the most efficient way for a virtual desktop scenario.

Before covering the results, it is important to understand the different profile sizes.

  * The default profile: 2.67MB;
  * Local profile on disk: 78.8 MB;
  * Roaming profile on a share: 46MB;
  * Mandatory profile: 376KB.

The mandatory profile is created using the Sysprep method which is described on the Microsoft website [here](https://docs.microsoft.com/en-us/windows/client-management/mandatory-user-profile){:target="_blank"}. The profile is stripped as much as possible till the size is the 376KB.

The Login VSI VSImax results represent the overall capacity of the scenarios. The VSImax is the defacto industry standard metric and is calculated a score to detriment the saturation point of the virtual desktop environment. More information about the VSImax is explained [here](https://www.loginvsi.com/blog-alias/login-vsi/481-calculating-maximum-virtual-desktop-capacity-vsimax-explained){:target="_blank"}.

<a href="{{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

The Login VSI VSImax shows roaming user profiles is the most optimal scenario from a capacity perspective which is not as expected.

It is important to validate if the VSImax score is reflected in the Login VSI baseline.

<a href="{{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The Login VSI baseline shows a minimal to no difference between the scenario, which means the response times are similar.

Within {{site.title}} the saturation point is CPU related, so according to the VSImax there should be a difference in CPU load between the scenarios.

<a href="{{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-host-cpu.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-host-cpu-compare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The CPU load between the scenarios corresponds with the VSImax results. There is an expected difference from a storage perspective as there are different copy methods used for each profile type.

<a href="{{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-host-reads-compare.png" data-lightbox="reads-compare">
![reads-compare]({{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-host-reads-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>


<a href="{{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-host-writes-compare.png" data-lightbox="writes-compare">
![writes-compare]({{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-host-writes-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It clearly shows having a small mandatory profile have a negative result on the storage reads and writes. The data missing within the profile will be restored from the default profile which results in higher storage load. A complete mandatory profile should, in theory, have a lower storage footprint.

It makes sense the roaming user profiles have less storage impact. The profile is most complete compared to a new local and mandatory user profile. This would be different in a stateful environment. Another import factor is the logon time which has a huge influence on the user experience. At logon the user profile is loaded so a quick loading time will result in a better experience.

<a href="{{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-logon-times.png" data-lightbox="logon">
![logon]({{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-logon-times.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-logon-times-compare.png" data-lightbox="logon-compare">
![logon-compare]({{site.baseurl}}/assets/images/posts/010-performance-difference-between-user-profiles/010-profiles-logon-times-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The trend in this post is also reflected in the logon times. A roaming user profile is the best performing profile type. During the logon the roaming user profile is copied over which is relatively small in this research scenario. Both the local and mandatory profile needs to rebuild the profile on disk which has a negative effect on the logon times.

## Conclusion
These results are not as expected and show a roaming user profile is the best profile type to use. This is not what we would recommend to our customers. It is important to understand the context of the research. The desktops are stateless where all changes are discarded at logoff. In a local user profile scenario every time a user logs on, a new profile is created which require more resources than from a copy action for a roaming user profile. But the roaming user profile is depended on the size of the profile. Users will experience slower logon times over a longer period as the profile grows. This has to do with settings from different applications and the amount of data stored in the documents. A Login VSI user uses a limited set of applications and does not store any data within the documents.

In this research, the mandatory profile is the worst performing profile type. This has to do with small mandatory profile used for this research. It shows it is important to validate if the profile is complete with all the required files which are interesting to further investigate in another research. There is no difference if the profile is stored locally or on a share, but keep in mind this is lab environment and will be different in a production environment.

Photo by [Val Vesa](https://unsplash.com/photos/ihFWKicceNk?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/silhouette?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
