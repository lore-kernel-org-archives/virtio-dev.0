Return-Path: <virtio-dev-return-10067-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F0B04986579
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Oct 2022 11:02:06 +0000 (UTC)
From: Hrishivarya Bhageeradhan <Hrishivarya.Bhageeradhan@opensynergy.com>
Date: Thu, 20 Oct 2022 11:01:49 +0000
Message-ID: <VI1PR0402MB3549FAC67F0C5FF1DEB222A8822A9@VI1PR0402MB3549.eurprd04.prod.outlook.com>
References: <20221014141826.502247-1-hrishivarya.bhageeradhan@opensynergy.com>
In-Reply-To: <20221014141826.502247-1-hrishivarya.bhageeradhan@opensynergy.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH] content: reserve device ID 43 for Camera device
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_VI1PR0402MB3549FAC67F0C5FF1DEB222A8822A9VI1PR0402MB3549_"
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--_000_VI1PR0402MB3549FAC67F0C5FF1DEB222A8822A9VI1PR0402MB3549_
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

H All,


The patch mentioned in the below mail fixes the following Github issue :

https://github.com/oasis-tcs/virtio-spec/issues/148
[https://opengraph.githubassets.com/a59147e0e3c3726d3dae156ea99d0f24bbd48df=
a7edbbb9e510fe25af1e29865/oasis-tcs/virtio-spec/issues/148]<https://github.=
com/oasis-tcs/virtio-spec/issues/148>
Reserve device ID 43 for Camera Device =B7 Issue #148 =B7 oasis-tcs/virtio-=
spec<https://github.com/oasis-tcs/virtio-spec/issues/148>
Please reserve device ID 43 for the Camera device as requested in https://l=
ists.oasis-open.org/archives/virtio-dev/202210/msg00021.html
github.com
I would hereby request for a review from the TC.

Best Regards,
Hrishivarya
________________________________
From: hrishivarya.bhageeradhan@opensynergy.com <hrishivarya.bhageeradhan@op=
ensynergy.com>
Sent: Friday, October 14, 2022 4:18 PM
To: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org>; Hris=
hivarya Bhageeradhan <Hrishivarya.Bhageeradhan@opensynergy.com>
Subject: [PATCH] content: reserve device ID 43 for Camera device

From: Hrishivarya Bhageeradhan <hrishivarya.bhageeradhan@opensynergy.com>

The virtio-camera device allows to stream a camera video with
ability to change controls, formats and get camera captures.
This patch is to reserve the next available device ID for
virtio-camera.

Signed-off-by: Hrishivarya Bhageeradhan <hrishivarya.bhageeradhan@opensyner=
gy.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index e863709..91ba76c 100644
--- a/content.tex
+++ b/content.tex
@@ -2990,6 +2990,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 42         &   RDMA device \\
 \hline
+43         &   Camera device \\
+\hline
 \end{tabular}

 Some of the devices above are unspecified by this document,
--
2.25.1


Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>

--_000_VI1PR0402MB3549FAC67F0C5FF1DEB222A8822A9VI1PR0402MB3549_
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
<p class=3D"ContentPasted0">H All,</p>
<p class=3D"ContentPasted0"><br>
</p>
<p class=3D"ContentPasted0 elementToProof">The patch mentioned in the below=
 mail fixes the following Github issue :<br>
</p>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof ContentPasted1">
<a href=3D"https://github.com/oasis-tcs/virtio-spec/issues/148" id=3D"LPlnk=
OWALinkPreview">https://github.com/oasis-tcs/virtio-spec/issues/148</a><br>
</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1">
<div id=3D"LPBorder_GTaHR0cHM6Ly9naXRodWIuY29tL29hc2lzLXRjcy92aXJ0aW8tc3BlY=
y9pc3N1ZXMvMTQ4" class=3D"LPBorder695374" style=3D"width: 100%; margin-top:=
 16px; margin-bottom: 16px; position: relative; max-width: 800px; min-width=
