Return-Path: <virtio-dev-return-9986-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A96D986499
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Sep 2022 08:08:11 +0000 (UTC)
Message-ID: <1664352064.4679146-1-xuanzhuo@linux.alibaba.com>
Date: Wed, 28 Sep 2022 16:01:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuy2m7PagJwccx3QSnasuJpnF0MtKn-1MQSJ3sPLjvjew@mail.gmail.com>
 <d091f3e4-3d69-f0ba-5c6b-d3e05ca6b88c@linux.alibaba.com>
 <20220904162337-mutt-send-email-mst@kernel.org>
 <9843a9ea-07b9-7966-efa0-debf0467902a@linux.alibaba.com>
 <20220909044129-mutt-send-email-mst@kernel.org>
 <1662727108.301059-1-xuanzhuo@linux.alibaba.com>
 <845a54fa-149e-e170-5662-1bc04515af19@redhat.com>
 <20220927173358-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220927173358-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH v7] virtio_net: support split header
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, kangjie.xu@linux.alibaba.com, Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 27 Sep 2022 17:35:09 -0400, "Michael S. Tsirkin" <mst@redhat.com> w=
rote:
> On Wed, Sep 14, 2022 at 11:34:43AM +0800, Jason Wang wrote:
> >
> > =E5=9C=A8 2022/9/9 20:38, Xuan Zhuo =E5=86=99=E9=81=93:
> > > On Fri, 9 Sep 2022 07:15:02 -0400, "Michael S. Tsirkin" <mst@redhat.c=
om> wrote:
> > > > On Fri, Sep 09, 2022 at 03:41:54PM +0800, Heng Qi wrote:
> > > > >
> > > > > =E5=9C=A8 2022/9/5 =E4=B8=8A=E5=8D=884:27, Michael S. Tsirkin =E5=
=86=99=E9=81=93:
> > > > > > On Fri, Sep 02, 2022 at 03:36:25PM +0800, Heng Qi wrote:
> > > > > > > We need to clarify that the purpose of header splitting is to=
 make all payloads
> > > > > > > can be independently in a page, which is beneficial for the z=
erocopy
> > > > > > > implemented by the upper layer.
> > > > > > absolutely, pls add motivation.
> > > > > >
> > > > > > > If the driver does not enforce that the buffers submitted to =
the receiveq MUST
> > > > > > > be composed of at least two descriptors, then header splittin=
g will become meaningless,
> > > > > > > or the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature should not=
 be negotiated at this time.
> > > > > > >
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > >
> > > > > > This seems very narrow and unecessarily wasteful of descriptors=
.
> > > > > > What is wrong in this:
> > > > > >
> > > > > > <header>...<padding>... <beginning of page><data>
> > > > > >
> > > > > > seems to achieve the goal of data in a separate page without
> > > > > > using extra descriptors.
> > > > > >
> > > > > > thus my proposal to replace the requirement of a separate
> > > > > > descriptor with an offset of data from beginning of
> > > > > > buffer that driver sets.
> > > > > >
> > > > > >
> > > > > We have carefully considered your suggestion.
> > > > >
> > > > > We refer to spec v7 and earlier as scheme A for short. Review sch=
eme A
> > > > > below:
> > > > >
> > > > > | receive buffer |
> > > > >
> > > > > | 0th descriptor | 1th descriptor |
> > > > >
> > > > > | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->| payload |
> > > > >
> > > > > We use a buffer plus a separate page when allocating the receive
> > > > >
> > > > > buffer. In this way, we can ensure that all payloads can be
> > > > >
> > > > > independently in a page, which is very beneficial for the zerocop=
y
> > > > >
> > > > > implemented by the upper layer.
> > > > >
> > > > > scheme A better solves the problem of headroom, tailroom and memo=
ry waste,
> > > > > but as you said, this solution relies on descriptor chain.
> > > > >
> > > > > Our rethinking approach is no longer based on or using descriptor=
 chain.
> > > > >
> > > > > We refer to your proposed offset-based scheme as scheme B:
> > > > >
> > > > > As you suggested, scheme B gives the device a buffer, using offse=
t to
> > > > > indicate where to place the payload like this:
> > > > >
> > > > > <header>...<padding>... <beginning of page><data>
> > > > >
> > > > > But how to apply for this buffer? Since we want the payload to be=
 placed on
> > > > > a separate page, the method we consider is to directly apply to t=
he driver
> > > > > for two pages of contiguous memory.
> > > > >
> > > > > Then the beginning of this contiguous memory is used to store the=
 headroom,
> > > > > and the contiguous memory after the headroom is directly handed o=
ver to the
> > > > > device. similar to the following:
> > > > >
> > > > > <------------------------------------------ receive buffer(2 page=
s)
> > > > > ----------------------------------------->
> > > > >
> > > > > <<---------------------------------- first page
> > > > > -----------------------------------><---- second page ------>>
> > > > >
> > > > > <<Driver reserved, the later part is filled><vheader><transport
> > > > > header>..<padding>..<beginning of page><data>>
> > > > >
> > > > > Based on your previous suggestion, we also considered another new=
 scheme C.
