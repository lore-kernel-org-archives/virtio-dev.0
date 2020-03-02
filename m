Return-Path: virtio-dev-return-6841-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36524985B2F
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 12:02:05 +0000 (UTC)
MIME-Version: 1.0
References: <4fa78a91-751d-a7b5-fadf-b0ae8a5d5903@siemens.com>
 <CAJPjb1+Jnm-eHUQSFjhRBKAFNKqceHQMdRWtKEG+uncypGYKcA@mail.gmail.com>
 <2fed2342-d6fa-17ff-a812-ec01a14d8183@siemens.com> <20200227050257-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200227050257-mutt-send-email-mst@kernel.org>
From: Rob Miller <rob.miller@broadcom.com>
Date: Mon, 2 Mar 2020 07:01:37 -0500
Message-ID: <CAJPjb1+XXw2+7WkDYnaTRo0SUUcEpho7SjaMO-YAwOuF-Z5OTg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] split-ring: Demand that a device must not
 change descriptor entries
Content-Type: multipart/alternative; boundary="00000000000097ade0059fddf48f"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--00000000000097ade0059fddf48f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

In reviewing my comments, I agree that I misunderstood what was being
requested. Please ignore my comments and continue as needed.

Rob Miller
rob.miller@broadcom.com
(919)721-3339


On Thu, Feb 27, 2020 at 5:05 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Mon, Nov 11, 2019 at 06:26:58PM +0100, Jan Kiszka wrote:
> > On 11.11.19 18:17, Rob Miller wrote:
> > > what is trying to be solved here? There is a reason why this is allow=
ed
> > > as some vendors update the table when using RX_MERABLE_BUFFERs &
> > > F_IN_ORDER features
> >
> > OK, good to know. Which fields are updated then? Under which conditions
> (ie.
> > in which states of the device)?
> >
> > The background is in the link below. My goal was to find a simple way
> > declaring all fields read-only for the device to avoid problems with ne=
w
> > implementations. But it looks like it's more complicated...
> >
> > Jan
>
> No answer yet. Rob I see the following options:
> - proceed with the ballot as is ignoring your comment. Maybe it's all a
>   misunderstanding? It could be the comment was referring to the
>   packed ring, where this patch refers to the split ring.
> - make it weaker: MUST if PLATFORM_ACCESS is negotiated, and
>   SHOULD if it isn't.
>
> > >
> > > Rob Miller
> > > rob.miller@broadcom.com <mailto:rob.miller@broadcom.com>
> > > (919)721-3339
> > >
> > >
> > > On Mon, Nov 11, 2019 at 12:13 PM Jan Kiszka <jan.kiszka@siemens.com
> > > <mailto:jan.kiszka@siemens.com>> wrote:
> > >
> > >     From: Jan Kiszka <jan.kiszka@siemens.com
> > >     <mailto:jan.kiszka@siemens.com>>
> > >
> > >     So far the spec only indirectly says that a descriptor table entr=
y
> is
> > >     not modified by a device when processing it. Make this explicit b=
y
> > >     adding it as normative requirement. Existing drivers already
> depend on
> > >     this.
> > >
> > >     See also
> > >
> https://lists.oasis-open.org/archives/virtio-dev/201910/msg00057.html.
> > >
> > >     Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com
> > >     <mailto:jan.kiszka@siemens.com>>
> > >     ---
> > >       split-ring.tex | 2 +-
> > >       1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > >     diff --git a/split-ring.tex b/split-ring.tex
> > >     index 123ac9f..bfef62d 100644
> > >     --- a/split-ring.tex
> > >     +++ b/split-ring.tex
> > >     @@ -217,7 +217,7 @@ \subsection{The Virtqueue Descriptor
> > >     Table}\label{sec:Basic Facilities of a Virt
> > >       \devicenormative{\subsubsection}{The Virtqueue Descriptor
> > >     Table}{Basic Facilities of a Virtio Device / Virtqueues / The
> > >     Virtqueue Descriptor Table}
> > >       A device MUST NOT write to a device-readable buffer, and a devi=
ce
> > >     SHOULD NOT
> > >       read a device-writable buffer (it MAY do so for debugging or
> > >     diagnostic
> > >     -purposes).
> > >     +purposes). A device MUST NOT write to any descriptor table entry=
.
> > >
> > >       \drivernormative{\subsubsection}{The Virtqueue Descriptor
> > >     Table}{Basic Facilities of a Virtio Device / Virtqueues / The
> > >     Virtqueue Descriptor Table}
> > >       Drivers MUST NOT add a descriptor chain longer than $2^{32}$
> bytes
> > >     in total;
> > >     --     2.16.4
> > >
> > >
>  ---------------------------------------------------------------------
> > >     To unsubscribe, e-mail:
> virtio-dev-unsubscribe@lists.oasis-open.org
> > >     <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
> > >     For additional commands, e-mail:
> > >     virtio-dev-help@lists.oasis-open.org
> > >     <mailto:virtio-dev-help@lists.oasis-open.org>
> > >
> >
> > --
> > Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> > Corporate Competence Center Embedded Linux
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>

--00000000000097ade0059fddf48f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">In reviewing my comments, I agree that I misunderstood=C2=
=A0what was being requested. Please ignore my comments and continue as need=
ed.<div><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signature" d=
ata-smartmail=3D"gmail_signature"><div dir=3D"ltr">Rob Miller<div><a href=
=3D"mailto:rob.miller@broadcom.com" target=3D"_blank">rob.miller@broadcom.c=
om</a></div><div>(919)721-3339</div></div></div></div><br></div></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb=
 27, 2020 at 5:05 AM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.co=
