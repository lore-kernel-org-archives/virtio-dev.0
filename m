Return-Path: <virtio-dev-return-10066-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 521CC986579
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Oct 2022 08:16:07 +0000 (UTC)
Date: Thu, 20 Oct 2022 16:16:01 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
Message-ID: <20221020081601.GA48712@h68b04307.sqa.eu95>
References: <20220920032824.GA125047@h68b04307.sqa.eu95>
 <CACGkMEtOHXtNtG13Zxpc+bhYJVyefp999kttz4YcPi22nMBSpQ@mail.gmail.com>
 <1663903426.8765974-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsmqngS-HYPzzV8b9dmv95=W6dJebAa=asXGmo7VEAnoA@mail.gmail.com>
 <20220923013341-mutt-send-email-mst@kernel.org>
 <619af5b3-4c38-955f-0f7f-f351f5a9527e@redhat.com>
 <20220928093530-mutt-send-email-mst@kernel.org>
 <CACGkMEsKHBo+tgJrADif9y5qLF-OHoK7pO6YvQBa-edjjPwVJQ@mail.gmail.com>
 <20220929022523-mutt-send-email-mst@kernel.org>
 <CACGkMEvmVJVCG-W-phG_JkVnEy_EpKRgG38LexTzStn7dADztw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvmVJVCG-W-phG_JkVnEy_EpKRgG38LexTzStn7dADztw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v8] virtio_net: support for split transport
 header
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Kangjie Xu <kangjie.xu@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Oct 08, 2022 at 12:37:45PM +0800, Jason Wang wrote:
> On Thu, Sep 29, 2022 at 3:04 PM Michael S. Tsirkin <mst@redhat.com> wrote=
:
> >
> > On Thu, Sep 29, 2022 at 09:48:33AM +0800, Jason Wang wrote:
> > > On Wed, Sep 28, 2022 at 9:39 PM Michael S. Tsirkin <mst@redhat.com> w=
rote:
> > > >
> > > > On Mon, Sep 26, 2022 at 04:06:17PM +0800, Jason Wang wrote:
> > > > > > Jason I think the issue with previous proposals is that they co=
nflict
> > > > > > with VIRTIO_F_ANY_LAYOUT. We have repeatedly found that giving =
the
> > > > > > driver flexibility in arranging the packet in memory is benefit=
ial.
> > > > >
> > > > >
> > > > > Yes, but I didn't found how it can conflict the any_layout. Devic=
e can just
> > > > > to not split the header when the layout doesn't fit for header sp=
litting.
> > > > > (And this seems the case even if we're using buffers).
> > > >
> > > > Well spec says:
> > > >
> > > >         indicates to both the device and the driver that no
> > > >         assumptions were made about framing.
> > > >
> > > > if device assumes that descriptor boundaries are where
> > > > driver wants packet to be stored that is clearly
> > > > an assumption.
> > >
> > > Yes but what I want to say is, the device can choose to not split the
> > > packet if the framing doesn't fit. Does it still comply with the abov=
e
> > > description?
> > >
> > > Thanks
> >
> > The point of ANY_LAYOUT is to give drivers maximum flexibility.
> > For example, if driver wants to split the header at some specific
> > offset this is already possible without extra functionality.
>=20
> I'm not sure how this would work without the support from the device.
> This probably can only work if:
>=20
> 1) the driver know what kind of packet it can receive
> 2) protocol have fixed length of the header
>=20
> This is probably not true consider:
>=20
> 1) TCP and UDP have different header length
> 2) IPv6 has an variable length of the header
>=20
>=20
> >
> > Let's keep it that way.
> >
> > Now, let's formulate what are some of the problems with the current way=
.
> >
> >
> >
> > A- mergeable buffers is even more flexible, since a single packet
> >   is built up of multiple buffers. And in theory device can
> >   choose arbitrary set of buffers to store a packet.
> >   So you could supply a small buffer for headers followed by a bigger
> >   one for payload, in theory even without any changes.
> >   Problem 1: However since this is not how devices currently operate,
> >   a feature bit would be helpful.
>=20
> How do we know the bigger buffer is sufficient for the packet? If we
> try to allocate 64K (not sufficient for the future even) it breaks the
> effort of the mergeable buffer:
>=20
> header buffer #1
> payload buffer #1
> header buffer #2
> payload buffer #2
>=20
> Is the device expected to
>=20
> 1) fill payload in header buffer #2, this breaks the effort that we
> want to make payload page aligned
> 2) skip header buffer #2, in this case, the device assumes the framing
> when it breaks any layout
>=20
> >
> >   Problem 2: Also, in the past we found it useful to be able to figure =
out whether
> >   packet fits in a single buffer without looking at the header.
> >   For this reason, we have this text:
> >
> >         If a receive packet is spread over multiple buffers, the device
> >         MUST use all buffers but the last (i.e. the first \field{num_bu=
ffers} -
> >         1 buffers) completely up to the full length of each buffer
> >         supplied by the driver.
> >
> >   if we want to keep this optimization and allow using a separate
> >   buffer for headers, then I think we could rely on the feature bit
> >   from Problem 1 and just make an exception for the first buffer.
> >   Also num_buffers is then always >=3D 2, maybe state this to avoid
> >   confusion.
> >
> >
> >
> >
> >
> > B- without mergeable, there's no flexibility. In particular, there can
> > not be uninitialized space between header and data.
>=20
> I had two questions
>=20
> 1) why is this not a problem of mergeable? There's no guarantee that
> the header is just the length of what the driver allocates for header
> buffer anyhow
>=20
> E.g the header length could be smaller than the header buffer, the
> device still needs to skip part of the space in the header buffer.
>=20
> 2) it should be the responsibility of the driver to handle the
> uninitialized space, it should do anything that is necessary for
> security, more below
>=20