> > > > >
> > > > > This scheme is implemented based on mergeable buffer, filling a s=
eparate
> > > > > page each time.
> > > > >
> > > > > If the split header is negotiated and the packet can be successfu=
lly split
> > > > > by the device, the device needs to find at least two buffers, nam=
ely two
> > > > > pages, one for the virtio-net header and transport header, and th=
e other for
> > > > > the data payload. Like the following:
> > > > >
> > > > > | receive buffer1(page) | receive buffer2 (page) |
> > > > >
> > > > > | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->| payload |
> > > > >
> > > > > At the same time, if XDP is considered, then the device needs to =
add
> > > > > headroom at the beginning of receive buffer1 when receiving packe=
ts, so that
> > > > > the driver can process programs similar to XDP. In order to solve=
 this
> > > > > problem, can scheme C introduce an offset, which requires the dev=
ice to
> > > > > write data from the offset position to receive buffer1, like the =
following:
> > > > >
> > > > > | receive buffer (page) | receive buffer (page) |
> > > > >
> > > > > | <-- offset(hold) --> | virtnet hdr | mac | ip hdr | tcp hdr|<--=
 hold -->|
> > > > > payload |
> > > > And in fact, B and C both use an offset now, right?
> > >
> > > B: offset is used to get the position to place the payload.
> > > C: The offset is used to reserve some space for the device, which the=
 driver can
> > >     use as headroom.
> > >
> > >     In order to make the payload page-aligned, we can only hand over =
the entire
> > >     page to the device, so we cannot reserve some headroom in advance=
.
> >
> >
> > For C, it might be better to do some tweak since mergeable buffer doesn=
't
> > forbid using a descriptor chain as a single buffer.
> >
> > So if it's a descriptor chain we got back the method A by placing the
> > payload in a dedicated buffer. If it's not placing the payload in an
> > adjacent buffer.
> >
> > Thanks
>
> Let's find a way so devices do not care how descriptors are laid out.

Can we try to make a desc describe a similar but unconnected piece of memor=
y?

struct vring_desc {
=09__virtio64 addr;
=09__virtio32 len;
=09__virtio16 flags;
=09__virtio16 next;
};

Note that len in desc is currently 32 bits, but generally 16 bits is enough=
, so
we have 16bits free space, and because we do not use desc chain, next is al=
so
free. We can use this two 16-bit spaces describe a hold.

|<-- buf1 --><-- hold --><--- page --->|
|<- offset-->|
             |<- size ->|

offset and size are less 65535.

Thanks.


>
> >
> > >
> > > > > Then we simply compare the advantages and disadvantages of scheme=
 A(spec
> > > > > v7), scheme B (offset buffer(2 pages)) and scheme C (based on mer=
geable
> > > > > buffer):
> > > > >
> > > > > 1. desc chain:
> > > > >
> > > > > - A depends on desciptor chain; - B, C do not depend on desciptor=
 chain.
> > > > >
> > > > > 2. page alloc
> > > > >
> > > > > - B fills two consecutive pages, which causes a great waste of me=
mory for
> > > > > small packages such as arp; - C fills a single page, slightly bet=
ter than B.
> > > > >
> > > > > 3. Memory waste:
> > > > >
> > > > > - The memory waste of scheme A is mainly the 0th descriptor that =
is skipped
> > > > > by the device;
> > > > there's also the cost of the indirect buffer since that is used whe=
n
> > > > there is a chain.
> > > Yes
> > >
> > >
> > > > > - When scheme B and scheme C successfully split the header,
> > > > > there is a huge waste of the first page, but the first page can b=
e quickly
> > > > > released by copying.
> > > > >
> > > > > 4. headroom
> > > > >
> > > > > - The headrooms of plan A and plan B are reserved; - Scheme C req=
uires the
> > > > > driver to set off to let the device skip off when using receive b=
uffer1.
> > > > >
> > > > > 5. tailroom
> > > > >
> > > > > - When splitting the header, skb usually needs to store each inde=
pendent
> > > > > page in the non-linear data area based on shinfo. - The tailroom =
of scheme A
> > > > > is reserved by itself; - Scheme B requires the driver to set the =
reserved
> > > > > padding area for the first receive buffer(2 pages) to use shinfo =
when the
> > > > > split header is not successfully executed; - Scheme C requires th=
e driver to
> > > > > set max_len for the first receive buffer(page).
> > > > >
> > > > >
> > > > > Which plan do you prefer?
> > > > I think either both B and C depending on the mergeable buffers flag=
,
> > > > or just one of these two.
> > > If I understand correctly, B does not depend on mergeable, while C mu=
st depend
> > > on mergeable.
> > >
> > > Thanks.
> > >
> > >
> > > > > ---
> > > > >
> > > > > Thanks.
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > >
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

