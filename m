Return-Path: <virtio-dev-return-8376-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 94F9C986312
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jul 2021 11:09:24 +0000 (UTC)
From: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>
Date: Thu, 22 Jul 2021 11:09:16 +0000
Message-ID: <BY5PR02MB7073904F2843A1FE0860DFD9F9E49@BY5PR02MB7073.namprd02.prod.outlook.com>
References: <BY5PR02MB7073F1EAF729D30ACFFC67FCF9E49@BY5PR02MB7073.namprd02.prod.outlook.com>,<b380151d-f20e-4e63-f1c3-a3f2220270cf@redhat.com>
In-Reply-To: <b380151d-f20e-4e63-f1c3-a3f2220270cf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] virtio-mmio: Specify wait needed in driver during
 reset
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR02MB7073904F2843A1FE0860DFD9F9E49BY5PR02MB7073namp_"
To: Jason Wang <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--_000_BY5PR02MB7073904F2843A1FE0860DFD9F9E49BY5PR02MB7073namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> > This is following up on the discussion we had earlier on MMIO reset
> > behavior:
> >
> > https://lists.oasis-open.org/archives/virtio-dev/202107/msg00012.html
> > <https://lists.oasis-open.org/archives/virtio-dev/202107/msg00012.html>
> >
> > Suggesting below change to spec to make it explicit what's expected in
> > driver. If this is accepted, I will follow up with a patch to Linux
> > driver.
> >
> > =3D=3D=3D
> >
> > Device reset is accomplished by writing 0 to Status register.
> > Explicitly note
> > that a driver needs to wait on Status register read returning 0 before
> > assuming that
> > device reset operation is complete.
> > Signed-off-by: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>
>
>
>
> I wonder if it deserves a feature bit.

I see this as fixing a bug in spec/code rather than adding any new feature,=
 so
perhaps no.

- vatsa

---

Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a=
 non-member to the virtio-dev mailing list for consideration and inclusion.


--_000_BY5PR02MB7073904F2843A1FE0860DFD9F9E49BY5PR02MB7073namp_
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
&gt; &gt; This is following up on the discussion we had earlier on MMIO res=
et</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div>&gt; &gt; behavior:</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; https://lists.oasis-open.org/archives/virtio-dev/202107/msg0=
0012.html</div>
<div>&gt; &gt; &lt;https://lists.oasis-open.org/archives/virtio-dev/202107/=
msg00012.html&gt;</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; Suggesting below change to spec to make it explicit what's e=
xpected in</div>
<div>&gt; &gt; driver. If this is accepted, I will follow up with a patch t=
o Linux</div>
<div>&gt; &gt; driver.</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; =3D=3D=3D</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; Device reset is accomplished by writing 0 to Status register=
.</div>
<div>&gt; &gt; Explicitly note</div>
<div>&gt; &gt; that a driver needs to wait on Status register read returnin=
g 0 before</div>
<div>&gt; &gt; assuming that</div>
<div>&gt; &gt; device reset operation is complete.</div>
<div>&gt; &gt; Signed-off-by: Srivatsa Vaddagiri &lt;svaddagi@qti.qualcomm.=
com&gt;</div>
<div>&gt; </div>
<div>&gt; </div>
<div>&gt; </div>
<div>&gt; I wonder if it deserves a feature bit.</div>
<div><br>
</div>
<div>I see this as fixing a bug in spec/code rather than adding any new fea=
ture, so</div>
<div>perhaps no.</div>
<div><br>
</div>
<span>- vatsa</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><span style=3D"margin:0px;font-size:12pt;color:black;background-color=
:white"><span style=3D"margin:0px">---</span></span>
<div style=3D"margin:0px;font-size:12pt;color:black;background-color:white"=
><br>
</div>
<span style=3D"margin:0px;font-size:12pt;color:black;background-color:white=
">Qualcomm Innovation Center, Inc. is submitting the attached &quot;feedbac=
k&quot; as a non-member to the virtio-dev mailing list for consideration an=
d inclusion.</span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><br>
</span></div>
</body>
</html>

--_000_BY5PR02MB7073904F2843A1FE0860DFD9F9E49BY5PR02MB7073namp_--

