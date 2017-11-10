Return-Path: virtio-dev-return-2670-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C76241CB807E
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Nov 2017 01:43:24 -0800 (PST)
From: "Tan, Jianfeng" <jianfeng.tan@intel.com>
Date: Fri, 10 Nov 2017 09:43:20 +0000
Message-ID: <ED26CBA2FAD1BF48A8719AEF02201E365134AA05@SHSMSX103.ccr.corp.intel.com>
References: <1d6a84dd-946b-840f-d04c-f786c900ce88@intel.com>
 <20171110093105.GD31658@stefanha-x1.localdomain>
In-Reply-To: <20171110093105.GD31658@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] Propose to report the offset addr back from vhost
 to virtio
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Liang, Cunming" <cunming.liang@intel.com>, "Gasparakis, Joseph" <joseph.gasparakis@intel.com>, 'Jason Wang' <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> Sent: Friday, November 10, 2017 5:31 PM
> To: Tan, Jianfeng
> Cc: virtio-dev@lists.oasis-open.org; Michael S. Tsirkin; Liang, Cunming;
> Gasparakis, Joseph; 'Jason Wang'
> Subject: Re: [virtio-dev] Propose to report the offset addr back from vho=
st to
> virtio
>=20
> On Thu, Nov 09, 2017 at 01:33:11PM +0800, Tan, Jianfeng wrote:
> > This proposal will be from virtio-net perspective, not sure if it helps=
 for
> > other device types.
> >
> > Current status:
> > VIRTIO-net "rx" path will rearm buffers for packets receiving, put the =
start
> > addr and len on the descriptor table (or the single ring for virtio 1.1
> > draft spec), vhost backend will put the packet exactly on the start add=
r,
> > and report the real packet len back. This way does not allow the vhost
> > backend to put the packet somewhere offset to the start addr.
> >
> > Use case:
> > When we look at vhost rx zero copy problem, we would like the NIC to pu=
t
> the
> > packets directly onto VM memory, but this raw packet (tunnel packet)
> always
> > contains a outer header which should be decap before VM starts receivin=
g
> the
> > packet. And unfortunately, not all NICs support decap. After the whole
> > tunnel packet be put on the VM buffer (starting with the start addr), a=
nd
> > after the vswitch's decap, we can report an "offset" back to VIRTIO
> > frontend, and of course, the frontend shall honor this offset and adjus=
t
> > accordingly.
> >
> > The proposal:
> > We can add a new feature like, VIRTIO_NET_F_OFFSET and add a new filed
> in
> > virtio_net_header; if this feature is negotiated, the vhost side can re=
port
> > the "offset" in virtio_net_header, and the frontend side will recognize=
 this
> > value and adjust the packet buffer accordingly.
> >
> > Any comments?
>=20
> Does exposing the encapsulation header to guest memory pose a security
> problem?

We could memset it to zero before returning it back to virtio; but that can=
not protect from a malicious VM which keep snooping on the memory. What's w=
orse, the malicious can still write that buffer.

Hmm, indeed, it's an unsecure solution.

>=20
> In a simple VLAN scenario it tells the guest about the VLAN ID used on
> the host.  If fancier encapsulation protocols are used there might be
> additional info that the guest shouldn't see?
>=20
> Besides this concern it seems like a useful virtio-net feature.

Thank you for your insight here.

Thanks,
Jianfeng

>=20
> Stefan

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

