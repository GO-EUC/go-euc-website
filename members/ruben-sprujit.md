---
layout: page
title: Ruben Sprujit
comments: false
---
{% assign author = site.authors['ruben'] %}

<img style="float: left; width: 250px; margin-right: 30px;" src="{{ site.url }}{{ author.picture | relative_url }}" alt="{{ author.display_name }}">Ruben Spruijt - Field CTO Dizzion; This tough mudder travels the world spreading tokens of knowledge hidden in stroopwafel from the land of nether.
Everywhere he travels, he shares information and sprouts understanding.
He frames his experience in End User Computing so that others can learn the root of the technology, and what is most important in life.

Ruben Spruijt is an accomplished Field Chief Technology Officer (CTO) at Dizzion specializing in End User Computing (EUC). In this influential role, Ruben does contribute to company and product strategy, alliances, analyze EUC technology trends, provide product and industry insights to fellow (executive) colleagues, and establish and lead vibrant communities of customers, partners, and ecosystem partners.

Ruben is a Microsoft Most Valuable Professional (MVP), NVIDIA GRID Community Advisor and was in the Citrix Technical Professional (CTP) program and VMware vExpert for many years.

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


{% include contributions.html name='ruben' %}
