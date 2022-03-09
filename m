Return-Path: <virtio-dev-return-9354-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D062898658A
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Mar 2022 03:53:06 +0000 (UTC)
Message-ID: <1646797809.0498495-1-xuanzhuo@linux.alibaba.com>
Date: Wed, 9 Mar 2022 11:50:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220302085217.16546-1-xuanzhuo@linux.alibaba.com>
 <fbb699b3-7f20-5acc-dd94-9a1164411e3c@redhat.com>
 <1646641908.5408983-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEttPn3M9v+v3QMcqORP67EMMD7Aj=Yjmdm4f+=HPuBPag@mail.gmail.com>
In-Reply-To: <CACGkMEttPn3M9v+v3QMcqORP67EMMD7Aj=Yjmdm4f+=HPuBPag@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v11] virtio-net: support device stats
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 8 Mar 2022 14:36:02 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Mar 7, 2022 at 5:07 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wro=
te:
> >
> > On Mon, 7 Mar 2022 15:58:03 +0800, Jason Wang <jasowang@redhat.com> wro=
te:
> > >
> > > =E5=9C=A8 2022/3/2 =E4=B8=8B=E5=8D=884:52, Xuan Zhuo =E5=86=99=E9=81=
=93:
> > > > This patch allows the driver to obtain some statistics from the dev=
ice.
> > > >
> > > > In the back-end implementation, we can count a lot of such informat=
ion,
> > > > which can be used for debugging and judging the running status of t=
he
> > > > back-end. We hope to directly display it to the user through ethtoo=
l.
> > > >
> > > > To get stats atomically, try to get stats for all queue pairs in on=
e
> > > > command.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > > v11:
> > > > 1. Use michael's advice to introduce virtio_net_ctrl_queue_stats to=
 get vq stats
> > > >     based on vq num and type
> > > > 2. split stats structure
>
> [...]
>
> > > What happens if driver tries to query RX stats through a TX index?
> >
> > Device setting ack to VIRTIO_NET_ERR.
> >
> > I relegated this case to the next case. "The type of vq does not match =
\field{type}."
> >
> > I will explain in the next release:
> >
> >   \item The type of vq does not match \field{type}. Such as the driver =
tries to query RX stats through a TX index.
> >
> > >
> > >
> > > > +    \item The type of vq does not match \field{type}.
> > > > +    \item The feature corresponding to the specified \field{type} =
was not successfully
> > > > +        negotiated.
> > > > +    \item The size of \field{command-specific-data-reply} is less =
than the sum
> > > > +        of \field{length}.
> > >
> > >
> > > I'm not sure I get here, I guess this proposal allows the driver to
> > > query an array of stats. So I guess it means the size of required sta=
ts
> > > instead of the size of \field{command-specific-data-reply}.
> >
> > The size of \field{command-specific-data-reply} refers to the size of m=
emory
> > allocated by the driver for \field{command-specific-data-reply}.
> >
> > Sorry, I will make it clearer in the next version.
> >
> > >
> > >
> > > > +\end{itemize}
> > > > +
> > > > +The device MUST write the requested stats structures in
> > > > +\field{command-specific-data-reply} in the order specified by the =
structure
> > > > +virtio_net_ctrl_queue_stats.
> > >
> > >
> > > Do we need per stat error code here? Or device can simply fail a batc=
h
> > > of query if one of those fails?
> >
> > Device can simply fail a batch of query if one of those fails.
>
> We need clarify, and I guess we should use MUST instead of MAY without
> a per stat error value.
>
> >
> > >
> > >
> > > > +
> > > > +The size of each stats MUST be less than or equal to the correspon=
ding
> > > > +\field{length}, but the space it occupies MUST be equal to the cor=
responding
> > > > +\field{length}.
> > >
> > >
> > > I wonder how the length trick can work here. Is this used for extensi=
on?
> > > If yes, how can driver know a suitable length?
> >
> > It only allows the possibility of expansion.
> >
> > The driver must set the length based on the size of the stats it knows.
>
> Ok, this seems like a way to make a new driver that can run on an old dev=
ice.
>
> But then I wonder if it would be simpler to just use fixed length and
> just extend the types.


If we decide to extend the new stats by adding a new type, even if we just =
add a
new counter to a current stats structure, we also add a new type. Then we c=
an
delete the length directly. Because type and the return stats must correspo=
nd.

Thanks.

>
> Thanks
>
> > It seems that I am not very clear on this point. I will make this clear=
 in the
> > next version.
> >
> > Of course, it is allowed to set a larger length. As long as the driver =
allocates
> > the corresponding memory for it.
> >
> >
> > > What happens if device support more stats?
> >
> > "The size of each stats MUST be less than or equal to the corresponding=
 \field{length}."
> >
> > >
> > >
> > > > +
> > > > +\drivernormative{\subparagraph}{Device Stats}{Device Types / Netwo=
rk Device / Device Operation / Control Virtqueue / Device Stats}
> > > > +
> > > > +When a driver tries to obtain a certain stats, it MUST confirm tha=
t the relevant
> > > > +feature negotiation is successful.
> > > > +
> > > > +\field{type} in struct virtio_net_ctrl_queue_stats MUST correspond=
 to the vq
> > > > +specified by \field{queue_num}.
> > > > +
> > > > +\field{length} in struct virtio_net_ctrl_queue_stats MUST be great=
er than or
> > > > +equal to the size of the structure corresponding to \field{type}. =
It MUST be a
> > > > +multiple of 8.
> > >
> > >
> > > Why do we need the padding here?
> >
> > This is to ensure structure alignment.
> >
> > >
> > >
> > > > +
> > > > +The size of \field{command-specific-data-reply} allocated by the d=
river MUST be
> > > > +greater than or equal to the sum of \field{legnth} in struct
> > >
> > >
> > > typo.
> >
> > I will fix it.
> >
> > >
> > >
> > > > +virtio_net_ctrl_queue_stats.
> > >
> > >
> > > Any value that we can allocate more than the sum of the length?
> >
> > It is theoretically allowed, as long as the allocated space is greater =
than the
> > sum of length, there will be no error.
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> > >
> > > > +
> > > > +When the driver reads the response, it MUST read
> > > > +\field{command-specific-data-reply} one by one based on the set \f=
ield{length}
> > > > +and \field{type}.
> > > >
> > > >   \subsubsection{Legacy Interface: Framing Requirements}\label{sec:=
Device
> > > >   Types / Network Device / Legacy Interface: Framing Requirements}
> > > > --
> > > > 2.31.0
> > > >
> > >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

