Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH 1/5] Add virtio Admin Virtqueue specification
Date: Tue, 18 Jan 2022 07:57:36 +0000
Message-ID: <PH0PR12MB54818359B93019B6D1E78B39DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-2-mgurtovoy@nvidia.com>
 <20220113124137-mutt-send-email-mst@kernel.org>
 <4946a0fe-70f0-43cc-6730-f8ab0f3d8687@nvidia.com>
 <20220117160951-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819C1FD23F3C5E3FCE9057DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011334-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220118011334-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 18, 2022 11:47 AM
>=20
> On Tue, Jan 18, 2022 at 03:22:27AM +0000, Parav Pandit wrote:
> > > I don't recall discussion about UUID so I can't really say what I thi=
nk about
> that.
> > > Do we need a UUID? I'm not sure I understand why.
> > > It can't hurt to abstract things a bit so it's not all tied to
> > > PFs/VFs since we know we'll want subfunctions down the road, too, if =
that
> is what you mean.
> > >
> > I still didn't find any reason in the discussion to find out why groupi=
ng device
> is needed.
>=20
> VFs are already grouped with their PF. However we should spell this out a=
s the
> motivation for the admin queue.
>
Ok. so for now, we are not introducing any explicitly grouping concept.
In v2, will revise to have description as,

PCI VFs of a parent PCI PF device are grouped together. These devices can b=
e optionally managed by its parent PCI PF.
=20
> > Current AQ proposal implicitly indicates that VFs of a PF are managed b=
y its
> parent PF.
> > And for some reason this work by one of the VF, this role assignment
> > can be certainly a new command on AQ as group command or some other
> > command.
>=20
> > >
> > >
> > > > >
> > > > > Following this idea, all commands would then gain fields for
> > > > > addressing one device from another.
> > > > >
> > > > > Not everything maps well to a queue. E.g. it would be great to
> > > > > have list of available commands in memory.
> > > >
> > > > I'm not sure I agree. Why can't it map to a queue ?
> > >
> > > You can map it to a queue, yes. But something static and read only
> > > such as list of commands maps well to config space. And it's not
> > > controlling one device from another, so does not really seem to belon=
g in
> the admin queue.
> > >
> > Aq serves the writing device config too in patch-5 in this patchset.
>=20
> List of available admin commands does not need to be written.
>
It is not written into the aq commands.
It is part of the feature bit VIRTIO_F_ADMIN_PCI_VIRT_MANAGER indicating a =
given functionality supported or not in patch-5.
And structure like, virtio_admin_pci_virt_mgmt_attr_identify_result can pot=
entially grow and storing those fields on on-chip resource is less efficien=
t.
Hence, they are shared via AQ.

=20
> > > >
> > > > > Figuring out max vectors also looks like a good example for
> > > > > memory and not through a command.
> > > >
> > > > Any explanation why is it looks good ? or better ?
> > >
> > > why is memory easier to operate than a VQ?
> > > It's much simpler and so less error prone.  you can have multiple
> > > actors read such a field at the same time without races, so e.g.
> > > there could be a sysfs attribute that reads from device on each
> > > access, and not special error handling is needed.
> > >
> > Writing fields is inherent part of the aq without getting blocked on pr=
evious
> writes.
> > I see you acked that AQ is fine in cover letter patch as below, so we a=
re sync
> on the motivation now.
> > Yes, will update the commit log as you suggested.
> >
> >  " if the answer is "commands A,B,C do not fit in config space, we plac=
ed
> commands D,E in a VQ for consistency"
> > then that is an ok answer, but it's something to be mentioned in the co=
mmit
> log"

