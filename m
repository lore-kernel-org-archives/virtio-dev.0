Return-Path: virtio-dev-return-5418-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E498985E0A
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Feb 2019 20:03:35 +0000 (UTC)
MIME-Version: 1.0
References: <501110004.11631.1549031044295@oodm23.prod.google.com>
 <CAJPjb1LF0x6AJ3vgvudURwhJ_OYkNHG0sG-ZfD7H-n7PcN1uBA@mail.gmail.com> <20190212134959-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190212134959-mutt-send-email-mst@kernel.org>
From: Rob Miller <rob.miller@broadcom.com>
Date: Tue, 12 Feb 2019 15:03:06 -0500
Message-ID: <CAJPjb1+163jTBdkN6YyXne9wWoR8StQuDt9FBSu7=Q4Ua+qamQ@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000072be110581b7eb80"
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Riddoch <driddoch@solarflare.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--00000000000072be110581b7eb80
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 12, 2019 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Fri, Feb 01, 2019 at 09:43:02AM -0800, Rob Miller wrote:
> > Agreed that this is needed.
> >
> > I would also like to suggest splitting the F_IN_ORDER into
> > F_RX_IN_ORDER and F_TX_IN_ORDER to support hw LRO implementations,
> > which can be more of a scatter/gather than tx. This would allow
> > batchmode for tx at least in packed rings.
>
> I'm not sure what does this buy us. Are you interested in
> out of order tx with in order rx then?
>
Other way around. It is easier to guarantee that TX pkts are processed in
order but rx is quite more difficult. The way some rx aggregators work is
that  as pkts are received from the wire, a "timer" and flow detector is
setup. This allows for other incoming packet with same TCP header (flow) to
be egg'd into one large packet with multiple segments. When a timeout fires
(no other segments arrive within time) or the TCP header changes, the whole
list of RX buffers is then sent up to the driver for processing. However
during this gathering period, multiple flows, say from other TCP sources
could be arriving. The hardware allocates rx buffers(descriptors) as the
fragments hit the receiver, hence they will be used out-of-order and batch
mode on RX isn't possible.

>
> > Finally, i would suggest a means to specify a given rings ring mode
> > and packed leans more towards TX, whilst split can be either really
> > depending upon LRO, jumbo, rx buff size, ect.. just like F_IN_ORDER,
> > we can have RX & TX, split out.
> >
> > Sent from my iPhone
>
> Before we jump there a bit more justification would be nice.
>
The above description of rx aggregation, where buffer are allocated for
each rx pkt segment as they hit the receiver . If there were 2 ingressing
flows from different sources, say nicely interleaved, then i would expect
to see rx desc usage as follows:

buffer 0 - flow 0
buffer 1- flow 1
buffer 2 - flow 0
buffer 3 - flow 1

I would think this lends itself to a split virtqueue mode of operation
better than ring buffer.

>
>
> E.g. doing this change in software isn't a lot of work. How about
> a software patch with some performance gains measured?
> Failing that, some back of the napkin calculations showing
> the potential gains and costs?
>
Yea I could do that. I wanted to bounce the idea around a bit first to
understand more if there are holes in my logic.

