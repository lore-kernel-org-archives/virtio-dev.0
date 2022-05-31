Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-comment] RE: [PATCH v5 2/7] Introduce admin command set
Date: Tue, 31 May 2022 20:39:24 +0000
Message-ID: <PH0PR12MB5481D968013490C396CD2944DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-3-mgurtovoy@nvidia.com>
 <20220515111056-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DD681A0172899E09BC6CDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220517074130-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220517074130-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, May 17, 2022 7:48 AM
>=20
> On Mon, May 16, 2022 at 09:08:34PM +0000, Parav Pandit wrote:
> > Hi Michael,
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Sunday, May 15, 2022 11:24 AM
> >
> > [..]
> >
> > > > +\subsection{VIRTIO ADMIN DEVICE CAPS ACCEPT
> > > command}\label{sec:Basic
> > > > +Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN
> > > > +DEVICE CAPS ACCEPT command}
> > > > +
> > > > +The VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT command is used by the
> > > driver to acknowledge those admin capabilities it understands and
> > > wishes to use.
> > >
> > >
> > > ok so we have a protocol here, kind of like feature negotiation.
> > > Please write its description.
> > > e.g. is it ok to change accepted caps? when? can device change its
> > > caps etc etc etc.
> > >
> > > Avoiding this kind of spec work is exactly why me and jason keep
> > > telling you to consider just using features instead. Add a 64 bit
> > > admin features field to the PCI transport and be done with it. CCW
> > > and MMIO already have feature selector so it's trivial to add feature=
 bits.
> > >
> > As we begin to scale with the device, adding more and more registers li=
ke
> this demands more on-device real estate to comply to the PCI standards.
> >
> > And therefore, things are queried/accessed rare or occasionally, are be=
tter
> accessed via a queue interface.
> >
> > One can argue that admin VQ is proposed only for the mgmt. functions so
> having this cfg register for PF is enough.
> >
> > However, AQ may find some usage in the VF/SF themselves down the
> road.
> > Hence, keeping the cap exchange transport this way is more optimal.
> >
> > Max has called out this AQ rationale in 4 or 5 points in the cover lett=
er.
>=20
> Hmm. It's kind of a generic claim though.=20
I am sorry for my way late response.

Not sure what you mean by generic claim.
If you mean generic for any PCI device, than yes, at scale such large regis=
ter scale doesn't work well.

> We never put devices on a diet
> trying to conserve registers.=20
> There is cost associated with this dance and that
> is driver boot time.
How much more time you anticipate by adding an additional queue which slows=
 down the boot time?
We don't see downtime increasing beyond in < 2 msec range.

And AQ is not used anyway until the actual AQ work is done.
With Q_RESET in place, driver won't even create the AQ during boot time any=
way.

>=20
> I also don't really understand how you can claim you need to save memory
> like this and at the same time blindly add a more or less "just in case" =
misc
> config in the config space.
> So, not pretty.
Adding to config space was really your suggestion. :)

There are multiple points described in cover letter that I prefer not to re=
peat here. It was not only memory.

Also, capabilities and fields around that are expected to grow more than q_=
index.
So not a right comparison.

>=20
> And as I said, you will need much more spec work to reach the level to wh=
ich
> features are specified - and note we are not yet happy with how features =
are
Can you be specific of the work that you are expecting in this v5 version?

> specified either! So it's a moving target.
>=20
> Maybe put this in features for now, and leave the whole capability thing =
for
> another day?
>=20
> --
> MST

It appears a narrow view to do temporary work on putting in features bits t=
hat doesn't scale.

