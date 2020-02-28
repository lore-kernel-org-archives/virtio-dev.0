Return-Path: virtio-dev-return-6810-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 18CF7985EB4
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Feb 2020 10:16:26 +0000 (UTC)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 28 Feb 2020 10:16:21 +0000
Message-ID: <87mu93vwy2.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] VIRTIO adoption in other hypervisors
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
Cc: jan.kiszka@siemens.com, Stefano Stabellini <sstabellini@kernel.org>, Wei Liu <liuw@liuw.name>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

I'm currently trying to get my head around virtio and was wondering how
widespread adoption of virtio is amongst the various hypervisors and
emulators out there.

Obviously I'm familiar with QEMU both via KVM and even when just doing
plain emulation (although with some restrictions). As far as I'm aware
the various Rust based VMMs have vary degrees of support for virtio
devices over KVM as well. CrosVM specifically is embracing virtio for
multi-process device emulation.

I believe there has been some development work for supporting VIRTIO on
Xen although it seems to have stalled according to:

  https://wiki.xenproject.org/wiki/Virtio_On_Xen

Recently at KVM Forum there was Jan's talk about Inter-VM shared memory
which proposed ivshmemv2 as a VIRTIO transport:

  https://events19.linuxfoundation.org/events/kvm-forum-2019/program/schedu=
le/

As I understood it this would allow Xen (and other hypervisors) a simple
way to be able to carry virtio traffic between guest and end point.

So some questions:

  - Am I missing anything out in that summary?
  - How about HyperV and the OSX equivalent?
  - Do any other type-1 hypervisors support virtio?

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

