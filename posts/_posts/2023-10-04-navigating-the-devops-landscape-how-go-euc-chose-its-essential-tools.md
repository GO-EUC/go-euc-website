---
layout: post
toc: true
title:  "Navigating the DevOps Landscape: How GO-EUC Chose Its Essential Tools"
hidden: false
authors: [ryan]
reviewers: [anton, eltjo]
categories: [ 'Development' ]
tags: [ DevOps, Terraform, Packer, Vault, GitHub, Azure, Docker ]
image: assets/images/posts/105-navigating-the-devops-landscape-how-go-euc-chose-its-essential-tools/navigating-the-devops-landscape-feature-image.png
---
The [introductory post](https://www.go-euc.com/the-devops-strategy-at-go-euc/){:target="_blank"} provided some insights into the tools GO-EUC has chosen to achieve our success. It is important to have a clear vision of the overall strategy when selecting your own DevOps tools. This article will go into a more in-depth look at the GO-EUC DevOps landscape and the rationale behind our choice of tools.

## The GO-EUC overall strategy
As previously mentioned, when selecting a toolset, it is important to clearly understand your organization's overall strategy. For instance, if your organization intends to transition from Microsoft Azure to Amazon AWS, it would not be wise to opt for Bicep as the infrastructure as code language, as it is only supported on Microsoft Azure.

At GO-EUC, the core mission is researching new technologies to gain new knowledge and share it with the community. The primary goal is to deliver articles reliably and consistently. It is key to have the flexibility to test any software on any platform and enable others to replicate and challenge the findings that we have. This implies a commitment to multi-cloud deployments and support for all delivery models, regardless of the platform.

We recognize that this is an ambitious vision, and to accomplish such a task, it's best to start small. Taking small steps and breaking down work into more manageable chunks of work makes it easier to release that perhaps ambitious goal. At the time of writing, GO-EUC has not yet achieved that level, but we do strive to reach our goal through our ongoing commitment for improvement.

## The technology at GO-EUC
Within our DevOps strategy, the selected tools serve the purpose of enabling us to accomplish the previously mentioned goals and facilitate knowledge sharing. While some technologies have already been mentioned in the previous post, let's delve into the rationale behind our choices.

### GitHub
[GitHub](https://github.com/){:target="_blank"} is a platform and cloud-based service for software development and version control using [Git](https://git-scm.com/){:target="_blank"}, allowing developers to store, manage and share their code.

GitHub plays a big role in our code-sharing efforts at GO-EUC. Collaboration and recognition are fundamental DevOps principles within our foundation, and GitHub is a perfect fit as a platform to facilitate these principles. We generate code that requires a repository, and as we are a strong believer in collective learning, we've decided to share all of our infrastructure as code publicly for several reasons.

First and foremost, since some of our members engage in similar activities at their customers, sharing our code publicly eliminates any conflicts of interest or concerns related to customer intellectual property. This decision is driven by GO-EUC's principles, ensuring that what we learn from our clients can be applied to our projects and vice versa.

Secondly, it's important to note that GO-EUC is a non-profit foundation, with members participating voluntarily and contributing to the community. Therefore, there is no profit motive in keeping our work private. Sharing it with the community aligns with our values and objectives.

Lastly, GitHub provides transparency by showcasing contributors to our projects. This transparency allows us to recognize and appreciate the contributions of others, a factor we consider very important. Furthermore, it opens the door for external individuals to contribute as well, to promote our community, and contribute to the overall success of our projects.

### Azure DevOps
[Azure DevOps](https://azure.microsoft.com/en-us/products/devops){:target="_blank"} is a Microsoft product that provides version control, reporting, requirements management, project management, automated builds, testing and release management capabilities. It covers the entire application lifecycle and enables DevOps capabilities. 

In the Netherlands, it's noteworthy that most companies implementing Agile practices or already engaged in DevOps have opted for Azure DevOps. While this choice enhances project adoption, GO-EUC has additional reasons for selecting Azure DevOps.

Certainly, we could have utilized GitHub actions, but the provisioning of our project in your environment necessitates a certain level of access. By utilizing Azure DevOps, we can ensure that when someone employs the GO-EUC example, the project remains private within a closed environment.

Moreover, many of our members already actively utilize Azure DevOps in their daily work routines. This familiarity and expertise in Azure DevOps make it more convenient for us to accomplish our tasks efficiently. This, however, does not imply that we won't extend support to GitHub actions in the future.

### HashiCorp’s, Packer and Terraform
[Packer](https://www.packer.io/){:target="_blank"} is an open-source tool for creating identical machine images for multiple platforms from a single source configuration. [Terraform](https://www.terraform.io/){:target="_blank"} is an infrastructure-as-code software tool created by HashiCorp. For both Packer and Terraform, users define and provide data center infrastructure using a declarative configuration language known as HashiCorp Configuration Language (HCL).

Regarding infrastructure as code, HashiCorp stands out as one of the industry leaders in this field. Despite the ongoing debate surrounding HashiCorp's transition from open source to closed source, it has not influenced our selection process as of yet.

At GO-EUC, we use HashiCorp's Packer and Terraform for tasks such as image creation and infrastructure deployment. The appeal of both Packer and Terraform lies in their ability to support multi-cloud environments and even on-premises infrastructure. That means that these two solutions make perfect sense as our primary deployment tools, which align with our end goal.

### Ansible
[Ansible](https://www.ansible.com/){:target="_blank"} is an open-source community project sponsored by Red Hat. Ansible is a cross-platform automation tool and it is primarily intended for IT professionals, who use it for application deployment, updates on workstations and servers, cloud provisioning, configuration management, intra-service orchestration. Because Ansile doesn’t depend on agent software it is very easy to deploy and maintain.

Having the infrastructure in place doesn't necessarily imply that the job is done; there's often a need for configuration to finalize the deployment. This is where Ansible comes into play, as it facilitates the application of configurations in a desired state approach.

Ansible offers the flexibility to manage both Linux and Windows operating systems, which aligns with our requirement to manage all kinds of platforms regardless of the operating system. It utilizes both Python and PowerShell as its underlying technologies and allows for extensibility. In situations where a particular module is unavailable, Ansible provides us with the opportunity to create our own, tailored to our needs.

### Docker
[Docker](https://www.docker.com/){:target="_blank"} is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly. 

Containers offer the flexibility to run solutions in isolation within their own containers. Although this practice may not be very common in the end-user computing sector, it does grant GO-EUC the ability to operate certain components in this manner.

Primarily, Docker is employed for running Azure DevOps Agent containers, simulating our web server, and managing HashiCorp Vault. It wouldn't be surprising if more components are deployed in Docker in the future, given its efficiency and ease of use.

### HashiCorp Vault
[Vault](https://www.vaultproject.io/){:target="_blank"} is an identity-based secrets and encryption management system. A secret is anything that you want to tightly control access to, such as API encryption keys, passwords, and certificates for example.

While utilizing a cloud provider like Azure comes with a default vault solution, Azure KeyVault, our strategy revolves around supporting multi-cloud environments. As the name already implies, Azure Keyvault is only available on Azure, and therefore, we decided to use HashiCorp Vault in favor of Azure Keyvault. This choice offers the flexibility to run Vault in a container on any platform, which really simplifies the creation of a unified integration from an Ansible perspective.

The adoption of HashiCorp Vault allows us to guarantee the security of all secrets and passwords, regardless of the deployment environment, including on-premises scenarios.
### PowerShell
[PowerShell](https://learn.microsoft.com/en-us/powershell/){:target="_blank"} is a task automation and configuration management program from Microsoft, consisting of a command-line shell and the associated scripting language. When Microsoft introduced PowerShell Core in 2016, which added support for platforms other than Windows, it became an open-source and cross-platform tool.

For us, PowerShell plays a role as a last-resort tool. At GO-EUC, the primary focus is on Ansible, but there are situations where PowerShell becomes the preferred solution. For instance, it finds its place in specific pipeline tasks.

## Closing notes
At GO-EUC, the focus remains on continuous improvement to ensure that processes are executed more efficiently. This approach begins with small steps, enabling us to achieve our goals effectively.

When considering a solution, it's vital to keep an open mind and a broad perspective. New insights emerge daily that can impact the selection of tools, potentially bringing us closer to our ultimate objectives.

This article offers insights into our toolset, aiming to assist you in your coding journey. If you have questions, please feel free to reach out or comment below.

Photo by [Dan Cristian Pădureț](https://unsplash.com/@dancristianpaduret?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/photos/noOXRT9gfQ8?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)
