Return-Path: <svaddagi@qti.qualcomm.com>
Subject: Re: [PATCH v1] virtio-mmio: Specify wait needed in driver during reset
From: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>
Date: Mon, 26 Jul 2021 11:25:29 +0000
Message-ID: <BY5PR02MB707337890F06CA1879CE7D54F9E89@BY5PR02MB7073.namprd02.prod.outlook.com>
References: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>,<87h7gh5od5.fsf@redhat.com>
In-Reply-To: <87h7gh5od5.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR02MB707337890F06CA1879CE7D54F9E89BY5PR02MB7073namp_"
To: Cornelia Huck <cohuck@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--_000_BY5PR02MB707337890F06CA1879CE7D54F9E89BY5PR02MB7073namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> > Changes since v0:
> >
> > Introduce a new feature bit, VIRTIO_F_MMIO_RESET_WAIT, which controls w=
hether
> > a driver polls
> > for reset completion or not.
>
> Nit: changelog should go into a "---" section, next to the diffstat (git
> format-patch should give you the correct base to edit.)

Thanks for your review. Will take care of that in next version.

> > +indicated by a read of \field{Status} returning 0. Such a device MUST =
also
> > fail to accept
> > +FEATURES_OK bit if driver does not negotiate VIRTIO_F_MMIO_RESET_WAIT.
>
> So, this basically means that an older driver that does not know the new
> feature bit will not work with devices offering this bit, even if it did
> poll? This seems acceptable, I just wanted to spell it out.

Yes I believe that's the desired result. Device has no way to know if drive=
r
will poll for reset completion or not unless it accepts the feature.
Are you suggesting we explicitly put in some text in spec to that effect?

> > +reset of such a device that offers VIRTIO_F_MMIO_RESET_WAIT, driver MU=
ST poll
> > for
>
> s/driver/the driver/
>
> But maybe use "if VIRTIO_F_MMIO_RESET_WAIT has been negotiated" instead?
> This is implied by the statements above, but the deciding factor here is
> that the feature has been negotiated, and not that it has been offered.

Sure sounds good.

> > +reset completion indicated by a read of \field{Status} returning 0.
> > +
> >  The driver MUST ignore a device with \field{MagicValue} which is not
> >  0x74726976,
> >  although it MAY report an error.
> >
> > @@ -6672,6 +6679,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserv=
ed
> > Feature Bits}
> >    transport specific.
> >    For more details about driver notifications over PCI see \ref{sec:Vi=
rtio
> >    Transport Options / Virtio Over PCI Bus / PCI-specific Initializatio=
n And
> >    Device Operation / Available Buffer Notifications}.
> >
> > +  \item[VIRTIO_F_MMIO_RESET_WAIT(40)] This feature could be offered by=
 a
> > device
> > +  using MMIO transport and indicates that the driver needs to poll for=
 reset
>
> "This feature is specific to the MMIO transport and indicates that the
> device requires the driver to poll..."
>
> ?

Ok

> > +  completion indicated by a read of \field{Status} returning 0.
> > +
> >  \end{description}
> >
> >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bit=
s}
> > @@ -6708,6 +6719,8 @@ \chapter{Reserved Feature Bits}\label{sec:Reserve=
d
> > Feature Bits}
> >
> >  A driver SHOULD accept VIRTIO_F_NOTIF_CONFIG_DATA if it is offered.
> >
> > +A driver SHOULD accept VIRTIO_F_MMIO_RESET_WAIT if it is offered.
> > +
>
> But this was specified as MUST above, wasn't it?

I guess I followed the convention of using SHOULD for other bits such as
VIRTIO_F_NOTIF_CONFIG_DATA in that section, but yes MUST sounds better.

I will post the next version shortly with recommended changes.

- vatsa

---

Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.

--_000_BY5PR02MB707337890F06CA1879CE7D54F9E89BY5PR02MB7073namp_
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
&gt; &gt; Changes since v0:
<div>&gt; &gt;</div>
<div>&gt; &gt; Introduce a new feature bit, VIRTIO_F_MMIO_RESET_WAIT, which=
 controls whether</div>
<div>&gt; &gt; a driver polls</div>
<div>&gt; &gt; for reset completion or not.</div>
<div>&gt; </div>
<div>&gt; Nit: changelog should go into a &quot;---&quot; section, next to =
the diffstat (git</div>
<div>&gt; format-patch should give you the correct base to edit.)</div>
<div><br>
</div>
<div>Thanks for your review. Will take care of that in next version.</div>
<div><br>
</div>
<div>&gt; &gt; +indicated by a read of \field{Status} returning 0. Such a d=
evice MUST also</div>
<div>&gt; &gt; fail to accept</div>
<div>&gt; &gt; +FEATURES_OK bit if driver does not negotiate VIRTIO_F_MMIO_=
RESET_WAIT.</div>
<div>&gt; </div>
<div>&gt; So, this basically means that an older driver that does not know =
the new</div>
<div>&gt; feature bit will not work with devices offering this bit, even if=
 it did</div>
