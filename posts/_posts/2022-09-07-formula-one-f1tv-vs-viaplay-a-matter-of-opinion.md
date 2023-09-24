---
layout: post
toc: true
title:  "Formula One: F1 TV vs Viaplay a matter of opinion?"
hidden: false
authors: [eltjo, ryan]
reviewers: [esther, tom]
categories: [ 'UX' ]
tags: [ 'Formula One', 'F1 TV', 'Viaplay', 'SSIM', 'NIQE']
image: assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion-feature-image.png
---
In the Netherlands, there are two streaming options for watching Formula One this 2022 season: F1 TV Pro and Viaplay. Both provide live streaming of all Formula One races on PCs, mobile devices, and tv boxes, like Chromecast and Fire TVs.
Formula One officially started to show live streaming of each race online with F1 TV in 2018. The F1 TV service includes many other features like a live view of each driver's car, live timings, and replay of all Formula One, Formula 2, and Formula 3 races. Besides the Netherlands, F1TV is available in the US, Germany, France, Mexico, Belgium, Austria, Hungary, and most countries in South America, among others.

Viaplay is a video-on-demand streaming service from the Viaplay Group. Viaplay is available in the Nordic and Baltic countries, Poland, the US, and recently also in the Netherlands.
Both have different options when it comes to streaming and to the quality in which they stream. This GO-EUC research will compare the options and the quality of both providers in detail.

At GO-EUC we're very passionate about end-user computing. That being said, we're also very passionate about Formula One.

> Please note, that this will not be a complete comparison and that is for a couple of different reasons. Firstly, the F1 streams are copyrighted which means that it will not be possible to show footage from the races in the comparisons.
>
> Secondly, because the quality of the streams is dependent on a lot of factors, it is nearly impossible to have a completely objective comparison done.

## Background
As mentioned in the introduction, In the Netherlands, there are two options available for streaming Formula One. F1TV streamed in Full HD with a resolution of 1080p and 25fps but F1TV switched to a higher quality stream with 50fps in the 2021 season. The underlying technique used by F1TV is developed by Accenture’s Industry X group and uses their Accenture Video Solution technology.

