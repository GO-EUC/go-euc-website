---
layout: page
title: Fredrik Brattstig
comments: false
---
{% assign author = site.authors['fredrik'] %}

<img style="float: left; width: 250px; margin-right: 30px;" src="{{ site.url }}{{ author.picture | relative_url }}" alt="{{ author.display_name }}">With over 20 years of experience of the VDI/Remote Apps and Desktops niche, Fredrik lives by the mantra of providing High-End User Experience.

Fredrik enjoys greatly to examine performance metrics and User Experience of Remoting protocols in the EUC space. CAD, 3D modelling, Gaming and Virtual Reality are good ways of showing the usability of Remote Graphics.

He has a great understanding of the importance of the tech Community and doesn’t hesitate to share hints and tricks on the different technologies he gets his hands on.
Fredrik lives in Sweden with his family of 4 kids and wife. Enjoys well cooled Lager and does his fair share of running (some might say it’s jogging)….


| Community Awards                    |                           |
| :---------------------------------- | :------------------------ |
| NVIDIA NGCA vGPU Community Advisor  | 2019, 2020, 2021 and 2022 |
| Microsoft MVP – Enterprise Mobility | 2020-2021 |

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

{% include contributions.html name='fredrik' %}
