Return-Path: virtio-dev-return-6671-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 06B38985F01
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Jan 2020 06:19:37 +0000 (UTC)
From: Jing Liu <jing2.liu@linux.intel.com>
Date: Tue, 21 Jan 2020 21:54:28 +0800
Message-Id: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
Subject: [virtio-dev] [PATCH v2 0/5] virtio-mmio enhancement
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, Jing Liu <jing2.liu@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The current virtio over MMIO has some limitations that impact the performan=
ce.
It only supports single legacy, dedicated interrupt and one virtqueue
notification register for all virtqueues which cause performance penalties.

To address such limitations, we proposed to update virtio-mmio spec with
two new feature bits to support MSI interrupt and enhancing notification me=
chanism.

For keeping virtio-mmio simple as it was, and considering practical usages,=
 this
provides two kinds of mapping mode for device: MSI non-sharing mode and MSI=
 sharing mode.
MSI non-sharng mode indicates a fixed static vector and event relationship =
specified
in spec, which can simplify the setup process and reduce vmexit, fitting fo=
r
a high interrupt rate request.
MSI sharing mode indicates a dynamic mapping, which is more like PCI does, =
fitting
for a non-high interrupt rate request.

Change Log:
v1->v2:
* Change version update to feature bit
* Add mask/unmask support
* Add two MSI sharing/non-sharing modes
* Change MSI registers layout and bits

Jing Liu (5):
  virtio-mmio: Add feature bit for MMIO notification
  virtio-mmio: Enhance queue notification support
  virtio-mmio: Add feature bit for MMIO MSI
  virtio-mmio: Introduce MSI details
  virtio-mmio: MSI vector and event mapping

 content.tex | 286 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--=
----
 msi-state.c |   5 ++
 2 files changed, 262 insertions(+), 29 deletions(-)
 create mode 100644 msi-state.c

--=20
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

