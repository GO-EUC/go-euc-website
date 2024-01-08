---
layout: post
toc: true
title:  "The true power of VMware OSOT in VDI"
hidden: false
authors: [ryan]
categories: [ 'VMware', 'microsoft', 'windows 10' ]
tags: [ 'VMware', 'OSOT', 'windows 10']
image: assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-feature-image.png
---
Optimizing the golden image is one of the best practices when creating a VDI environment. There are multiple tools available that can help you out with applying all these optimizations. This research will take a closer look at the VMware Operating System Optimization Tool (OSOT) and the performance benefits when using it.

## What is VMware OSOT?
VMware OSOT, which stands for OS Optimization Tool, is a free tool provided by VMware Labs. The tool allows you to optimize an operating system using predefined templates which are created by VMware and the community.

Each template contains optimizations like disabling services, scheduled tasks, removing built-in apps and other specific tweaks. With the GUI the appropriate template can be selected, and each individual optimization can be enabled or disabled. The tool also allows you to analyze all applied optimizations which are displayed in a chart in the top right corner.

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot.png" data-lightbox="vmware-osot">
![vmware-osot]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot.png)
</a>

Out of the box it provides templates for multiple Microsoft operating systems:

  * Windows 7;
  * Windows 8.1;
  * Windows 10;
  * Windows Server 2008;
  * Windows Server 2012;
  * Windows Server 2016.

It comes with various templates for specific use-cases and some default templates are provided by Login VSI. By default, the following templates are available.

  * App Volumes Packaging Machine;
  * Windows 10 – LoginVSI.com;
  * Windows 10;
  * Windows 10 (Horizon Cloud);
  * Windows 2016 – LoginVSI.com;
  * Windows 7;
  * Windows 7 (Horizon Cloud);
  * Windows 8;
  * Windows 8.1;
  * Windows Server 2016 – Desktop;
  * Windows Server 2016 – RDSH;
  * Windows Server 2016 – Server;
  * Windows Server 2008-2012.

Next to the default templates, there are various community templates available in the Public Templates tab.

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-public-templates.png" data-lightbox="vmware-osot-public">
![vmware-osot-public]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-public-templates.png)
</a>

VMware OSOT can be fully automated using the command line interface. This is required when integrating the tool in a deployment solution like Microsoft MDT or System Center Configuration Manager. Details using the command line interface is in the screenshot below.

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-command-line.png" data-lightbox="vmware-osot-command">
![vmware-osot-command]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-command-line.png)
</a>

