---
layout: post
toc: true
title:  "Unveiling the True Cost: Single-User vs. Multi-User Sessions in Microsoft Azure Virtual Desktop"
hidden: false
authors: [ruben, ryan]
reviewers: [patrick, leee, eltjo]
categories: [ 'Azure' ]
tags: [ 'Azure', 'Compute', 'SKU', 'Cost', 'Cloud', 'AVD']
image: assets/images/posts/112-unveiling-the-true-cost-single-user-vs-multi-user-sessions-in-microsoft-azure-virtual-desktop/unveiling-the-true-cost-feature-image.png
---
In the domain of End-User Computing (EUC) and precisely Desktop as a Service (DaaS) the choice between single-user and multi-user sessions in Microsoft Azure Virtual Desktop (AVD) carries significant weight, directly impacting both cost and performance.

Cost and performance pose significant challenges in adopting of Desktop as a Service (DaaS), as revealed by the free [DaaS Like a Pro](https://daaslikeapro.com/){:target="_blank"} EUC industry survey. With 706 respondents participating, the survey highlights that cost accounts for 21.5% of the challenges, while performance closely follows at 15.1%. While cost and performance are pivotal factors, the comparison between single-user Windows Operating System and Multi-User, multi-session environments extends beyond these topics. Considerations such as application compatibility, ensuring consistent performance amidst potential 'noisy neighbours,' standardization across physical and virtual desktops and applications, and integrating modern management and identity solutions all play critical roles.

In this analysis, we delve into the comparative cost dynamics of single-user and multi-user session types and don’t focus on the other topics. We will use Microsoft's recommended sizing guidelines and real-world sizing numbers to uncover the nuanced implications and cost differentials of each approach.

## The challenge of single or multi-session sizing
The challenge in single-user versus multi-user sizing boils down to finding the sweet spot between meeting individual user and administrator needs and maximizing resource efficiency. In a single-user setup, each user gets its own persistent or non-persistent Virtual Machine with dedicated CPU/RAM/Storage and (v)GPU resources, ensuring consistent performance but potentially leading to higher costs, especially if resources are underutilized. Conversely, in a multi-user environment, resources are shared, which can be cost-effective but may introduce less consistent performance challenges since users compete for resources and neighbours are running on the same Virtual Machine.

Practically, this means IT professionals must carefully assess factors like user workload types, application requirements, changing resource requirements, looking at browsers and unified communications and expected usage patterns to determine the most suitable sizing strategy. They need to balance providing adequate resources for each user to maintain productivity and optimizing resource utilization to keep costs in check. Additionally, they must consider the potential impact of scaling, load balancing, user growth, and evolving technology and application trends on both single-user and multi-user environments.

## Methodology
This research's methodology is entirely theoretical and based on calculations and sizing recommendations from Microsoft and ourselves. Our own sizing recommendations are based on two larger scale AVD deployments containing 1000+ active users that fit in the ‘medium’ user category running Microsoft Office, Edge/Chrome with multiple tabs open and running Microsoft Teams in both offloaded and non-offloading scenarios.

In reality the working time and duration of an employee are never consistent. To simulate this, a starting window between 6 AM and 11 AM is used where users work between 6 and 10 hours per day. For each user, the start time and working hours are randomly generated based on these parameters.

The amount of required AVD hosts is calculated based on the sizing approach. For example, following the Microsoft recommendation, the ratio per vCPU is 4, meaning that for a D8s_v5 that contains 8vCPUs, the recommended size is 32 users per host.

> vCPU * ratio = users
> 8 * 4 = 32

Each individual user with a random working time is mapped to the host, depending on the sizing, where the minimum starting time and the maximum shutdown time are calculated based on allocated users. The users are divided from top to bottom, meaning based on the sizing example mentioned above the first 32 users are allocated on the first host. For this research, the total number of users is 1000 for each scenario.

Prices are calculated based on the prices per hour for the selected SKU from the [Microsoft pricing calculator website](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/windows/#pricing){:target="_blank"}. The following properties are chosen on the website:

| Option                             | Value                          |
| :--------------------------------- | :----------------------------- |
| OS/Software                        | Windows OS                     |
| Category                           | General Purpose                |
| VM series                          | Dsv5 series                    |
| Region                             | West Europe                    |
| Currency                           | United States - Dollar ($) USD |
| Display price by                   | Hour                           |
| Pricing model & comparison         | Saving plan (1 & 3 year)       |
| Show Azure Hybrid Benefits pricing | Disabled                       |

Pay-as-you-go prices per hour are used per instance. To calculate the actual computing cost, the price per hour is divided by 60 to obtain the price per minute, which is multiplied by the total running time of the session host. For the hours the host is not running, the machine is in a stopped (deallocated) state, which Azure will not charge.

> For this research, only the compute cost per instance is used. Additional costs such as storage, network, and licensing are not included.

Regarding the storage cost, as mentioned above this is not included as the difference in percentage is the same based on the starting cost and the calculated total cost.

In most environments, a small capacity will remain available 24/7 so users can always work. For this research, a capacity for 5 users is taken into account. This means in a single session scenario, 5 VMs will remain active for 24 hours. In the case of the multi-session, this is calculated based on the used sizing.

Based on the Microsoft sizing recommendation, the following SKU’s are included in the research:


| SKU     | vGPUs | Memory |
| :------ | :---- | :----- |
| D4s_v5  | 4     | 16 GB  |
| D8s_v5  | 8     | 32 GB  |
| D16s_v5 | 16    | 64 GB  |
| D32s_v5 | 32    | 128 GB |

Please note that Microsoft recommends using a VM size between 4 vCPUs and 24 vCPUs because this generally provides a better capacity. Even though the recommendation is that the D32s_v5 be included to see the effect in pricing.

## Sizing calculations
The complexity of sizing is the unpredictability of the user's behaviour. A workload type is generally used to categorize user behaviour or load type. This can be in terms of tasks, office, knowledge, and power workers or light, medium, heavy, and power. For this research, the medium workload type has been selected. As Microsoft has no clear description of what to expect from a medium workload, our definition is as follows:

A medium or knowledge workload type included working in the Microsoft Office suite, use of Microsoft Teams, two additional applications, and browser-based applications with a minimum amount of tabs of 5.

In the case of a single session, the medium workload recommended sizing would be 4 vCPUs and 16 GB memory configuration. For multi-session, the Microsoft’s recommendation is a maximum of 4 users per vCPU with a minimum of 8 vCPUs and 16GB memory.

Source: [Session host virtual machine sizing guidelines for Azure Virtual Desktop and Remote Desktop Services - Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/remote/remote-desktop-services/virtual-machine-recs){:target="_blank"}

For each instance, this comes to the following sizes for facilitating 1000 users

| Session | Instance | vGPUs | Memory | Hosts | User per host | Memory per user |
| :------ | :------- | :---- | :----- | :---- | :------------ | :-------------- |
| Single  | D4s_v5   | 4     | 16     | 1000  | 1             | 12 GB           |
| Multi   | D4s_v5   | 4     | 16     | 63    | 16            | 750 MB          |
| Multi   | D8s_v5   | 8     | 32     | 32    | 32            | 875 MB          |
| Multi   | D16s_v5  | 16    | 64     | 16    | 63            | 952 MB          |
| Multi   | D32s_v5  | 32    | 128    | 8     | 125           | 992 MB          |

> Formula: vGPUs * ratio = users per host

Memory per user is calculated based on the total amount of memory minus 4 GB reserved for the operating system devices by the number of users per host. The reserved operating system memory is a practice from the field, which was also applied to the [What is the best Azure Virtual Machine size for WVD using Citrix Cloud?](https://www.go-euc.com/what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/#expectations){:target="_blank"} research. As operating systems are consuming more, this might need to be increased nowadays, but for now, the 4GB is applied to this research.

In reality, is the memory footprint continuously growing, therefore Microsoft's sizing recommendation is unrealistic. Microsoft Teams and modern web browsers can quickly claim a lot of memory. Therefore, a more realistic scaling recommendation would be sizing on memory where you at least have 2 GB per user available. Based on multiple customers environment our recommendation would be a 3 GB per user for a multi-session host. Based on the same instance the sizing would be as follows.

| Session | Instance | vGPUs | Memory | Hosts | User per host | Memory per user |
| :------ | :------- | :---- | :----- | :---- | :------------ | :-------------- |
| Single  | D4s_v5   | 4     | 16     | 1000  | 1             | 12 GB           |
| Multi   | D4s_v5   | 4     | 16     | 250   | 4             | 3 GB            |
| Multi   | D8s_v5   | 8     | 32     | 114   | 9             | 3.1 GB          |
| Multi   | D16s_v5  | 16    | 64     | 50    | 20            | 3 GB            |
| Multi   | D32s_v5  | 32    | 128    | 25    | 40            | 3.1 GB          |

> Formula: VM memory - 4 GB OS reserve / 3 GB = users per host

There is a clear difference between both sizing estimations are way different which definitely affects the overall cost estimations. To put this in perspective, in general there is a over 3x increase in the amount of resource required between these two sizing guidelines.

Please note this might change in the near future, as more and more browser-based applications are offloading a lot of rending and functionality to the client side, resulting in higher memory footprints. Therefore, analyzing the actual user behaviour in existing environments is always recommended.

## Hypothesis
Before delving into the findings, our initial hypothesis suggests that the multi-session scenario will prove more cost-efficient than its single-session counterpart. However, the landscape has evolved considerably, with applications like Microsoft Teams, Zoom, Microsoft Office, and web browsers like Edge/Chrome experiencing increased memory utilization. Additionally, shifts in user behaviour, such as maintaining numerous browser tabs open simultaneously, contribute to increased resource consumption over time.

Furthermore, Microsoft's recommended sizing remains unchanged from four maybe five years ago. However, considering the evolving landscape of application resource usage, the impact of security patches, and shifts in overall user behavior, it's evident that these sizing guidelines have become outdated. Interesting to see is that vendors such as [Nerdio](https://nmmce.getnerdio.com/){:target="_blank"} also use these sizing guidelines.

Considering the evolving nature of application resource usage, the impact of security patches, and shifts in user behavior, it becomes evident that these sizing guidelines may no longer align with today's needs. This would have a big impact on the total cost in a business case. Therefore, there's a compelling argument to update and adapt the Microsoft guidelines.

## Results
The following chart is created based on the Microsoft recommended sizing ratio of 4 users per vCPU. All prices are USD per day for facilitating 1000 users. As described, there is a capacity for 5 users, and 24 hours are available to ensure the user can work.

{% include chart.html scale='auto' type='bar' data_file='assets/data/112-unveiling-the-true-cost-single-user-vs-multi-user-sessions-in-microsoft-azure-virtual-desktop/microsoft-sizing-per-day.json' %}

As expected, a multi-session scenario is way more cost-effective compared to a single-session.

Now for the realistic sizing, the size is based on the memory consumption as specified in the previous chapter.

{% include chart.html scale='auto' type='bar' data_file='assets/data/112-unveiling-the-true-cost-single-user-vs-multi-user-sessions-in-microsoft-azure-virtual-desktop/realistic-sizing-per-day.json' %}

Overall, again, the multi-session is the most cost-effective, however, compared to the Microsoft recommended sizing, there is a big difference, which is around $800,- per day. Reflecting this to an entire year, which for 2024 has 251 working days, this is around $200.000,- difference between both, which is on average a difference of 300%.

As described in the introduction, the challenge of having multiple users on a single host means the overall runtime of a host is going to be longer. The following chart shows the estimated runtime of each instance.

{% include chart.html scale='auto' type='bar' data_file='assets/data/112-unveiling-the-true-cost-single-user-vs-multi-user-sessions-in-microsoft-azure-virtual-desktop/vm-runtime.json' %}

The overall conclusion is that more users on a single host means the running time is expected to be longer.

## Conclusion
In summary, the current Microsoft sizing guidelines lack accuracy and relevance, remaining unchanged for the past four years despite evolving technology landscapes. While Microsoft's recommended sizing numbers aren’t usable for many or at least debatable, multi-user setups generally offer greater cost-effectiveness compared to single-user configurations. However, single-user setups provide benefits such as consistent performance and future-proofing, with enough CPU and memory resources available in commonly used 4vCPU with 16GB RAM instances. It's worth noting that both Microsoft and also Nerdio default multi-user sizing guidelines fail to reflect real-world customer scenarios, overwriting the defaults and using realistic numbers in the sizing calculator is advised.

When relying on the Microsoft sizing guidelines for your business case it will negatively impact the total cost of ownership. Based on this context, the total cost on a realistic sizing will be 3 times higher.

Microsoft's sizing guidelines lack essential context such as date, application versions and details about usage. For light users with minimal application needs, multi-user configurations with published applications are preferred and cost-efficient. However, for medium users often running with a published desktop and running more diverse application requirements and increasing resource utilization, the difference between single-user and multi-user setups is there but not as big as many people believe it is.

Opting for larger instance sizes in multi-user environments can complicate shutdown procedures when sessions are inactive. Despite minimal cost differences between instance sizes like D4, D8, D16, and D32, it's advisable to use D8 machines or higher for multi-user setups due to their larger memory capacity.

In realistic scenarios, allocating 2 GB of RAM for light users and 3-4 GB for medium users proves more practical. Real-world data from Azure Virtual Desktop (AVD) environments suggests that D8v4 instances, supporting nine medium user sessions with typical applications like Edge, Office, and Teams, each consuming at least 3GB of RAM, are common.

While Teams offloading can help minimize resource consumption, there are instances where it may not be effective, impacting sizing considerations significantly. Note: Microsoft Teams offloading does help in lowering resource consumption, but there are various real-world examples where offloading doesn’t work which impacts resource utilization on the host.

Photo by [Mackenzie Marco](https://unsplash.com/@kenziem?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash){:target="_blank"} on [Unsplash](https://unsplash.com/photos/100-us-dollar-banknote-lot-XG88BYDSDZA?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash){:target="_blank"}