m">mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Mon, Nov 11, 2019 at 06:26:58PM +0100, Jan Kiszka wrote=
:<br>
&gt; On 11.11.19 18:17, Rob Miller wrote:<br>
&gt; &gt; what is trying to be solved=C2=A0here? There is a reason why this=
 is allowed<br>
&gt; &gt; as some vendors update the table when using RX_MERABLE_BUFFERs &a=
mp;<br>
&gt; &gt; F_IN_ORDER features<br>
&gt; <br>
&gt; OK, good to know. Which fields are updated then? Under which condition=
s (ie.<br>
&gt; in which states of the device)?<br>
&gt; <br>
&gt; The background is in the link below. My goal was to find a simple way<=
br>
&gt; declaring all fields read-only for the device to avoid problems with n=
ew<br>
&gt; implementations. But it looks like it&#39;s more complicated...<br>
&gt; <br>
&gt; Jan<br>
<br>
No answer yet. Rob I see the following options:<br>
- proceed with the ballot as is ignoring your comment. Maybe it&#39;s all a=
<br>
=C2=A0 misunderstanding? It could be the comment was referring to the<br>
=C2=A0 packed ring, where this patch refers to the split ring.<br>
- make it weaker: MUST if PLATFORM_ACCESS is negotiated, and<br>
=C2=A0 SHOULD if it isn&#39;t.<br>
<br>
&gt; &gt; <br>
&gt; &gt; Rob Miller<br>
&gt; &gt; <a href=3D"mailto:rob.miller@broadcom.com" target=3D"_blank">rob.=
miller@broadcom.com</a> &lt;mailto:<a href=3D"mailto:rob.miller@broadcom.co=
m" target=3D"_blank">rob.miller@broadcom.com</a>&gt;<br>
&gt; &gt; (919)721-3339<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; On Mon, Nov 11, 2019 at 12:13 PM Jan Kiszka &lt;<a href=3D"mailto=
:jan.kiszka@siemens.com" target=3D"_blank">jan.kiszka@siemens.com</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:jan.kiszka@siemens.com" target=3D"_b=
lank">jan.kiszka@siemens.com</a>&gt;&gt; wrote:<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0From: Jan Kiszka &lt;<a href=3D"mailto:jan.kis=
zka@siemens.com" target=3D"_blank">jan.kiszka@siemens.com</a><br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:jan.kiszka@siemen=
s.com" target=3D"_blank">jan.kiszka@siemens.com</a>&gt;&gt;<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0So far the spec only indirectly says that a de=
scriptor table entry is<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0not modified by a device when processing it. M=
ake this explicit by<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0adding it as normative requirement. Existing d=
rivers already depend on<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0this.<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0See also<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lists.oasis-open.org/archiv=
es/virtio-dev/201910/msg00057.html" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.oasis-open.org/archives/virtio-dev/201910/msg00057.html</a>.<br=
>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Jan Kiszka &lt;<a href=3D"mailt=
o:jan.kiszka@siemens.com" target=3D"_blank">jan.kiszka@siemens.com</a><br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:jan.kiszka@siemen=
s.com" target=3D"_blank">jan.kiszka@siemens.com</a>&gt;&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0split-ring.tex | 2 +-<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A01 file changed, 1 insertion(+), 1 delet=
ion(-)<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0diff --git a/split-ring.tex b/split-ring.tex<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0index 123ac9f..bfef62d 100644<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0--- a/split-ring.tex<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0+++ b/split-ring.tex<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0@@ -217,7 +217,7 @@ \subsection{The Virtqueue =
Descriptor<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Table}\label{sec:Basic Facilities of a Virt<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\devicenormative{\subsubsection}{The Vi=
rtqueue Descriptor<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Table}{Basic Facilities of a Virtio Device / V=
irtqueues / The<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Virtqueue Descriptor Table}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0A device MUST NOT write to a device-rea=
dable buffer, and a device<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0SHOULD NOT<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0read a device-writable buffer (it MAY d=
o so for debugging or<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0diagnostic<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-purposes).<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0+purposes). A device MUST NOT write to any des=
criptor table entry.<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0\drivernormative{\subsubsection}{The Vi=
rtqueue Descriptor<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Table}{Basic Facilities of a Virtio Device / V=
irtqueues / The<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Virtqueue Descriptor Table}<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Drivers MUST NOT add a descriptor chain=
 longer than $2^{32}$ bytes<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0in total;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0--=C2=A0 =C2=A0 =C2=A02.16.4<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0----------------------------------------------=
-----------------------<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0To unsubscribe, e-mail: <a href=3D"mailto:virt=
io-dev-unsubscribe@lists.oasis-open.org" target=3D"_blank">virtio-dev-unsub=
scribe@lists.oasis-open.org</a><br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:virtio-dev-unsubs=
cribe@lists.oasis-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.=
oasis-open.org</a>&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0For additional commands, e-mail:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"mailto:virtio-dev-help@lists.oasis-=
open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</a><br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:virtio-dev-help@l=
ists.oasis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org=
</a>&gt;<br>
&gt; &gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Siemens AG, Corporate Technology, CT RDA IOT SES-DE<br>
&gt; Corporate Competence Center Embedded Linux<br>
&gt; <br>
&gt; ---------------------------------------------------------------------<=
br>
&gt; To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists=
.oasis-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-open.=
org</a><br>
&gt; For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lis=
ts.oasis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</=
a><br>
<br>
</blockquote></div>

--00000000000097ade0059fddf48f--

