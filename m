Return-Path: <svaddagi@qti.qualcomm.com>
Subject: Re: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in driver
 during reset
From: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>
Date: Fri, 30 Jul 2021 03:49:59 +0000
Message-ID: <BY5PR02MB7073DBD36ACEDCF540162808F9EC9@BY5PR02MB7073.namprd02.prod.outlook.com>
References: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87h7gh5od5.fsf@redhat.com>
 <BY5PR02MB707337890F06CA1879CE7D54F9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87eebl5msn.fsf@redhat.com> <20210726091851-mutt-send-email-mst@kernel.org>
 <BY5PR02MB7073036306A91FEF52CCC5FBF9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <20210726141737-mutt-send-email-mst@kernel.org>
 <BY5PR02MB70731E359EB50CD2E3827239F9E99@BY5PR02MB7073.namprd02.prod.outlook.com>,<875ywt2lit.fsf@redhat.com>
In-Reply-To: <875ywt2lit.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR02MB7073DBD36ACEDCF540162808F9EC9BY5PR02MB7073namp_"
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--_000_BY5PR02MB7073DBD36ACEDCF540162808F9EC9BY5PR02MB7073namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> > Thinking on those lines, I am wondering if we can avoid the feature bit
> > all together based on that logic.
> >
> > 1) Driver writes 0 to status register - device initiates reset sequence
> > 2) Driver reads status - return 0x40 (VIRTIO_CONFIG_S_NEEDS_RESET)
> >    if reset sequence is in progress, otherwise return 0
>
> I don't think we can have the device return NEEDS_RESET in that case;
> that status is supposed to indicate "that the device has experienced an
> error from which it can't recover" -- which is not the case here,
> especially since the driver has already initiated a reset.

In that case, how about introducing a new status bit, RESET_IN_PROGRESS (bi=
t 4 or
some other unused bit) and return that to indicate reset is not complete?

Its not clear otherwise what the device is supposed to return in such case.

---

Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.



--_000_BY5PR02MB7073DBD36ACEDCF540162808F9EC9BY5PR02MB7073namp_
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
&gt; &gt; Thinking on those lines, I am wondering if we can avoid the featu=
re bit</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div>&gt; &gt; all together based on that logic.</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; 1) Driver writes 0 to status register - device initiates res=
et sequence</div>
<div>&gt; &gt; 2) Driver reads status - return 0x40 (VIRTIO_CONFIG_S_NEEDS_=
RESET)</div>
<div>&gt; &gt; &nbsp; &nbsp;if reset sequence is in progress, otherwise ret=
urn 0</div>
<div>&gt; </div>
<div>&gt; I don't think we can have the device return NEEDS_RESET in that c=
ase;</div>
<div>&gt; that status is supposed to indicate &quot;that the device has exp=
erienced an</div>
<div>&gt; error from which it can't recover&quot; -- which is not the case =
here,</div>
<div>&gt; especially since the driver has already initiated a reset.</div>
<div><br>
</div>
<div>In that case, how about introducing a new status bit, RESET_IN_PROGRES=
S (bit 4 or</div>
<div>some other unused bit) and return that to indicate reset is not comple=
te?</div>
<div><br>
</div>
<div>Its not clear otherwise what the device is supposed to return in such =
case.</div>
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_BY5PR02MB7073DBD36ACEDCF540162808F9EC9BY5PR02MB7073namp_--

