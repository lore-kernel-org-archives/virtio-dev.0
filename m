Return-Path: <virtio-dev-return-8405-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4AB4D98622C
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Jul 2021 09:53:03 +0000 (UTC)
From: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>
Date: Tue, 27 Jul 2021 09:52:59 +0000
Message-ID: <BY5PR02MB70731E359EB50CD2E3827239F9E99@BY5PR02MB7073.namprd02.prod.outlook.com>
References: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87h7gh5od5.fsf@redhat.com>
 <BY5PR02MB707337890F06CA1879CE7D54F9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87eebl5msn.fsf@redhat.com> <20210726091851-mutt-send-email-mst@kernel.org>
 <BY5PR02MB7073036306A91FEF52CCC5FBF9E89@BY5PR02MB7073.namprd02.prod.outlook.com>,<20210726141737-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210726141737-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in driver during reset
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR02MB70731E359EB50CD2E3827239F9E99BY5PR02MB7073namp_"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--_000_BY5PR02MB70731E359EB50CD2E3827239F9E99BY5PR02MB7073namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> > > What about resets before FEATURES_OK? How are these handled?
> >
> > From device perspective, it's reset logic will always be same, independ=
ent of
> > when reset was performed by driver (before or after feature negotiation=
). A
> > driver that does not wait for reset completion will see undefined behav=
ior
> > after
> > reset until it discovers that feature negotiation has failed?
>
> Hmm. that doesn't sound too good. Makes using
> feature negotiation for this kind of useless ...
> Device can actually detect a read from status, right?
> Maybe if it sees status was not read it can just
> stay in reset state and not exit it?

Thinking on those lines, I am wondering if we can avoid the feature bit
all together based on that logic.

1) Driver writes 0 to status register - device initiates reset sequence
2) Driver reads status - return 0x40 (VIRTIO_CONFIG_S_NEEDS_RESET)
   if reset sequence is in progress, otherwise return 0
3) Driver writes status (ACKNOWLEDGE Bit) - if this happened before reset
   sequence completed and before we returned 0 for status read, then reject
   further initialization by setting VIRTIO_CONFIG_S_NEEDS_RESET (until nex=
t
   reset that is)

This should let device detect if we have a driver polling on reset completi=
on or
not?

---

Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.

--_000_BY5PR02MB70731E359EB50CD2E3827239F9E99BY5PR02MB7073namp_
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
&gt; &gt; &gt; What about resets before FEATURES_OK? How are these handled?
<div>&gt; &gt;</div>
<div>&gt; &gt; From device perspective, it's reset logic will always be sam=
e, independent of</div>
<div>&gt; &gt; when reset was performed by driver (before or after feature =
negotiation). A</div>
<div>&gt; &gt; driver that does not wait for reset completion will see unde=
fined behavior</div>
<div>&gt; &gt; after</div>
<div>&gt; &gt; reset until it discovers that feature negotiation has failed=
?</div>
<div>&gt; </div>
<div>&gt; Hmm. that doesn't sound too good. Makes using</div>
<div>&gt; feature negotiation for this kind of useless ...</div>
<div>&gt; Device can actually detect a read from status, right?</div>
<div>&gt; Maybe if it sees status was not read it can just</div>
<div>&gt; stay in reset state and not exit it?</div>
<div><br>
</div>
<div>Thinking on those lines, I am wondering if we can avoid the feature bi=
t</div>
<div>all together based on that logic.</div>
<div><br>
</div>
<div>1) Driver writes 0 to status register - device initiates reset sequenc=
e</div>
<div>2) Driver reads status - return 0x40 (VIRTIO_CONFIG_S_NEEDS_RESET)</di=
v>
<div>&nbsp; &nbsp;if reset sequence is in progress, otherwise return 0</div=
>
<div>3) Driver writes status (ACKNOWLEDGE Bit) - if this happened before re=
set</div>
<div>&nbsp; &nbsp;sequence completed and before we returned 0 for status re=
ad, then reject</div>
<div>&nbsp; &nbsp;further initialization by setting VIRTIO_CONFIG_S_NEEDS_R=
ESET (until next</div>
<div>&nbsp; &nbsp;reset that is)</div>
<div><br>
</div>
<div>This should let device detect if we have a driver polling on reset com=
pletion or</div>
<div>not?</div>
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

--_000_BY5PR02MB70731E359EB50CD2E3827239F9E99BY5PR02MB7073namp_--

