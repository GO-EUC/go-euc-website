---
layout: page
title: Gerjon Kunst
comments: false
---
{% assign author = site.authors['gerjon'] %}

<img style="float: left; width: 250px; margin-right: 30px;" src="{{ site.url }}{{ author.picture | relative_url }}" alt="{{ author.display_name }}"> Gerjon Kunst is a Principal Consultant at RawWorks in het Netherlands, focusing on future Workspace and Cloud. Gerjon has 20 years experience in the IT business starting as a system engineer working his way up to a IT pro with broad and in depth knowledge of Workspace and Cloud.

Gerjon is a known presenter on Citrix User Groups and E2EVC and as he is a Microsoft Certified Trainer you might have met him in a classroom somewhere.

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

{% include contributions.html name='gerjon' %}