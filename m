Return-Path: virtio-dev-return-7548-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB6E1985E55
	for <virtio-dev@lists.oasis-open.org>; Tue, 14 Jul 2020 21:43:40 +0000 (UTC)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 14 Jul 2020 22:43:36 +0100
Message-ID: <87r1tdydpz.fsf@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] On doorbells (queue notifications)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: Zha Bin <zhabin@linux.alibaba.com>, Zha Bin <zhabin@linux.alibaba.com>, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Hi,

At some point in the life cycle of a virt queue there needs to be a
notification event to signal to the guest or host that there has been an
update to the virtio structures. The number of context switches made by
the hypervisor is therefor a limiting factor to the overall performance
of the system.

As I understand it on the host side this can either be reported up via
eventfd or user-space can simply busy-wait loop reading the virt queue
status so it can process the queue as soon as a status change is
visible.

On the guest side however a busy-wait approach is undesirable as it
prevents the hypervisor from properly sharing resources. This will also
be the case if you want to service the backend of a particular virtio
device in another separate VMs.

For Virtio PCI you get an IRQ number from a (hopefully virtualised) GIC
and eventually end up at the IRQ handler which does a
ioread8(vp_dev->isr). This implicitly clears the current IRQ event. The
value of the ISR tells the driver what event has occurred (config or
queue update).

I'm slightly confused by the MSI terminology because this only seems to
be relevant for the PCI legacy interface and AFAICT only touch the
outgoing path in setup and del_vq. Do incoming MSI interrupts just get
mapped directly to the appropriate handler function to process the
queues or the config?

For MMIO based transports there is a more traditional setup of a
InterruptStatus register which is read and then acknowledged with write
to a InterruptACK register. If the device memory is handled with trap
and emulate this means a two round trips to the hypervisor just to
process one vq update.

I see there was a proposal to introduce the concept of MSI based IRQs to
virtio-mmio last year:

  https://lore.kernel.org/patchwork/patch/1171065/

with proposed kernel changes in January:

  https://patchwork.kernel.org/cover/11343097/

I haven't seen any follow up since those series were posted. Is this a
proposal that support? Is there another version likely to be proposed to
the virtio-comment list?

Finally I'm curious if this is just a problem avoided by the s390
channel approach? Does the use of messages over a channel just avoid the
sort of bouncing back and forth that other hypervisors have to do when
emulating a device?

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

