Return-Path: <virtio-dev-return-9827-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D58598642F
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Aug 2022 02:56:19 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 23 Aug 2022 02:56:15 +0000
Message-ID: <PH0PR12MB548134ABC8B055298834050EDC709@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220819144904.3332-1-gavinl@nvidia.com>
In-Reply-To: <20220819144904.3332-1-gavinl@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v2 0/2] Improve virtio performance for 9k mtu
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gavin Li <gavinl@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kubakici@wp.pl" <kubakici@wp.pl>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>
Cc: Gavi Teitz <gavi@nvidia.com>, Gavin Li <gavinl@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Gavin Li <gavinl@nvidia.com>
> Sent: Friday, August 19, 2022 10:49 AM
>=20
> This small series contains two patches that improves virtio netdevice
> performance for 9K mtu when GRO/ guest TSO is disabled.
>=20
> Gavin Li (2):
>   virtio-net: introduce and use helper function for guest gso support
>     checks
>   virtio-net: use mtu size as buffer length for big packets
>=20
>  drivers/net/virtio_net.c | 52 +++++++++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 16 deletions(-)

This driver change is in drivers/net.
Patches must include, netdev@vger.kernel.org to this series.
I do not know if they are merged through MST tree or netdev tree.

You might want to wait for a day or two, and if you don't receive comments,=
 you should resend V2 by including netdev@vger.kernel.org.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

