Return-Path: <virtio-dev-return-10797-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 8 Feb 2023 13:52:52 +0000
Message-ID: <PH0PR12MB54816D252CCF262048F15F42DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <20230207090019-mutt-send-email-mst@kernel.org>
 <1675820731.3018508-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54810448CDA1F3A21B283AF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1675823090.089496-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481EF640830788A2B6D62D2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208050439-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230208050439-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-dev] RE: RE: [virtio-comment] [PATCH] virtio-net: support per-queue
 coalescing moderation
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists .
 oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists
 . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, February 8, 2023 5:07 AM
> >
> > 2. Have a mode cmd,
> > Mode =3D (a) per device or (b) per VQ (c) disable After the mode is set=
,
> > driver can set per device or per VQ.
>=20
> I like 2 better.  I also think a and b are enough. c can be achieved thro=
ugh a.
>
Yep. (c) is just to indicate that its disabled via the mode in a command.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

