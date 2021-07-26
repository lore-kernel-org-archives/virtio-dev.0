Return-Path: <svaddagi@qti.qualcomm.com>
Subject: Re: [PATCH v1] virtio-mmio: Specify wait needed in driver during reset
From: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>
Date: Mon, 26 Jul 2021 14:17:08 +0000
Message-ID: <BY5PR02MB7073036306A91FEF52CCC5FBF9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
References: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87h7gh5od5.fsf@redhat.com>
 <BY5PR02MB707337890F06CA1879CE7D54F9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87eebl5msn.fsf@redhat.com>,<20210726091851-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210726091851-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR02MB7073036306A91FEF52CCC5FBF9E89BY5PR02MB7073namp_"
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--_000_BY5PR02MB7073036306A91FEF52CCC5FBF9E89BY5PR02MB7073namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> On Mon, Jul 26, 2021 at 01:36:56PM +0200, Cornelia Huck wrote:
> > On Mon, Jul 26 2021, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com> wro=
te:
> >
> > >> > +indicated by a read of \field{Status} returning 0. Such a device =
MUST also
> > >> > fail to accept
> > >> > +FEATURES_OK bit if driver does not negotiate VIRTIO_F_MMIO_RESET_=
WAIT.
> > >>
> > >> So, this basically means that an older driver that does not know the=
 new
> > >> feature bit will not work with devices offering this bit, even if it=
 did
> > >> poll? This seems acceptable, I just wanted to spell it out.
> > >
> > > Yes I believe that's the desired result. Device has no way to know if=
 driver
> > > will poll for reset completion or not unless it accepts the feature.
> > > Are you suggesting we explicitly put in some text in spec to that
> > > effect?
> >
> > Not sure whether it is needed (do others have an opinion?), but probabl=
y
> > not.
>
> What about resets before FEATURES_OK? How are these handled?

From device perspective, it's reset logic will always be same, independent =
of
when reset was performed by driver (before or after feature negotiation). A
driver that does not wait for reset completion will see undefined behavior =
after
reset until it discovers that feature negotiation has failed?

- vatsa

---

Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.



--_000_BY5PR02MB7073036306A91FEF52CCC5FBF9E89BY5PR02MB7073namp_
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
<div style=3D"margin:0px;font-size:12pt">&gt; On Mon, Jul 26, 2021 at 01:36=
:56PM +0200, Cornelia Huck wrote:</div>
<div style=3D"margin:0px;font-size:12pt">
<div style=3D"margin:0px">&gt; &gt; On Mon, Jul 26 2021, Srivatsa Vaddagiri=
 &lt;svaddagi@qti.qualcomm.com&gt; wrote:</div>
<div style=3D"margin:0px">&gt; &gt;</div>
<div style=3D"margin:0px">&gt; &gt; &gt;&gt; &gt; +indicated by a read of \=
field{Status} returning 0. Such a device MUST also</div>
<div style=3D"margin:0px">&gt; &gt; &gt;&gt; &gt; fail to accept</div>
<div style=3D"margin:0px">&gt; &gt; &gt;&gt; &gt; +FEATURES_OK bit if drive=
r does not negotiate VIRTIO_F_MMIO_RESET_WAIT.</div>
<div style=3D"margin:0px">&gt; &gt; &gt;&gt;</div>
<div style=3D"margin:0px">&gt; &gt; &gt;&gt; So, this basically means that =
an older driver that does not know the new</div>
<div style=3D"margin:0px">&gt; &gt; &gt;&gt; feature bit will not work with=
 devices offering this bit, even if it did</div>
<div style=3D"margin:0px">&gt; &gt; &gt;&gt; poll? This seems acceptable, I=
 just wanted to spell it out.</div>
<div style=3D"margin:0px">&gt; &gt; &gt;</div>
<div style=3D"margin:0px">&gt; &gt; &gt; Yes I believe that's the desired r=
esult. Device has no way to know if driver</div>
<div style=3D"margin:0px">&gt; &gt; &gt; will poll for reset completion or =
not unless it accepts the feature.</div>
<div style=3D"margin:0px">&gt; &gt; &gt; Are you suggesting we explicitly p=
ut in some text in spec to that</div>
<div style=3D"margin:0px">&gt; &gt; &gt; effect?</div>
<div style=3D"margin:0px">&gt; &gt;</div>
<div style=3D"margin:0px">&gt; &gt; Not sure whether it is needed (do other=
s have an opinion?), but probably</div>
<div style=3D"margin:0px">&gt; &gt; not.</div>
<div style=3D"margin:0px">&gt;</div>
<div style=3D"margin:0px">&gt; What about resets before FEATURES_OK? How ar=
e these handled?</div>
<div style=3D"margin:0px"><br>
</div>
<div style=3D"margin:0px">From device perspective, it's reset logic will al=
ways be same, independent of</div>
<div style=3D"margin:0px">when reset was performed by driver (before or aft=
er feature negotiation). A</div>
<div style=3D"margin:0px">driver that does not wait for reset completion wi=
ll see undefined behavior after</div>
<div style=3D"margin:0px">reset until it discovers that feature negotiation=
 has failed?</div>
<div style=3D"margin:0px"><br>
</div>
<div style=3D"margin:0px">- vatsa</div>
<div style=3D"margin:0px"><br>
</div>
<div style=3D"margin:0px">---</div>
<div style=3D"margin:0px"><br>
</div>
<div style=3D"margin:0px">Qualcomm Innovation Center, Inc. is submitting th=
e attached &quot;feedback&quot; as a</div>
<span style=3D"margin:0px">non-member to the virtio-dev mailing list for co=
nsideration and inclusion.</span><br>
</div>
<div style=3D"margin:0px"></div>
<span style=3D"margin:0px;font-size:12pt"></span><br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
</body>
</html>

--_000_BY5PR02MB7073036306A91FEF52CCC5FBF9E89BY5PR02MB7073namp_--

