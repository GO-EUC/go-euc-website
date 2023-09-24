---
layout: page
title: Eltjo van Gulik
comments: false
---
{% assign author = site.authors['eltjo'] %}

<img style="float: left; width: 250px; margin-right: 30px;" src="{{ site.url }}{{ author.picture | relative_url }}" alt="{{ author.display_name }}">

Together with Ryan Ververs-Bijkerk, I co-founded the G0-EUC platform and community. I’m the Principal Product Manager for HDX & Graphics at Citrix, directing the vision and strategy for the Citrix HDX remoting protocol and I have two decades of experience in the End User Computing domain.

Recognised as a former [CTP](http://www.citrix.com/blogs/2020/02/11/welcome-to-the-2020-class-of-citrix-technology-professionals/){:target="_blank"}, my contributions span blogging, public speaking at international events like Citrix Synergy, and participating in other community-driven initiatives like TeamRGE.

Outside of work, I‘m a proud father and husband. And as a self-proclaimed beer and coffee aficionado, I prefer Russian Imperial Stouts, and the distinct tastes of Brasil/Costa Rica Arabica blends for my coffee.

In my spare time, I’m an avid Dungeons and Dragons player. Only 3rd edition though, because the newer versions suck (did I say that I was pedantic yet?).

Friends often label me as social, slightly pedantic, and suitably lazy.

Let's connect! Find me on Twitter and LinkedIn.

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

{% include contributions.html name='eltjo' %}