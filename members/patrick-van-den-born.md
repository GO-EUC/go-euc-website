---
layout: page
title: Patrick van den Born
comments: false
---
{% assign author = site.authors['patrick'] %}

<img style="float: left; width: 250px; margin-right: 30px;" src="{{ site.url }}{{ author.picture | relative_url }}" alt="{{ author.display_name }}"> Patrick van den Born is an independent senior Consultant and IT Architect focused on the End User Computing, Public Cloud, Everything-as-Code, and DevOps area. Patrick is responsible for designing, leading, and implementing End User Computing projects. With experience in automation, everything-as-Code, infrastructure, and EUC, Patrick is capable of transforming organizations towards a DevOps and automation approach.

Patrick is an expert in the following topics: Citrix End User Computing, Microsoft Azure, NVIDIA-Technologies, Hashicorp Terraform, and Hashicorp Packer. He also has a broad knowledge of on-premises VMware and Microsoft Technologies.

Patrick is active in the community presenting at various events. Patrick is also a member of TeamRGE and GO-EUC. Citrix has rewarded Patrick with the Citrix Technology Professional status.

You can follow Patrick on Twitter and LinkedIn or read his blog.

<div style="display: inline-flex; font-size: 32px;">
{% if author.linkedin %}
<a style="padding: 5px;" href="{{author.linkedin}}" target="_blank"><i class="ion ion-logo-linkedin"></i></a>
{% endif %}

{% if author.twitter %}
<a style="padding: 5px;" href="{{author.twitter}}" target="_blank"><i class="ion ion-logo-twitter"></i></a>
{% endif %}

{% if author.web %}
<a style="padding: 5px;" href="{{author.web}}" target="_blank"><i class="ion ion-logo-wordpress"></i></a>
{% endif %}

{% if author.github %}
<a style="padding: 5px;" href="{{author.github}}" target="_blank"><i class="ion ion-logo-github"></i></a>
{% endif %}

{% if author.reddit %}
<a style="padding: 5px;" href="{{author.reddit}}" target="_blank"><i class="ion ion-logo-reddit"></i></a>
{% endif %}
</div>

{% include contributions.html name='patrick' %}