<div>&gt; poll? This seems acceptable, I just wanted to spell it out.</div>
<div><br>
</div>
<div>Yes I believe that's the desired result. Device has no way to know if =
driver</div>
<div>will poll for reset completion or not unless it accepts the feature.</=
div>
<div>Are you suggesting we explicitly put in some text in spec to that effe=
ct?</div>
<div><br>
</div>
<div>&gt; &gt; +reset of such a device that offers VIRTIO_F_MMIO_RESET_WAIT=
, driver MUST poll</div>
<div>&gt; &gt; for</div>
<div>&gt; </div>
<div>&gt; s/driver/the driver/</div>
<div>&gt; </div>
<div>&gt; But maybe use &quot;if VIRTIO_F_MMIO_RESET_WAIT has been negotiat=
ed&quot; instead?</div>
<div>&gt; This is implied by the statements above, but the deciding factor =
here is</div>
<div>&gt; that the feature has been negotiated, and not that it has been of=
fered.</div>
<div><br>
</div>
<span>Sure sounds good.</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>&gt; &gt; +reset completion indicated by a read of \field{Status} ret=
urning 0.
<div>&gt; &gt; +</div>
<div>&gt; &gt; &nbsp;The driver MUST ignore a device with \field{MagicValue=
} which is not</div>
<div>&gt; &gt; &nbsp;0x74726976,</div>
<div>&gt; &gt; &nbsp;although it MAY report an error.</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; @@ -6672,6 +6679,10 @@ \chapter{Reserved Feature Bits}\label=
{sec:Reserved</div>
<div>&gt; &gt; Feature Bits}</div>
<div>&gt; &gt; &nbsp; &nbsp;transport specific.</div>
<div>&gt; &gt; &nbsp; &nbsp;For more details about driver notifications ove=
r PCI see \ref{sec:Virtio</div>
<div>&gt; &gt; &nbsp; &nbsp;Transport Options / Virtio Over PCI Bus / PCI-s=
pecific Initialization And</div>
<div>&gt; &gt; &nbsp; &nbsp;Device Operation / Available Buffer Notificatio=
ns}.</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; + &nbsp;\item[VIRTIO_F_MMIO_RESET_WAIT(40)] This feature cou=
ld be offered by a</div>
<div>&gt; &gt; device</div>
<div>&gt; &gt; + &nbsp;using MMIO transport and indicates that the driver n=
eeds to poll for reset</div>
<div>&gt; </div>
<div>&gt; &quot;This feature is specific to the MMIO transport and indicate=
s that the</div>
<div>&gt; device requires the driver to poll...&quot;</div>
<div>&gt; </div>
<div>&gt; ?</div>
<div><br>
</div>
<div>Ok</div>
<span></span><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span>&gt; &gt; + &nbsp;completion indicated by a read of \field{Status} re=
turning 0.
<div>&gt; &gt; +</div>
<div>&gt; &gt; &nbsp;\end{description}</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; &nbsp;\drivernormative{\section}{Reserved Feature Bits}{Rese=
rved Feature Bits}</div>
<div>&gt; &gt; @@ -6708,6 +6719,8 @@ \chapter{Reserved Feature Bits}\label{=
sec:Reserved</div>
<div>&gt; &gt; Feature Bits}</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; &nbsp;A driver SHOULD accept VIRTIO_F_NOTIF_CONFIG_DATA if i=
t is offered.</div>
<div>&gt; &gt;</div>
<div>&gt; &gt; +A driver SHOULD accept VIRTIO_F_MMIO_RESET_WAIT if it is of=
fered.</div>
<div>&gt; &gt; +</div>
<div>&gt; </div>
<div>&gt; But this was specified as MUST above, wasn't it?</div>
<div><br>
</div>
<div>I guess I followed the convention of using SHOULD for other bits such =
as</div>
<div>VIRTIO_F_NOTIF_CONFIG_DATA in that section, but yes MUST sounds better=
.</div>
<div><br>
</div>
<div>I will post the next version shortly with recommended changes.</div>
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
</span></div>
</body>
</html>

--_000_BY5PR02MB707337890F06CA1879CE7D54F9E89BY5PR02MB7073namp_--

