---
layout: page
title: Anton van Pelt
comments: false
---
{% assign author = site.authors['anton'] %}

<img style="float: left; width: 250px; margin-right: 30px;" src="{{ site.url }}{{ author.picture | relative_url }}" alt="{{ author.display_name }}">Anton van Pelt is an independent senior IT consultant and architect with over 18 years of experience in complex IT environments. Anton’s focus is primarily on designing and building secure end user computing solutions. He also works a lot on Citrix and Microsoft Cloud based solutions to extend the on-premises datacenter by making use of Infrastructure as Code tools like Ansible, Terraform and Packer. Nevertheless, his interests extend much further, giving him broad knowledge in complex IT environments.

For more than 5 years Anton is awarded as a Citrix Technology Professional. Anton is active in presenting his knowledge throughout the community and at various stages around the world.

You can follow Anton on twitter, LinkedIn or personal blog.

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

{% include contributions.html name='anton' %}