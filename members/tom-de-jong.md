---
layout: page
title: Tom de Jong
comments: false
---
{% assign author = site.authors['tom'] %}

<img style="float: left; width: 250px; margin-right: 30px;" src="{{ site.url }}{{ author.picture | relative_url }}" alt="{{ author.display_name }}"> Tom de Jong is based in the most beautiful part from the Netherlands, which is the West-Friesland region. He is working as a EUC consultant on the Citrix portfolio, since he started working Citrix, things skyrocketed as he is only working since 3 years in this field. He has a passion for CAD/CAM workloads with for example Solidworks and Autocad, and very interested in the vGPU side.

Quick learner, and always searching for the latest technologies and releases.

Feel free to contact him on LinkedIn.

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

{% include contributions.html name='tom' %}