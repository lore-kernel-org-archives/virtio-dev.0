Return-Path: <virtio-dev-return-9925-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E18B9986534
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Sep 2022 19:51:40 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 7 Sep 2022 19:51:38 +0000
Message-ID: <PH0PR12MB54815E541D435DDC9339CA02DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220907101335-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D19E1E5DA11B2BD067CFDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907103420-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481066A18907753997A6F0CDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907141447-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C6E39AB31AB445C714A1DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907151026-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811F1234CB7822F47DD1B9DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907152156-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481291080EBEC54C82A5641DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907153425-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220907153425-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v5 2/2] virtio-net: use mtu size as buffer length for big
 packets
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Li <gavinl@nvidia.com>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "kuba@kernel.org" <kuba@kernel.org>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Gavi Teitz <gavi@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, September 7, 2022 3:36 PM
>=20
> On Wed, Sep 07, 2022 at 07:27:16PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, September 7, 2022 3:24 PM
> > >
> > > On Wed, Sep 07, 2022 at 07:18:06PM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Wednesday, September 7, 2022 3:12 PM
> > > >
> > > > > > Because of shallow queue of 16 entries deep.
> > > > >
> > > > > but why is the queue just 16 entries?
> > > > I explained the calculation in [1] about 16 entries.
> > > >
> > > > [1]
> > > >
> > >
> https://lore.kernel.org/netdev/PH0PR12MB54812EC7F4711C1EA4CAA119DC
> > > 419@
> > > > PH0PR12MB5481.namprd12.prod.outlook.com/
> > > >
> > > > > does the device not support indirect?
> > > > >
> > > > Yes, indirect feature bit is disabled on the device.
> > >
> > > OK that explains it.
> >
> > So can we proceed with v6 to contain
> > (a) updated commit message and
> > (b) function name change you suggested to drop _fields suffix?
>=20
> (c) replace mtu =3D 0 with sensibly not calling the function when mtu is
> unknown.

>=20
>=20
> And I'd like commit log to include results of perf testing
> - with indirect feature on
Which device do you suggest using for this test?

> - with mtu feature off
Why is this needed when it is not touching the area of mtu being not offere=
d?

> just to make sure nothing breaks.
Not sure why you demand this.
Can you please share the link to other patches that ensured that nothing br=
eaks, for example I didn't see a similar "test ask" in v14 series [1]?
What is so special about current patch of interest vs [1] that requires thi=
s special testing details in commit log, and it is not required in [1] or p=
ast patches?
Do you have link to the tests done with synchronization tests by commit [2]=
?

This will help to define test matrix for developers and internal regression=
 and similar report in all subsequent patches like [1].

[1] https://lore.kernel.org/bpf/20220801063902.129329-41-xuanzhuo@linux.ali=
baba.com/
[2] 6213f07cb54

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

