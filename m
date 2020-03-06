Return-Path: virtio-dev-return-6892-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FAF5985FBD
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Mar 2020 18:34:01 +0000 (UTC)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 06 Mar 2020 18:33:57 +0000
Message-ID: <874kv15o4q.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] Backend libraries for VirtIO device emulation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

So the context of my question is what sort of common software layer is
required to implement a virtio backend entirely in userspace?

Currently most virtio backends are embedded directly in various VMMs
which emulate a number of devices as well as deal with handling devices
that are vhost aware and link with the host kernel. However there seems
to be a growing interest in having backends implemented in separate
processes, potentially even hosted in other guest VMs.

As far as I can tell there is a lot of duplicated effort in handling the
low level navigation of virt queues and buffers. QEMU has code in
hw/virtio as well as contrib/libvhost-user which is used by the recent
virtiofsd daemon. kvm-tool has a virtio subdirectory that implements a
similar set of functionality for it's emulation. The Rust-vmm project
has libraries for implementing the device traits.

Another aspect to this is the growing interest in carrying virtio over
other hypervisors. I'm wondering if there is enough abstraction possible
to have a common library that is hypervisor agnostic? Can a device
backend be emulated purely with some shared memory and some sockets for
passing messages/kicks from/to the VMM which then deals with the hypervisor
specifics of the virtio-transport?

Thoughts?

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

