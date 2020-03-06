Return-Path: virtio-dev-return-6894-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66286985FC0
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Mar 2020 19:41:07 +0000 (UTC)
Date: Fri, 6 Mar 2020 19:40:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20200306194058.GN3033@work-vm>
References: <874kv15o4q.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <874kv15o4q.fsf@linaro.org>
Subject: Re: [virtio-dev] Backend libraries for VirtIO device emulation
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

* Alex Benn=E9e (alex.bennee@linaro.org) wrote:
> Hi,
>=20
> So the context of my question is what sort of common software layer is
> required to implement a virtio backend entirely in userspace?
>=20
> Currently most virtio backends are embedded directly in various VMMs
> which emulate a number of devices as well as deal with handling devices
> that are vhost aware and link with the host kernel. However there seems
> to be a growing interest in having backends implemented in separate
> processes, potentially even hosted in other guest VMs.
>=20
> As far as I can tell there is a lot of duplicated effort in handling the
> low level navigation of virt queues and buffers. QEMU has code in
> hw/virtio as well as contrib/libvhost-user which is used by the recent
> virtiofsd daemon. kvm-tool has a virtio subdirectory that implements a
> similar set of functionality for it's emulation. The Rust-vmm project
> has libraries for implementing the device traits.
>=20
> Another aspect to this is the growing interest in carrying virtio over
> other hypervisors. I'm wondering if there is enough abstraction possible
> to have a common library that is hypervisor agnostic? Can a device
> backend be emulated purely with some shared memory and some sockets for
> passing messages/kicks from/to the VMM which then deals with the hypervis=
or
> specifics of the virtio-transport?

It's a little tricky because it has to interface tightly with the way
that the memory-mapping works for the hypervisor, so that the external
process can access the memory of the queues.
QEMU's vhost-user has a fair amount of code for handling the mappings,
dirty logging for migration, iommu's and things like reset (which is
pretty hairy, and probably needs more work).

Dave

> Thoughts?
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

