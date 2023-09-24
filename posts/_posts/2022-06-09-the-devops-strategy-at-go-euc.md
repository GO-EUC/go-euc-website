---
layout: post
toc: true
title:  "The DevOps Strategy at GO-EUC"
hidden: false
authors: [ryan, eltjo]
reviewers: [esther, patrick, gerjon]
categories: [ 'Development' ]
tags: [ 'DevOps', 'Terraform', 'Ansible', 'Pipeline']
image: assets/images/posts/090-the-devops-strategy-at-go-euc/the-devops-strategy-at-go-euc-feature-image.png
---
More and more organizations are in the middle of adopting a DevOps strategy to increase agility. Right from the start, using a DevOps approach lies at the core of GO-EUC. As DevOps is becoming a big topic in the end-user computing industry, GO-EUC has decided to provide some insights into the GO-EUC DevOps strategy. This post will serve as a general introduction and provides an overview of the DevOps strategy applied at GO-EUC.

## The core of GO-EUC
At GO-EUC our main mission is to facilitate individuals with research capabilities to explore new technologies and inspire and serve the community by providing new knowledge. And for that purpose, GO-EUC hosts a platform and provides methodologies to test and explore the latest EUC-related technologies.
With these fast evolving technologies, using a Devops focused approach allows us to be agile enough to keep up with these changes.

## Our DevOps principles
Within GO-EUC, there are several DevOps principles we apply in our work:

  * Collaboration and recognition
  * Automation and reproducibility
  * Continuous improvement
  * Think big, start small

### Collaboration and recognition
Even though collaboration a principal should be evident, it is a critical factor in the success of the DevOps way of working. When great minds collaborate together, this can lead to a brilliant outcome. All information and output produced is available and accessible to each member to enable and facilitate collaboration. Furthermore, getting proper recognition is vital to support the individual brands of our members. Our platform facilitates and helps to create and share content, so they can grow in the EUC community.

### Automation and reproducibility
It is an utopia to automate everything, and there needs to be a consideration if it will be beneficial even to automate it. One of the architectural principles at GO-EUC is automate *where possible*. This is essential to keep our standards high and ensure the reproducibility of what we do.

### Continuous improvement
There is always room for improvement, which is part of our culture and mindsets. Often there is an evaluation of how everything is going and where we can improve our way of working. Another vital philosophy at GO-EUC is that we embrace failing. Of course, failing will result in negative emotions, but we see it as a learning point. We are not robots; we all make mistakes, but we take this as a learning point and see how we can improve this.

### Think big, start small
It is challenging to keep the focus and make a research, or any activity for that matter, way too big is our natural behavior. It is essential to embrace big thinking, but it needs to start small to get this done. This is applied to everything we do: our automation, new developments, and even the research. Because our patform is voluntary-based, the time invested in GO-EUC is often limited. To produce output, all big ideas are broken down into small chunks that are easier to digest.

## Insights into our lab automation
As GO-EUC is continuously improving on the automation of the platform and provisioning of our lab¸ the choice was made to share the code created with the public. This enables our principles listed above to allow others to reproduce and maybe even challenge our results.

Among the latest additions to the capabilities of the automation platform, we’ve added support to test on several different platforms, on-premises or cloud and including support for the major EUC delivery methodes.

To enable this kind of approach, the following technologies are selected:

| Vendor | Solution | Reason |
| :-------- |:----------| :---------- |
| Hashicorp | [Terraform](https://www.terraform.io/){:target="_blank"} | IaC, which supports all major clouds and vendors. |
| Hashicorp | [Packer](https://www.packer.io/){:target="_blank"} | IaC image management with support for major clouds and vendors. |
| RedHat | [Ansible](https://www.ansible.com/){:target="_blank"} | Desired state with support for both Linux and Windows. |
| Docker Inc. | [Docker](https://www.docker.com/){:target="_blank"} | Containers for a couple of services. |
| Microsoft | [PowerShell](https://docs.microsoft.com/en-us/powershell/){:target="_blank"} | Main scripting language used as our last resort. |
| Microsoft | [Azure DevOps](https://azure.microsoft.com/en-us/services/devops/){:target="_blank"} | Primary DevOps solution for pipelines. |
| Microsoft | [GitHub](https://github.com){:target="_blank"} | Source code location. |

These technologies enable us to achieve our goals. As one of the GO-EUC principles is continuous improvement, it is also important to keep track of new and emerging technologies that might be a better fit. The team has decided on the the technology stack listed above, but who knows what new insights the future might bring.

## Next steps
More information will be provided in upcoming publications on how [our repository](https://github.com/GO-EUC/go-euc-lab){:target="_blank"} is set up and how you can use it in your environments.

Photo by [S Migaj](https://unsplash.com/@simonmigaj?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/yoga?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