We've talked a bit more about split header so far, but there still seem to
be some issues, so let's recap.

=E4=B8=80=E3=80=81 Method Discussion Review

In order to adapt to the Eric's tcp receive interface to achieve zero copy,
header and payload are required to be stored separately, and the payload is
stored in a paged alignment way. Therefore, we have discussed several optio=
ns
for split header as follows:

1: method A ( depend on the descriptor chain )
|                         receive buffer                            |=20
|              0th descriptor                      | 1th descriptor |=20
| virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|      payload   |=20
Method A uses a buffer plus a separate page when allocating the receive
buffer. In this way, we can ensure that all payloads can be put
independently in a page, which is very beneficial for the zerocopy=20
implemented by the upper layer.=20

The advantage of method A is that the implementation is clearer, it can sup=
port normal
header spit and the rollback conditions. It can also easily support xdp. Th=
e downside is
that devices operating directly on the descriptor chain may cause the layer=
ing violation,
and also affect the performance.

2. method B ( depend on mergeable buffer)
|                   receive buffer (page)                                 |=
 receive buffer (page) |=20
| <-- offset(hold) --> | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|=
         payload       |=20
^
|
pointer to device

Method B is based on your previous suggestion, it is implemented based
on mergeable buffer, filling a separate page each time.=20

If the split header is negotiated and the packet can be successfully split =
by the device,
the device needs to find at least two buffers, namely two pages, one for th=
e virtio-net header
and transport header, and the other for the payload.

The advantage of method B is that it relies on mergeable buffer instead of =
the descriptor chain.
It overcomes the shortcomings of method A and can achieve the purpose of th=
e device focusing
on the buffer instead of the descriptor. Its disadvantage is that it causes=
 memory waste.

3. method C ( depend on mergeable buffer )
| small buffer | data buffer (page) | small buffer | data buffer (page) | s=
mall buffer | data buffer (page) |

Method B fills a separate page each time, while method C needs to fill the =
small buffer and
page buffer separately. Method C puts the header in small buffer and the pa=
yload in a page.

