---
layout: page
title: Krishan Khoesial
comments: false
---
{% assign author = site.authors['krishan'] %}

<img style="float: left; width: 250px; margin-right: 30px;" src="{{ site.url }}{{ author.picture | relative_url }}" alt="{{ author.display_name }}"> Krishan is a Workspace Consultant at Cegeka. He has more than a decade experience in End User Computing and conducted many performance scans for customers, national and international. Currently Krishan focuses on the Citrix Stack and primarily Citrix Virtual Apps and Desktops and Citrix Hypervisor. He has strong knowledge of these products including designing, implementing and maintaining complex infrastructures. Krishan holds several Microsoft and Citrix certifications and tries to keep up with the latest technologies.

Besides the business part I am a father of two and married. In essence, I don’t have a lot of spare time.

The time that I have I enjoy with family and friends and for the time being I am a part time “constructor”, as we bought a new home. It’s fun to design, plan and construct things in my home as my profession is certainly not a constructor.

You can get in touch via LinkedIn. Feel free to contact me.

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

{% include contributions.html name='krishan' %}