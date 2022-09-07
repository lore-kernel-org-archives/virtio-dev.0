Return-Path: <virtio-dev-return-9910-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69E4D986534
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Sep 2022 14:08:22 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 7 Sep 2022 14:08:18 +0000
Message-ID: <PH0PR12MB54812EC7F4711C1EA4CAA119DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220901021038.84751-1-gavinl@nvidia.com>
 <20220901021038.84751-3-gavinl@nvidia.com>
 <20220907012608-mutt-send-email-mst@kernel.org>
 <0355d1e4-a3cf-5b16-8c7f-b39b1ec14ade@nvidia.com>
 <20220907052317-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220907052317-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Gavin Li <gavinl@nvidia.com>
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "kuba@kernel.org" <kuba@kernel.org>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Gavi Teitz <gavi@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, September 7, 2022 5:27 AM
>=20
> On Wed, Sep 07, 2022 at 04:08:54PM +0800, Gavin Li wrote:
> >
> > On 9/7/2022 1:31 PM, Michael S. Tsirkin wrote:
> > > External email: Use caution opening links or attachments
> > >
> > >
> > > On Thu, Sep 01, 2022 at 05:10:38AM +0300, Gavin Li wrote:
> > > > Currently add_recvbuf_big() allocates MAX_SKB_FRAGS segments for
> > > > big packets even when GUEST_* offloads are not present on the
> device.
> > > > However, if guest GSO is not supported, it would be sufficient to
> > > > allocate segments to cover just up the MTU size and no further.
> > > > Allocating the maximum amount of segments results in a large waste
> > > > of buffer space in the queue, which limits the number of packets
> > > > that can be buffered and can result in reduced performance.
>=20
> actually how does this waste space? Is this because your device does not
> have INDIRECT?
VQ is 256 entries deep.
Driver posted total of 256 descriptors.
Each descriptor points to a page of 4K.
These descriptors are chained as 4K * 16.
So total packets that can be serviced are 256/16 =3D 16.
So effective queue depth =3D 16.

So, when GSO is off, for 9K mtu, packet buffer needed =3D 3 pages. (12k).
So, 13 descriptors (=3D 13 x 4K =3D52K) per packet buffer is wasted.

After this improvement, these 13 descriptors are available, increasing the =
effective queue depth =3D 256/3 =3D 85.

[..]
> > > >
> > > > MTU(Bytes)/Bandwidth (Gbit/s)
> > > >               Before   After
> > > >    1500        22.5     22.4
> > > >    9000        12.8     25.9
>=20
>=20
> is this buffer space?
Above performance numbers are showing improvement in bandwidth. In Gbps/sec=
.

> just the overhead of allocating/freeing the buffers?
> of using INDIRECT?
The effective queue depth is so small, device cannot receive all the packet=
s at given bw-delay product.

> > >
> > > Which configurations were tested?
> > I tested it with DPDK vDPA + qemu vhost. Do you mean the feature set
> > of the VM?
>=20
The configuration of interest is mtu, not the backend.
Which is different mtu as shown in above perf numbers.

> > > Did you test devices without VIRTIO_NET_F_MTU ?
> > No.=A0 It will need code changes.
No. It doesn't need any code changes. This is misleading/vague.

This patch doesn't have any relation to a device which doesn't offer VIRTIO=
_NET_F_MTU.
Just the code restructuring is touching this area, that may require some ex=
isting tests.
I assume virtio tree will have some automation tests for such a device?

> > > >
> > > > @@ -3853,12 +3866,10 @@ static int virtnet_probe(struct
> > > > virtio_device *vdev)
> > > >
> > > >                dev->mtu =3D mtu;
> > > >                dev->max_mtu =3D mtu;
> > > > -
> > > > -             /* TODO: size buffers correctly in this case. */
> > > > -             if (dev->mtu > ETH_DATA_LEN)
> > > > -                     vi->big_packets =3D true;
> > > >        }
> > > >
> > > > +     virtnet_set_big_packets_fields(vi, mtu);
> > > > +
> > > If VIRTIO_NET_F_MTU is off, then mtu is uninitialized.
> > > You should move it to within if () above to fix.
> > mtu was initialized to 0 at the beginning of probe if VIRTIO_NET_F_MTU
> > is off.
> >
> > In this case,=A0 big_packets_num_skbfrags will be set according to gues=
t gso.
> >
> > If guest gso is supported, it will be set to MAX_SKB_FRAGS else
> > zero---- do you
> >
> > think this is a bug to be fixed?
>=20
>=20
> yes I think with no mtu this should behave as it did historically.
>=20
Michael is right.
It should behave as today. There is no new bug introduced by this patch.
dev->mtu and dev->max_mtu is set only when VIRTIO_NET_F_MTU is offered with=
/without this patch.

Please have mtu related fix/change in different patch.

> > >
> > > >        if (vi->any_header_sg)
> > > >                dev->needed_headroom =3D vi->hdr_len;
> > > >
> > > > --
> > > > 2.31.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

