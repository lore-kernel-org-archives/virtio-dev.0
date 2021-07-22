Return-Path: <virtio-dev-return-8370-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4AEE7986312
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jul 2021 09:20:00 +0000 (UTC)
From: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>
Date: Thu, 22 Jul 2021 09:19:56 +0000
Message-ID: <BY5PR02MB7073F1EAF729D30ACFFC67FCF9E49@BY5PR02MB7073.namprd02.prod.outlook.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio-mmio: Specify wait needed in driver during reset
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR02MB7073F1EAF729D30ACFFC67FCF9E49BY5PR02MB7073namp_"
To: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--_000_BY5PR02MB7073F1EAF729D30ACFFC67FCF9E49BY5PR02MB7073namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This is following up on the discussion we had earlier on MMIO reset behavio=
r:

https://lists.oasis-open.org/archives/virtio-dev/202107/msg00012.html

Suggesting below change to spec to make it explicit what's expected in driv=
er. If this is accepted, I will follow up with a patch to Linux driver.

=3D=3D=3D

Device reset is accomplished by writing 0 to Status register. Explicitly no=
te
that a driver needs to wait on Status register read returning 0 before assu=
ming that
device reset operation is complete.

Signed-off-by: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>

diff --git a/content.tex b/content.tex
index 5c70a3c..7631be4 100644
--- a/content.tex
+++ b/content.tex
@@ -1985,6 +1985,10 @@ \subsubsection{Device Initialization}\label{sec:Virt=
io Transport Options / Virti
 and if its value is zero (0x0) MUST abort initialization and
 MUST NOT access any other register.

+After writing 0 to \field{Status}, the driver MUST wait for a read of
+\field{Status} to return 0 before proceeding with the remaining steps of
+initializing the device.
+
 Drivers not expecting shared memory MUST NOT use the shared
 memory registers.


---

Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a=
 non-member to the virtio-dev mailing list for consideration and inclusion.

--_000_BY5PR02MB7073F1EAF729D30ACFFC67FCF9E49BY5PR02MB7073namp_
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
: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin:0px;font-size:12pt;color:black;background-color:rgb(25=
5, 255, 255)">
<div style=3D"margin:0px">This is following up on the discussion we had ear=
lier on MMIO reset behavior:</div>
<div style=3D"margin:0px"><br>
</div>
<div style=3D"margin:0px"><a href=3D"https://lists.oasis-open.org/archives/=
virtio-dev/202107/msg00012.html" id=3D"LPlnk">https://lists.oasis-open.org/=
archives/virtio-dev/202107/msg00012.html</a><br>
</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1"></div>
<br>
Suggesting below change to spec to make it explicit what's expected in driv=
er. If this is accepted, I will follow up with a patch to Linux driver.</di=
v>
<div style=3D"margin:0px;font-size:12pt;color:black;background-color:rgb(25=
5, 255, 255)">
<br>
</div>
<div style=3D"margin:0px;font-size:12pt;color:black;background-color:rgb(25=
5, 255, 255)">
=3D=3D=3D</div>
<div style=3D"margin:0px;font-size:12pt;color:black;background-color:rgb(25=
5, 255, 255)">
<div style=3D"margin:0px"><br>
</div>
<div style=3D"margin:0px">Device reset is accomplished by writing 0 to Stat=
us register. Explicitly note</div>
<div style=3D"margin:0px">that a driver needs to wait on Status register re=
ad returning 0 before assuming that</div>
<div style=3D"margin:0px">device reset operation is complete.</div>
<div style=3D"margin:0px">&nbsp; &nbsp;</div>
<div style=3D"margin:0px">Signed-off-by: Srivatsa Vaddagiri &lt;svaddagi@qt=
i.qualcomm.com&gt;</div>
<div style=3D"margin:0px"><br>
</div>
<div style=3D"margin:0px">diff --git a/content.tex b/content.tex</div>
<div style=3D"margin:0px">index 5c70a3c..7631be4 100644</div>
<div style=3D"margin:0px">--- a/content.tex</div>
<div style=3D"margin:0px">+++ b/content.tex</div>
<div style=3D"margin:0px">@@ -1985,6 +1985,10 @@ \subsubsection{Device Init=
ialization}\label{sec:Virtio Transport Options / Virti</div>
<div style=3D"margin:0px">&nbsp;and if its value is zero (0x0) MUST abort i=
nitialization and</div>
<div style=3D"margin:0px">&nbsp;MUST NOT access any other register.</div>
<div style=3D"margin:0px">&nbsp;</div>
<div style=3D"margin:0px">+After writing 0 to \field{Status}, the driver MU=
ST wait for a read of</div>
<div style=3D"margin:0px">+\field{Status} to return 0 before proceeding wit=
h the remaining steps of</div>
<div style=3D"margin:0px">+initializing the device.</div>
<div style=3D"margin:0px">+</div>
<div style=3D"margin:0px">&nbsp;Drivers not expecting shared memory MUST NO=
T use the shared</div>
<div style=3D"margin:0px">&nbsp;memory registers.</div>
<span style=3D"margin:0px">&nbsp;</span><br>
</div>
<div style=3D"margin:0px;font-size:12pt;color:black;background-color:rgb(25=
5, 255, 255)">
<span style=3D"margin:0px"><br>
</span></div>
<div style=3D"margin:0px;font-size:12pt;color:black;background-color:rgb(25=
5, 255, 255)">
<span style=3D"color: black; font-size: 12pt;">---</span><br>
</div>
<div style=3D"margin:0px;font-size:12pt;color:black;background-color:rgb(25=
5, 255, 255)">
<br>
</div>
<span style=3D"margin:0px;font-size:12pt;color:black;background-color:rgb(2=
55, 255, 255)">Qualcomm Innovation Center, Inc. is submitting the attached =
&quot;feedback&quot; as a non-member to the virtio-dev mailing list for con=
sideration and inclusion.</span><br>
</div>
</body>
</html>

--_000_BY5PR02MB7073F1EAF729D30ACFFC67FCF9E49BY5PR02MB7073namp_--

