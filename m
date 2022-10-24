Return-Path: <hrishivarya.bhageeradhan@opensynergy.com>
From: Hrishivarya Bhageeradhan <Hrishivarya.Bhageeradhan@opensynergy.com>
Subject: Re: [virtio-dev] [PATCH] content: reserve device ID 43 for Camera
 device
Date: Mon, 24 Oct 2022 09:16:27 +0000
Message-ID: <VI1PR0402MB35495780C3E861B4ACE95067822E9@VI1PR0402MB3549.eurprd04.prod.outlook.com>
References: <20221014141826.502247-1-hrishivarya.bhageeradhan@opensynergy.com>
 <87ilkd9xzv.fsf@redhat.com>
In-Reply-To: <87ilkd9xzv.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_VI1PR0402MB35495780C3E861B4ACE95067822E9VI1PR0402MB3549_"
To: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--_000_VI1PR0402MB35495780C3E861B4ACE95067822E9VI1PR0402MB3549_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Huck,

The virtio-camera is intended to support all hardware camera formats, conve=
rsion from one format to another, camera identification (front camera, rear=
 camera, etc.).
The main idea here is to control the streaming of video from the physical c=
amera.
The virtio-camera is another device which has its own functionality as ment=
ioned which is different from encoder/decoder devices.


Best Regards,
Hrishivarya
________________________________
From: Cornelia Huck <cohuck@redhat.com>
Sent: Friday, October 21, 2022 2:12 PM
To: Hrishivarya Bhageeradhan <Hrishivarya.Bhageeradhan@opensynergy.com>; vi=
rtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org>; Hrishivary=
a Bhageeradhan <Hrishivarya.Bhageeradhan@opensynergy.com>
Subject: Re: [virtio-dev] [PATCH] content: reserve device ID 43 for Camera =
device

On Fri, Oct 14 2022, hrishivarya.bhageeradhan@opensynergy.com wrote:

> From: Hrishivarya Bhageeradhan <hrishivarya.bhageeradhan@opensynergy.com>
>
> The virtio-camera device allows to stream a camera video with
> ability to change controls, formats and get camera captures.
> This patch is to reserve the next available device ID for
> virtio-camera.

Does this device relate in any way to the already reserved video
{en,de}coder devices (ids 30, 31)? Or is this intended to more actively
control how a physical camera processes video?

[The video devices 30 and 31 do not have a specification included in the
virtio spec, unfortunately.]

>
> Signed-off-by: Hrishivarya Bhageeradhan <hrishivarya.bhageeradhan@opensyn=
ergy.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index e863709..91ba76c 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2990,6 +2990,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  42         &   RDMA device \\
>  \hline
> +43         &   Camera device \\
> +\hline
>  \end{tabular}
>
>  Some of the devices above are unspecified by this document,


Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>

--_000_VI1PR0402MB35495780C3E861B4ACE95067822E9VI1PR0402MB3549_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<br>
</div>
<div id=3D"signature_bookmark"></div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0); background-color: rgb(=
255, 255, 255);"><span class=3D"ContentPasted0 ContentPasted1" style=3D"bac=
kground-color: rgb(255, 255, 255);">Hi Huck,<br>
</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<div style=3D"font-size: 12pt; color: rgb(0, 0, 0); background-color: rgb(2=
55, 255, 255);">
<span class=3D"ContentPasted0 ContentPasted1" style=3D"background-color: rg=
b(255, 255, 255);"><br class=3D"ContentPasted0">
</span></div>
<div style=3D"font-size: 12pt; color: rgb(0, 0, 0); background-color: rgb(2=
55, 255, 255);">
<span class=3D"ContentPasted0 ContentPasted1" style=3D"background-color: rg=
b(255, 255, 255);">The virtio-camera is intended to support all hardware ca=
mera formats, conversion from one format to another, camera identification =
(front camera, rear camera, etc.).</span><br class=3D"ContentPasted0">
</div>
<div style=3D"font-size: 12pt; color: rgb(0, 0, 0); background-color: rgb(2=
55, 255, 255);">
<span class=3D"ContentPasted0 ContentPasted1" style=3D"background-color: rg=
b(255, 255, 255);">The main idea here is to control the streaming of video =
from the physical camera.</span></div>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0); background-color: rgb(=
255, 255, 255);"><span class=3D"ContentPasted0 ContentPasted1" style=3D"bac=
kground-color: rgb(255, 255, 255);">The virtio-camera is another device whi=
ch has its own functionality as mentioned
 which is different from encoder/decoder devices.<br>
