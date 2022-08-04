Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20220731154354.15698-1-mgurtovoy@nvidia.com> <20220731154354.15698-2-mgurtovoy@nvidia.com>
 <20220802092302-mutt-send-email-mst@kernel.org> <CACGkMEtgghEpPk=eE4z=5QiGTW42768i4729KR0-+ThHaQE3bA@mail.gmail.com>
 <20220803020125-mutt-send-email-mst@kernel.org> <6d17a2f0-649c-2125-c108-96aedba19c5f@redhat.com>
 <20220803081918-mutt-send-email-mst@kernel.org> <CACGkMEueh1-0Awf5RVNFjsw0RQFVqmh7FSoKS2VkTnv5fcq5Rg@mail.gmail.com>
 <20220804014448-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220804014448-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 4 Aug 2022 15:17:15 +0800
Message-ID: <CACGkMEsdZt9=v5pVizwTTzpsRoZy6bHMQKxp3GbGKcVp18SVkg@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] Introduce device group
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-comment@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Ariel Adam <aadam@redhat.com>, virtio@lists.oasis-open.org, eperezma <eperezma@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Aug 4, 2022 at 2:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Aug 04, 2022 at 10:08:30AM +0800, Jason Wang wrote:
> > On Wed, Aug 3, 2022 at 8:33 PM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> > >
> > > On Wed, Aug 03, 2022 at 04:04:50PM +0800, Jason Wang wrote:
> > > >
> > > > =E5=9C=A8 2022/8/3 14:10, Michael S. Tsirkin =E5=86=99=E9=81=93:
> > > > > On Wed, Aug 03, 2022 at 12:44:38PM +0800, Jason Wang wrote:
> > > > > > On Tue, Aug 2, 2022 at 9:42 PM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > > > > > > I feel some of my latest review opened some questions that I =
don't have
> > > > > > > good answers for and might have felt a bit rambling.
> > > > > > > So to focus the discussion:
> > > > > > >
> > > > > > > On Sun, Jul 31, 2022 at 06:43:50PM +0300, Max Gurtovoy wrote:
> > > > > > > > +A device can be a member of one or more device groups.
> > > > > > > Presumably this is so we can e.g. create subfunctions inside =
a VF.
> > > > > > Then VF should have its own transport virtqueue. And subfunctio=
ns need
> > > > > > to be created there. If we don't all thing in PF, we may end up=
 with
> > > > > > nesting issue when assign VF to the guest.
> > > > > > > A VF now is a member of a SRIOV and SIOV type groups and we
> > > > > > > can use type to distinguish between these.
> > > > > > >
> > > > > > > We should probably be explicit that each of these groups has =
to
> > > > > > > have a distinct group type then.
> > > > > > >
> > > > > > > And this raises the question: different types have different
> > > > > > > capabilities. So let's say admin queue is used to both
> > > > > > > control features for SRIOV VFs and to create SIOV SFs.
> > > > > > I don't get how the admin queue can be used to control VF featu=
res
> > > > > > considering VF has its capabilities. (SR-IOV lacks the ability =
to
> > > > > > provision a single VF).
> > > > > Well look at latest proposal, last patch controls VF features fro=
m PF.
> > > >
> > > >
> > > > Yes, so it works like previous MSI-X allocation which needs some ca=
re to
> > > > prevent managed device from being probed before assigning features.
> > > >
> > > > This is technically possible, but I'm not sure it is a good design.=
 For
> > > > example, what happens if the management change the feature while th=
e a
> > > > driver is using the managed device.
> > >
> > > I think this should be prohibited in the spec.
> >
> > Yes, but implementation wise, this needs to be considered.
>
> Just check the DRIVER status bit, it's not difficult.

But it would be a race? There could be an ongining probing for this
device, the code just didn't reach the line that set the DRIVER.