>
>
> > > On Feb 1, 2019, at 9:23 AM, David Riddoch <driddoch@solarflare.com>
> wrote:
> > >
> > > All,
> > >
> > > I'd like to propose a small extension to the packed virtqueue mode.  My
> > > proposal is to add an offset/wrap field, written by the driver,
> > > indicating how many available descriptors have been added to the ring.
> > >
> > > The reason for wanting this is to improve performance of hardware
> > > devices.  Because of high read latency over a PCIe bus, it is important
> > > for hardware devices to read multiple ring entries in parallel.  It is
> > > desirable to know how many descriptors are available prior to issuing
> > > these reads, else you risk fetching descriptors that are not yet
> > > available.  As well as wasting bus bandwidth this adds complexity.
> > >
> > > I'd previously hoped that VIRTIO_F_NOTIFICATION_DATA would solve this
> > > problem, but we still have a problem.  If you rely on doorbells to tell
> > > you how many descriptors are available, then you have to keep doorbells
> > > enabled at all times.  This can result in a very high rate of doorbells
> > > with some drivers, which can become a severe bottleneck (because x86
> > > CPUs can't emit MMIOs at very high rates).
> > >
> > > The proposed offset/wrap field allows devices to disable doorbells when
> > > appropriate, and determine the latest fill level via a PCIe read.
> > >
> > > I suggest the best place to put this would be in the driver area,
> > > immediately after the event suppression structure.
> > >
> > > Presumably we would like this to be an optional feature, as
> > > implementations of packed mode already exist in the wild.  How about
> > > VIRTIO_F_RING_PACKED_AVAIL_IDX?
> > >
> > > If I prepare a patch to the spec is there still time to get this into
> v1.1?
> > >
> > > Best,
> > > David
> > >
> > > --
> > > David Riddoch  <driddoch@solarflare.com> -- Chief Architect,
> Solarflare
> > >
> > >
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

--00000000000072be110581b7eb80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 12, 2019 at 1:55 PM Micha=
el S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, F=
eb 01, 2019 at 09:43:02AM -0800, Rob Miller wrote:<br>
&gt; Agreed that this is needed.<br>
&gt; <br>
&gt; I would also like to suggest splitting the F_IN_ORDER into<br>
&gt; F_RX_IN_ORDER and F_TX_IN_ORDER to support hw LRO implementations,<br>
&gt; which can be more of a scatter/gather than tx. This would allow<br>
&gt; batchmode for tx at least in packed rings.<br>
<br>
I&#39;m not sure what does this buy us. Are you interested in<br>
out of order tx with in order rx then?<br></blockquote><div>Other way aroun=
d. It is easier to guarantee that TX pkts are processed in order but rx is =
quite more difficult. The way some rx aggregators work is that=C2=A0=C2=A0a=
s pkts are received from the wire, a &quot;timer&quot; and flow detector is=
 setup. This allows for other incoming packet with same TCP header (flow) t=
o be egg&#39;d into one large packet with multiple segments. When a timeout=
 fires (no other segments arrive within time) or the TCP header changes, th=
e whole list of RX buffers is then sent up to the driver for processing. Ho=
wever during this gathering period, multiple flows, say from other TCP sour=
ces could be arriving. The hardware allocates rx buffers(descriptors) as th=
e fragments hit the receiver, hence they will be used out-of-order and batc=
h mode on RX isn&#39;t possible.</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
&gt; Finally, i would suggest a means to specify a given rings ring mode<br=
>
&gt; and packed leans more towards TX, whilst split can be either really<br=
>
&gt; depending upon LRO, jumbo, rx buff size, ect.. just like F_IN_ORDER,<b=
r>
&gt; we can have RX &amp; TX, split out.<br>
&gt; <br>
&gt; Sent from my iPhone<br>
<br>
Before we jump there a bit more justification would be nice.<br></blockquot=
e><div>The above description of rx aggregation, where buffer are allocated =
for each rx pkt segment as they hit the receiver . If there were 2 ingressi=
ng flows from different sources, say nicely interleaved, then i would expec=
t to see rx desc usage as follows:</div><div><br></div><div>buffer 0 - flow=
 0</div><div>buffer 1- flow 1</div><div>buffer 2 - flow 0</div><div>buffer =
3 - flow 1</div><div><br></div><div>I would think this lends itself to a sp=
lit virtqueue mode of operation better than ring buffer.</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
<br>
E.g. doing this change in software isn&#39;t a lot of work. How about<br>
a software patch with some performance gains measured?<br>
Failing that, some back of the napkin calculations showing<br>
the potential gains and costs?<br></blockquote><div>Yea I could do that. I =
wanted to bounce the idea around a bit first to understand more if there ar=
e holes in my logic.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
<br>
&gt; &gt; On Feb 1, 2019, at 9:23 AM, David Riddoch &lt;<a href=3D"mailto:d=
riddoch@solarflare.com" target=3D"_blank">driddoch@solarflare.com</a>&gt; w=
rote:<br>
&gt; &gt;<br>
&gt; &gt; All,<br>
&gt; &gt;<br>
&gt; &gt; I&#39;d like to propose a small extension to the packed virtqueue=
 mode.=C2=A0 My<br>
&gt; &gt; proposal is to add an offset/wrap field, written by the driver,<b=
r>
&gt; &gt; indicating how many available descriptors have been added to the =
ring.<br>
&gt; &gt;<br>
&gt; &gt; The reason for wanting this is to improve performance of hardware=
<br>
&gt; &gt; devices.=C2=A0 Because of high read latency over a PCIe bus, it i=
s important<br>
&gt; &gt; for hardware devices to read multiple ring entries in parallel.=
=C2=A0 It is<br>
&gt; &gt; desirable to know how many descriptors are available prior to iss=
uing<br>
&gt; &gt; these reads, else you risk fetching descriptors that are not yet<=
br>
&gt; &gt; available.=C2=A0 As well as wasting bus bandwidth this adds compl=
exity.<br>
&gt; &gt;<br>
&gt; &gt; I&#39;d previously hoped that VIRTIO_F_NOTIFICATION_DATA would so=
lve this<br>
&gt; &gt; problem, but we still have a problem.=C2=A0 If you rely on doorbe=
lls to tell<br>
&gt; &gt; you how many descriptors are available, then you have to keep doo=
rbells<br>
&gt; &gt; enabled at all times.=C2=A0 This can result in a very high rate o=
f doorbells<br>
&gt; &gt; with some drivers, which can become a severe bottleneck (because =
x86<br>
&gt; &gt; CPUs can&#39;t emit MMIOs at very high rates).<br>
&gt; &gt;<br>
&gt; &gt; The proposed offset/wrap field allows devices to disable doorbell=
s when<br>
&gt; &gt; appropriate, and determine the latest fill level via a PCIe read.=
<br>
&gt; &gt;<br>
&gt; &gt; I suggest the best place to put this would be in the driver area,=
<br>
&gt; &gt; immediately after the event suppression structure.<br>
&gt; &gt;<br>
&gt; &gt; Presumably we would like this to be an optional feature, as<br>
&gt; &gt; implementations of packed mode already exist in the wild.=C2=A0 H=
ow about<br>
&gt; &gt; VIRTIO_F_RING_PACKED_AVAIL_IDX?<br>
&gt; &gt;<br>
&gt; &gt; If I prepare a patch to the spec is there still time to get this =
into v1.1?<br>
&gt; &gt;<br>
&gt; &gt; Best,<br>
&gt; &gt; David<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; David Riddoch=C2=A0 &lt;<a href=3D"mailto:driddoch@solarflare.com=
" target=3D"_blank">driddoch@solarflare.com</a>&gt; -- Chief Architect, Sol=
arflare<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; -----------------------------------------------------------------=
----<br>
&gt; &gt; To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@=
lists.oasis-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-=
open.org</a><br>
&gt; &gt; For additional commands, e-mail: <a href=3D"mailto:virtio-dev-hel=
p@lists.oasis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.=
org</a><br>
&gt; &gt;<br>
&gt; <br>
&gt; ---------------------------------------------------------------------<=
br>
&gt; To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists=
.oasis-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-open.=
org</a><br>
&gt; For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lis=
ts.oasis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</=
a><br>
</blockquote></div></div>

--00000000000072be110581b7eb80--