VMware OSOT is a free tool which can be downloaded right here: [https://labs.vmware.com/flings/vmware-os-optimization-tool](https://labs.vmware.com/flings/vmware-os-optimization-tool){:target="_blank"}

> Please note, the technical preview license applies to VMware OSOT which states no support services and use at own risk. Also “Flings” are experimental and should not be run on production systems. All details can be found here: [https://labs.vmware.com/flings/vmware-os-optimization-tool/license](https://labs.vmware.com/flings/vmware-os-optimization-tool/license){:target="_blank"}

## Scenarios and Configuration
The goal of this research is to see the performance benefit when using VMware OSOT. Therefore, this research contains three scenarios:

  * Default without optimization, as the baseline;
  * Default optimizations from VMware OSOT;
  * All optimizations from VMware OSOT.

The default detected template is used for both scenarios which is the VMware Windows 10 template. All optimizations are applied using VMware OSOT version b1100 9320643 on a Windows 10 1809 VDI, configured with 2vCPU’s and 4GB of memory. The desktop is delivered using Citrix running the VDA 1808.2 with Microsoft Office 2016 x64.

To get consistent and reliable results Windows Defender was disabled and OneDrive removed in all scenarios.

The research has taken place on the {{site.title}} lab environment which is described [here]({{site.baseurl}}/architecture-and-hardware-setup-overview-2018){:target="_blank"}. All scenarios are tested using the default testing methodology which is described [here]({{site.baseurl}}/insight-in-the-testing-methodology){:target="_blank"}.

## Results
It is expected there is a performance gain using an optimizer. This should result in a higher VSImax and lower host resource utilization on any level.

The Login VSI VSImax is one of the best metrics to see if there is a capacity improvement. More information about the VSImax can be found here.

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-vsimax.png" data-lightbox="vsimax">
![vsimax]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-vsimax.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Higher is better</i>
</p>

As expected, there is a capacity gain when using VMware OSOT. When using the full optimization set there is a 16% improvement.

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-baseline.png" data-lightbox="baseline">
![baseline]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-baseline.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The baseline shows an improvement as well which results in quicker response time within the desktop.

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-host-cpu.png" data-lightbox="cpu">
![cpu]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-host-cpu.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-host-cpu-compare.png" data-lightbox="cpu-compare">
![cpu-compare]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-host-cpu-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It is clear when all optimizations are applied it show a stunning 25% improvement in the CPU utilization. Normally, the VSImax should reflect similar results in the CPU Utilization because this is the main bottleneck in the GO-EUC lab. This means there is another factor that has an impact in the VSImax results.

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-host-reads.png" data-lightbox="reads">
![reads]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-host-reads.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-host-reads-compare.png" data-lightbox="reads-compare">
![reads-compare]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-host-reads-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-host-writes.png" data-lightbox="writes">
![writes]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-host-writes.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-host-writes-compare.png" data-lightbox="writes-compare">
![writes-compare]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-host-writes-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

It is strange to see there is a big increase in the host reads/sec while the host writes/sec are as expected. The individual runs are consistent but to ensure the validity of the data, additional validation runs have been done to ensure the quality of the tests, with similar results.

All scenarios have been tested on Windows 10 1803 to ensure if there is not an issue using VMware OSOT with Windows 10 1809. Results showed a similar pattern with a higher host reads/sec. The impact is significantly lower with a 35% increase in the host reads/sec. The cause of this behavior is not clear but it is consistent over both Windows builds. It would be recommended for the VMware OSOT team to take a deeper investigation in the different Windows 10 builds.

The logon times are an important factor to the user experience. This is the first impression of a user and if it takes longer it will have a negative experience.

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-logon-times.png" data-lightbox="logon">
![logon]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-logon-times.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-logon-times-compare.png" data-lightbox="logon-compare">
![logon-compare]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-logon-times-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

At the host saturation point, around 46 minutes in the test, the logon times almost double. In order to compare the logon times, the average in the logon time comparison is based on the first 30 min of the test. The first 30 min have consistent logon times in all scenarios and therefore show the true difference between the scenarios.

It is clear VMware OSOT has a positive impact on the logon times.

Another factor of the user experience is the number of frames send over the protocol. During our tests, we collect the protocol information using Remote Display Analyzer. More information about Remote Display Analyzer can be found here.

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-ica-fps.png" data-lightbox="fps">
![fps]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-ica-fps.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-ica-fps-compare.png" data-lightbox="fps-compare">
![fps-compare]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-ica-fps-compare.png)
</a>

In general, a higher framerate is better, but in this case a lower framerate is also good. As the optimizations contains disabling visual elements in Windows it results in a lower FPS as there is a decrease in visual updates compared to the baseline.

This behavior should also be reflected in the bandwidth as there is less data when all optimizations are applied.

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-ica-bandwidth.png" data-lightbox="bandwidth">
![bandwidth]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-ica-bandwidth.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-ica-bandwidth-compare.png" data-lightbox="bandwidth-compare">
![bandwidth-compare]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-ica-bandwidth-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The results show an improvement in the bandwidth especially when all the optimizations are applied which is especially beneficial in a WAN scenario.

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-ica-rtt.png" data-lightbox="rtt">
![rtt]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-ica-rtt.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

<a href="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-ica-rtt-compare.png" data-lightbox="rtt-compare">
![rtt-compare]({{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-ica-rtt-compare.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Lower is better</i>
</p>

The round trip time, also known as RTT is the latency between the endpoint, the launcher in our case, and the virtual desktop. A high RTT result in delays when the user interacts with the desktop. By only applying optimizations the RTT can be improved which is as well beneficial in a WAN scenario.

## Conclusion
In general, VMware OSOT has a positive impact on performance. Using VMware OSOT results in an increase in user capacity and lower host resource utilization. It also shows benefit from a protocol perspective which is crucial in a WAN scenario.

The tool is easy to use and allows to be automated which is valuable for automated operating system deployments.

> **Beware:** Optimizations may break applications so ensure to proper functional test all applications before applying these. VMware OSOT should not be run on production systems and is not supported, so use at your own risk.

In my opinion, there are some improvements that can make the tool better. Within the user interface, all the optimizations are in a long list and divided into some categories. It is not possible to quickly filter on a specific category, which makes it difficult to quickly filter some settings.

Next to that, it is not possible to view a Windows 10 template from a Windows Server 2016 machine without analyzing the system. It is possible to view the tree with settings but the basic information what the optimization does is not visible.

Right now, there is one universal template for Windows 10 and not for each individual build. As each release of Windows 10 had new features and some are removed it would have made sense to have specific templates.



<a href="https://twitter.com/HilkoLantinga" data-lightbox="Hilko Lantinga">
> <img style="width: 100px; float: left; margin-right: 15px; margin-top: 15px" src="{{site.baseurl}}/assets/images/posts/022-the-true-power-of-vmware-osot-in-vdi/022-vmware-osot-hilko-lantinga.png"/> A special thanks to [Hilko Lantinga](https://twitter.com/HilkoLantinga){:target="_blank"} from VMware for the time to review and share thoughts about these results. The results has been shared with VMware and they will further investigate the storage behaviour.
</a>
>
>
>  	&nbsp;

Share your thought about these results in the comments below or get involved by joining our Slack channel right [here](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Steven Erixon](https://unsplash.com/photos/LOvpejk4nZs?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