: 424px;">
<table id=3D"LPContainer695374" role=3D"presentation" style=3D"padding: 12p=
x 36px 12px 12px; width: 100%; border-width: 1px; border-style: solid; bord=
er-color: rgb(200, 200, 200); border-radius: 2px;">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td>
<div id=3D"LPImageContainer695374" style=3D"position: relative; margin-righ=
t: 12px; height: 120px; overflow: hidden; width: 240px;">
<a target=3D"_blank" id=3D"LPImageAnchor695374" href=3D"https://github.com/=
oasis-tcs/virtio-spec/issues/148"><img id=3D"LPThumbnailImageId695374" alt=
=3D"" style=3D"display: block;" width=3D"240" height=3D"120" src=3D"https:/=
/opengraph.githubassets.com/a59147e0e3c3726d3dae156ea99d0f24bbd48dfa7edbbb9=
e510fe25af1e29865/oasis-tcs/virtio-spec/issues/148"></a></div>
</td>
<td style=3D"width: 100%;">
<div id=3D"LPTitle695374" style=3D"font-size: 21px; font-weight: 300; margi=
n-right: 8px; font-family: &quot;wf_segoe-ui_light&quot;, &quot;Segoe UI Li=
ght&quot;, &quot;Segoe WP Light&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif; margin-bottom: 12px;">
<a target=3D"_blank" id=3D"LPUrlAnchor695374" href=3D"https://github.com/oa=
sis-tcs/virtio-spec/issues/148" style=3D"text-decoration: none; color: var(=
--themePrimary);">Reserve device ID 43 for Camera Device =B7 Issue #148 =B7=
 oasis-tcs/virtio-spec</a></div>
<div id=3D"LPDescription695374" style=3D"font-size: 14px; max-height: 100px=
; color: rgb(102, 102, 102); font-family: &quot;wf_segoe-ui_normal&quot;, &=
quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; margi=
n-bottom: 12px; margin-right: 8px; overflow: hidden;">
Please reserve device ID 43 for the Camera device as requested in https://l=
ists.oasis-open.org/archives/virtio-dev/202210/msg00021.html</div>
<div id=3D"LPMetadata695374" style=3D"font-size: 14px; font-weight: 400; co=
lor: rgb(166, 166, 166); font-family: &quot;wf_segoe-ui_normal&quot;, &quot=
;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif;">
github.com</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);">I would hereby request for a review from the TC.</s=
pan></div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-color: rgb=
(255, 255, 255);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-color: rgb=
(255, 255, 255);">
Best Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-color: rgb=
(255, 255, 255);">
Hrishivarya<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> hrishivarya.bhageerad=
han@opensynergy.com &lt;hrishivarya.bhageeradhan@opensynergy.com&gt;<br>
<b>Sent:</b> Friday, October 14, 2022 4:18 PM<br>
<b>To:</b> virtio-dev@lists.oasis-open.org &lt;virtio-dev@lists.oasis-open.=
org&gt;; Hrishivarya Bhageeradhan &lt;Hrishivarya.Bhageeradhan@opensynergy.=
com&gt;<br>
<b>Subject:</b> [PATCH] content: reserve device ID 43 for Camera device</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Hrishivarya Bhageeradhan &lt;hrishivarya.bha=
geeradhan@opensynergy.com&gt;<br>
<br>
The virtio-camera device allows to stream a camera video with<br>
ability to change controls, formats and get camera captures.<br>
This patch is to reserve the next available device ID for<br>
virtio-camera.<br>
<br>
Signed-off-by: Hrishivarya Bhageeradhan &lt;hrishivarya.bhageeradhan@opensy=
nergy.com&gt;<br>
---<br>
&nbsp;content.tex | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/content.tex b/content.tex<br>
index e863709..91ba76c 100644<br>
--- a/content.tex<br>
+++ b/content.tex<br>
@@ -2990,6 +2990,8 @@ \chapter{Device Types}\label{sec:Device Types}<br>
&nbsp;\hline<br>
&nbsp;42&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&nbsp;&nbsp; =
RDMA device \\<br>
&nbsp;\hline<br>
+43&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&nbsp;&nbsp; Camer=
a device \\<br>
+\hline<br>
&nbsp;\end{tabular}<br>
&nbsp;<br>
&nbsp;Some of the devices above are unspecified by this document,<br>
-- <br>
2.25.1<br>
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

--_000_VI1PR0402MB3549FAC67F0C5FF1DEB222A8822A9VI1PR0402MB3549_--

