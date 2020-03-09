Return-Path: virtio-dev-return-6901-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 800FF98425C
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Mar 2020 10:44:47 +0000 (UTC)
Date: Mon, 9 Mar 2020 10:44:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20200309104440.GE3088@work-vm>
References: <874kv15o4q.fsf@linaro.org>
 <20200306194058.GN3033@work-vm>
 <871rq55j12.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <871rq55j12.fsf@linaro.org>
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
> >> Hi,
> >>=20
> >> So the context of my question is what sort of common software layer is
> >> required to implement a virtio backend entirely in userspace?
> >>=20
> >> Currently most virtio backends are embedded directly in various VMMs
> >> which emulate a number of devices as well as deal with handling device=
s
> >> that are vhost aware and link with the host kernel. However there seem=
s
> >> to be a growing interest in having backends implemented in separate
> >> processes, potentially even hosted in other guest VMs.
> >>=20
> >> As far as I can tell there is a lot of duplicated effort in handling t=
he
> >> low level navigation of virt queues and buffers. QEMU has code in
> >> hw/virtio as well as contrib/libvhost-user which is used by the recent
> >> virtiofsd daemon. kvm-tool has a virtio subdirectory that implements a
> >> similar set of functionality for it's emulation. The Rust-vmm project
> >> has libraries for implementing the device traits.
> >>=20
> >> Another aspect to this is the growing interest in carrying virtio over
> >> other hypervisors. I'm wondering if there is enough abstraction possib=
le
> >> to have a common library that is hypervisor agnostic? Can a device
> >> backend be emulated purely with some shared memory and some sockets fo=
r
> >> passing messages/kicks from/to the VMM which then deals with the hyper=
visor
> >> specifics of the virtio-transport?
> >
> > It's a little tricky because it has to interface tightly with the way
> > that the memory-mapping works for the hypervisor, so that the external
> > process can access the memory of the queues.
>=20
> I suspect the problem space can at least be reduced to at least a
> POSIX-like environment - if that makes things simpler. The setting up of
> memory-mappings should be the problem of the VMM, which would possibly
> be hypervisor specific. After that it is simply(?) a question of sharing
> the appropriate bit of memory between the VMM and the device process.

The 'simply(?)' is actually pretty tricky.
You have to share the mapping of all the RAM blocks in whcih the virtio
queues or the data to which they point might reside, and you also have
to let the other process know where in Guest physical address space they
live.  That mapping is also not constant, either with hotplug, or with
architecture specific things that cause physical address mapping to
change.

> The other model would be the device process runs inside another guest -
> most likely a Linux VM. Here the guest kernel can be told an area of
> memory is special in some way and provide a device node that can be
> mmaped in more or less the same way. In this configuration it can't even
> be aware of what the underlying hypervisor is - just a block of memory
> and a way to receive message queue events.

Doing it between VMs works in my mind; but again you still need to
handle that mapping.

> > QEMU's vhost-user has a fair amount of code for handling the mappings,
> > dirty logging for migration, iommu's and things like reset (which is
> > pretty hairy, and probably needs more work).
>=20
> I suspect all of these multi-process models just hand wave away details
> like migration because that really does benefit from a single process
> with total awareness of the state of the system.

Vhost-user has it pretty well defined; it works - as long as the user
process does dirty map update.  Postcopy can also be made to work.

> That said I wonder how
> robust a guest can be if the device emulation may go away at any time?

That one I've not thought too much about, but the opposite case; making
the separate process survive even when the guest behaves
badly/resets/etc is quite nasty.

Dave

> I guess in virtio if you never signal the consumption of a virt-queue it
> will still be there waiting until you restart the emulation process and
> pick up from where you left off?
>=20
> >
> > Dave
> >
> >> Thoughts?
> >>=20
> >> --=20
> >> Alex Benn=E9e
> >>=20
> >> ---------------------------------------------------------------------
> >> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> >> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >>=20
>=20
>=20
> --=20
> Alex Benn=E9e
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

