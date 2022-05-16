Return-Path: <virtio-comment-return-3032-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Mon, 16 May 2022 21:08:34 +0000
Message-ID: <PH0PR12MB5481DD681A0172899E09BC6CDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-3-mgurtovoy@nvidia.com>
 <20220515111056-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220515111056-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v5 2/7] Introduce admin command set
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Michael,

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, May 15, 2022 11:24 AM

[..]

> > +\subsection{VIRTIO ADMIN DEVICE CAPS ACCEPT
> command}\label{sec:Basic
> > +Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN
> > +DEVICE CAPS ACCEPT command}
> > +
> > +The VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT command is used by the
> driver to acknowledge those admin capabilities it understands and wishes =
to
> use.
>=20
>=20
> ok so we have a protocol here, kind of like feature negotiation. Please w=
rite
> its description.
> e.g. is it ok to change accepted caps? when? can device change its caps e=
tc
> etc etc.
>=20
> Avoiding this kind of spec work is exactly why me and jason keep telling =
you
> to consider just using features instead. Add a 64 bit admin features fiel=
d to
> the PCI transport and be done with it. CCW and MMIO already have feature
> selector so it's trivial to add feature bits.
>=20
As we begin to scale with the device, adding more and more registers like t=
his demands more on-device real estate to comply to the PCI standards.

And therefore, things are queried/accessed rare or occasionally, are better=
 accessed via a queue interface.

One can argue that admin VQ is proposed only for the mgmt. functions so hav=
ing this cfg register for PF is enough.

However, AQ may find some usage in the VF/SF themselves down the road.
Hence, keeping the cap exchange transport this way is more optimal.

Max has called out this AQ rationale in 4 or 5 points in the cover letter.

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

