Return-Path: <virtio-comment-return-4353-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Fri, 17 Feb 2023 16:12:34 +0000
Message-ID: <PH0PR12MB54815528B92662843B750D3ADCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
 <20230216111552-mutt-send-email-mst@kernel.org>
 <20230217052404.GA114259@h68b04307.sqa.eu95>
 <20230217053039-mutt-send-email-mst@kernel.org>
 <CAJs=3_B7snyMbjfL3vaKKe3wfx2XomLeVzCiCPNxFpy_ZTbepA@mail.gmail.com>
 <20230217062539-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230217062539-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [virtio-dev] Re: [PATCH v3] virtio-net: support the virtqueue
 coalescing moderation
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, February 17, 2023 6:35 AM

> > We mention the device reset case, but nothing about VQ reset.
> >
> > I feel that no matter how we handle this, we break something.
> >
> > Having default coalescing values may collide with "Upon reset, a
> > device MUST initialize all coalescing parameters to 0."
>=20
> No this is after device reset.
>=20
> > We can say that VQ reset doesn't affect the "global parameters" and a
> > device reset does, but this collides with "Device Requirements:
> > Virtqueue Reset".
> >
Not really.
When the device resets, VQ objects are destroyed in the device.
So VQ's notifications parameters doesn't exists on device reset.

And so the same case with VQ reset.
When a VQ is reset (disabled), VQ's notifications configuration is removed =
in the device too.
Just like its desc ring and other addresses are invalid.

> > In fact, resetting coalescing values after vq reset may be derived
> > from "Upon reset, a device MUST initialize all coalescing parameters
> > to 0".
> > This is consistent with "Device Requirements: Virtqueue Reset".
> >
> > I can add in my patch some clarifications.
> >
> > This will break the linux virtio_net ethtool implementation a little,
> > we'll need to fix it.
>=20
> Not good. I feel we must come up with spec that is backwards compatible.
> Hmm, maybe this is why Parav kept talking about modes.
> I did not realize at the time, sorry Parav.
>=20
> I still feel modes are not the best way to describe things so I propose t=
his:
> - in addition to per vq parameters, device that supports global TX/RX
>   commands and ring reset maintains two sets of default parameters: for R=
X and
> TX
> - existing commands change default and change all enabled vqs
>   of the correct type (RX/TX) to the same value
> - vq reset changes a vq to the default
> - device reset changes defaults to 0 and changes all vqs to  0
>=20
> note how defaults are only used for ring reset.  is "vq reset parameter"
> a better name? I feel we will repeat "reset" too many times in a sentence=
 if we
> call it that though.
>=20
> So fundamentally the only change is with RING_RESET, then default is not
> always 0, it can be set by the global command.

True default is not zero when global are configured.
It is ok to report VQ parameters on GET command when globals are configured=
.

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

