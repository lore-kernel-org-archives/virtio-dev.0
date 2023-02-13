Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-comment] [PATCH v8] virtio-net: support inner header hash
Date: Mon, 13 Feb 2023 21:42:25 +0000
Message-ID: <PH0PR12MB54817EAF86DF11B9FB0DCB8EDCDD9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230208090836.74355-1-hengqi@linux.alibaba.com>
 <0f73e9c7-5080-d01c-0f63-dd23942fa71b@linux.alibaba.com>
In-Reply-To: <0f73e9c7-5080-d01c-0f63-dd23942fa71b@linux.alibaba.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Monday, February 13, 2023 8:05 AM
> Hi, all.
>=20
> Do you have any comments on this version?
>=20
> Thanks.
>=20
> =1B$B:_=1B(B 2023/2/8 =1B$B2<8a=1B(B5:08, Heng Qi =1B$B<LF;=1B(B:
> > If the tunnel is used to encapsulate the packets, the hash calculated
> > using the outer header of the receive packets is always fixed for the
> > same flow packets, i.e. they will be steered to the same receive queue.
> >
> > We add a feature bit VIRTIO_NET_F_HASH_TUNNEL and related bitmasks in
> > \field{hash_tunnel_types}, which instructs the device to calculate the
> > hash using the inner headers of tunnel-encapsulated packets. Besides,
> > values in \field{hash_report_tunnel_types} are added to report tunnel t=
ypes.
> >
> > Note that VIRTIO_NET_F_HASH_TUNNEL only indicates the ability of the
> > inner header hash, and does not give the device the ability to use the
> > hash value to select a receiving queue to place the packet.
> >
[..]
> > @@ -3384,9 +3396,10 @@ \subsection{Device Operation}\label{sec:Device
> Types / Network Device / Device O
> >           le16 csum_start;
> >           le16 csum_offset;
> >           le16 num_buffers;
> > -        le32 hash_value;        (Only if VIRTIO_NET_F_HASH_REPORT
> negotiated)
> > -        le16 hash_report;       (Only if VIRTIO_NET_F_HASH_REPORT
> negotiated)
> > -        le16 padding_reserved;  (Only if VIRTIO_NET_F_HASH_REPORT
> negotiated)
> > +        le32 hash_value;              (Only if VIRTIO_NET_F_HASH_REPOR=
T
> negotiated)
> > +        le16 hash_report;             (Only if VIRTIO_NET_F_HASH_REPOR=
T
> negotiated)
> > +        u8 hash_report_tunnel_types;  (Only if VIRTIO_NET_F_HASH_REPOR=
T

I am yet to review the changes of v8.
But the quick response is, I do not see a use case of above field by sw dri=
ver.
And this addition requires the core hw data path to supply this value.
Without good motivation, it is hard to have it here.

What is valuable is to have a VNI already identified and coming to the driv=
er, like a hash value.
This can cut down the cpu processing power, in outer header packet processi=
ng.
However, that is relatively a different feature than inner hash.

So, my input is to omit hash_report_tunnel_types.
Will respond to Michael question in other thread.

