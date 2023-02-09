Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] Re: [virtio-comment] Re: [PATCH v7] virtio-net:
 support inner header hash
Date: Thu, 9 Feb 2023 05:34:06 +0000
Message-ID: <PH0PR12MB5481A67E9B1362BB18CEDDC4DCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
 <20230111042905-mutt-send-email-mst@kernel.org>
 <20230116080106.GA114763@h68b04307.sqa.eu95>
 <f7e5a6c8-ad4c-c60c-2d9e-cd64f6fdd90e@redhat.com>
 <20230131052834.GA34480@h68b04307.sqa.eu95>
 <5bee268d-a0dc-d649-4174-7b211a49e2f0@linux.alibaba.com>
 <PH0PR12MB5481CA073B96CC2828F8AA15DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <52ddcc45-70e0-a670-9ac2-215e84eb12ba@linux.alibaba.com>
 <PH0PR12MB5481F054A6BA5C10831F0AA8DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <98ffa453-7a76-9afc-1861-8c46efef4705@linux.alibaba.com>
 <PH0PR12MB54817A1F42DAB9C24D0B73B2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eea0ca26-99c7-c5d7-a0e3-c6a37951f544@linux.alibaba.com>
In-Reply-To: <eea0ca26-99c7-c5d7-a0e3-c6a37951f544@linux.alibaba.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Thursday, February 9, 2023 12:21 AM

> >>>> Thanks for your reply.
> >>> I had one last question. Why do we need to inform the
> >> hash_report_tunnel_type of the outer header in the virtio_net_hdr?
> >>> Is this for debug? Or is there a use case that will process this valu=
e?
> >> The driver may use it to do some statistical information, or do some
> >> rx classification based on the rx hash, and we'd better not hide
> >> information from the driver.
> >>
> > Statistical information is better gathered via stats, instead of adding=
 such code
> in driver data path.
>=20
> A cautionary note : the source of hash_report_tunnel comes from the
> discussion here
> https://lists.oasis-open.org/archives/virtio-dev/202211/msg00063.html

> If I understand correctly, if virtio-net-hdr also has hash_report_tunnel,=
 how
> does the driver do statistics?
I am asking to avoid having hash_report_tunnel in virtio_net_hdr if it is o=
nly for the statistics purpose.
If it has more use than just statistics, I like to understand its use in rx=
 packet processing flow, if there is any and to describe in commit log too.

Below [1] says about driver doing some rx classification. It is unclear on =
inner or outer.
The response is not very clear to me, about how this field is useful.

[1] https://lists.oasis-open.org/archives/virtio-dev/202211/msg00063.html

If driver needs to know the statistics of it, it can query them from the de=
vice by introducing statistics cmd.

