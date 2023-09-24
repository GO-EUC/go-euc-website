---
layout: post
toc: true
title:  "Performance impact of Windows 10 21H1"
hidden: false
authors: [ryan, omar]
reviewers: [sven, eltjo, marcel, jeff]
categories: [ 'Windows 10' ]
tags: [ 'Windows 10', '2004', '2009', '20H2', '21H1']
image: assets/images/posts/077-performance-impact-of-windows-10-21h1/performance-impact-of-windows-10-21h1-feature-image.png
---
Even though Windows 11 is generally available since this month, this does not mean every organization is directly migrating toward Windows 11. With the continuous improvements in Windows 10 and the support cadence, organizations are still upgrading to a newer Windows 10 release. Therefore, this research will focus on the performance differences in a VDI context between the latest Windows 10 releases, including both 20H2 and 21H1.

## What's new in Windows 10 21H1
Before covering the results let's first start covering the new features and improvements of the Windows 10 21H1 release.

  * New Windows Hello multi-camera feature.
  * News and interests widget for Windows 10 21H1 taskbar.
  * Windows Mixed Reality new feature to set the sleep timer for headsets.
  * Windows Defender Application Guard (WDAG) improvements.
  * Windows Management Instrumentation (WMI) Group Policy Service (GPSVC) improvements.
  * New Microsoft Edge (Chromium) support for kiosk mode on Windows 10 May 2021 Update.
  * WinHTTP Web Proxy Auto-Discovery Service improvements.
  * Updates the Open Mobile Alliance (OMA) Device Management (DM) sync protocol.
  * Windows 10 startup times for apps with roaming settings improvements on version 21H1.
  * Windows Server Storage Migration Service new feature to migrate from NetApp FAS arrays to Windows Servers and clusters.

