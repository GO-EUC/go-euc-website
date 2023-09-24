---
layout: page
title: Ruud Hund
comments: false
---
{% assign author = site.authors['ruud'] %}

<img style="float: left; width: 250px; margin-right: 30px;" src="{{ site.url }}{{ author.picture | relative_url }}" alt="{{ author.display_name }}"> Ruud is a Thought Leader Connected Workspace at Cegeka. Ruud has over 10+ years experience in designing and building network infrastructures. These range from small to large international networks.

He focuses on the SDN stack and optimizing networks for modern day cloud use. Besides SDN Ruud is also experienced in Citrix ADC, Identity and Access management.
Ruud lives in the north of the Netherlands with his girlfriend and three children.

You can get in touch via LinkedIn

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

{% include contributions.html name='ruud' %}