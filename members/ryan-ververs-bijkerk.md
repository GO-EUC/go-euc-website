---
layout: page
title: Ryan Ververs-Bijkerk
image: '/assets/images/head.jpg'
comments: false
---
{% assign author = site.authors['ryan'] %}

<img style="float: left; width: 250px; margin-right: 30px;" src="{{ site.url }}{{ author.picture | relative_url }}" alt="{{ author.display_name }}">Ryan is a self-employed Technologist at GO-INIT focused on the EUC and Code area. Ryan is primarily focusing on the user experience in centralized desktop environments. With his development skills, Ryan is capable of adapting quickly to customers' needs by having an agile mindset. Ryan is a bit lazy, yes lazy but in a good way. Ryan is all about automation as he is not made for repeating tasks.

Community is very important for Ryan as he is an active blogger and has published multiple tools. Next, to his personal blogs and tools, Ryan is also a member of the Remote Display Analyzer team and TeamRGE. Ryan has been awarded several times for Microsoft Most Valuable Professional (MVP) and currently holds the Citrix Technology Professional (CTP), NVIDIA vGPU Community Advisor (NGCA), Very Important Parallels Professional (VIPP), and VMware vExpert status.

If you ever meet Ryan you can always  do him a pleasure buying a beer because he loves beer. Besides that, he also enjoys sim racing and playing games like Rainbow Six Siege and CS:GO.

You can follow Ryan on Twitter and his blog or get in touch via LinkedIn.

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

{% include contributions.html name='ryan' %}
