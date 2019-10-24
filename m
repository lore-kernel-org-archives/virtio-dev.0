Return-Path: virtio-dev-return-6255-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E12229860B4
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 Oct 2019 11:22:19 +0000 (UTC)
From: Shahaf Shuler <shahafs@mellanox.com>
Date: Thu, 24 Oct 2019 11:22:16 +0000
Message-ID: 
 <AM0PR0502MB37958EA359A04C0A67DB1A36C36A0@AM0PR0502MB3795.eurprd05.prod.outlook.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_AM0PR0502MB37958EA359A04C0A67DB1A36C36A0AM0PR0502MB3795_"
MIME-Version: 1.0
Subject: [virtio-dev] Virtio device specific MSIX arming
To: Virtio-Dev <virtio-dev@lists.oasis-open.org>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Tzahi Oved <tzahio@mellanox.com>, Alex Rosenbaum <alexr@mellanox.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--_000_AM0PR0502MB37958EA359A04C0A67DB1A36C36A0AM0PR0502MB3795_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,



Below question mainly raise when looking on the ways to have vDPA implement=
ation of virtio-net device.



One complexity we encounter is with the MSIX relay between the device and t=
he guest.

Reading the spec, and looking on the driver implementation, it seems there =
is no way for the driver to re-arm the virtio device after MSIX was trigger=
ed.



There is a way to suppress interrupt by setting some flags on the available=
 rings, however it is hard to poll on it from a real (not emulated) PCI dev=
ice.



Is above correct? Or there is a way to re-arm virtio device for next interr=
upt?



If no way to re-arm,

1. are there any thoughts on adding such addition to spec?

2. What is the recommended approach for vDPA implementation? Use static

    interrupt moderation?


--_000_AM0PR0502MB37958EA359A04C0A67DB1A36C36A0AM0PR0502MB3795_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">Hi,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Below question mainly raise when looking on the w=
ays to have vDPA implementation of virtio-net device.<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">One complexity we encounter is with the MSIX rela=
y between the device and the guest.<o:p></o:p></p>
<p class=3D"MsoPlainText">Reading the spec, and looking on the driver imple=
mentation, it seems there is no way for the driver to re-arm the virtio dev=
ice after MSIX was triggered.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">There is a way to suppress interrupt by setting s=
ome flags on the available rings, however it is hard to poll on it from a r=
eal (not emulated) PCI device.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Is above correct? Or there is a way to re-arm vir=
tio device for next interrupt?<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">If no way to re-arm,<o:p></o:p></p>
<p class=3D"MsoPlainText">1. are there any thoughts on adding such addition=
 to spec?<o:p></o:p></p>
<p class=3D"MsoPlainText">2. What is the recommended approach for vDPA impl=
ementation? Use static<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp; interrupt moderation?<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_AM0PR0502MB37958EA359A04C0A67DB1A36C36A0AM0PR0502MB3795_--
