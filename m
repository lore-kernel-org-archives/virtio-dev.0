Return-Path: virtio-dev-return-6893-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DCD9D985FBD
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Mar 2020 19:14:43 +0000 (UTC)
Date: Fri, 6 Mar 2020 20:14:27 +0100
From: Matias Ezequiel Vara Larsen <matiasevara@gmail.com>
Message-ID: <20200306191427.GA132@matiasv.localdomain>
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

Hello Alex,
On Fri, Mar 06, 2020 at 06:33:57PM +0000, Alex Benn=E9e wrote:
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
>=20
> Thoughts?

I am currently investigating the use of metamodeling to capture virtio
concepts. The work is still a draft but you can give a look at
https://github.com/MatiasVara/virtioml. One of the ideas is to base on a
metamodel to generate the code for different targets, e.g., rust,
c, etc. For the moment, I just played by generating the c header. This
could be extended to other languages.=20

Regards, Matias.
>=20
> --=20
> Alex Benn=E9e
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

