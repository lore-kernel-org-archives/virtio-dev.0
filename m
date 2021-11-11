Return-Path: <eperezma@redhat.com>
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v3 0/2] virtio: introduce STOP status bit
Date: Thu, 11 Nov 2021 19:58:10 +0100
Message-Id: <20211111185812.2326093-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, mst@redhat.com, jasowang@redhat.com
Cc: amikheev@nvidia.com, stefanha@redhat.com, shahafs@nvidia.com, oren@nvidia.com, pasic@linux.ibm.com, cohuck@redhat.com, bodong@nvidia.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, parav@nvidia.com, mgurtovoy@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch introduces a new status bit STOP. This can be used by the=0D
driver to stop the device in order to safely fetch used descriptors=0D
status, making sure the device will not fetch new available ones.=0D
=0D
Its main use case is live migration, although it has other orthogonal=0D
use cases. It can be used to safely discard requests that have not been=0D
used: in other words, to rewind available descriptors.=0D
=0D
Stopping the device in the live migration context is done by per-device=0D
operations in vhost backends, but the introduction of STOP as a basic=0D
virtio facility comes with advantages:=0D
* All the device virtio-specific state is summarized in a single entity,=0D
  making easier to reason about it.=0D
* VMM does not need to implement device specific operations in the=0D
  driver part.=0D
* Work out of the box for devices that use pure virtio backends in some=0D
  part of the device emulation chain (virtio_pci_vdpa or virtio_vdpa),=0D
  in any transport the device can use.=0D
* It's totally self-contained, solving the nested virtualization case=0D
  straightforwardly.=0D
=0D
To fully understand its position in the live migration case, it's needed=0D
to note that the VMM acts as a part (or the whole) of the virtio device=0D
from the guest point of view, and it can act as a part of the driver=0D
from an external virtio device point of view. This is already the case=0D
when using vhost-net, for example, where VMM exposes a combination of=0D
backend and VMM features, and can mask them if needed.=0D
=0D
To migrate an external device the VMM needs to retrieve its (guest=0D
visible) status and make sure the device does not modify it or=0D
communicate with the guest anymore. The STOP status bit achieves the=0D
last part, and even the first one in case of a pure stateless device=0D
using the split vring.=0D
=0D
In its simpler way of working, the VMM masks the VIRTIO_F_STOP feature=0D
to the guest, and also masks the STOP and STOP_FAILED status bit. This=0D
way the VMM can stop and resume operation unilaterally, totally=0D
transparent for the latter.=0D
=0D
If we don't need the STOP status bit in the hypervisor but we want the=0D
guest to be able to stop the device, the status can be passthrough.=0D
=0D
If we want the guest to be able to stop and=0D
resume the device by itself and VMM does not need LM, the flag and=0D
status must not be masked. If we want both, we need VMM to be able to=0D
override, taking into account the device status for the guest.=0D
=0D
v3:=0D
* Delete all virtqueue state saving and restoring, not needed at the=0D
  moment.=0D
* Add STOP_FAILED bit so device can fail the operation=0D
* Add config interrupt to notify driver about the stop bit is set, so it=0D
  can avoid busy waiting polling status.=0D
* Expand device's required treatment to in-flight descriptors before=0D
  setting the STOP bit.=0D
* Add rewind capabilities.=0D
* Add resume operation, clearing the STOP bit.=0D
* Reword status clear bit / PCI reset contradictions, already present in=0D
  the spec=0D
* Specify device behavior if STOP status bit is set before DRIVER_OK=0D
=0D
Signed-off-by: Jason Wang <jasowang@redhat.com>=0D
Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>=0D
=0D
Eugenio P=C3=A9rez (1):=0D
  content: Explain better the status clearing bits=0D
=0D
Jason Wang (1):=0D
  virtio: introduce STOP status bit=0D
=0D
 content.tex | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++--=0D
 1 file changed, 87 insertions(+), 3 deletions(-)=0D
=0D
--=20=0D
2.27.0=0D
=0D

