Return-Path: <virtio-dev-return-9982-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D9BA986490
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Sep 2022 21:35:18 +0000 (UTC)
Date: Tue, 27 Sep 2022 17:35:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220927173358-mutt-send-email-mst@kernel.org>
References: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuy2m7PagJwccx3QSnasuJpnF0MtKn-1MQSJ3sPLjvjew@mail.gmail.com>
 <d091f3e4-3d69-f0ba-5c6b-d3e05ca6b88c@linux.alibaba.com>
 <20220904162337-mutt-send-email-mst@kernel.org>
 <9843a9ea-07b9-7966-efa0-debf0467902a@linux.alibaba.com>
 <20220909044129-mutt-send-email-mst@kernel.org>
 <1662727108.301059-1-xuanzhuo@linux.alibaba.com>
 <845a54fa-149e-e170-5662-1bc04515af19@redhat.com>
MIME-Version: 1.0
In-Reply-To: <845a54fa-149e-e170-5662-1bc04515af19@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v7] virtio_net: support split header
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, kangjie.xu@linux.alibaba.com, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 14, 2022 at 11:34:43AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2022/9/9 20:38, Xuan Zhuo =E5=86=99=E9=81=93:
> > On Fri, 9 Sep 2022 07:15:02 -0400, "Michael S. Tsirkin" <mst@redhat.com=
> wrote:
> > > On Fri, Sep 09, 2022 at 03:41:54PM +0800, Heng Qi wrote:
> > > >=20
> > > > =E5=9C=A8 2022/9/5 =E4=B8=8A=E5=8D=884:27, Michael S. Tsirkin =E5=
=86=99=E9=81=93:
> > > > > On Fri, Sep 02, 2022 at 03:36:25PM +0800, Heng Qi wrote:
> > > > > > We need to clarify that the purpose of header splitting is to m=
ake all payloads
> > > > > > can be independently in a page, which is beneficial for the zer=
ocopy
> > > > > > implemented by the upper layer.
> > > > > absolutely, pls add motivation.
> > > > >=20
> > > > > > If the driver does not enforce that the buffers submitted to th=
e receiveq MUST
> > > > > > be composed of at least two descriptors, then header splitting =
will become meaningless,
> > > > > > or the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature should not b=
e negotiated at this time.
> > > > > >=20
> > > > > >=20
> > > > > > Thanks.
> > > > > >=20
> > > > > >=20
> > > > > This seems very narrow and unecessarily wasteful of descriptors.
> > > > > What is wrong in this:
> > > > >=20
> > > > > <header>...<padding>... <beginning of page><data>
> > > > >=20
> > > > > seems to achieve the goal of data in a separate page without
> > > > > using extra descriptors.
> > > > >=20
> > > > > thus my proposal to replace the requirement of a separate
> > > > > descriptor with an offset of data from beginning of
> > > > > buffer that driver sets.
> > > > >=20
> > > > >=20
> > > > We have carefully considered your suggestion.
> > > >=20
> > > > We refer to spec v7 and earlier as scheme A for short. Review schem=
e A
> > > > below:
> > > >=20
> > > > | receive buffer |
> > > >=20
> > > > | 0th descriptor | 1th descriptor |
> > > >=20
> > > > | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->| payload |
> > > >=20
> > > > We use a buffer plus a separate page when allocating the receive
> > > >=20
> > > > buffer. In this way, we can ensure that all payloads can be
> > > >=20
> > > > independently in a page, which is very beneficial for the zerocopy
> > > >=20
> > > > implemented by the upper layer.
> > > >=20
> > > > scheme A better solves the problem of headroom, tailroom and memory=
 waste,
> > > > but as you said, this solution relies on descriptor chain.
> > > >=20
> > > > Our rethinking approach is no longer based on or using descriptor c=
hain.
> > > >=20
> > > > We refer to your proposed offset-based scheme as scheme B:
> > > >=20
> > > > As you suggested, scheme B gives the device a buffer, using offset =
to
> > > > indicate where to place the payload like this:
> > > >=20
> > > > <header>...<padding>... <beginning of page><data>
> > > >=20
> > > > But how to apply for this buffer? Since we want the payload to be p=
laced on
> > > > a separate page, the method we consider is to directly apply to the=
 driver
