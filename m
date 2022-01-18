Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH 1/5] Add virtio Admin Virtqueue specification
Date: Tue, 18 Jan 2022 03:22:27 +0000
Message-ID: <PH0PR12MB54819C1FD23F3C5E3FCE9057DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-2-mgurtovoy@nvidia.com>
 <20220113124137-mutt-send-email-mst@kernel.org>
 <4946a0fe-70f0-43cc-6730-f8ab0f3d8687@nvidia.com>
 <20220117160951-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220117160951-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, January 18, 2022 3:01 AM

> On Mon, Jan 17, 2022 at 11:56:09AM +0200, Max Gurtovoy wrote:
> > > > +Admin virtqueue is used to send administrative commands to
> > > > +manipulate various features of the device which would not easily
> > > > +map into the configuration space.
> > > IMHO this is too vague to be useful. E.g. I don't really see why
> > > would not commands specified in the next patch map to config space.
> >
> > Well I took this sentence from the current spec :)
>=20
> Well in current spec it applies to things like MAC address filtering, whi=
ch does
> not easily map into config space because number of MACs varies.

It doesn't well map to the config space for very primary reason that that i=
t is read+write access that driver should be able to in async manner.
Yes, we will improve this part of the commit log to described that doing vi=
a AQ enables driver to not get blocked by previous outstanding command.

>=20
>=20
> >
> > >
> > >
> > > We had an off-list meeting where I proposed addressing one device
> > > from another or grouping multiple devices as a more specific scope.
> > > That would be one way to address this.
> >
> > Are you suggestion a creation of a virtio subsystem or a virtio group
> > definition ?
> >
> > Devices will be part of this subsystem: one primary/manager device and
> > many secondary/managed devices ?
> >
> > Each subsystem will have a unique UUID and each device will have a
> > unique vdev_id within this subsystem.
> >
> > If this is the direction, I can prepare something..
>=20
> I was merely saying that what is special about admin queue is that it all=
ows
> controlling one device from another within some group.
> Or maybe that it allows grouping multiple devices.
> *Not* that these are things that do not map to config space.
>=20
> Let me give you another example, imagine that you want to handle pagefaul=
ts
> from device.  Clearly a generic thing that does not map to config space. =
 It
> could be a good candidate for the admin queue, however it would require t=
hat
> lots of buffers are pre-added to the queue. So it looks like it will beed=
 another
> distinct fault queue. =20
Right page fault queue is async queue located in hv and/or guest more like =
net device rq.
AQ is serving request-response queue.
Page fault queue likely needed multiple to have any reasonable bw, per cpu =
is one option.

> Further it is possible that you want to handle faults
> within guest, by the driver. In that case you do not want it in the admin=
 queue
> since that is controlled by hypervisor, you want it in a separate queue
> controlled by driver.
>=20
Yes. so it is better to not merge page fault queue with admin queue.

>=20
> I don't recall discussion about UUID so I can't really say what I think a=
bout that.
> Do we need a UUID? I'm not sure I understand why.
> It can't hurt to abstract things a bit so it's not all tied to PFs/VFs si=
nce we know
> we'll want subfunctions down the road, too, if that is what you mean.
>
I still didn't find any reason in the discussion to find out why grouping d=
evice is needed.
Current AQ proposal implicitly indicates that VFs of a PF are managed by it=
s parent PF.
And for some reason this work by one of the VF, this role assignment can be=
 certainly a new command on AQ as group command or some other command.
=20
>=20
>=20
> > >
> > > Following this idea, all commands would then gain fields for
> > > addressing one device from another.
> > >
> > > Not everything maps well to a queue. E.g. it would be great to have
> > > list of available commands in memory.
> >
> > I'm not sure I agree. Why can't it map to a queue ?
>=20
> You can map it to a queue, yes. But something static and read only such a=
s list
> of commands maps well to config space. And it's not controlling one devic=
e
> from another, so does not really seem to belong in the admin queue.
>=20
Aq serves the writing device config too in patch-5 in this patchset.

> >
> > > Figuring out max vectors also looks like a good example for memory
> > > and not through a command.
> >
> > Any explanation why is it looks good ? or better ?
>=20
> why is memory easier to operate than a VQ?
> It's much simpler and so less error prone.  you can have multiple actors =
read
> such a field at the same time without races, so e.g.  there could be a sy=
sfs
> attribute that reads from device on each access, and not special error ha=
ndling
> is needed.
>
Writing fields is inherent part of the aq without getting blocked on previo=
us writes.
I see you acked that AQ is fine in cover letter patch as below, so we are s=
ync on the motivation now.
Yes, will update the commit log as you suggested.

 " if the answer is "commands A,B,C do not fit in config space, we placed c=
ommands D,E in a VQ for consistency"
then that is an ok answer, but it's something to be mentioned in the commit=
 log"

