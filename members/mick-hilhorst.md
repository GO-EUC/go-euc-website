---
layout: page
title: Mick Hilhorst
comments: false
---
{% assign author = site.authors['mick'] %}

<img style="float: left; width: 250px; margin-right: 30px;" src="{{ site.url }}{{ author.picture | relative_url }}" alt="{{ author.display_name }}">

Mick is an active community member who is always in for some discussion regarding automation, geese, or food.
Primarily Mick's contributions in the community (but are not limited to) Citrix NetScalers.
Currently he holds the Citrix CTA title.

In his sparetime he enjoys videogames, food, geese, development and 3d-printing.

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

{% include contributions.html name='mick' %}
