---
layout: page
title: Sven Huisman
comments: false
---
{% assign author = site.authors['sven'] %}

<img style="float: left; width: 250px; margin-right: 30px;" src="{{ site.url }}{{ author.picture | relative_url }}" alt="{{ author.display_name }}">Sven is working as a solutions architect at Nutanix with the focus on End User Computing. From 2010 to 2013 he was an active contributor to Project VRC, a collaboration of two consultancy companies to research and find best practices for virtualizing desktop workloads. Because of this history with benchmarking VDI and RDSH and publishing about the results, he didn’t have to think twice about joining the community initiative GO-EUC!

Apart from his professional interest in finding the best performance in VDI and RDSH environment, in his private time his interest is in finding the best (personal) performance in running, from 5K to marathon distance.

You can follow Sven on Twitter or get in touch via LinkedIn.

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

{% include contributions.html name='sven' %}