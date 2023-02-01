Return-Path: <virtio-comment-return-3934-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 1 Feb 2023 01:51:25 +0000
Message-ID: <PH0PR12MB5481A27116866CCE1000113FDCD19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
 <PH0PR12MB54813142D74C1328873435E2DCC79@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230131055710.GC34480@h68b04307.sqa.eu95>
In-Reply-To: <20230131055710.GC34480@h68b04307.sqa.eu95>
MIME-Version: 1.0
Subject: RE: [virtio-comment] RE: [virtio-dev] [PATCH v7] virtio-net: support
 inner header hash
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Tuesday, January 31, 2023 12:57 AM
>=20
> On Wed, Jan 18, 2023 at 11:45:39PM +0000, Parav Pandit wrote:
> >
> >
> > > From: virtio-dev@lists.oasis-open.org
> > > <virtio-dev@lists.oasis-open.org>
> > > Sent: Wednesday, January 4, 2023 2:14 AM
> >
> > > If the tunnel is used to encapsulate the packets, the hash
> > > calculated using the outer header of the receive packets is always
> > > fixed for the same flow packets, i.e. they will be steered to the sam=
e
> receive queue.
> >
> > > +\item[VIRTIO_NET_F_HASH_TUNNEL(52)] Device supports inner
> > > +    header hash for GRE, VXLAN and GENEVE tunnel-encapsulated packet=
s.
> > > +
> > A device may not support all 3 at the same time.
> > Please remove mentioning tunneling protocols description from here.
> > Just say device support inner header hash ...
>=20
> Sorry for the late reply due to vacation.
>=20
> Good idea, Michael suggested doing the same. But we also discussed this i=
ssue:
> Early, we used a feature bit to force devices to support GRE and VXLAN=20
..
There is no need to force the device.
LM will work as it will use both he values - the feature bit and the suppor=
ted/negotiated hash type in the config space.

> > An additional bit map somewhere else should say supported hash over
> different tunneling types.
> >
>=20
> Yes, we use \field{supported_hash_types} to declare supported hash types.
Nice. So yes, just remove the description from the feature bits.
[..]
> >
> > With the inclusion of tunnel outer header, it doesn't need to redefine =
the
> hashing for inner packets which is exactly same without the tunnel.
> > hash tunnel capability only indicates that hashing is done on the inner=
 packets
> as_before.
> >
>=20
> This seems like a trade-off, and I can get rid of this if the simple stat=
ement
> "computing the hash for the inner header of the tunnel packet is the same=
 as
> without tunnel"
> is also clear to the reader.
> What do you think? Cc Jason and Michael.
Not sure I follow your comment.
Inclusion of outer header has zero change in inner header hash.

The data structure etc is just fine in the patch you proposed.
So, there is no need to redefine all over it again.
Only description need to be simplified as below.
Please just change the text wording to indicate that when tunnel feature is=
 negotiated, and if the hashing is performed by the device on the inner hea=
der, hash_report_tunnel will contain the valid outer tunnel type informatio=
n.

Also, this patch is adding two functionalities.
1. Inner header hash calculation of existing already defined hash types=20
2. outer header hash for new type for GRE,VXLAN,GENEVE.
#1 should be in 1st patch.
#2 should be in 2nd patch.
This is better to review.

Overall useful features. Thanks for adding.

This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

