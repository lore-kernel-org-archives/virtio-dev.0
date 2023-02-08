Return-Path: <virtio-comment-return-4057-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 8 Feb 2023 15:48:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230208154450-mutt-send-email-mst@kernel.org>
References: <3a1dbf6f-48ab-1eba-7f31-27e782a7ff12@linux.alibaba.com>
 <20230208091334-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B432271067C449CB7725DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094015-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4BEC03ACB994794AB51DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208094504-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FA44C4FF2EB6569BE66BDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208101323-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E095570E381AA498CDF1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54810BD4404DAAEE873BF3EEDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54810BD4404DAAEE873BF3EEDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: [virtio-comment] [PATCH] virtio-net: support per-queue
 coalescing moderation
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 08, 2023 at 07:23:12PM +0000, Parav Pandit wrote:
> You are right. Two commands are there.
> Regardless the ambiguity remains
> =E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81
> From: Parav Pandit
> Sent: Wednesday, February 8, 2023 8:57 PM
> To: Michael S. Tsirkin <mst@redhat.com>
> Cc: Heng Qi <hengqi@linux.alibaba.com>; Xuan Zhuo <xuanzhuo@linux.alibaba=
.com>;
> virtio-comment @ lists . oasis-open . org
> <virtio-comment@lists.oasis-open.org>; virtio-dev @ lists . oasis-open . =
org
> <virtio-dev@lists.oasis-open.org>; Jason Wang <jasowang@redhat.com>; Alva=
ro
> Karsz <alvaro.karsz@solid-run.com>
> Subject: RE: [virtio-comment] [PATCH] virtio-net: support per-queue coale=
scing
> moderation
> =20
>=20
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, February 8, 2023 10:20 AM
>=20
> [..]
>=20
> > >
> > > Most performant data path wouldn't implement and read the extra mode.
> > > It is always fw that is going to program same value, or per queue val=
ued or
> > disable value in each Q regardless whichever way we craft the CVQ cmd.
> > >
> > > The sequence that bothers me is below.
> > > 1. driver set global params
> > > 2. few minutes later, now driver set param for Q=3D1
> > >
> > > On this command, a device need to decide:
> > > Should Q =3D 2 to N
> > > (a) either work with previous globals, or
> > > (b) because per Q was set for one queue, they rest of the queues impl=
icitly
> > disable it.
> > >
> > > If it is (b),
> > > When a command on Q object =3D1 is issued, it affects other Q objects=
. <-
> This I
> > want to avoid.
> > > A cmd that modifies the object, should only modify that object.
> > >
> > > If it is (a), it is mixed mode operation, which is ambiguous definiti=
on.
> > >
> > > A better semantic is to define such change at device level and no ext=
ra
> cost in
> > the data path.
> >
> > Ugh. Looks like I didn't explain it well, yet again :(.
> > Here is my proposal in pseudo-code:
> >
> >
> > if (cmd =3D=3D VQ_SET)
> >                vq[cmd.index].param =3D cmd.param;
> >
> > if (cmd =3D=3D TX_SET)
> >        for (i =3D 0; ++i; i < maxvqn / 2)
> >                vq[i * 2].param =3D cmd.param;
> >
> > if (cmd =3D=3D RX_SET)
> >        for (i =3D 0; ++i; i < maxvqn / 2)
> >                vq[i * 2 + 1].param =3D cmd.param;
> >
> >
> Currently we have cmd =3D GLOBAL_SET the code is:
>=20
>  if (cmd =3D=3D GLOBAL_SET)
>         for (i =3D 0; i < maxvqn; i++)
>                 vq[i].param =3D cmd.param;

exactly.

> >
> > there's nothing to decide at all. No modes. TX_SET and RX_SET affect ha=
lf
> vqs,
> > VQ_SET affects one vq.
> >
> I explained above that, when cmd=3DGLOBAL_SET and after that if driver is=
sues cmd
> =3DVQ_SET, at that point, the device is in partial mode.
> One VQ is running with its own param, and rest are in global mode.


Because there's no "global mode" - it is always per queue and each queue
uses a set of parameters, that is all. No ambiguity. You can quickly set
them all with a special command, or you can set them one by one.

For example consider a driver that loops over all vqs
and does RX_SET(0). Are we in global mode, per queue mode or disabled
mode? The questions is pointless is it not?

--=20
MST


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

