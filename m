Return-Path: virtio-dev-return-6895-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 56512985FC3
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Mar 2020 20:24:15 +0000 (UTC)
References: <874kv15o4q.fsf@linaro.org> <20200306194058.GN3033@work-vm>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200306194058.GN3033@work-vm>
Date: Fri, 06 Mar 2020 20:24:09 +0000
Message-ID: <871rq55j12.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Backend libraries for VirtIO device emulation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Dr. David Alan Gilbert <dgilbert@redhat.com> writes:

> * Alex Benn=C3=A9e (alex.bennee@linaro.org) wrote:
>> Hi,
>>=20
>> So the context of my question is what sort of common software layer is
>> required to implement a virtio backend entirely in userspace?
>>=20
>> Currently most virtio backends are embedded directly in various VMMs
>> which emulate a number of devices as well as deal with handling devices
>> that are vhost aware and link with the host kernel. However there seems
>> to be a growing interest in having backends implemented in separate
>> processes, potentially even hosted in other guest VMs.
>>=20
>> As far as I can tell there is a lot of duplicated effort in handling the
>> low level navigation of virt queues and buffers. QEMU has code in
>> hw/virtio as well as contrib/libvhost-user which is used by the recent
>> virtiofsd daemon. kvm-tool has a virtio subdirectory that implements a
>> similar set of functionality for it's emulation. The Rust-vmm project
>> has libraries for implementing the device traits.
>>=20
>> Another aspect to this is the growing interest in carrying virtio over
>> other hypervisors. I'm wondering if there is enough abstraction possible
>> to have a common library that is hypervisor agnostic? Can a device
>> backend be emulated purely with some shared memory and some sockets for
>> passing messages/kicks from/to the VMM which then deals with the hypervi=
sor
>> specifics of the virtio-transport?
>
> It's a little tricky because it has to interface tightly with the way
> that the memory-mapping works for the hypervisor, so that the external
> process can access the memory of the queues.

I suspect the problem space can at least be reduced to at least a
POSIX-like environment - if that makes things simpler. The setting up of
memory-mappings should be the problem of the VMM, which would possibly
be hypervisor specific. After that it is simply(?) a question of sharing
the appropriate bit of memory between the VMM and the device process.

The other model would be the device process runs inside another guest -
most likely a Linux VM. Here the guest kernel can be told an area of
memory is special in some way and provide a device node that can be
mmaped in more or less the same way. In this configuration it can't even
be aware of what the underlying hypervisor is - just a block of memory
and a way to receive message queue events.

> QEMU's vhost-user has a fair amount of code for handling the mappings,
> dirty logging for migration, iommu's and things like reset (which is
> pretty hairy, and probably needs more work).

I suspect all of these multi-process models just hand wave away details
like migration because that really does benefit from a single process
with total awareness of the state of the system. That said I wonder how
robust a guest can be if the device emulation may go away at any time?

I guess in virtio if you never signal the consumption of a virt-queue it
will still be there waiting until you restart the emulation process and
pick up from where you left off?

>
> Dave
>
>> Thoughts?
>>=20
>> --=20
>> Alex Benn=C3=A9e
>>=20
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>=20


--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

