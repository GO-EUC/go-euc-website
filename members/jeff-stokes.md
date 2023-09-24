---
layout: page
title: Jeff Stokes
comments: false
---
{% assign author = site.authors['jeff'] %}

<img style="float: left; width: 250px; margin-right: 30px;" src="{{ site.url }}{{ author.picture | relative_url }}" alt="{{ author.display_name }}">Jeff Stokes is a Principal Engineer at Tanium. His career started at Digital (DEC) in 1994. He has specialized in the field of Windows performance analytics since 2008 while a Senior Escalation Engineer and then a Premier Field Engineer (PFE) at Microsoft. He is an expert in the fields of Windows performance analytics, debugging, VDI, and Windows imaging and deployment. He holds many Microsoft certifications. He was the lead author of books on the Microsoft Deployment Toolkit and Windows 10 Enterprise Administration, and a contributor to several others.

He lives in the metro Atlanta area and is an avid gamer, reader, blogger, and music fan.

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

{% include contributions.html name='jeff' %}