The advantage of method C is that some buffers are filled for header and da=
ta respectively,
which reduces the memory waste of method B. However, this method is difficu=
lt to weigh
the number of filled header buffers and data buffers, and an unreasonable p=
roportion will
affect performance. For example, in a scenario with a large number of large=
 packets,
too many header buffers will affect performance, or in a scenario with a la=
rge number of small
packets, too many data buffers can also affect performance. At the same tim=
e, if some protocols
with a large number of packets do not support split header, the existence o=
f the header buffers
will also affect performance.

=E4=BA=8C=E3=80=81Points of agreement and disagreement

1. What we have now agreed upon is that:
None of the three methods break VIRTIO_F_ANY_LAYOUT, they make virtio net h=
eader and
packet header stored together.

We have now agreed to relax the following in the split header scenario,
=09"indicates to both the device and the driver that no assumptions were ma=
de about framing."
because when a bigger packet comes, and a data buffer is not enough to stor=
e this packet,
the device either chooses to skip the next header buffer to break what the =
spec says above,
or chooses not to skip the header buffer and cannot make payload page align=
ed.
Therefore, all three methods need to relax the above requirements.

2. What we haven't now agreed upon is that:
The point where we don't agree now is that we don't have a more precise dis=
cussion of which
approach to take, but we're still bouncing between approaches.
At present, all three approaches seem to achieve our requirements, but each=
 has advantages
and disadvantages. Should we focus on the most important points, such as pe=
rformance to choose.
It seems a little difficult to cover everything?

=E4=B8=89=E3=80=81Two forms of implementing receive zerocopy

the Eric's tcp receive interface requires the header and payload are stored=
 in separate buffers, and the payload is
stored in a paged alignment way.

Now, io_uring also proposes a new receive zerocopy method, which requires h=
eader and payload
to be stored in separate buffers, but does not require payload page aligned=
.
https://lore.kernel.org/io-uring/20221007211713.170714-1-jonathan.lemon@gma=
il.com/T/#m678770d1fa7040fd76ed35026b93dfcbf25f6196


Thanks.

> > If we had flexibility here, this could be
> > helpful for alignment, security, etc.
> > Unfortunately, our hands are tied:
> >
> >
> >         \field{len} is particularly useful
> >         for drivers using untrusted buffers: if a driver does not know =
exactly
> >         how much has been written by the device, the driver would have =
to zero
> >         the buffer in advance to ensure no data leakage occurs.
> >
> >         For example, a network driver may hand a received buffer direct=
ly to
> >         an unprivileged userspace application.  If the network device h=
as not
> >         overwritten the bytes which were in that buffer, this could lea=
k the
> >         contents of freed memory from other processes to the applicatio=
n.
>=20
> This should be a bug of the driver. For example, if the driver wants
> to implement zerocopy, it must guarantee that every byte was written
> by the device before mapping it to the userspace, if it can't it
> should do the copy instead.
>=20
> >
> >
> > so all buffers have to be initialized completely up to the reported
> > used length.
> >
> > It could be that the guarantee is not relevant in some use-cases.
> > We would have to specify that this is an exception to the rule,
> > explain that drivers must be careful about information leaks.
> > Let's say there's a feature bit that adds uninitialized space
> > somewhere. How much was added? We can find out by parsing the
> > packet but once you start doing that just to assemble the skb
> > you have already lost performance.
>=20
> I don't get here, for those uninitialized spaces, it looks just
> tailroom for the skb.
>=20
> Thanks
>=20
> > So lots of spec work, some security risks, and unclear performance.
> >
> >
> >
> >
> > Is above a fair summary?
> >
> >
> >
> > If yes I would say let's address A, but make sure we ask drivers
> > to clear the new feature bit if there's no mergeable
> > (as opposed to e.g. failing probe) so we can add
> > support for !mergeable down the road.
> >
> >
> >
> >
> >
> > --
> > MST
> >

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

