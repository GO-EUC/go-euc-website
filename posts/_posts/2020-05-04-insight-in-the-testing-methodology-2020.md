---
layout: post
toc: true
title:  "Insight in the testing methodology - Current"
hidden: false
authors: [ryan]
categories: [ 'infastructure' ]
tags: [ 'infastructure', 'testing', 'data' ]
image: assets/images/posts/000-insight-in-the-testing-methodology-2020/000-insight-in-the-testing-mehtodolodgy-2020-feature-image.png
---
One of the key components in the GO-EUC researches is the testing methodology. This methodology allows us to produce consistent and reliable results that are used to publish the researches. Describing the testing methodology also allows you to reproduce and challenge our results. This article describes the details, sources and methods used for the GO-EUC researches.

## Performance solution: LoadGen
Our goal is to see the behavior of a solution in an environment that is under load. To achieve this, a load simulation solution is used. The primary solution used at GO-EUC is LoadGen. LoadGen makes it possible to simulation user behavior on virtual environments. LoadGen is the default solution in the researches, unless stated otherwise.

> LoadGen offers customers and service providers a complete software solution to test, and maintain the optimal performance, user experience, scalability, and availability of (virtual) desktop environments including all of your business applications.
>
> Whatever you wish to test, LoadGen makes it easier with our user-friendly software. Load tests, stress tests, performance tests, End-to-End Monitoring. The wide range of Load and Performance Testing options allows you to create customized simulations in just a few simple steps. The outcome means that if necessary, you can take appropriate action well in time so that the user experience of your IT environment remains optimal. LoadGen simulates end-user behavior for systems such as Citrix Virtual Apps and Desktops, Microsoft Remote Desktop Services, VMware Horizon, and Fat Clients.
>
> Product and Application reliability and objective simulations that identify the possible effects of planned changes to your IT environment. It allows you to test what will happen before the actual change is applied, allowing you to gain full control over the performance of your IT environment and your end-users to continue using your systems unhindered.
>
> More information about LoadGen can be found [here](https://www.loadgen.com){:target="_blank"}.

### Workload and applications
By default, LoadGen does not come with any standardized workloads and therefore GO-EUC created a self-maintained workload which can be found here:

| Date       | Name            | Version  |
| :--------: | :-------------: | :------: |
| 04-20-2020 | KnowledgeWorker | [v2004.01](https://github.com/GO-EUC/go-euc-workloads/blob/master/KnowledgeWorker_v2004.1.lgs){:target="_blank"} |
| 05-01-2020 | KnowledgeWorker | [v2005.01](https://github.com/GO-EUC/go-euc-workloads/blob/master/KnowledgeWorker_v2005.1.lgs){:target="_blank"} |
| 06-11-2021 | KnowledgeWorker | [v2106.01](https://github.com/GO-EUC/go-euc-workloads/blob/master/KnowledgeWorker_v2106.1.lgs){:target="_blank"} |
| 10-15-2021 | KnowledgeWorker | [v2110.01](https://github.com/GO-EUC/go-euc-workloads/blob/master/KnowledgeWorker_v2110.1.lgs){:target="_blank"} |

This workload contains the following default applications:

  * Microsoft Outlook;
  * Microsoft Word;
  * Microsoft PowerPoint;
  * Microsoft Excel;
  * A modern web browser, like Google Chrome or Microsoft Edge;
  * Adobe Reader.

The workload is divided into four different user types. Each user type contains the same set of applications and each user starts from a different starting point. This way the load is spread evenly during the test.

<a href="{{site.baseurl}}/assets/images/posts/000-insight-in-the-testing-methodology-2020/000-insight-in-the-testing-mehtodolodgy-2020-loadgen-workload.png" data-lightbox="host-cpu">
 ![host-cpu]({{site.baseurl}}/assets/images/posts/000-insight-in-the-testing-methodology-2020/000-insight-in-the-testing-mehtodolodgy-2020-loadgen-workload.png)
</a>

All the websites used in the workload are offline available and provided using a docker container. This is a Linux based container using NGINX. The container contains 5 versions of various websites, including a video player. The content library contains various documents that are used in the workload. Both the content library as the webserver docker container are available in the table below.


| Date       | Name                       | Version  |
| :--------: | :------------------------: | :------: |
| 04-20-2020 | Content library            | [v2004.01](https://1drv.ms/u/s!AhNjcTavBrn7sk7hEgKQBAffhqGy?e=35ajfV){:target="_blank"} |
| 04-20-2020 | Webserver Docker container | [v2004.01](https://hub.docker.com/r/goeuc/webserver){:target="_blank"} |

A logon script is used to stage and prepare the LoadGen users. A network share is used that provides all the files that are available in the content library. When the user login, a personal local H drive is created and the random documents are copied from the share location to the H drive. A PST file is configured in Outlook simulating an offline mailbox.

## Automation
All the researches published at GO-EUC are executed using automation. This ensures the same steps are executed for each scenario. Automation used depends on the delivery method, but each cycle always contains the following steps:

  * Reboot the LoadGen bots;
  * Shutdown virtual machines (depending on the delivery method);
  * Reboot the hypervisor;
  * Start virtual machines (depending on the delivery method);
  * Idle x minutes to ensure load is stable;
  * Start performance metric collectors;
  * Start LoadGen simulation;
  * Wait for the test to complete;
  * Collect performance metrics.

For each scenario, the cycle is run 10 times by default, unless stated otherwise. This means every step stated above is executed 10 times which takes approximately 24 hours to complete.

## Data sources
To create a dataset, performance data is collected from multiple sources for each scenario. The following data sources are collected by default:

  * Hypervisor data (ESXtop);
  * LoadGen Bots Perfmon data;
  * Protocol data using Remote Display Analyzer;
  * Application start times from LoadGen;
  * Logon times from LoadGen.

In addition to the standard sources, GO-EUC has the ability to collect perfmon data from the virtual machine where the user is simulated. As a stateless scenario is often used, this is not done by default. Additionally GO-EUC owns a video capture card with which physical endpoint output can be recorded.

## Deployment and preparation
Before starting a research, the scenarios are, if possible, prepared beforehand. In most cases, the automation can switch between the various scenarios automatically. Even though scenarios have been tested before, a dataset is never used between different researches. As Windows is continuously improving using Windows updates these datasets cannot be compared. Therefore, all scenarios are fully tested using a deployment that is prepared at the same time.

The GO-EUC deployments are done using Microsoft MDT which includes all necessary components, like redistributables, delivery agents like Citrix VDA or the VMware Horizon Agent and the required software like Microsoft Office. Depending on the scenario, best practices are applied like Windows updates and optimization using Citrix Optimizer or VMware OSOT.

## Review and analysis
Each individual run of a scenario is reviewed to ensure it has consistent results. It may occur for whatever reason that one of the scenarios did not run as expected. In that case, this individual run is removed from all data sources. If more then 3 runs have not been performed as expected, this scenario will be marked as invalid and is not be used in the publication. Depending on the schedule or the research, this scenario will be executed again, not used or the entire research is dropped and postponed.

All results used in the GO-EUC publications or presentations are a collection of valid runs. By default, these are 10 runs and thus 10 datasets for each scenario. The metrics used depend on the research and analysis. In case of unexpected results that cannot be explained, there can be removed from the publication for further analysis.

## Updates and continuous improvement
Our platform is continuously improving the automation and testing methodology. As the workloads and data library are maintained by GO-EUC, this will be included. Several updates are expected in broth the data library and the workload, which will be shared in this article.

If you have comments, questions, or suggestions, please feel free to share those in the comment below. Or start the conversation at the Slack channel.

## Change log
<b>04-20-2020: version 2004.1</b> – Initial release.
<br>
<b>05-01-2020: version 2005.1</b> – Extended the Excel block.
<br>
<b>06-11-2021: version 2106.1</b> – Transformed the workload to the enhanced, allowing to have more control.
<br>
<b>10-14-2021: version 2110.1</b> – More error handling en refinement in the workload.

Photo by [Isaac Smith](https://unsplash.com/@isaacmsmith?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_bank"} on [Unsplash](https://unsplash.com/s/photos/measure?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