[Revamped F1 TV service announced for 2021 season and launches in three new territories - Formula One®](https://www.formula1.com/en/latest/article.revamped-f1-tv-service-announced-for-2021-season-and-launches-in-three-new.gnmATn163HYW6oMYMMkRH.html){:target="_blank"}

Viaplay took over the Formula One broadcasting rights from Ziggo for the 2022 season. They received a lot of backlash due to the quality of the commentary and the quality of the streams. Viaplay started streaming in a maximum resolution of 720p originally but quickly switched to Full HD 1080 at 50fps in the beginning of the season:

<blockquote class="twitter-tweet"><p lang="nl" dir="ltr">Vandaag wordt de F1 pre-season testing uitgezonden in Full HD (1080p) en afgespeeld met 50 frames per seconde (fps). Houd er rekening mee dat de ondersteuning voor 50 fps apparaat specifiek is, als het apparaat deze framesnelheid niet ondersteunt, ontvangt deze 25 fps. /Dominique</p>&mdash; Viaplay Sport Nederland (@viaplaysportnl) <a href="https://twitter.com/viaplaysportnl/status/1502587633364520960?ref_src=twsrc%5Etfw">March 12, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Neither of the streaming services has a 4k stream available. This is a step backwards because the previous party that had the rights to broadcast Formula One in the Netherlands, Ziggo did broadcast Formula One in 4k for certain users.

As far as we are aware, there are no other publications available on the internet that focus on the quality difference between both platforms. The reason for this could be that either no one has ever taken the time to research this, or it could be the case that these publications were subjected to take-down notices. Let's hope for our sake that the former is true and not the latter. Moreover, if the latter should prove to be the case, then none of you will probably have read this publication anyway.

Following the Fundamental Principles set out by the FORMULA 1 organization, we are obligated to note that this research and publication is not official and is therefore not approved or endorsed by them. All rights in still images/ photos/ screenshots are the property of their respective owners.

## Quality
F1TV provides 6 quality settings, ranging from 1080p all the way down to a measly 480x720 resolution for the main channel:

| Resolution | Framerate | Bandwidth |
| :------ | :---- | :--------- |
| 480x270     | 50 | 256000   |
| 512x288     | 50 | 512000    |
| 640x360     | 50 | 1024000    |
| 960x540     | 50 | 1800000    |
| 1280x720     | 50 | 3499968  |
| 1920x1080    | 50 | 6000000 |

Source: [F1MultiViewer](https://gist.github.com/f1multiviewer/2b5eae8d9df6ebf46575aa29992d2228){:target="_blank"}.

Huge shout-out to [F1MultiViewer](https://twitter.com/F1MultiViewer){:target="_blank"} for sharing the exact bandwidth numbers.

The car onboard cameras of course are of a much lower resolution and bitrate (3500 kbit/s) to account for the fact that the data needs to be transmitted using mobile transmitters and cars moving in and out of transmission zones at speeds up to 350kph / 217mph.

Viaplay doesn’t share their bandwidth numbers, but in the FAQ they state among the requirements is a stable internet connection with a minimum speed of 10 Mbit/s.

Viaplay has the following quality settings:
  * Highest
  * High
  * Average
  * Low

These of course do not mean much; however, we do know that the highest quality setting provides a 1080p 50fps stream.

Both streaming services also have an automatic quality setting that is enabled by default that will adjust the quality of the streams based on the available bandwidth and the screen resolution of the device used to view the stream.

Both resolution and FPS alone do not say anything about the (perceived) image quality. The image quality is also dependent on the compression algorithm used for example.

The algorithm used for decoding can be easily checked in modern browsers with the Media tab in the developer tools:

<a href="{{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/viaplay-quality-highest.png" data-lightbox="viaplay-quality-highest">
![viaplay-quality-highest]({{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/viaplay-quality-highest.png)
</a>

<a href="{{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/f1tv-quality-1080p.png" data-lightbox="f1tv-quality-1080p">
![f1tv-quality-1080p]({{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/f1tv-quality-1080p.png)
</a>

The different decoding algorithms used for Viaplay and F1TV are as following:

| Service	| Quality | Codec | Resolution |
| :-----  | :------ | :---- | :--------- |
| Viaplay | Low     | H.264 | 640,360    |
| Viaplay | Average | H.264 | 960,540    |
| Viaplay | High    | H.264 | 960,540    |
| Viaplay | Highest | H.264 | 1280,720   |
| F1 TV   | 480     | H.264 | 480,270    |
| F1 TV   | 512     | H.264 | 512,288    |
| F1 TV   | 640     | H.264 | 640,360    |
| F1 TV   | 960     | H.264 | 960,540    |
| F1 TV   | 720     | H.264 | 1280,720   |
| F1 TV   | 1080    | H.264 | 1920,1080  |

It seems that even when using the highest quality setting, Viaplay is limited to 720p and not 1080p. Furthermore, there is no reported difference between the high and average settings with both settings decoding in 960x540.

Perhaps this is only related to the web application and with other streaming devices the highest quality will indeed be the promised 1080p quality, but the only other device that we have available is an Amazon FireTV stick. The FireTV sticks (and Google Chromecasts as well for that matter) use High-bandwidth Digital Content Protection (HDCP) as a digital copy protection system. HDCP was designed to prevent the recording and piracy of commercial movies and TV shows. Due to the usage of HDCP, the Elgato capture devices used at GO-EUC cannot capture HDMI signals with HDCP protection enabled.

F1 TV’s reported streaming resolutions are as advertised with 1080 actually being 1080p in contrast to Viaplay.

## Quality analysis
For the quality analysis, we’ve used the industry standard SSIM metric. SSIM is a full reference perceived image quality metric. We’ve been using SSIM as our defacto standard when it comes to perceived image quality.

SSIM is a full reference model where the image quality is always measured against a baseline or reference image.

All footage was captured with the latest version of OBS Studio and encoded using the Nvidia NVENC H.265 (new) encoder with the settings at the highest quality as shown below:
<a href="{{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/obs-settings-1.png" data-lightbox="obs-settings-1">
![obs-settings-1]({{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/obs-settings-1.png)
</a>

The output resolution was 1920x1080 with a constant FPS of 60.
<a href="{{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/obs-settings-2.png" data-lightbox="obs-settings-2">
![obs-settings-2]({{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/obs-settings-2.png)
</a>

All videos have been recorded a minimum of three times and the best result was selected and used for the analysis and comparisons.

Because we did not have access to the raw footage, the highest quality stream is selected as the baseline. Based on our initial observations the highest quality stream was F1 TV’s 1080p stream.

To limit the number of data points and the computational time needed to perform all the analysis from the baseline video only the keyframes were extracted.

In most common video compression algorithms like H.264 for example, only changes that occur from one frame to the next are stored in the data stream, in order to reduce the amount of information that must be stored. Keyframes, in this context, are frames where the complete image is stored in the data stream.

There were some complications, however. Due to the nature of full reference comparisons, the to-be-tested images must be perfectly scaled and aligned to match the baseline images to produce comparable results. There was a slight scaling difference between the F1 TV and the Viaplay streams which results in some lower-than-expected results in the comparisons between F1 TV and Viaplay.

Due to the inherent issues with SSIM outlined above, and to provide an additional metric for the perceived image quality, NIQE was chosen, which is a blind or no reference image quality metric.

Whereas full reference IQA assessments rely on a reference image that is used in the comparison, a blind or no reference IQA, as the name implies, does not use a reference and instead relies on image features to determine the perceived quality.

The score used is a no reference (NR)  image quality score using the Naturalness Image Quality Evaluator (NIQE). The NIQE metric is using the default model which is computed from images of natural scenes. A lower score indicates better perceptual quality. This means when comparing two images, the original undistorted image that has best perceptual quality will have the lowest NIQE score.

More information about NIQE can be found here [niqe_spl.pdf (utexas.edu)](http://live.ece.utexas.edu/research/quality/niqe_spl.pdf){:target="_blank"}.

## F1 TV data
The first comparison presented is the perceived quality differences between the different quality settings of both F1 TV and Viaplay.

For F1 TV there were a total number of 21 keyframes extracted from the ~50 second intro and used for the SSIM comparison.

{% include chart.html type='hbar' data_file='assets/data/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/ssim-f1tv-set1.json'%}

{% include chart.html type='hbar' data_file='assets/data/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/ssim-f1tv-set2.json'%}

{% include chart.html type='hbar' data_file='assets/data/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/ssim-f1tv-set3.json'%}

For SSIM a higher value means a closer likeness to the reference or baseline image and will indicate a higher perceived image quality.

The comparison clearly shows a higher SSIM score for the 1280x720 stream in comparison to the 640x360 stream across the board, while this is to be expected the change in quality does directly reflect back on the perceived quality as measured by the SSIM metric.

The SSIM difference between both quality streams might not seem very significant, but when the images are compared side by side, the difference is very apparent:

| 1080p | 720p |
| :---- | :--- |
| <a href="{{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/max-verstappen-1080p.png" data-lightbox="max-verstappen-1080p">![max-verstappen-1080p]({{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/max-verstappen-1080p.png)</a> | <a href="{{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/max-verstappen-720p.png" data-lightbox="max-verstappen-720p">![max-verstappen-720p]({{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/max-verstappen-720p.png)</a> |

This shows that a slight reduction in SSIM values means a substantial degradation in perceived visual quality.

## Viaplay data
With the Viaplay intro being shorter in comparison to the F1 TVs intro, the amount of keyframes available is also much lower, 7 in this case.

Here the comparison was done with the ‘highest’ quality setting acting as the baseline and the two lower quality settings ‘high’ and ‘average’ are tested against this baseline.

Although there are fewer data points to compare which always makes for less interesting charts; the last two data points show a sharp decline in quality for the average quality settings.

{% include chart.html type='hbar' data_file='assets/data/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/ssim-viaplay-set1.json'%}

| Highest | Average |
| :---- | :--- |
| <a href="{{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/viaplay-intro-highest.png" data-lightbox="viaplay-intro-highest.png">![viaplay-intro-highest.png]({{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/viaplay-intro-highest.png)</a> | <a href="{{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/viaplay-intro-average.png" data-lightbox="viaplay-intro-average">![viaplay-intro-average]({{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/viaplay-intro-average.png)</a> |


Visually, the quality difference between the quality settings for Viaplay is considerably smaller in comparison to F1TV. For F1TV there is a bigger variance between the tested quality settings. It would be interesting to see what the bandwidth usage is between the different quality settings, because these findings could suggest that the bandwidth difference will be less when compared to the different quality settings that F1 TV offers.

These results are predictable but on the other hand also quite educational. The most interesting comparison, of course, is the quality comparison between F1 TV and Viaplay when it comes to the actual F1 streams.

For the comparison between the two streaming services, the footage from the Race Highlights of the FORMULA 1 ARAMCO MAGYAR NAGYDÍJ 2022 Grand Prix™ was used where the first 20 seconds from lights out to the first car exiting the first corner have been recorded. This 20-second footage rendered 10 keyframes in the F1 1080p stream that was used as the basis for the comparison. The keyframes were then compared to all frames or the 20-second footage from the Viaplay stream and the best matching results were selected based on the highest SSIM score.

{% include chart.html type='hbar' data_file='assets/data/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/ssim-compare.json'%}

As mentioned before in the introduction, these results are skewed due to the fact that the Viaplay frames aren’t perfectly aligned and scaled in comparison to the baseline (the F1 TV stream).

To circumvent this inherent shortcoming of SSIM, the same comparison was done using the No Reference (NR) metric, NIQE.

For the NR metric, we used the same 10 data points here but individually measured each picture, both the reference and the test image. As this is a blind or no reference metric, the baseline images are not used in the comparison but are scored individually and do not influence the score of the Viaplay images.

Please keep in mind that NIQE doesn’t compare images, the algorithm has no knowledge of the other image and both images are scored individually.

{% include chart.html type='hbar' data_file='assets/data/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/niqe-compare.json'%}

Just like with the SSIM comparison, the NIQE metric also shows that F1 TV produces a higher quality image according to NIQE measurements. Please note, as mentioned before a lower score is better for NIQE.

| F1 TV | Viaplay |
| :---- | :--- |
| <a href="{{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/f1tv-race-1080p.png" data-lightbox="f1tv-race-1080p.png">![f1tv-race-1080p]({{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/f1tv-race-1080p.png)</a> | <a href="{{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/viaplay-race-highest.png" data-lightbox="viaplay-race-highest">![viaplay-race-highest]({{site.baseurl}}/assets/images/posts/093-formula-one-f1tv-vs-viaplay-a-matter-of-opinion/viaplay-race-highest.png)</a> |

## Conclusion
Based on the data, GO-EUC can state F1 TV provides better screen quality compared to Viaplay. Please note, this is only taking the video quality into account and not the commentary (as we both have a preference though). However, the quality depends on a lot of different factors, for example, limited bandwidth or latency at both the streaming services of the end-user side.

The main question remains why the 'highest' quality settings for Viaplay remains at 720p instead of 1080p. With only half of the pixel depth used this negatively affects image quality. As mentioned, this might only be an issue in the web browser, but we are not able to validate this at this moment in time.

This research showcases the complexity of measuring quality differences in video streams. There are various approaches and algorithms available, and this is a perfect example of not just fixating on an induvial method.

In this case, the NIQE method was used. A No Reference (NR) allowed GO-EUC to assess an image from a video stream without relying on a reference image. More information about NIQE can be found [here](http://live.ece.utexas.edu/research/quality/niqe_spl.pdf){:target="_blank"}.

As mentioned in the beginning, this research is a bit different compared to the previous content. This type of research showcases various methodologies, algorithms, and approaches to provide in-depth quality assessments which are applicable for various use cases.

Please share your thoughts on this topic, approach, or just new ideas in the comment below, as this type of feedback and interaction will help improve the platform.

Photo by [Melyna Valle](https://unsplash.com/@melynavv?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/s/photos/fast?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}

---

References: Mittal, A., R. Soundararajan, and A. C. Bovik. "Making a Completely Blind Image Quality Analyzer." IEEE Signal Processing Letters. Vol. 22, Number 3, March 2013, pp. 209–212.

Disclaimer: The F1 logo, FORMULA ONE, F1, GRAND PRIX and related marks are trademarks of Formula One Licensing BV, a Formula One company. All rights reserved.
All rights in still images/ photos/ screenshots are the property of their respective owners.

This website is unofficial and is not associated in any way with the Formula 1 companies. F1, FORMULA ONE, FORMULA 1, FIA FORMULA ONE WORLD CHAMPIONSHIP, GRAND PRIX and related marks are trade marks of Formula One Licensing B.V.