</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0); background-color: rgb(=
255, 255, 255);"><span class=3D"ContentPasted0 ContentPasted1" style=3D"bac=
kground-color: rgb(255, 255, 255);"><br>
</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0); background-color: rgb(=
255, 255, 255);"><span class=3D"ContentPasted0 ContentPasted1" style=3D"bac=
kground-color: rgb(255, 255, 255);"><br>
</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0); background-color: rgb(=
255, 255, 255);"><span class=3D"ContentPasted0 ContentPasted1" style=3D"bac=
kground-color: rgb(255, 255, 255);">Best Regards,</span></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0); background-color: rgb(=
255, 255, 255);"><span class=3D"ContentPasted0 ContentPasted1" style=3D"bac=
kground-color: rgb(255, 255, 255);">Hrishivarya<br>
</span></span></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size: 11pt;" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Cornelia Huck &lt;c=
ohuck@redhat.com&gt;<br>
<b>Sent:</b> Friday, October 21, 2022 2:12 PM<br>
<b>To:</b> Hrishivarya Bhageeradhan &lt;Hrishivarya.Bhageeradhan@opensynerg=
y.com&gt;; virtio-dev@lists.oasis-open.org &lt;virtio-dev@lists.oasis-open.=
org&gt;; Hrishivarya Bhageeradhan &lt;Hrishivarya.Bhageeradhan@opensynergy.=
com&gt;<br>
<b>Subject:</b> Re: [virtio-dev] [PATCH] content: reserve device ID 43 for =
Camera device</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">On Fri, Oct 14 2022, hrishivarya.bhageeradhan@open=
synergy.com wrote:<br>
<br>
&gt; From: Hrishivarya Bhageeradhan &lt;hrishivarya.bhageeradhan@opensynerg=
y.com&gt;<br>
&gt;<br>
&gt; The virtio-camera device allows to stream a camera video with<br>
&gt; ability to change controls, formats and get camera captures.<br>
&gt; This patch is to reserve the next available device ID for<br>
&gt; virtio-camera.<br>
<br>
Does this device relate in any way to the already reserved video<br>
{en,de}coder devices (ids 30, 31)? Or is this intended to more actively<br>
control how a physical camera processes video?<br>
<br>
[The video devices 30 and 31 do not have a specification included in the<br=
>
virtio spec, unfortunately.]<br>
<br>
&gt;<br>
&gt; Signed-off-by: Hrishivarya Bhageeradhan &lt;hrishivarya.bhageeradhan@o=
pensynergy.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; content.tex | 2 ++<br>
&gt;&nbsp; 1 file changed, 2 insertions(+)<br>
&gt;<br>
&gt; diff --git a/content.tex b/content.tex<br>
&gt; index e863709..91ba76c 100644<br>
&gt; --- a/content.tex<br>
&gt; +++ b/content.tex<br>
&gt; @@ -2990,6 +2990,8 @@ \chapter{Device Types}\label{sec:Device Types}<b=
r>
&gt;&nbsp; \hline<br>
&gt;&nbsp; 42&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&nbsp;&n=
bsp; RDMA device \\<br>
&gt;&nbsp; \hline<br>
&gt; +43&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&nbsp;&nbsp; =
Camera device \\<br>
&gt; +\hline<br>
&gt;&nbsp; \end{tabular}<br>
&gt;<br>
&gt;&nbsp; Some of the devices above are unspecified by this document,<br>
<br>
</div>
</span></font></div>
<br>
<span style=3D"font-family:arial;font-size:12px">Please mind our <a href=3D=
"https://www.opensynergy.com/datenschutzerklaerung/privacy-notice-for-busin=
ess-partners-pursuant-to-article-13-of-the-general-data-protection-regulati=
on-gdpr/">
privacy notice</a> pursuant to Art. 13 GDPR. // Unsere Hinweise zum Datensc=
hutz gem. Art. 13 DSGVO finden Sie
<a href=3D"https://www.opensynergy.com/de/datenschutzerklaerung/datenschutz=
hinweise-fuer-geschaeftspartner-gem-art-13-dsgvo/">
hier.</a> </span><br>
</body>
</html>

--_000_VI1PR0402MB35495780C3E861B4ACE95067822E9VI1PR0402MB3549_--

