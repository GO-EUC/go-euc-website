---
layout: post
toc: true
title:  "Nutanix lab architecture and hardware setup overview 2019 – Current"
hidden: false
authors: [sven]
categories: [ 'infrastructure' ]
tags: [ 'infrastructure', 'nutanix' ]
image: assets/images/posts/000-nutanix-lab-architecture-and-hardware-setup-overview-2019/000-nutanix-lab-architecture-and-hardware-setup-overview-2019-feature-image.png
---
Next to the infrastructure used by {{site.title}} that is rented at an external hosting company, we are now able to occasionally perform tests on hardware that is available at one of the labs at Nutanix. When available, we can use the {{site.title}} automation to run Login VSI tests on this hardware and use the results in our research.

> **Disclaimer:** Nutanix is not sponsoring {{site.title}}. Sven Huisman, an employee of Nutanix, has joined {{site.title}} on a personal basis to help researching EUC-related (performance) topics. He has the ability (and the permission) to use a Nutanix-lab for {{site.title}} related research when the lab is not being used by Nutanix. Because the Login VSI testing is automated, tests can be easily scheduled during off hours.

> The Nutanix-lab will not be used to perform tests to benchmark hypervisors. It will only be used to perform Login VSI tests to be able to identify the impact of changes in the one of the other layers in the EUC-stack (operating systems, applications, desktop delivery types, etc).

This post describes the high-level architecture and hardware setup of the components that will be used in the Nutanix-lab. When this infrastructure is used for a research, it will be specified in the blogpost. As {{site.title}} is meant to be an independent and open community platform, during tests on this infrastructure, the Nutanix controller VM will be powered off on the target-host. This allows anyone to reproduce our results on hardware with the same CPU and memory specifications, but without the Nutanix components.

## Nutanix hardware setup
The infrastructure in the Nutanix-lab is divided in two 4-node clusters. One cluster is used for the infrastructure and the other cluster is used to run the workloads for testing. On the target cluster, only one host is used to perform tests (the target host), while the other three nodes are used for storage only.

As the name implies, the infrastructure cluster hosts all the infrastructure components such as the AD, databases and Citrix components as well as the Login VSI launcher VMs (to initiate the sessions to the target VMs). The infrastructure cluster consists of NX-3050 nodes with dual Intel(R) Xeon(R) CPU E5-2670 @ 2.60GHz CPUs and 256GB memory. Somewhat older CPUs but good enough to host the infrastructure.

The target cluster is a NX-3060-G5 cluster with nodes that consists two Intel® Xeon® E5-2680 v4 processors with 14 cores each, totaling to 56 hyperthreading cores. The nodes are equipped with 512 Gigabytes of internal memory.

<a href="{{site.baseurl}}/assets/images/posts/000-nutanix-lab-architecture-and-hardware-setup-overview-2019/000-nutanix-lab-overview.png" data-lightbox="nutanix-overview">
![nutanix-overview]({{site.baseurl}}/assets/images/posts/000-nutanix-lab-architecture-and-hardware-setup-overview-2019/000-nutanix-lab-overview.png)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Infrastructure setup of Login VSI in the Nutanix-lab</i>
</p>


In a Nutanix Hyperconverged infrastructure there will be a Controller VM running on each node in the cluster. The Nutanix Controller VM enables the pooling of local storage from all nodes in the cluster. When the hypervisor running on the nodes is VMware vSphere, this pool of storage is presented by NFS to the hosts. As mentioned, when testing for {{site.title}}, the Nutanix controller VM is turned off on the target-host. When the Nutanix CVM is powered off, the storage path will be redirected to one of the other CVMs over the 10 Gbe network over NFS.

<a href="{{site.baseurl}}/assets/images/posts/000-nutanix-lab-architecture-and-hardware-setup-overview-2019/000-nutanix-lab-cvm-failure.jpg" data-lightbox="nutanix-cvm-failure">
![nutanix-cvm-failure]({{site.baseurl}}/assets/images/posts/000-nutanix-lab-architecture-and-hardware-setup-overview-2019/000-nutanix-lab-cvm-failure.jpg)
</a>
<p align="center" style="margin-top: -30px;" >
  <i>Storage path redirection when the Controller VM is offline</i>
</p>

The only impact for the target VMs is that the storage is accessed over the network, so there is no advantage of data locality. This might impact the user experience, but as we will be comparing before and after situations on the same infrastructure, this will not affect the results.

## Hypervisor platform
Currently, VMware vSphere is used in the {{site.title}} infrastructure. Therefore, the tests performed for {{site.title}} in the Nutanix-lab will also be performed on vSphere.  VMware vSphere 6.7 U1 with build number 10302608 is installed.

<a href="{{site.baseurl}}/assets/images/posts/000-nutanix-lab-architecture-and-hardware-setup-overview-2019/000-nutanix-lab-vmware.png" data-lightbox="nutanix-vmware">
![nutanix-vmware]({{site.baseurl}}/assets/images/posts/000-nutanix-lab-architecture-and-hardware-setup-overview-2019/000-nutanix-lab-vmware.png)
</a>

## Desktop virtualization platform
In the Nutanix-lab Citrix Virtual Apps and Desktops 7 version 1811 is installed. The Citrix infrastructure is based on the Citrix VDI Handbook and Best Practices and the design considerations therein, with a couple of changes and additions.

Availability of the VDI’s is set to 100%, and peak hours are set to 24-7 so that all desktops will be instantly available at any time.

The VDI’s are optimized with the current version of the Citrix Optimizer tool ([https://support.citrix.com/article/CTX224676](https://support.citrix.com/article/CTX224676){:target="_blank"}) with the default settings enabled.

If you want more information about this infrastructure, please feel free to ask questions on the [Slack channel](https://worldofeuc.slack.com){:target="_blank"}.
