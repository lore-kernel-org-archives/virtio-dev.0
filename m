Return-Path: <virtio-comment-return-4050-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 8 Feb 2023 15:27:36 +0000
Message-ID: <PH0PR12MB5481E095570E381AA498CDF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB54810448CDA1F3A21B283AF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1675823090.089496-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481EF640830788A2B6D62D2DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3a1dbf6f-48ab-1eba-7f31-27e782a7ff12@linux.alibaba.com>
 <20230208091334-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B432271067C449CB7725DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094015-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4BEC03ACB994794AB51DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094504-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FA44C4FF2EB6569BE66BDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208101323-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230208101323-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: RE: [virtio-comment] [PATCH] virtio-net: support per-queue coalescing
 moderation
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open .
 org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, February 8, 2023 10:20 AM

[..]

> >
> > Most performant data path wouldn't implement and read the extra mode.
> > It is always fw that is going to program same value, or per queue value=
d or
> disable value in each Q regardless whichever way we craft the CVQ cmd.
> >
> > The sequence that bothers me is below.
> > 1. driver set global params
> > 2. few minutes later, now driver set param for Q=3D1
> >
> > On this command, a device need to decide:
> > Should Q =3D 2 to N
> > (a) either work with previous globals, or
> > (b) because per Q was set for one queue, they rest of the queues implic=
itly
> disable it.
> >
> > If it is (b),
> > When a command on Q object =3D1 is issued, it affects other Q objects. =
<- This I
> want to avoid.
> > A cmd that modifies the object, should only modify that object.
> >
> > If it is (a), it is mixed mode operation, which is ambiguous definition=
.
> >
> > A better semantic is to define such change at device level and no extra=
 cost in
> the data path.
>=20
> Ugh. Looks like I didn't explain it well, yet again :(.
> Here is my proposal in pseudo-code:
>=20
>=20
> if (cmd =3D=3D VQ_SET)
> =09=09vq[cmd.index].param =3D cmd.param;
>=20
> if (cmd =3D=3D TX_SET)
> =09for (i =3D 0; ++i; i < maxvqn / 2)
> =09=09vq[i * 2].param =3D cmd.param;
>=20
> if (cmd =3D=3D RX_SET)
> =09for (i =3D 0; ++i; i < maxvqn / 2)
> =09=09vq[i * 2 + 1].param =3D cmd.param;
>=20
>
Currently we have cmd =3D GLOBAL_SET the code is:

 if (cmd =3D=3D GLOBAL_SET)
=09for (i =3D 0; i < maxvqn; i++)
=09=09vq[i].param =3D cmd.param;
=20
>=20
> there's nothing to decide at all. No modes. TX_SET and RX_SET affect half=
 vqs,
> VQ_SET affects one vq.
>
I explained above that, when cmd=3DGLOBAL_SET and after that if driver issu=
es cmd=3DVQ_SET, at that point, the device is in partial mode.
One VQ is running with its own param, and rest are in global mode.

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

