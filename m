Return-Path: <virtio-comment-return-4354-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Fri, 17 Feb 2023 16:24:11 +0000
Message-ID: <PH0PR12MB5481F2A332FF5765EF9F8FFFDCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230208090836.74355-1-hengqi@linux.alibaba.com>
 <20230213171113-mutt-send-email-mst@kernel.org>
 <b7fb5b84-2939-3d4d-b12f-998ce238ea21@linux.alibaba.com>
 <20230216064509-mutt-send-email-mst@kernel.org>
 <fe901a5a-bd78-640a-bcb9-8b13d309a680@linux.alibaba.com>
 <20230217092215-mutt-send-email-mst@kernel.org>
 <20230217153614.GA117623@h68b04307.sqa.eu95>
In-Reply-To: <20230217153614.GA117623@h68b04307.sqa.eu95>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH v8]
 virtio-net: support inner header hash
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> O=
n
> Behalf Of Heng Qi

[..]

> We assume that hash_report_tunnel_types is still present in the next vers=
ion,

I am little lost.
I thought we all agreed that reporting just the tunnel type in data path pa=
th virtio_net_hdr is not useful to sw.
And hence we should omit in the virtio_net_hdr.

Did I miss the motivation to add it back?
If not, probably it is better to review and discuss v9 without it, which wi=
ll be easier to discuss.

> but it only exists in virtio net hdr and should be populated by the devic=
e after
> the hash calculation. hash_tunnel_types already controls whether the devi=
ce
> computes internal header hashes.
>=20
> > > I don't really follow this, hash_report_tunnel_type is better off
> > > keeping it "report" literally.
> >
> >
> > Talking about VIRTIO_NET_F_HASH_TUNNEL here. Not
> > hash_report_tunnel_type.

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

