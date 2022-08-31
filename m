Return-Path: <virtio-dev-return-9863-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31847986449
	for <virtio-dev@lists.oasis-open.org>; Wed, 31 Aug 2022 11:26:16 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 31 Aug 2022 11:26:13 +0000
Message-ID: <PH0PR12MB54819F82D423B90F92DC256EDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220831090305.63510-1-gavinl@nvidia.com>
 <20220831090305.63510-2-gavinl@nvidia.com>
In-Reply-To: <20220831090305.63510-2-gavinl@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v4 1/2] virtio-net: introduce and use helper function for
 guest gso support checks
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gavin Li <gavinl@nvidia.com>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kuba@kernel.org" <kuba@kernel.org>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>
Cc: Gavi Teitz <gavi@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Gavin Li <gavinl@nvidia.com>
> Sent: Wednesday, August 31, 2022 5:03 AM
>=20
> Probe routine is already several hundred lines.
> Use helper function for guest gso support check.
>=20
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>

You missed the review by and ack by entries that were added in the email re=
ply for v3 for this, and 2nd patch.
Please add them.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

