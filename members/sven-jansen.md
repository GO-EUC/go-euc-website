---
layout: page
title: Sven Jansen
comments: false
---
{% assign author = site.authors['sven-j'] %}

<img style="float: left; width: 250px; margin-right: 30px;" src="{{ site.url }}{{ author.picture | relative_url }}" alt="{{ author.display_name }}">I try seeing myself as father first. Nothing I like more than witnessing my daughter grow up and spend time with her! Re-charging and burning off energy happens on my MTB mainly and also with other types of sports. Sometimes I get my hands on a guitar as well. Please do not ask me to play something! 😊

I’m lucky enough having a job that supports my way of living and keeps me going: As Pre-Sales Manager for “deviceTRUST”, I am responsible for anything technical between customers, partners and us. A responsible position that mixes being close to technology and also to people very well. deviceTRUST are a good bunch of people with high work ethics, which makes my workdays quite enjoyable. Before that, I used to work as IT professional, mainly focused on Citrix Virtual Apps and Desktops, as well as Citrix ADC.

Together with @CarstenBruns, I run a local community event called #VCNRW. I try being active in the IT community every now and then, the latest activity being to join the awesome GO:EUC crowd. Hopefully, I can add some value to the already very good approach/tool and spread the word on events like @E2EVC!

You can get in touch via LinkedIn. Always happy hearing from you!

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

{% include contributions.html name='sven-j' %}