Return-Path: virtio-dev-return-6903-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D1BB9848B9
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Mar 2020 15:08:39 +0000 (UTC)
Date: Mon, 9 Mar 2020 15:08:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20200309150831.GF3088@work-vm>
References: <874kv15o4q.fsf@linaro.org>
 <20200306194058.GN3033@work-vm>
 <871rq55j12.fsf@linaro.org>
 <20200309104440.GE3088@work-vm>
 <87a74pk9rc.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87a74pk9rc.fsf@linaro.org>
Subject: Re: [virtio-dev] Backend libraries for VirtIO device emulation
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

* Alex Benn=E9e (alex.bennee@linaro.org) wrote:
>=20
> Dr. David Alan Gilbert <dgilbert@redhat.com> writes:
>=20
> > * Alex Benn=E9e (alex.bennee@linaro.org) wrote:
> >>=20
> >> Dr. David Alan Gilbert <dgilbert@redhat.com> writes:
> >>=20
> >> > * Alex Benn=E9e (alex.bennee@linaro.org) wrote:
> >> >> Hi,
> >> >>=20
> >> >> So the context of my question is what sort of common software layer=
 is
> >> >> required to implement a virtio backend entirely in userspace?
> >> >>=20
> >> >> Currently most virtio backends are embedded directly in various VMM=
s
> >> >> which emulate a number of devices as well as deal with handling dev=
ices
> >> >> that are vhost aware and link with the host kernel. However there s=
eems
> >> >> to be a growing interest in having backends implemented in separate
> >> >> processes, potentially even hosted in other guest VMs.
> >> >>=20
> >> >> As far as I can tell there is a lot of duplicated effort in handlin=
g the
> >> >> low level navigation of virt queues and buffers. QEMU has code in
> >> >> hw/virtio as well as contrib/libvhost-user which is used by the rec=
ent
> >> >> virtiofsd daemon. kvm-tool has a virtio subdirectory that implement=
s a
> >> >> similar set of functionality for it's emulation. The Rust-vmm proje=
ct
> >> >> has libraries for implementing the device traits.
> >> >>=20
> >> >> Another aspect to this is the growing interest in carrying virtio o=
ver
> >> >> other hypervisors. I'm wondering if there is enough abstraction pos=
sible
> >> >> to have a common library that is hypervisor agnostic? Can a device
> >> >> backend be emulated purely with some shared memory and some sockets=
 for
> >> >> passing messages/kicks from/to the VMM which then deals with the hy=
pervisor
> >> >> specifics of the virtio-transport?
> >> >
> >> > It's a little tricky because it has to interface tightly with the wa=
y
> >> > that the memory-mapping works for the hypervisor, so that the extern=
al
> >> > process can access the memory of the queues.
> >>=20
> >> I suspect the problem space can at least be reduced to at least a
> >> POSIX-like environment - if that makes things simpler. The setting up =
of
> >> memory-mappings should be the problem of the VMM, which would possibly
> >> be hypervisor specific. After that it is simply(?) a question of shari=
ng
> >> the appropriate bit of memory between the VMM and the device process.
> >
> > The 'simply(?)' is actually pretty tricky.
>=20
> Well I am at the start of this journey so may be hand waving a bit ;-)
>=20
> Lets drill down:
>=20
> > You have to share the mapping of all the RAM blocks in whcih the virtio
> > queues or the data to which they point might reside
>=20
> Aren't all the queues in one section of memory?

I don't think so; it's just allocated in guest RAM which can be split
into multiple blocks due to NUMA etc.

> As for where the data is doesn't this depend on the structure of the
> device. As I understand the behaviour of virtfs there is a direct
> relationship between the guest page cache and the host page cache to
> take advantage of DAX. This by definition means the backend needs access
> to the entire address space of the guest.
>=20
> Is this also the case for other devices?

virtiofs's DAX shared memory is a bit different from normal virtio
queues and data.  Normal queues and data just live in normal guest RAM
and their location is chosen by the guest.


> > and you also have
> > to let the other process know where in Guest physical address space the=
y
> > live.  That mapping is also not constant, either with hotplug, or with
> > architecture specific things that cause physical address mapping to
> > change.
>=20
> It sounds like the solution here would be to have bounce buffers as part
> of the virtio spec which could be part of the virtio memory block? I
> guess another option is for guests to keep their internal data (as
> referenced by virtio drivers) in a fixed guest physical address but that
> gets real complicated quick and I suspect is harder to audit from a
> security point of view.

Bounce buffers are expensive - they're used in some things (like SEV
encrypted memory).

> >> The other model would be the device process runs inside another guest =
-
> >> most likely a Linux VM. Here the guest kernel can be told an area of
> >> memory is special in some way and provide a device node that can be
> >> mmaped in more or less the same way. In this configuration it can't ev=
en
> >> be aware of what the underlying hypervisor is - just a block of memory
> >> and a way to receive message queue events.
> >
> > Doing it between VMs works in my mind; but again you still need to
> > handle that mapping.
> >
> >> > QEMU's vhost-user has a fair amount of code for handling the mapping=
s,
> >> > dirty logging for migration, iommu's and things like reset (which is
> >> > pretty hairy, and probably needs more work).
> >>=20
> >> I suspect all of these multi-process models just hand wave away detail=
s
> >> like migration because that really does benefit from a single process
> >> with total awareness of the state of the system.
> >
> > Vhost-user has it pretty well defined; it works - as long as the user
> > process does dirty map update.  Postcopy can also be made to work.
> >
> >> That said I wonder how
> >> robust a guest can be if the device emulation may go away at any time?
> >
> > That one I've not thought too much about, but the opposite case; making
> > the separate process survive even when the guest behaves
> > badly/resets/etc is quite nasty.
>=20
> I guess whatever orchestrates the start-up of the VMs has to worry about
> that. Some of the models I've been looking at have very simplistic
> setups where the guest VMs described in the platform data to be spawned
> directly by the hypervisor. I guess in those cases you need to restart
> everything.

That depends; the orchestrator doesn't normally see a guest reset - even
a nasty one.

Dave

> >
> > Dave
> >
> >> I guess in virtio if you never signal the consumption of a virt-queue =
it
> >> will still be there waiting until you restart the emulation process an=
d
> >> pick up from where you left off?
> >>=20
> >> >
> >> > Dave
> >> >
> >> >> Thoughts?
> >> >>=20
> >> >> --=20
> >> >> Alex Benn=E9e
> >> >>=20
> >> >> -------------------------------------------------------------------=
--
> >> >> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> >> >> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.o=
rg
> >> >>=20
> >>=20
> >>=20
> >> --=20
> >> Alex Benn=E9e
> >>=20
>=20
>=20
> --=20
> Alex Benn=E9e
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