For a complete overview with all the new features and improvements, please read the following article: [Windows 10 21H1 new features and changes - Pureinfotech](https://pureinfotech.com/windows-10-21h1-new-features/){:target="_blank"}.

## Infrastructure and configuration
This research has taken place on the GO-EUC infrastructure, which is described [here](https://www.go-euc.com/architecture-and-hardware-setup-overview-2020/){:target="_blank"}. All Windows deployments are created using a similar MDT deployment including all required software. Conform best practices, the latest Windows updates are applied, including the recommended optimization template of the latest available Citrix Optimizer version, at the time of testing. In the case of Windows 10 21H1, the recommended template is the previous edition, which is Windows 10 20H2.

The following scenarios are part of this research:

  * Windows 10 1909, build 18363.1679, as the baseline
  * Windows 10 2004, build 19041.1110
  * Windows 10 20H2, build 19042.1110
  * Windows 10 21H1, build 19043.1110

This research has been executed using LoadGen using the following [testing methodology](https://www.go-euc.com/insight-in-the-testing-methodology-2020/){:target="_blank"}.

## Expectations and results
It is not the first time multiple Windows 10 builds are tested at GO-EUC, so based on the previous researches it is expected to see a small difference in terms of performance. The big question is, will [Moore's law of increasing Windows 10 performance impact](https://www.go-euc.com/moores-law-of-windows-10-1903/){:target="_blank"} be broken?

<iframe title="Host CPU Utilization %" aria-label="Interactive line chart" id="datawrapper-chart-bxLO7" src="https://datawrapper.dwcdn.net/bxLO7/3/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="450"></iframe><script type="text/javascript">!function(){"use strict";window.addEventListener("message",(function(e){if(void 0!==e.data["datawrapper-height"]){var t=document.querySelectorAll("iframe");for(var a in e.data["datawrapper-height"])for(var r=0;r<t.length;r++){if(t[r].contentWindow===e.source)t[r].style.height=e.data["datawrapper-height"][a]+"px"}}}))}();
</script>

<iframe title="Comparison Host CPU Utilization" aria-label="Bar Chart" id="datawrapper-chart-AX78s" src="https://datawrapper.dwcdn.net/AX78s/4/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="235"></iframe><script type="text/javascript">!function(){"use strict";window.addEventListener("message",(function(e){if(void 0!==e.data["datawrapper-height"]){var t=document.querySelectorAll("iframe");for(var a in e.data["datawrapper-height"])for(var r=0;r<t.length;r++){if(t[r].contentWindow===e.source)t[r].style.height=e.data["datawrapper-height"][a]+"px"}}}))}();
</script>

From the host CPU utilization perspective there is no noticeable difference. When an environment is CPU limited, upgrading to Windows 10 21H1 will not have an impact on the user density compared to other tested Windows 10 versions.

<iframe title="Host Available Memory (GB)" aria-label="Interactive line chart" id="datawrapper-chart-9KUjY" src="https://datawrapper.dwcdn.net/9KUjY/2/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="450"></iframe><script type="text/javascript">!function(){"use strict";window.addEventListener("message",(function(e){if(void 0!==e.data["datawrapper-height"]){var t=document.querySelectorAll("iframe");for(var a in e.data["datawrapper-height"])for(var r=0;r<t.length;r++){if(t[r].contentWindow===e.source)t[r].style.height=e.data["datawrapper-height"][a]+"px"}}}))}();
</script>

<iframe title="Comparison Host Available Memory (GB)" aria-label="Grouped Bars" id="datawrapper-chart-qCNiw" src="https://datawrapper.dwcdn.net/qCNiw/1/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="223"></iframe><script type="text/javascript">!function(){"use strict";window.addEventListener("message",(function(e){if(void 0!==e.data["datawrapper-height"]){var t=document.querySelectorAll("iframe");for(var a in e.data["datawrapper-height"])for(var r=0;r<t.length;r++){if(t[r].contentWindow===e.source)t[r].style.height=e.data["datawrapper-height"][a]+"px"}}}))}();
</script>

It is interesting to see the footprint of Windows 10 20H2 is a bit higher compared to both Windows 10 1909 & 21H1. This means Windows 10 21H1 consumes less memory compared to the previous two builds.

<iframe title="Host Storage Reads/sec" aria-label="Interactive line chart" id="datawrapper-chart-95e6Z" src="https://datawrapper.dwcdn.net/95e6Z/3/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="400"></iframe><script type="text/javascript">!function(){"use strict";window.addEventListener("message",(function(e){if(void 0!==e.data["datawrapper-height"]){var t=document.querySelectorAll("iframe");for(var a in e.data["datawrapper-height"])for(var r=0;r<t.length;r++){if(t[r].contentWindow===e.source)t[r].style.height=e.data["datawrapper-height"][a]+"px"}}}))}();
</script>

<iframe title="Host Storage Writes/sec" aria-label="Interactive line chart" id="datawrapper-chart-ngGJi" src="https://datawrapper.dwcdn.net/ngGJi/4/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="400"></iframe><script type="text/javascript">!function(){"use strict";window.addEventListener("message",(function(e){if(void 0!==e.data["datawrapper-height"]){var t=document.querySelectorAll("iframe");for(var a in e.data["datawrapper-height"])for(var r=0;r<t.length;r++){if(t[r].contentWindow===e.source)t[r].style.height=e.data["datawrapper-height"][a]+"px"}}}))}();
</script>

<iframe title="Comparison Host Storage Reads &amp;amp; Writes/sec" aria-label="Grouped Bars" id="datawrapper-chart-upLjZ" src="https://datawrapper.dwcdn.net/upLjZ/4/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="328"></iframe><script type="text/javascript">!function(){"use strict";window.addEventListener("message",(function(e){if(void 0!==e.data["datawrapper-height"]){var t=document.querySelectorAll("iframe");for(var a in e.data["datawrapper-height"])for(var r=0;r<t.length;r++){if(t[r].contentWindow===e.source)t[r].style.height=e.data["datawrapper-height"][a]+"px"}}}))}();
</script>

The data shows a small difference in both host reads/sec and writes/sec, but overall, the pattern is very consistent, but the main difference is caused by the outliers. This performance difference will most probably not be noticeable from the user experience.

<iframe title="Session Frames per Second (FPS)" aria-label="Interactive line chart" id="datawrapper-chart-t43h6" src="https://datawrapper.dwcdn.net/t43h6/1/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="450"></iframe><script type="text/javascript">!function(){"use strict";window.addEventListener("message",(function(e){if(void 0!==e.data["datawrapper-height"]){var t=document.querySelectorAll("iframe");for(var a in e.data["datawrapper-height"])for(var r=0;r<t.length;r++){if(t[r].contentWindow===e.source)t[r].style.height=e.data["datawrapper-height"][a]+"px"}}}))}();
</script>

<iframe title="Comparison Session Frames per Second (FPS)" aria-label="Grouped Bars" id="datawrapper-chart-ZKb27" src="https://datawrapper.dwcdn.net/ZKb27/1/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="200"></iframe><script type="text/javascript">!function(){"use strict";window.addEventListener("message",(function(e){if(void 0!==e.data["datawrapper-height"]){var t=document.querySelectorAll("iframe");for(var a in e.data["datawrapper-height"])for(var r=0;r<t.length;r++){if(t[r].contentWindow===e.source)t[r].style.height=e.data["datawrapper-height"][a]+"px"}}}))}();
</script>

Frames per Second (FPS) is a difficult metric, as this is based on the activity in the session. As the GO-EUC workload is simulated by LoadGen it is important to take a look at the consistency of the results. For more information regarding the workload, please see the [GO-EUC testing methodology](https://www.go-euc.com/insight-in-the-testing-methodology-2020/){:target="_blank"}. In this case, the results are consistent, showing that upgrading to the latest version of Windows 10 will not have a direct negative effect on the overall measured user experience (not the perceived user experience).

<iframe title="Session Round Trip Time (RTT) " aria-label="Interactive line chart" id="datawrapper-chart-vOUZO" src="https://datawrapper.dwcdn.net/vOUZO/1/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="450"></iframe><script type="text/javascript">!function(){"use strict";window.addEventListener("message",(function(e){if(void 0!==e.data["datawrapper-height"]){var t=document.querySelectorAll("iframe");for(var a in e.data["datawrapper-height"])for(var r=0;r<t.length;r++){if(t[r].contentWindow===e.source)t[r].style.height=e.data["datawrapper-height"][a]+"px"}}}))}();
</script>

<iframe title="Comparison Session Round Trip Time (RTT)" aria-label="Grouped Bars" id="datawrapper-chart-MmZSg" src="https://datawrapper.dwcdn.net/MmZSg/1/" scrolling="no" frameborder="0" style="width: 0; min-width: 100% !important; border: none;" height="200"></iframe><script type="text/javascript">!function(){"use strict";window.addEventListener("message",(function(e){if(void 0!==e.data["datawrapper-height"]){var t=document.querySelectorAll("iframe");for(var a in e.data["datawrapper-height"])for(var r=0;r<t.length;r++){if(t[r].contentWindow===e.source)t[r].style.height=e.data["datawrapper-height"][a]+"px"}}}))}();
</script>

The session round trip time (RTT) is an important metric that should not have high outliers, as this will have a direct negative effect on the user experience. These results are again very consistent but do show a difference. Please note, an 8% is around 3.8 ms increase in RTT, which will not have a direct negative effect on the overall user experience. It is important to keep this in mind when having a high latency environment, as this can have a higher significant impact.

## Conclusion
The data show a minimal to no difference between the latest Windows 10 releases. Based on these results it is expected a user won’t notice any difference besides the new features or visual updates. This means it is safe to upgrade from one of the tested Windows 10 versions to the latest Windows 10 21H1 on your VDI environment.

Please do note, these results are based on our context, described in the infrastructure and configuration section, and might be different when implementing in production because of the application landscape, hardware, and other factors. Therefore, it is always important to validate this in your own environment in a controlled manner, by using [LoadGen](https://www.loadgen.com){:target="_blank"} for example.

Nevertheless, it is noticeable Microsoft is getting control of the upgrades as the pattern discovered in previous Moore's law of Windows 10 research has been broken. Hopefully, Microsoft will keep this up for both Windows 10 and Windows 11.

Do you see the same consistent results in your environment? Please share your experience below or in the [Slack Channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Pawel Czerwinski](https://unsplash.com/@pawel_czerwinski?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/abstract?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}.
