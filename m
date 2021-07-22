Return-Path: <svaddagi@qti.qualcomm.com>
Subject: Re: [virtio-dev] [PATCH] virtio-mmio: Specify wait needed in driver during
 reset
From: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>
Date: Thu, 22 Jul 2021 15:41:49 +0000
Message-ID: <BY5PR02MB7073E8361281BB624E320FA4F9E49@BY5PR02MB7073.namprd02.prod.outlook.com>
References: <BY5PR02MB7073F1EAF729D30ACFFC67FCF9E49@BY5PR02MB7073.namprd02.prod.outlook.com>
 <b380151d-f20e-4e63-f1c3-a3f2220270cf@redhat.com>
 <87pmva7h06.fsf@redhat.com>,<f2b9203c-faaf-9aba-faad-0df2c199cb94@redhat.com>
In-Reply-To: <f2b9203c-faaf-9aba-faad-0df2c199cb94@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR02MB7073E8361281BB624E320FA4F9E49BY5PR02MB7073namp_"
To: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--_000_BY5PR02MB7073E8361281BB624E320FA4F9E49BY5PR02MB7073namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> >> I wonder if it deserves a feature bit.
> > Not sure what that feature bit should govern; if it is not negotiated,
> > the device must assume that the driver considers the reset to be
> > complete right after writing? I'm not sure what the device is supposed
> > to do then.
>
>
> The (hardware) device can refuse the feature negotiation if driver
> doesn't support the feature.
>
> This makes sure the driver is not broken by the device.

Let me send the next patch with a new feature bit added. I guess I can use =
bit
40 for it (VIRTIO_F_MMIO_RESET_WAIT)?

- vatsa

---

Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.

--_000_BY5PR02MB7073E8361281BB624E320FA4F9E49BY5PR02MB7073namp_
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
&gt; &gt;&gt; I wonder if it deserves a feature bit.
<div>&gt; &gt; Not sure what that feature bit should govern; if it is not n=
egotiated,</div>
<div>&gt; &gt; the device must assume that the driver considers the reset t=
o be</div>
<div>&gt; &gt; complete right after writing? I'm not sure what the device i=
s supposed</div>
<div>&gt; &gt; to do then.</div>
<div>&gt; </div>
<div>&gt; </div>
<div>&gt; The (hardware) device can refuse the feature negotiation if drive=
r</div>
<div>&gt; doesn't support the feature.</div>
<div>&gt; </div>
<div>&gt; This makes sure the driver is not broken by the device.</div>
<div><br>
</div>
<div>Let me send the next patch with a new feature bit added. I guess I can=
 use bit</div>
<div>40 for it (VIRTIO_F_MMIO_RESET_WAIT)?</div>
<div><br>
</div>
<div>- vatsa</div>
<div><br>
</div>
<div>---</div>
<div><br>
</div>
<div>Qualcomm Innovation Center, Inc. is submitting the attached &quot;feed=
back&quot; as a</div>
<span>non-member to the virtio-dev mailing list for consideration and inclu=
sion.</span><br>
</div>
</body>
</html>

--_000_BY5PR02MB7073E8361281BB624E320FA4F9E49BY5PR02MB7073namp_--