> > > > for two pages of contiguous memory.
> > > >=20
> > > > Then the beginning of this contiguous memory is used to store the h=
eadroom,
> > > > and the contiguous memory after the headroom is directly handed ove=
r to the
> > > > device. similar to the following:
> > > >=20
> > > > <------------------------------------------ receive buffer(2 pages)
> > > > ----------------------------------------->
> > > >=20
> > > > <<---------------------------------- first page
> > > > -----------------------------------><---- second page ------>>
> > > >=20
> > > > <<Driver reserved, the later part is filled><vheader><transport
> > > > header>..<padding>..<beginning of page><data>>
> > > >=20
> > > > Based on your previous suggestion, we also considered another new s=
cheme C.
> > > >=20
> > > > This scheme is implemented based on mergeable buffer, filling a sep=
arate
> > > > page each time.
> > > >=20
> > > > If the split header is negotiated and the packet can be successfull=
y split
> > > > by the device, the device needs to find at least two buffers, namel=
y two
> > > > pages, one for the virtio-net header and transport header, and the =
other for
> > > > the data payload. Like the following:
> > > >=20
> > > > | receive buffer1(page) | receive buffer2 (page) |
> > > >=20
> > > > | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->| payload |
> > > >=20
> > > > At the same time, if XDP is considered, then the device needs to ad=
d
> > > > headroom at the beginning of receive buffer1 when receiving packets=
, so that
> > > > the driver can process programs similar to XDP. In order to solve t=
his
> > > > problem, can scheme C introduce an offset, which requires the devic=
e to
> > > > write data from the offset position to receive buffer1, like the fo=
llowing:
> > > >=20
> > > > | receive buffer (page) | receive buffer (page) |
> > > >=20
> > > > | <-- offset(hold) --> | virtnet hdr | mac | ip hdr | tcp hdr|<-- h=
old -->|
> > > > payload |
> > > And in fact, B and C both use an offset now, right?
> >=20
> > B: offset is used to get the position to place the payload.
> > C: The offset is used to reserve some space for the device, which the d=
river can
> >     use as headroom.
> >=20
> >     In order to make the payload page-aligned, we can only hand over th=
e entire
> >     page to the device, so we cannot reserve some headroom in advance.
>=20
>=20
> For C, it might be better to do some tweak since mergeable buffer doesn't
> forbid using a descriptor chain as a single buffer.
>=20
> So if it's a descriptor chain we got back the method A by placing the
> payload in a dedicated buffer. If it's not placing the payload in an
> adjacent buffer.
>=20
> Thanks

Let's find a way so devices do not care how descriptors are laid out.

>=20
> >=20
> > > > Then we simply compare the advantages and disadvantages of scheme A=
(spec
> > > > v7), scheme B (offset buffer(2 pages)) and scheme C (based on merge=
able
> > > > buffer):
> > > >=20
> > > > 1. desc chain:
> > > >=20
> > > > - A depends on desciptor chain; - B, C do not depend on desciptor c=
hain.
> > > >=20
> > > > 2. page alloc
> > > >=20
> > > > - B fills two consecutive pages, which causes a great waste of memo=
ry for
> > > > small packages such as arp; - C fills a single page, slightly bette=
r than B.
> > > >=20
> > > > 3. Memory waste:
> > > >=20
> > > > - The memory waste of scheme A is mainly the 0th descriptor that is=
 skipped
> > > > by the device;
> > > there's also the cost of the indirect buffer since that is used when
> > > there is a chain.
> > Yes
> >=20
> >=20
> > > > - When scheme B and scheme C successfully split the header,
> > > > there is a huge waste of the first page, but the first page can be =
quickly
> > > > released by copying.
> > > >=20
> > > > 4. headroom
> > > >=20
> > > > - The headrooms of plan A and plan B are reserved; - Scheme C requi=
res the
> > > > driver to set off to let the device skip off when using receive buf=
fer1.
> > > >=20
> > > > 5. tailroom
> > > >=20
> > > > - When splitting the header, skb usually needs to store each indepe=
ndent
> > > > page in the non-linear data area based on shinfo. - The tailroom of=
 scheme A
> > > > is reserved by itself; - Scheme B requires the driver to set the re=
served
> > > > padding area for the first receive buffer(2 pages) to use shinfo wh=
en the
> > > > split header is not successfully executed; - Scheme C requires the =
driver to
> > > > set max_len for the first receive buffer(page).
> > > >=20
> > > >=20
> > > > Which plan do you prefer?
> > > I think either both B and C depending on the mergeable buffers flag,
> > > or just one of these two.
> > If I understand correctly, B does not depend on mergeable, while C must=
 depend
> > on mergeable.
> >=20
> > Thanks.
> >=20
> >=20
> > > > ---
> > > >=20
> > > > Thanks.
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

