Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v5 3/7] Introduce new destination type for admin commands
Date: Mon, 16 May 2022 21:21:11 +0000
Message-ID: <PH0PR12MB5481BB099226A96CF3DDD4D0DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-4-mgurtovoy@nvidia.com>
 <20220515110536-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220515110536-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, May 15, 2022 11:09 AM
>=20
> > ---
> >  admin.tex | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/admin.tex b/admin.tex
> > index 6725daa..f816c3b 100644
> > --- a/admin.tex
> > +++ b/admin.tex
> > @@ -11,11 +11,13 @@ \section{Administration command
> set}\label{sec:Basic Facilities of a Virtio Devi
> >          le16 command;
> >          /*
> >           * 0 - self
> > -         * 1 - 65535 are reserved
> > +         * 1 - other virtio device (identified by vdev_id) in the same=
 device
> group
> > +         * 2 - 65535 are reserved
> >           */
> >          le16 dst_type;
> > +        le64 vdev_id;
>=20
> Alignment problems. Proposal:
>=20
> vdev_id
> dst_type
> command

I remember that this has come up internal review as well.
Though it is certainly good to naturally align, I don't think we have align=
ment problem spec wise based on below snippet of the spec [1].
It was kind of counter intuitive to see vdev_id before seeing what the actu=
al command is.
That way current layout made more sense.

There was some internal version or external, do not recall, where vdev_id w=
as optional or was union.

But I think if we always going have vdev_id, it can be naturally aligned li=
ke your above proposal.

[1] "Structure Specifications
Many device and driver in-memory structure layouts are documented using the=
 C struct syntax. All structures
are assumed to be without additional padding. To stress this, cases where c=
ommon C compilers are known
to insert extra padding within structures are tagged using the GNU C __attr=
ibute__((packed)) syntax."

