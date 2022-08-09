Return-Path: <virtio-dev-return-9729-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 37C8D98633A
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Aug 2022 21:37:59 +0000 (UTC)
Date: Tue, 9 Aug 2022 17:37:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220809173542-mutt-send-email-mst@kernel.org>
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, Jason Wang <jasowang@redhat.com>, Gavin Li <gavinl@nvidia.com>, "Hemminger, Stephen" <stephen@networkplumber.org>, davem <davem@davemloft.net>, virtualization <virtualization@lists.linux-foundation.org>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kubakici@wp.pl" <kubakici@wp.pl>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, Gavi Teitz <gavi@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 09, 2022 at 07:18:30PM +0000, Parav Pandit wrote:
> > From: Si-Wei Liu <si-wei.liu@oracle.com>
> > Sent: Tuesday, August 9, 2022 3:09 PM
>=20
> > >> From: Si-Wei Liu <si-wei.liu@oracle.com>
> > >> Sent: Tuesday, August 9, 2022 2:39 PM Currently it is not. Not a
> > >> single patch nor this patch, but the context for the eventual goal i=
s
> > >> to allow XDP on a MTU=3D9000 link when guest users intentionally low=
er
> > >> down MTU to 1500.
> > > Which application benefit by having asymmetry by lowering mtu to 1500
> > to send packets but want to receive 9K packets?
>=20
> Below details doesn=E2=80=99t answer the question of asymmetry. :)
>=20
> > I think virtio-net driver doesn't differentiate MTU and MRU, in which c=
ase
> > the receive buffer will be reduced to fit the 1500B payload size when m=
tu is
> > lowered down to 1500 from 9000.=20
> How? Driver reduced the mXu to 1500, say it is improved to post buffers o=
f 1500 bytes.
>=20
> Device doesn't know about it because mtu in config space is RO field.
> Device keep dropping 9K packets because buffers posted are 1500 bytes.
> This is because device follows the spec " The device MUST NOT pass receiv=
ed packets that exceed mtu".


The "mtu" here is the device config field, which is

        /* Default maximum transmit unit advice */

there is no guarantee device will not get a bigger packet.
And there is no guarantee such a packet will be dropped
as opposed to wedging the device if userspace insists on
adding smaller buffers.


> So, I am lost what virtio net device user application is trying to achiev=
e by sending smaller packets and dropping all receive packets.
> (it doesn=E2=80=99t have any relation to mergeable or otherwise).


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

