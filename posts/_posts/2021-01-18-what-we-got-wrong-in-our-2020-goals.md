---
layout: post
toc: true
title:  "What we got wrong in our 2020 goals"
hidden: false
authors: [bas, eltjo, ryan]
categories: [ 'Citrix' ]
tags: [ 'Citrix', 'CVAD', 'watermark']
image: assets/images/posts/000-what-we-got-wrong-in-our-2020-goals/000-what-we-got-wrong-in-our-2020-goals-feature-image.png
---
It is always good to take some time at the end of the year to reflect and validate the set goals and look at the future. As expected from GO-EUC it is also the time to take a closer look at the data of the website and see the reach in the community. This post will take a closer look at 2020 and provide some insight into the goals of 2021.

## Why do we do what we do?

The goal of GO-EUC is to be the community research platform of EUC related topics. Now due to the transformation of GO-EUC, more about that later, we felt it was needed to draft up a mission statement that could reflect our work and ambitions. It is always good to have a mission statement to ensure everybody is heading in the same direction. For the mission statement, the inspiration came from the best of the best, the [US Navy’s Blue Angels](https://www.blueangels.navy.mil/){:target="_blank"}.

Their mission is..

> to showcase the teamwork and professionalism of the United States Navy and Marine Corps through flight demonstrations and community outreach while inspiring a culture of excellence and service to country.

![stats-2020]({{site.baseurl}}/assets/images/posts/000-what-we-got-wrong-in-our-2020-goals/blue-angels.jpg)
<p align="center" style="margin-top: -30px; font-size: 10px;" >
  <i>The appearance of U.S. Department of Defense (DoD) visual information does not imply or constitute DoD endorsement.</i>
</p>

This is an inspiring mission statement and has been adopted into the mission statement of GO-EUC.

GO-EUC’s mission is..

> To facilitate the individual with research capabilities for exploring new technologies, to inspire and serve the community by providing new knowledge.

New years resolutions
It's always good to start a new chapter and a new year with new goals and dreams. In 2019 a couple of goals were set for 2020:

  * It is our aim to reach even more people in 2020.
  * Our goal is to get at least five new participants at GO-EUC in 2020.
  * In 2020, we also want to continue with the next step in our hardware platform.

The last goal was our big hairy audacious goal, the BHAG. In 2019 GO-EUC was still renting hardware from OVH. This construction is constricted in the types of researches that could be done. Because the servers were located in Germany without physical access, there was no way to add hardware like memory or GPUs to the systems for instance.

Luckily in 2020 hardware was donated to GO-EUC which made it possible to move away from OVH and migrate the whole environment to our dedicated hardware in our mini datacenter in the east of the Netherlands.

Having dedicated hardware realizes our biggest goal and ambition to take performance and scalability testing to the next level. The dedicated hardware also opens up new possibilities and with the donation of new GPUs from NVIDIA, GO-EUC now also has the prospect of testing more modern graphical workloads.

For more information on our current hardware please refer to our new and updated platform guide [here](https://www.go-euc.com/architecture-and-hardware-setup-overview-2020/){:target="blank"}.

<a href="{{site.baseurl}}/assets/images/posts/000-what-we-got-wrong-in-our-2020-goals/000-website-stats-2020.png" data-lightbox="stats-2020">
![stats-2020]({{site.baseurl}}/assets/images/posts/000-what-we-got-wrong-in-our-2020-goals/000-website-stats-2020.png)
<a>

The first goal for 2020 was to reach even more people than in 2019. In that regard, we succeeded in that goal. There was an increase of 51% of unique visitors and 31% more pageview compared to 2019.

Although the number of publications published decreased in 2020 compared to 2019 from a total of 28 publications to 17 posts in 2020, the platform did manage to attract more visitors.

In terms of members, GO-EUC grew from 9 to 13 active members, which means that goal was not met. Growing in members did come with a realization of the time required to onboard the new members on the platform. As GO-EUC we strive to maintain a certain level of quality which also affects the abovementioned number of publications. At GO-EUC all publications are peer-reviewed by all members before they are published. This is a time-consuming process and for the more complex publications, it can mean a couple of weeks of reviewing and editing before you can read the publication online. It is our duty to provide you, the reader, with accurate and fact-checked data and substantiated conclusions.

> Sometimes that data or those conclusions don't come easy and as we said before, data doesn't lie. So, if the data doesn't match up or seems incorrect the most probable reasons are that either the tests haven't run correctly or the initial assumptions must have been incorrect.

## What is going on behind the scenes

All in all 2020 was a turbulent year, which is an understatement. For GO-EUC, the biggest change was the transformation into a non-profit organization. Although the timing wasn’t ideal during the circumstances, it did result in the continuing existence of the GO-EUC platform. Because GO-EUC was and will always be independent, the switch to a non-profit foundation was the only logical choice for us. This change also empowers our unbiased and independent character even more than we could ever do in the past.

Due to the transformation, GO-EUC also started with sponsorships which is the main reason why the platform can continue to provide independent researches.

In name of GO-EUC we a very pleased with both LoadGen and Tricerat sponsoring the platform. For more information about both LoadGen and Tricerat, please visit the sponsor page right [here](https://www.go-euc.com/sponsors/){:target="_blank"}.

With LoadGen as a new sponsor, it made sense to move to LoadGen as our new standard load generation solution. Using LoadGen allowed us to have more control over the workload and ensures the results are better reflected in the real world.
If that wasn't enough, GO-EUC has also migrated from a WordPress site to GitHub pages. Besides the performance benefits, GitHub also enables the community values of the platform as all the content is “open-source”.

## Goals for 2021
Like the previous year, setting yearly goals helps to provide the focus for the platform. This provides expectations for both members and the community alike and also shows the general direction and ambition of GO-EUC as a platform.
Now previous year the goal of an increase in visitors was one of the goals of 2020. Now as this has been accomplished, we decided to not include this as a dedicated goal, as it is a result of interesting researches and the quality we bring to the table.

**1. Even more and better involvement of the community.**
Although the community involvement is already high, GO-EUC strives to have an even better involvement of the community to ensure the right topics are researched. At this point, we are slacking in the [World of EUC Slack channel](https://worldofeuc.slack.com){:target="_blank"}, so this is one of the places activities needs to increase. The Slack channel is the easiest way to reach out to us and share your thoughts, ideas, and opinions.

**2. Innovative and ground-breaking research capabilities.**
To stay ahead of the curve, the platform and the researches need to evolve over time. It is our ambition to develop or integrate innovative solutions to better measure the end-user experience. Additionally, incorporating technologies like machine learning helps us to predict scalability and performance degradations on a new level. These are some of the topics that we are looking into developing for the platform.


**3. Automation Framework in the DevOps style.**
At last, GO-EUC has a tremendous amount of automation that makes our researches reliable and consistent. Even though it works how it should be, there are a lot of improvements that need to be implemented. By adopting the DevOps strategy we strive to increase the flexibility in our automated deployment and testing capabilities.

Reaching these goals will never be possible without our members, sponsors, and our visitors. Therefore, a big thank you to you all for making GO-EUC a great success!

Cheers,
The GO-EUC Foundation Board.

<span>Photo by <a target="_blank" href="https://unsplash.com/@dannyhowe?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Danny Howe</a> on <a target="_blank" href="https://unsplash.com/?utm_source=unsplash&amp;utm_medium=referral&amp;utm_content=creditCopyText">Unsplash</a></span>