>
> > >
> > > It might be a good idea to have explicit commands that allow driver t=
o
> > > attach.
> > >
> > > For example the following might work for both VFs and SFs:
> > >
> > >
> > > INIT
> > >
> > > configure
> > >
> > > ENABLE <- driver can attach now, configure is blocked
> > >
> > >
> > > --- device can be used ---
> > >
> > > Note: some configs might be editable while device is in use.
> > > E.g. enabling/disabling softmac dynamically.
> > >
> > > --- device can be used ---
> > >
> > > DISABLE -> takes control from driver. we can have a flag telling
> > >            whether we want to be graceful about it and fail
> > >            if driver is still attached or not
> > >
> > > configure - if we want to attach to another VM
> > >
> > > CLEANUP - release resources and forget config
> >
> > Yes, but for SF it's not a must.
> >
> > And should we add these states in the current state machine? If yes,
> > it might complicate the migration compatibility.
>
> Noidea what does it have to do with migration.

For example, in src, we support the above new status but not in the destina=
tion.

>
> > >
> > >
> > >
> > > >
> > > > >
> > > > > > > I guess we'll have a feature bit to say "command to create
> > > > > > > SIOV SFs is supported" but how do we say that this command
> > > > > > > is only supported for VFs not SFs?
> > > > > > I think we should first answer if having VF and SF to be dealt =
with a
> > > > > > single type of virtqueue is a good idea. They have something in=
 common
> > > > > > but they distinguish each other:
> > > > > >
> > > > > > - SF requires per virtual device lifecycle management
> > > > > > - SF requires a transport other than PCI
> > > > > > - SF requires more mediation in the software layer for presenti=
ng a
> > > > > > virtual device
> > > > > >
> > > > > > Using a single type of virtqueue may end up with complex design=
.
> > > > > > Having a dedicated queue for SF might be a better choice.
> > > > > And dedicated feature bits for commands thereof?
> > > >
> > > >
> > > > Only needed if we're using a single type of the queue.
> > >
> > >
> > > Imagine a command only allowed for SFs not VFs. Does
> > > the PF supporting SFs and VFs have the corresponding
> > > feature bit or not?
> >
> > I wonder if we can do:
> >
> > 1) having two type of virtqueues
> > 2) VFs goes to VF admin queue
> > 3) SFs goes to SF transport queue
> >
> > So if PF supports both SFs and VFs, it should have at least two feature=
 bits.
>
> This does not answer the question.  Let's say we have command X. We
> would normally have feature COMMAND_X.  How do we communicate which of
> the VQs support which command?

It should work like the existing virtqueue? E.g for virtio-net, ctrl
vq only accepts commands VIRTIO_NET_CTRL_VQ_XXX. So did for the admin
vq and transport vq.

>
>
> > >
> > > >
> > > > >    For example, I imagine
> > > > > we could have commands to control the MAC of the group member. Th=
at is
> > > > > the same for SF and VF, yes? How do we avoid duplication for that=
?
> > > >
> > > >
> > > > In the transport vq, all configs (include mtu and features) were sp=
ecified
> > > > during the device creating command. It is not allowed to change mac
> > > > afterwards. (If we need, the SF needs to be destroyed and created a=
gain with
> > > > different configs).
> > >
> > > It was just an example. Are you implying SFs and VFs have completely
> > > different needs with no overlap then?
> >
> > There indeed overlaps, e.g the provisions of the configs. Other than
> > these, there should be no other.
>
> Yes provision but my point is that it is not just the config space.
> Here's a better example of a resource which is not in device config: MAC
> table size.  And one of the issues is that this is also something that ca=
n be
> changed transparently as device is running.

It looks to me spec doesn't say it can be changed in this way.

>  So we could have a separate
> command to provision it both for admin queue and for transport vq, and a
> separate command to change it later, but it seems inelegant.

For MAC table size, as spec suggests, it probably requires a mediation
layer in the software: switching to use alluni when we run out of mac
tables. Having to provision mac table size seems a burden for the mgmt
layer since it is not something that can be seen by the driver.

So for transport vq, the idea is to provision all config in one
command with the provision of the SF itself. So if the config
provision could be done for SR-IOV, we may think of a way to unify
them. It could be something like

1) define the common structure
2) map them into different command

This might be useful for other DMA/CMA based transport in the future.
This is similar to other device facilities: e.g the device status
could be accessed in various transport dependent ways.

>
>
> > The idea of the transport virtqueue
> > is mainly for having a new transport. This is different from what I
> > understand for the admin virtqueue.
>
> Hmm my point was that a transport, or a bus, is in fact a way to address
> a group of devices.  Which is exactly what admin queue does.

