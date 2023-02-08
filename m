Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] Re: [virtio-comment] Re: [PATCH v7] virtio-net:
 support inner header hash
Date: Wed, 8 Feb 2023 05:18:32 +0000
Message-ID: <PH0PR12MB5481F054A6BA5C10831F0AA8DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
 <20230111042905-mutt-send-email-mst@kernel.org>
 <20230116080106.GA114763@h68b04307.sqa.eu95>
 <f7e5a6c8-ad4c-c60c-2d9e-cd64f6fdd90e@redhat.com>
 <20230131052834.GA34480@h68b04307.sqa.eu95>
 <5bee268d-a0dc-d649-4174-7b211a49e2f0@linux.alibaba.com>
 <PH0PR12MB5481CA073B96CC2828F8AA15DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <52ddcc45-70e0-a670-9ac2-215e84eb12ba@linux.alibaba.com>
In-Reply-To: <52ddcc45-70e0-a670-9ac2-215e84eb12ba@linux.alibaba.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Tuesday, February 7, 2023 10:25 PM

[..]
> >>
> >> Do you think we need both hash_types and hash_tunnel_types?
> > In struct virtio_net_config we need two fields.
> > a. supported_hash_types (already exists) b. supported_hash_tunnel_type
> > -> bitmap indicating for which outer headers, inner hash calculation is
> supported.
>=20
> Thanks for the suggestion, we seem to have reached an agreement.
>=20
> >
> > In struct virtio_net_hdr we need two fields.
> > a. hash_report (already exists)
> > b. hash_tunnel_type 8 bits -> absolute value indicating which outer hea=
der
> exists when inner header hash calculated.
> > You already have it in your patch named as hash_report_tunnel.
> > May be better to name as hash_report_tunnel_type to make it clearer tha=
t its
> type.
>=20
> Sure.
>=20
> Thanks for your reply.

I had one last question. Why do we need to inform the hash_report_tunnel_ty=
pe of the outer header in the virtio_net_hdr?
Is this for debug? Or is there a use case that will process this value?

