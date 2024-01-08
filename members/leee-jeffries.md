---
layout: page
title: Leee Jeffries
comments: false
---
{% assign author = site.authors['leee'] %}

<img style="float: left; width: 250px; margin-right: 30px;" src="{{ site.url }}{{ author.picture | relative_url }}" alt="{{ author.display_name }}">Leee Jeffries is an IT professional with over 15 years of experience in the IT industry. Leee's main focus is in End User Computing (EUC) with a good amount of experience in performance testing EUC environments. Leee Works with large and small organisations across the IT industry, Leee is keen on exercise and likes competing in triathlons, obstacle races and running. You will see him around at EUC Forum events and other conferences, he enjoys being involved in community events.

Leee is a current Citrix Technology Professional (CTP) and has held the award for the last 4 years.

You can follow Leee on twitter, LinkedIn or personal blog.

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


{% include contributions.html name='leee' %}
