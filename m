Return-Path: <virtio-comment-return-4072-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Thu, 9 Feb 2023 00:06:40 +0000
Message-ID: <PH0PR12MB5481161B6D8A61BA86554252DCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1675823090.089496-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481EF640830788A2B6D62D2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3a1dbf6f-48ab-1eba-7f31-27e782a7ff12@linux.alibaba.com>
 <20230208091334-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B432271067C449CB7725DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094015-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4BEC03ACB994794AB51DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094504-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FA44C4FF2EB6569BE66BDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D_Of4kMOr9+YobXHptUYUcP4UjqT8fM+zbvAdZ1uc_5A@mail.gmail.com>
 <20230208154819-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810798C047E97434BCB9B4DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_D9fbXN6Sonn9jnOoVLd0P+HcxWB7TxRqP4CBqot4eKjg@mail.gmail.com>
 <PH0PR12MB5481FBD525D714CB5B1D3ABBDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_DFp=BNObtzB=x0Gprwcr-tCS2zEeJaRogZL-GdbUvP6Q@mail.gmail.com>
In-Reply-To: <CAJs=3_DFp=BNObtzB=x0Gprwcr-tCS2zEeJaRogZL-GdbUvP6Q@mail.gmail.com>
MIME-Version: 1.0
Subject: RE: [virtio-comment] [PATCH] virtio-net: support per-queue coalescing
 moderation
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open
 . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists .
 oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Alvaro Karsz <alvaro.karsz@solid-run.com>
> Sent: Wednesday, February 8, 2023 5:36 PM
>=20
> > > From: Alvaro Karsz <alvaro.karsz@solid-run.com>
> > > Sent: Wednesday, February 8, 2023 4:56 PM
> >
> > > > Alvaro,
> > > > Do you know if any software used it? Can you get some real data?
> > >
> > > I implemented this feature in our DPU, so at least 1 vendor is using
> > > this feature
> >
> > But which software (virtio net driver) in which OS is using this?
>=20
> Sorry, I'm not sure I understand your question.
>=20
> The feature is implemented in the linux kernel

Ok. so, there is sw using it. This global feature bit stays.

> > How does a driver disable all queues or reset all queues? -> One by one=
.
> > So if user want to change for all TXQ, sw can do it one by one by itera=
ting TXQ
> vqns.
>=20
> Yes, but resetting the queues doesn't require a control command.
> If a server has 64K queues, and a user wants to set all coalescing parame=
ters to
> X (maybe with ethtool), it will generate 64K control commands..
He he. What an example.
64K control cmds. 64 register writes and poll. All same from sw pov.

The conclusion is there is sw using the feature bit defined in spec 1.3. Di=
scussion ends.
I wish you pointed to this sw way earlier in the discussion.

Please proceed with the new feature bit and new command.



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

