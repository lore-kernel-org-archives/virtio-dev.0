Return-Path: <virtio-dev-return-9998-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F16B1986690
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Oct 2022 10:29:13 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 5 Oct 2022 10:29:10 +0000
Message-ID: <PH0PR12MB54817CD89ECD1D0856103421DC5D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220901021038.84751-1-gavinl@nvidia.com>
	<20220901021038.84751-3-gavinl@nvidia.com>
	<20220922052734-mutt-send-email-mst@kernel.org>
	<PH0PR12MB5481374E6A14EFC39533F9A8DC4E9@PH0PR12MB5481.namprd12.prod.outlook.com>
	<20220922060753-mutt-send-email-mst@kernel.org>
 <20220922053458.66f31136@kernel.org>
In-Reply-To: <20220922053458.66f31136@kernel.org>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Li <gavinl@nvidia.com>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Gavi Teitz <gavi@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, September 22, 2022 6:05 PM
>=20
> On Thu, 22 Sep 2022 06:14:59 -0400 Michael S. Tsirkin wrote:
> > It's nitpicking to be frank. v6 arrived while I was traveling and I
> > didn't notice it.  I see Jason acked that so I guess I will just apply
> > as is.
>=20
> Oh, you wanna take it? The split on who takes virtio_net is a touch uncle=
ar
> but if it makes more sense here to go via virtio feel free to slap my ack=
 on the
> v6.

Michael,

Did you get a chance to take this?
I don't see it at https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost=
.git/log/?h=3Dlinux-next

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

