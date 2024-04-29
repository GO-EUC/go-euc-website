---
layout: post
toc: true
title:  "Unveiling the True Cost: Single-User vs. Multi-User Sessions in Microsoft Azure Virtual Desktop"
hidden: false
authors: [ruben, ryan]
reviewers: [leee, patrick, eltjo]
categories: [ 'Azure' ]
tags: [ 'Azure', 'Compute', 'SKU', 'Cost', 'Cloud', 'AVD']
image: assets/images/posts/112-unveiling-the-true-cost-single-user-vs-multi-user-sessions-in-microsoft-azure-virtual-desktop/unveiling-the-true-cost-feature-image.png
---
In the Desktop as a Service (DaaS) industry, the choice between utilizing single-session vs. multi-session Windows OS usually carries significant ramifications to both the cost and performance of your DaaS deployment. Which, as it turns out, according to the [2022-2023 DaaS Like a Pro Survey](https://daaslikeapro.com/){:target="_blank"} were the top two barriers to adoption of DaaS. With 706 respondents participating in last year’s survey, 21.5% of respondents say that ‘Cost’ is the number one barrier with ‘Performance’ close behind at 15.1%.

While cost and performance are certainly important factors (and we will certainly dive deep into costs in this research), the comparison between single-session and multi-session is much more nuanced. Considerations such as use case fit, workspace and OS strategy, application compatibility, session modality (desktop vs. published apps), image management, as well as power and capacity management are all important factors in your decision.

In this research, we will focus on the comparative cost dynamics of single-session and multi-session types with Windows 10/11 in the context of desktop and application virtualization. We will use both Microsoft's recommended sizing guidelines and real-world sizing numbers and uncover the nuanced implications and cost differentials associated with each approach.

## The challenge of single or multi-session sizing
The challenge in single-session versus multi-session sizing boils down to finding the sweet spot between meeting individual user, administrator and business needs and maximizing resource efficiency. In a single-session setup, each user gets their own persistent or non-persistent Virtual Machine (VM) with dedicated CPU, RAM, disk and (v)GPU resources, ensuring consistent performance but potentially leading to higher costs, especially if resources are underutilized. Conversely, in a multi-session environment, resources are shared, which can be cost-effective but may introduce less consistent performance since users compete for resources and (noisy) neighbors are running on the same VM.

Practically, this means DaaS administrators must carefully assess factors like user workload types, application requirements, changing resource requirements looking at browsers and unified communications and expected usage patterns to determine the most suitable sizing strategy. They need to strike a balance between providing adequate resources for each user to maintain productivity and optimizing resource utilization to keep costs in check. Additionally, they must consider the potential impact of scaling, user growth, and evolving technology and applications trends on both single-session and multi-session environments.

## Methodology
As we mentioned earlier, for our analysis we will be comparing the cost impact of single-session vs. multi-session Windows 10/11 utilizing both [Microsoft’s sizing recommendations](https://learn.microsoft.com/en-us/windows-server/remote/remote-desktop-services/virtual-machine-recs){:target="_blank"} for a ‘medium’ workload use case as well as sizing guidelines based on two real world Azure Virtual Desktop (AVD) deployments. Our real world deployments both have around 1000 active users with the primary usage being Microsoft Office, Edge with multiple tabs open, and Microsoft Teams in both offloading (to the endpoint device) and non-offloading scenarios.

To calculate real-world conditions of varying working times and duration of users, we assumed a session start window between 6 AM and 11 AM with users working anywhere between 6 and 10 hours in-session per day. For each user, the start time and working hours were then randomly generated in Excel based on these parameters.

The amount of required AVD hosts is calculated based on the sizing approach. For example, following Microsoft’s recommendation of 4 users per vCPU for a medium workload, we can expect a D8s_v5 instance with 8 vCPUs to support up to 32 users.

Each individual user with a random working time is mapped to a host, depending on the sizing, where the minimum starting time and the maximum shutdown time are calculated based on allocated users. The users are divided from top to bottom, meaning based on the sizing example mentioned above the first 32 users are allocated on the first host. For this research, the total number of users is 1000 for each scenario.

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

We are using current (at the time of writing this research) Azure Pay-As-You-Go instance pricing which is based on per hour usage per instance. In order to calculate the actual computing cost, the price per hour is divided by 60 to obtain a price per minute, which is multiplied by the total running time of the session host. For the hours the host is not running, the machine is in a stopped (deallocated) state, which Azure will not charge for.

> For this research, only the compute cost per instance and the storage cost are used. Additional costs such as network and licensing are not included.

In most environments, a small capacity will remain available 24/7 so users can always work. For the purposes of our analysis, a capacity for 5 users is taken into account. This means in a single session scenario, 5 VMs will remain active for 24 hours. In the case of the multi-session, this is calculated based on the used sizing.

Based on the Microsoft sizing recommendation the following Azure instance types are included in the research:

| SKU     | vGPUs | Memory |
| :------ | :---- | :----- |
| D2s_v5  | 2     | 8 GB   |
| D4s_v5  | 4     | 16 GB  |
| D8s_v5  | 8     | 32 GB  |
| D16s_v5 | 16    | 64 GB  |
| D32s_v5 | 32    | 128 GB |

Microsoft recommends selecting a virtual machine (VM) size ranging from 4 to 24 vCPUs to optimize capacity. Additionally, we have included the D32s_v5 model in our analysis just to assess its impact on pricing.

## Sizing calculations
The complexity of sizing is the unpredictability of the user's behavior. A workload type is generally used to categorize user behavior or load type. This can be in terms of tasks, office, knowledge, and power workers or light, medium, heavy, and power.

The following table provides a description of the various workload types from the Microsoft website.


| Workload type | Example users | Example apps |
| :------------ | :------------ | :----------- |
| Light         | Users doing basic data entry tasks | Database entry applications, command-line interfaces |
| Medium        | Consultants and market researchers | Database entry applications, command-line interfaces, Microsoft Word, static web pages |
| Heavy         | Software engineers, content creators | Database entry applications, command-line interfaces, Microsoft Word, static web pages, Microsoft Outlook, Microsoft PowerPoint, dynamic web pages, software development |
| Power         | Graphic designers, 3D model makers, machine learning researchers | Database entry applications, command-line interfaces, Microsoft Word, static web pages, Microsoft Outlook, Microsoft PowerPoint, dynamic web pages, photo and video editing, computer-aided design (CAD), computer-aided manufacturing (CAM) |

Source: [Session host virtual machine sizing guidelines for Azure Virtual Desktop and Remote Desktop Services - Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/remote/remote-desktop-services/virtual-machine-recs#workloads){:target="_blank"}

As the Power workload type is ended on graphical workloads, for this research it is not included.

The definition at GO-EUC of a medium or knowledge workload type included working in the Microsoft Office suite, use of Microsoft Teams, two additional applications, and browser-based applications with a minimum amount of tabs of 5.

Reflecting on the table from Microsoft, this is closest to the heavy workload type. Also, the table does not include any unified communications applications such as Microsoft Teams, which means that this table needs to be updated.

In the case of a single session, the heavy workload recommended sizing would be 4 vCPUs and 16 GB memory configuration. For multi-session, Microsoft's recommendation is a maximum of 4 users per vCPU with a minimum of 8 vCPUs and 16GB memory.

Source: [Session host virtual machine sizing guidelines for Azure Virtual Desktop and Remote Desktop Services - Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/remote/remote-desktop-services/virtual-machine-recs){:target="_blank"}

For each instance, this comes to the following sizes for facilitating 1000 users based on the Microsoft sizing recommendations:

| Type   | Session | Instance | vCPUs | Memory | Hosts | User per host | Memory per user |
| ------ | ------- | -------- | ----- | ------ | ----- | ------------- | --------------- |
| Light  | Single  | D2s_v5   | 2     | 8      | 1000  | 1             | 4 GB            |
| Light  | Multi   | D4s_v5   | 4     | 16     | 42    | 24            | 500 MB          |
| Light  | Multi   | D8s_v5   | 8     | 32     | 21    | 48            | 580 MB          |
| Light  | Multi   | D16s_v5  | 16    | 64     | 11    | 91            | 650 MB          |
| Light  | Multi   | D32s_v5  | 32    | 128    | 6     | 167           | 700 MB          |
| Medium | Single  | D4s_v5   | 4     | 16     | 1000  | 1             | 12 GB           |
| Medium | Multi   | D4s_v5   | 4     | 16     | 63    | 16            | 750 MB          |
| Medium | Multi   | D8s_v5   | 8     | 32     | 32    | 32            | 875 MB          |
| Medium | Multi   | D16s_v5  | 16    | 64     | 16    | 63            | 952 MB          |
| Medium | Multi   | D32s_v5  | 32    | 128    | 8     | 125           | 992 MB          |
| Heavy  | Single  | D8s_v5   | 8     | 32     | 1000  | 1             | 28 GB           |
| Heavy  | Multi   | D4s_v5   | 4     | 16     | 125   | 8             | 1.5 GB          |
| Heavy  | Multi   | D8s_v5   | 8     | 32     | 63    | 16            | 1.75 GB         |
| Heavy  | Multi   | D16s_v5  | 16    | 64     | 32    | 32            | 1.85 GB         |
| Heavy  | Multi   | D32s_v5  | 32    | 128    | 16    | 163           | 2 GB            |


> Formula: vGPUs * ratio = users per host

Memory per user is calculated based on the total amount of memory minus 4 GB reserved for the operating system divided by the number of users per host. The reserved operating system memory is a practice from the field, which was also applied to the [What is the best Azure Virtual Machine size for WVD using Citrix Cloud?](https://www.go-euc.com/what-is-the-best-azure-virtual-machine-size-for-wvd-using-citrix-cloud/#expectations){:target="_blank"} esearch. As operating systems are consuming more, this might need to be increased nowadays, but for now, the 4GB is applied to this research.

In reality, the memory footprint is continuously growing. Microsoft Teams and modern web browsers can quickly claim a lot of memory. Therefore, a more realistic scaling recommendation would be sizing on memory where you at least have 2 GB per user available.

**Light  = 2GB**
**Medium = 3GB**
**Heavy = 6GB**

Based on the same instance the recommended sizing would be as follows.


| Type   | Session | Instance | vCPUs | Memory | Hosts | User per host | Memory per user |
| ------ | ------- | -------- | ----- | ------ | ----- | ------------- | --------------- |
| Light  | Single  | D2s_v5   | 2     | 8      | 1000  | 1             | 4 GB            |
| Light  | Multi   | D4s_v5   | 4     | 16     | 167   | 6             | 2 GB            |
| Light  | Multi   | D8s_v5   | 8     | 32     | 74    | 14            | 2 GB            |
| Light  | Multi   | D16s_v5  | 16    | 64     | 35    | 29            | 2 GB            |
| Light  | Multi   | D32s_v5  | 32    | 128    | 16    | 63            | 2 GB            |
| Medium | Single  | D4s_v5   | 4     | 16     | 1000  | 1             | 12 GB           |
| Medium | Multi   | D4s_v5   | 4     | 16     | 250   | 4             | 3 GB            |
| Medium | Multi   | D8s_v5   | 8     | 32     | 114   | 9             | 3.1 GB          |
| Medium | Multi   | D16s_v5  | 16    | 64     | 50    | 20            | 3 GB            |
| Medium | Multi   | D32s_v5  | 32    | 128    | 25    | 40            | 3.1 GB          |
| Heavy  | Single  | D4s_v5   | 4     | 16     | 1000  | 1             | 12 GB           |
| Heavy  | Multi   | D4s_v5   | 4     | 16     | 500   | 2             | 6 GB            |
| Heavy  | Multi   | D8s_v5   | 8     | 32     | 250   | 4             | 6 GB            |
| Heavy  | Multi   | D16s_v5  | 16    | 64     | 100   | 10            | 6 GB            |
| Heavy  | Multi   | D32s_v5  | 32    | 128    | 50    | 20            | 6 GB            |


> Formula: VM memory - 4 GB OS reserve / memory = users per host

There is a clear difference between both Microsoft and GO-EUC sizing estimations, which affects overall cost estimations. To put this in perspective, in general, there is an over 2x increase in the amount of resources required between the Microsoft and GO-EUC sizing guidelines.

Please note that applications increasingly impact resource utilization and specifically memory footprints. This trend is expected to intensify, making it crucial to analyze actual user behavior within existing single-user and multi-user environments. Most operating systems, applications, and SaaS/web applications are not designed with Application and Desktop Virtualization in mind. In the VDI and DaaS industry, there's a tendency to focus narrowly on application and desktop virtualization as a common solution, overlooking the reality that physical desktops still predominate.

Applications are typically developed for the average consumer and business physical PC, which continues to grow in CPU, memory, storage and GPU capabilities.
It's important to highlight the significant gap between what Microsoft recommends for compute allocations in Azure Virtual Desktop (AVD) and Remote Desktop Services (RDS), and the hardware typically found in a high school student’s backpack—likely an 8-core Intel chip, at least 8GB of RAM, and a dedicated GPU. This disparity underscores the need for a reassessment of virtualization strategies to better align with the capabilities of commonly used devices.

For storage it is recommended to reserve 30GB for the operating system and at least 30GB to accommodate for the user profiles. It is also important to keep in mind that the applications also need to be installed, this is very dependent on the type of application.

| Disk | Type        | Size | Price per month | Price per day |
| ---- | ----------- | ---- | --------------- | ------------- |
| P10  | Premium-SSD | 128  | $21.68          | $0.712        |
| P15  | Premium-SSD | 256  | $41.82          | $1.373        |
| P20  | Premium-SSD | 512  | $80.54          | $2.646        |

Source: [Pricing - Managed Disks - Microsoft Azure](https://azure.microsoft.com/en-us/pricing/details/managed-disks/){:target="_blank"}

> Price per month / 30.43  = price per day

The formula above calculates the price per day, which is based on monthly prices divided by 30.43, which is the average amount of days in each month for the entire year. Based on Microsoft's minimum storage size requirements, the P10 disk with 128GB is selected for all scenarios.

## Hypothesis
Before delving into the findings, our initial hypothesis suggests that the multi-session scenario will prove more cost-efficient than its single-session counterpart. However, the landscape has evolved considerably, with applications like Microsoft Teams, Zoom, Microsoft Office, and web browsers like Edge/Chrome experiencing increased memory utilization. Additionally, shifts in user behavior, such as maintaining numerous browser tabs open simultaneously, contribute to increased resource consumption over time.

Furthermore, Microsoft's recommended sizing remains unchanged from three maybe four years ago. However, considering the evolving landscape of application resource usage, the impact of security patches, and shifts in overall user behavior, it's evident that these sizing guidelines have become outdated. Interesting to see is that vendors such as
[Nerdio](https://nmmce.getnerdio.com/){:target="_blank"} also use these sizing guidelines.

Considering the evolving nature of application resource usage, the impact of security patches, and shifts in user behavior, it becomes evident that these sizing guidelines may no longer align with today's needs. This would have a big impact on the total cost in a business case. Therefore, there's a compelling argument to update and adapt the Microsoft guidelines.

## Results
The following chart is created based on the Microsoft recommended sizing ratio for light, medium and heavy workload types. All prices are USD per day for facilitating 1000 users. As described, there is a capacity for 5 users, and 24 hours are available to ensure the user can work.

{% include chart.html scale='auto' type='bar' data_file='assets/data/112-unveiling-the-true-cost-single-user-vs-multi-user-sessions-in-microsoft-azure-virtual-desktop/microsoft-sizing-per-day.json' currency='true' %}

As expected, a multi-session scenario is significantly more cost-effective compared to a single-session.

For the realistic sizing, the size is based on the memory consumption as specified in the previous chapter.

{% include chart.html scale='auto' type='bar' data_file='assets/data/112-unveiling-the-true-cost-single-user-vs-multi-user-sessions-in-microsoft-azure-virtual-desktop/realistic-sizing-per-day.json' currency='true' %}

Overall, again, the multi-session is the most cost-effective, however, compared to the Microsoft recommended sizing, there is a massive difference – nearly $500 per day! Reflecting this to an entire year, which for 2024 has 251 working days, this is around $100,000 difference between both, which is on average a difference of 200%.

The following chart is a breakdown of the storage cost per day.

{% include chart.html scale='auto' type='bar' data_file='assets/data/112-unveiling-the-true-cost-single-user-vs-multi-user-sessions-in-microsoft-azure-virtual-desktop/microsoft-sizing-disk-per-day.json' currency='true'%}

{% include chart.html scale='auto' type='bar' data_file='assets/data/112-unveiling-the-true-cost-single-user-vs-multi-user-sessions-in-microsoft-azure-virtual-desktop/realistic-sizing-disk-per-day.json' currency='true'%}

The prices are based on the number of VMs required to facilitate 1000 users. The differences are minimal as the overall cost per day is relatively low. There are ways to optimize the cost, such as changing the SKU to a standard HDD while the VM is in a stopped state. However, the disks are persistent for this research.

As described in the introduction, the challenge of having multiple users on a single host means the overall runtime of a host is going to be longer. The following chart shows the estimated runtime of each instance.


{% include chart.html scale='auto' type='bar' data_file='assets/data/112-unveiling-the-true-cost-single-user-vs-multi-user-sessions-in-microsoft-azure-virtual-desktop/vm-runtime.json' %}

The overall conclusion is that more users on a single host means the running time is expected to be longer.

## Conclusion
In summary, the current Microsoft sizing guidelines lack accuracy and relevance, remaining unchanged for the past three years despite evolving technology landscapes. Microsoft's sizing guidelines lack essential context such as date, application versions, less clear definitions of workload type and example user and details about application usage.

While Microsoft's recommended sizing numbers aren’t usable for many or at least debatable, multi-user setups generally offer greater cost-effectiveness compared to single-user configurations. However, single-user setups provide benefits such as consistent performance, streamlined Client OS deployment, management and future-proofing, with enough CPU and memory resources available in commonly used 4vCPU with 16GB RAM instances. It's worth noting that both Microsoft and also Nerdio default multi-user sizing guidelines fail to reflect real-world customer scenarios, overwriting the defaults and using realistic numbers in the sizing calculator is advised.

When relying on the Microsoft sizing guidelines for your business case it will negatively impact the total cost of ownership. Based on this context, the total cost on a realistic sizing will be 2 times higher.

For light users with minimal application needs, multi-user configurations with published applications are preferred and very cost-efficient. However, for medium and heavy users often running with a published desktop and running more diverse application requirements and increasing resource utilization, the difference between single-user and multi-user setups is there but not as big as many people believe it is.

Opting for larger instance sizes in multi-user environments can complicate shutdown procedures when sessions are inactive. Despite minimal cost differences between instance sizes like D4, D8, D16, and D32, it's advisable to use D8 or D16 machines for multi-user setups due to their larger memory capacity.

In realistic scenarios, allocating 2 GB of RAM for light users, 3-4 GB for medium users, and 5-6GB for heavy users proves more practical. Real-world data from Azure Virtual Desktop (AVD) environments suggests that D8v4 instances, supporting nine medium user sessions with typical applications like Edge, Office, and Teams, each consuming at least 3GB of RAM per user session, are common.

While Microsoft Teams offloading can help minimize resource consumption, there are scenarios where it may not be effective, impacting sizing considerations significantly. In environments with a BYOD (Bring Your Own Device) policy, you cannot always control the remoting protocol application version, resulting in unoptimized Teams communications.

Photo by [Mackenzie Marco](https://unsplash.com/@kenziem?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash){:target="_blank"} on [Unsplash](https://unsplash.com/photos/100-us-dollar-banknote-lot-XG88BYDSDZA?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash){:target="_blank"}