---
layout: post
toc: true
title:  "Architecture and hardware setup overview 2018 – 2020"
hidden: false
authors: [eltjo, ryan]
categories: [ 'infrastructure' ]
tags: [ 'infrastructure', 'OVH', 'VMware' ]
image: assets/images/posts/000-architecture-and-hardware-setup-overview-2018/000-architecture-and-hardware-setup-overview-2018-feature-image.png
---
This post is meant as an introductory breakdown describing the high-level architecture and hardware setup of the basic components that we are currently using in the {{site.title}} lab as of August 2018. We’ve setup {{site.title}} as an independent and open community platform and therefore we mean to be completely open about the hardware and setup that we use during our researches. This way everyone has the opportunity to replicate our lab setup and confirm or challenge our findings.

## Hardware setup
Because {{site.title}} is a startup we’ve chosen to rent dedicated hardware instead of buying. This means our upfront costs are relatively low and we have more flexibility in the hardware than we would have had, had we chosen to buy all the necessary hardware.

To that end for the hardware setup, we’ve partnered up with a hosting company called OVH. OVH is hosting company with 28 datacenters in 8 countries and over 1.4 million customers worldwide. They are a well-known player in the market and offer competitive pricing for their offerings.

For more information on OVH, please visit their website at [https://www.ovh.com](https://www.ovh.com){:target="_blank"}.

As of writing, we are renting two dedicated servers from their Western European datacenter in Germany.

<a href="{{site.baseurl}}/assets/images/posts/000-architecture-and-hardware-setup-overview-2018/000-architecture-and-hardware-ovh-control.png" data-lightbox="ovh-controls">
![ovh-controls]({{site.baseurl}}/assets/images/posts/000-architecture-and-hardware-setup-overview-2018/000-architecture-and-hardware-ovh-control.png)
</a>

The two hosts are broken down in an Infrastructure Host, the esx-01 and a separate host dedicated for the workloads surprisingly called esx-02. Because we’ve separated out the infrastructure platform from the host hosting the VDI’s we can assure that spikes in the infrastructure host will never interfere with the actual workloads and influence our results.

First off the infrastructure hosts is a midrange EG-128 Server. This model has a single Intel® Xeon® Processor E5-1660 processor and 128GB of internal memory. See [https://www.ovh.com/world/dedicated-servers/infra/1801eg04.xml](https://www.ovh.com/world/dedicated-servers/infra/1801eg04.xml){:target="_blank"} for additional specifications.

<a href="{{site.baseurl}}/assets/images/posts/000-architecture-and-hardware-setup-overview-2018/000-architecture-and-hardware-esx-01.png" data-lightbox="esx-01">
![esx-01]({{site.baseurl}}/assets/images/posts/000-architecture-and-hardware-setup-overview-2018/000-architecture-and-hardware-esx-01.png)
</a>

As the name implies, the infrastructure host, houses al the infrastructural components such as the AD, databases and Citrix components as well as our management jump host. The Login VSI launchers are also installed on the infra host.

For the dedicated workloads host, we’ve chosen the EG-384-H model ([https://www.ovh.com/world/dedicated-servers/infra/1801eg09.xml](https://www.ovh.com/world/dedicated-servers/infra/1801eg09.xml){:target="_blank"}).

This configuration has two Intel® Xeon® E5-2687W v4 processors with 12 cores each, totaling to 48 hyperthreading cores and is equipped with 384 Gigabytes of internal memory.

<a href="{{site.baseurl}}/assets/images/posts/000-architecture-and-hardware-setup-overview-2018/000-architecture-and-hardware-esx-02.png" data-lightbox="esx-02">
![esx-02]({{site.baseurl}}/assets/images/posts/000-architecture-and-hardware-setup-overview-2018/000-architecture-and-hardware-esx-02.png)
</a>

Most importantly with these specifications, the hosts are capable of running realistic scenarios comparable to production environments.

Both hosts are connected on a private VLAN via OVH’s vRack private network configuration.

## Hypervisor platform
In the first iteration of our lab setup, we used Citrix XenServer 6.1 as the main hypervisor platform. Later on, we decided against using XenServer as the hypervisor platform and switched to VMware vSphere. We had a lot of difficulties achieving the desired performance and stability with XenServer in the beginning.

According to the latest ‘State of the Union 2018’ survey results from VDI like a PRO, VMware has the biggest market share when it comes to the hypervisor for SBC workloads with a share of almost 60%, compared to a little under 20% for Citrix XenServer.

So at the moment, we decided to switch to VMware vSphere and both hosts are running VMware vSphere 6.5 U1g with build number 7967591.

But we are not bound to VMware as the hypervisor platform. By using OVH we have the flexibility to switch hypervisors without much effort and this allows us to test the other vendors like Microsoft, Citrix and Nutanix if the need arises.

<a href="{{site.baseurl}}/assets/images/posts/000-architecture-and-hardware-setup-overview-2018/000-architecture-and-hardware-vsphere.png" data-lightbox="vsphere">
![vsphere]({{site.baseurl}}/assets/images/posts/000-architecture-and-hardware-setup-overview-2018/000-architecture-and-hardware-vsphere.png)
</a>

On the Hypervisor level, the environment is checked against best practices defined and outlined in the VMware performance best practices guide. Most notably this means for example that the power profile for the hosts is set to static – high performance and that all VM’s are using paravirtualized network and storage adapters.

We will provide a detailed setup of all settings in a later publication.

## Desktop virtualization platform
{{site.title}} uses Citrix Virtual Apps & Desktops as the primary application virtualization platform but is platform agnostic. We can just as easily switch our workloads from Citrix to VMware Horizon, Parallels RAS or any other platform if the testing scenario requires it.

Our research scenarios use Citrix Xendesktop 7.18 at the moment.  The Citrix infrastructure is based on the Citrix VDI Handbook and Best Practices and the design considerations therein, with a couple of changes and additions.

Due to the nature of the lab environment and the method of testing, we have no need for the internal metrics from Citrix Director and for that reason, we can set the grooming to 1 day in order to keep the database as clean as possible.

Availability of the VDI’s is set to 100%, and peak hours are set to 24-7 so that all desktops will be instantly available at any time.

Because we can assume that the entire environment will be available when starting the test runs, we have no need for connection leasing or the Localhost cache functionality

LHC in particular will have a negative effect on the performance of the delivery controllers and can impact the testing results.

More info on the LHC: [https://docs.citrix.com/en-us/categories/solution_content/implementation_guides/local-host-cache-sizing-scaling.html](https://docs.citrix.com/en-us/categories/solution_content/implementation_guides/local-host-cache-sizing-scaling.html){:target="_blank"}

The VDI’s are optimized with the current version of the Citrix Optimizer tool ([https://support.citrix.com/article/CTX224676](https://support.citrix.com/article/CTX224676){:target="_blank"}) with the default settings enabled.

## Update: June 2019
Since June 2019 the {{site.title}} lab environment has been expanded with an additional infrastructure server to evenly spread the load of infrastructure roles and the Login VSI launcher. The server specifications are exactly the same as the existing infra server, model EG-128.

VMware vSphere is updated to version 6.7 and Citrix Virtual Apps & Desktop are to version 1906.

Photo by [Thomas Kvistholt](https://unsplash.com/photos/oZPwn40zCK4?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/collections/878944/server-room?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