Addressing for VF has been done via BDF (transport) for SR-IOV. My
understanding for admin virtqueue so far is that it is not aimed to be
a transport but a way to have an out of band management interface.

>
> > > It seems weird since
> > > fundamentally they look the same at a lot of levels.
> >
> > Yes but only from the view of the functionality.
>
> The concept of a device addressing other devices is what unifies them.
> The patch dealing with device groups was developed in response to this.

My understanding is that there are one major differences In the case
of transport vq proposal, the basic device facility (device
configuration like status, virtqueue, features etc) is carried via
virtual queue but in the admin virtqueue they are still expected to be
accessed via BAR.

>
> > >
> > >
> > >
> > > >
> > > > >
> > > > > > > Do we just make features list a superset of what is supported=
 and simply
> > > > > > > say in the spec which commands are legal with which group typ=
es?
> > > > > > >
> > > > > > >
> > > > > > > Jason Cornelia what do you think?
> > > > > > It looks to me it would be much more simpler if we use separate=
d
> > > > > > virtqueues for SRIOV and SIOV.
> > > > > >
> > > > > > Thanks
> > > > > Then is it still helpful that we have the generic group type conc=
ept?
> > > >
> > > >
> > > > Not sure, I wonder if the implicit group can do here. E.g _F_SRIOV =
with
> > > > _F_ADMIN_VQ menast SR-IOV group.
> > >
> > >
> > > I don't see how. PF can have SFs right?
> >
> > Yes, but technically, we have capabilities then we know which
> > virtqueue is doing PF and which is doing SF.
>
> What are capabilities? An older proposal from nvidia had them but
> it was dropped. Do you propose bringing them back?

Just to be clear, I meant we can develop any necessary facilities for
the driver to know:

virtqueue X: admin virtqueue or not
virtqueue Y: transport virtqueue or not
virtqueue Z: live migration virtqueue or not

etc.

>
> > >
> > >
> > > >
> > > > > I was hoping it will work so the same command can be used for VFs
> > > > > and SFs.
> > > >
> > > >
> > > > Yes, but the transport vq ties the mac and other configuration with=
 the
> > > > device creating. Not sure we can easily do the same for SR-IOV.
> > > >
> > > > Thanks
> > >
> > > We can if we either split SF out or artificially add creation to VFs.
> >
> > I agree. But the artificial creation for VF requires more work.
>
> Well we need to specify what can be changed when otherwise it's
> a free for all, drivers will go crazy changing random fields
> at random time and then we need to support this mess.
> Just look at featuresm config fields and FEATURES_OK mess -
> the spec said don't do it but implementations did not bother
> checking and now we wasted man months already trying to fix it properly.

Yes, so what I meant is that. Consider the complexity, If we provision
all configs along with the SF itself, we don't need to bother with
artificial creation.

>
> > >
> > >
> > >
> > > But I expect more command will be exactly the same. Live migration?
> >
> > My understanding is that the live migration is a basic facility like
> > device status. It means it needs to be transport independent.
> >
> > That means the function could be accessed via PCI capability/MMIO and
> > other transport so it does not look like an issue specific to admin
> > virtqueue or transport virtqueue. We can define a common data
> > structure then it can be mapped to the same or different commands in
> > each type of transport(or virtqueue)?
> >
> > Thanks
> >
> > Thanks
>
> I think I now understand that you would add capability to have admin
> queue inside the vq transport. It does address some issues though not
> all. I will need to ponder this.

I prefer to do them in parallel if it's possible. The only overlap is
the provisioning, but we can think of a way to reduce the duplication
of commands.

Thanks

>
>
> > >
> > >
> > >
> > > >
> > > > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > > > +\item Self type (group identifier =3D 0) - this group has =
only one device in the group. Each virtio device is a member of at least on=
e device group, the Self type group.
> > > > > > > Presumably, this is here so we can send commands that refer t=
o the
> > > > > > > device itself as opposed to a group member (e.g. to
> > > > > > > PF as opposed to VF). Is that right?
> > > > > > >
> > > > > > > It's handy but again the problem here is, this refers to
> > > > > > > device as part of which group? Let's just drop this type?
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > MST
> > > > > > >
> > >
>

