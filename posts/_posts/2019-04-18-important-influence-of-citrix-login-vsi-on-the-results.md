---
layout: post
toc: true
title:  "Important: Influence of Citrix & Login VSI on the results"
hidden: false
authors: [ryan, eltjo]
categories: [ 'infrastructure' ]
tags: [ 'citrix', 'Login VSI', 'FPS' ]
image: assets/images/posts/000-important-influence-of-citrix-login-vsi-on-the-results/000-influence-citrix-loginvsi-feature-image.png
---
Over the last couple of months, a lot of new insights have been shared on GO-EUC. After publishing one of our results, we received some feedback regarding these results within the Slack channel. It appears that some of the test results were affected by a specific setting, in the OS, which means the results may vary between product versions. This blog post will explain the insights, analysis, and effected results.

> When performing the analysis of data that we collect from the performance tests, no matter how objective we stay, we always have the tendency to interpret the data towards our initial hypotheses. This phenomenon is called confirmation bias. In our VDA post, we saw some exceptional results and performance gains when switching from VDA 7.18 to 1808.2 with an increase of 30% in VSImax. We expected an increase in performance, so we perceived an increase in performance based on previous tests and the collected data. And data doesn’t lie.

Based on our recent research and blog post [Citrix VDA versions breakdown, a giant leap forward]({{site.baseurl}}/citrix-vda-versions-breakdown-a-giant-leap-forward){:target="_blank"} [Muhammad Dawood](https://www.linkedin.com/in/muhammad-dawood){:target="_blank"} (Principal Software Engineer at Citrix) and [Martin Rowan](https://www.linkedin.com/in/martinrowan){:target="_blank"} (Head of Engineering at Highlight, former Citrix employee) have joined the Slack channel to talk about our results. We got challenged by them, specifically on the FPS values of the older VDA versions. These numbers did not exhibit the behavior as Citrix would have expected them to be.

Our test results show that both versions of Citrix VDA 7.15 and VDA 7.18 have an overall higher FPS. This is the part which is not as expected and should show a similar pattern as version 1808.2 and 1811.1 (lower FPS). Our analysis tells us that, in theory, something within the workload is continuously generating screen updates.

To get a better understanding of what is going-on a call was organized to investigate the behavior between the different VDA versions. During the call, we analyzed the workloads and it was noticed the progress bar of Login VSI is causing the high FPS.

> Within the Login VSI progress bar, there is a small green line that contains an animation. This animation has a shiny effect and a background shadow.

As the progress bar is always on top this will influence the FPS.

<div align="center">


</div>

<a href="{{site.baseurl}}/assets/images/posts/000-important-influence-of-citrix-login-vsi-on-the-results/000-loginvsi-progress-bar.gif" data-lightbox="progress-bar">
![progress-bar]({{site.baseurl}}/assets/images/posts/000-important-influence-of-citrix-login-vsi-on-the-results/000-loginvsi-progress-bar.gif)
</a>



Source: [https://youtu.be/FiVev7TkDbI](https://youtu.be/FiVev7TkDbI){:target="_blank"}

The insight was that this behavior was not present in the later VDA versions (e.g. version 1808.2 and up). After further analysis, we discovered that Citrix applied some optimization in the VDA. Although we could not validate the exact setting, we did manage to get the same animation effects by disabling the “Animate controls and elements inside windows” setting in the operating system.

<a href="{{site.baseurl}}/assets/images/posts/000-important-influence-of-citrix-login-vsi-on-the-results/000-performance-options-animation.png" data-lightbox="perf-options">
![perf-options]({{site.baseurl}}/assets/images/posts/000-important-influence-of-citrix-login-vsi-on-the-results/000-performance-options-animation.png)
</a>

This setting disables the animation inside windows and therefore also within the Login VSI progress bar. Please note, the setting mention above only applies to the current user.

As shown, this has a tremendous positive influence on the overall results.

<a href="{{site.baseurl}}/assets/images/posts/000-important-influence-of-citrix-login-vsi-on-the-results/000-vda-compare-no-progress-bar-fps.png" data-lightbox="fps">
![fps]({{site.baseurl}}/assets/images/posts/000-important-influence-of-citrix-login-vsi-on-the-results/000-vda-compare-no-progress-bar-fps.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/000-important-influence-of-citrix-login-vsi-on-the-results/000-vda-compare-no-progress-bar-fps-compare.png" data-lightbox="fps-compare">
![fps-compare]({{site.baseurl}}/assets/images/posts/000-important-influence-of-citrix-login-vsi-on-the-results/000-vda-compare-no-progress-bar-fps-compare.png)
</a>

Not only the FPS is influenced by this change but also shows an impact on the other metrics from which the CPU metric is most notable. All this results in a higher VSImax value in favor of the VDA version 1808.2 and higher.

## Our point of view on these insights
Well, data does not lie but because of the changes made to newer VDA versions (1808.2 and upwards), there wasn’t a level playing field anymore. The results would always be in favor of these newer versions in our comparison blog.

We could not find the optimization change in the release notes of the [Citrix VDA releases](https://docs.citrix.com/en-us/citrix-virtual-apps-desktops/1808/whats-new.html){:target="_blank"}. As this change is a form of OS optimizations, we believe this should be part of the “Citrix optimizer” instead of being a part of the VDA itself and therewith let us decide to apply this optimization as it influences the end-user experience.

From a Login VSI perspective, we would expect it to only generate workload and not to be influencing the results from outside the workload itself, meaning the progress bar.

Does this mean Citrix is wrong? No; they develop their product to deliver optimal end-user experience.  Does this mean LoginVSI is the fault? No; LoginVSI delivers objective and reliable data at all time when comparing configurations.

## Changes for upcoming researches
For our upcoming researches, we need to create a “level playing field” again. Knowing that our environment is changed with the Citrix changes in the VDA we have three options to avoid the influence on the FPS:

  * The first option would be to ensure the animation effects are the same in each test, this way the results can be compared between the different versions of VDA.
  * The second option would be to create the optimization settings for lower versions as with the later versions of VDA.

> We believe that the first option is the way to go and this can be achieved by removing the progress bar entirely as this method does not require custom optimizations within the OS. Therefore, we decided to adopt this option for the upcoming researches. The removal does not influence the LoginVSI functionality in any way.

<a href="{{site.baseurl}}/assets/images/posts/000-important-influence-of-citrix-login-vsi-on-the-results/000-loginvsi-progress-bar-removed.png" data-lightbox="progress-bar-remove">
![progress-bar-remove]({{site.baseurl}}/assets/images/posts/000-important-influence-of-citrix-login-vsi-on-the-results/000-loginvsi-progress-bar-removed.png)
</a>

  * A third option would be to not compare the different versions between 7.18 (and lower) with 1808.2 (and higher). But this is not a real option now is it...

## What is next?
A couple of our published researches are affected by the differences in FPS because of the VDA versions we compared, and this tells us that we need to rerun the tests with the above-mentioned change in setup.

> It is important to understand all the results we published are correct and the conclusions will most likely remain the same.

Affected researches have been edited with a disclaimer containing a link to this post. Once the tests of the affected researches have been rerun, the posts will also be updated with a link to the new research post.

We are thankful to Muhammad and, Martin for helping us understand our playground. If, in the meantime, you have any questions or remarks please feel free to reach out to us on the [Slack Channel](https://worldofeuc.slack.com){:target="_blank"}.

Photo by [Ivan Vranić](https://unsplash.com/photos/j9-2LIZ2_Rc?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/broken?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
