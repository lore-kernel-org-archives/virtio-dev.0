Return-Path: <virtio-dev-return-10000-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A954F9866EF
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Oct 2022 16:56:50 +0000 (UTC)
From: Usama Arif <usama.arif@bytedance.com>
Date: Fri,  7 Oct 2022 17:56:39 +0100
Message-Id: <20221007165643.3920613-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 0/4] Introduce aux. notifications and virtio-vhost-user
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com, Usama Arif <usama.arif@bytedance.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

This patch series introduces device and driver auxiliary notifications
as a new set of virtio device resources, as well as vhost-user device
backend that uses these resources.

Driver auxiliary notifications allow the device to send notifications
other than configuration changes and used buffer notifications to the
driver, these are optional and their meaning is **device-specific**.

Device auxiliary notifcations allow the driver to send notifcations
other than available buffer notifications to the device for example
through a device register, these are optional and their meaning is
**device-specific**.

These resources are used in the last patch by the virtio-vhost-user
device in order to send/receive notifications to/from the driver
regarding activity on the vhost-user virtqueues. By standardizing
these resources as standalone virtio device resources, other future
devices will be able to use them as well.

The last patch introduces the vhost-user device backend which facilitates
vhost-user device emulation through vhost-user protocol exchanges and
access to shared memory. Software-defined networking, storage, and other
I/O appliances can provide services through this device.

This device is based on Wei Wang's vhost-pci work. The virtio-vhost-user
device differs from vhost-pci because it is a single virtio
device type that exposes the vhost-user protocol instead of a family of
new virtio device types, one for each vhost-user device type.

A HTML version with the changes is available at [1].

For more information about virtio-vhost-user, see [2].

These patches are based on the work initially done by Stefan Hajnoczi [2]
and continued by Nikos Dragazis [3], [4].

A working prototype implementing this spec can be reproduced using
instructions in [5] utilizing QEMU [6] and DPDK [7].
This is also based on the work initially done by Stefan
and continued later by Nikos. The prototype code uses the terms
"doorbell"/"device-specific notification" and "master"/"slave" instead of
"device auxiliary notification"/"driver auxiliary notification" and
"frontend"/"backend". This is based on older work, however, their
functionality is the same. If these virtio-spec changes get approved,
I will refractor the patches for QEMU/DPDK and send them for review
according to the final patches in the respective mailing list.

Thanks and looking forward to your response!
Usama

[1] https://uarif1.github.io/vvu/v3/virtio-v1.2-cs01
[2] https://wiki.qemu.org/Features/VirtioVhostUser
[3] https://ndragazis.github.io/dpdk-vhost-vvu-demo.html
[4] https://lists.oasis-open.org/archives/virtio-dev/202005/msg00132.html
[5] https://uarif1.github.io/vvu/dpdk-vvu-instructions
[6] https://github.com/uarif1/qemu/tree/vvu
[7] https://github.com/uarif1/dpdk/tree/vvu
----------
v2->v3:
Mostly addressing comments made by Michael S. Tsirkin:
- Give a clearer relation between backend driver, backend device and fronte=
nd at
  beginning of the Vhost-user Device Backend section.
- change uuid to id.
- Add information about inflight memory.

v1->v2:
- Shortened device aux. notification section
- Make data width of device aux. notifications device specific and not
  limited to 2 bytes.
- Added information about the minimum number of MSIX vectors.
- Split virtio-mmio implementation of driver aux. notifications into 2
  registers, DeviceAuxNotificationIndex and DeviceAuxNotificationData.
- Made the shared memory section in virtio vhost-user clearer and added
  the shared memory would look like when
  VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS has been negotiated.

Usama Arif (4):
  content: Introduce driver/device auxiliary notifications
  content: Introduce driver/device aux. notification cfg type for PCI
  content: Introduce driver/device auxiliary notifications for MMIO
  vhost-user: add vhost-user device type

 conformance.tex       |  29 +++-
 content.tex           | 254 +++++++++++++++++++++++++++++-----
 introduction.tex      |   3 +
 virtio-vhost-user.tex | 309 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 554 insertions(+), 41 deletions(-)
 create mode 100644 virtio-vhost-user.tex

--=20
2.25.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

