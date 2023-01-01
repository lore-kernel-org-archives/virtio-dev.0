Return-Path: <virtio-comment-return-3627-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sun, 1 Jan 2023 20:08:04 +0200
Message-ID: <20230101180824.325172-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v1 00/20] Split device spec to its individual files
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Relatively several of the recent device specifications are maintained
in their own specification file. Such separate files enables better
maintenance of the specification overall.
However, several of the initial virtio device specifications
are located in single file.

Hence, split them into their individual files.

Additionally, each device's driver and device conformance is
present in one giant conformance file all together.

As Michael suggest's move this device and driver conformance
section adjacent to device specification in each device specific
directory. This further makes device specification self-contained.

Added patch to fix spelling errors in network device
specification which was inherited from its previous file
location.

Patches do not change any part of the specification outcome
except fixing the spelling errors.
It only changes how the specification is maintained.

patch summary:
-------------
patch 1 to 7 creates new files for moving devices spec out of
content and conformance files.
patch 8 to 20 move existing dedicated file spec to new directory
and creates per device,driver conformance file for each device.

changelog:
----------
v0->v1:
- move device spec to their own directory
- added split files for conformance and placed them adjacent to
  device spec
- added patch to fix spelling errors in network device


Parav Pandit (20):
  virtio-network: Maintain network device spec in separate directory
  virtio-network: Fix spelling errors
  virtio-block: Maintain block device spec in separate directory
  virtio-console: Maintain console device spec in separate directory
  virtio-entropy: Maintain entropy device spec in separate directory
  virtio-mem-balloon: Maintain mem balloon device spec in separate
    directory
  virtio-scsi: Maintain scsi host device spec in separate directory
  virtio-gpu: Maintain gpu device spec in separate directory
  virtio-input: Maintain input device spec in separate directory
  virtio-crypto: Maintain crypto device spec in separate directory
  virtio-vsock: Maintain socket device spec in separate directory
  virtio-fs: Maintain file system device spec in separate directory
  virtio-rpmb: Maintain rpmb device spec in separate directory
  virtio-iommu: Maintain iommu device spec in separate directory
  virtio-sound: Maintain sound device spec in separate directory
  virtio-mem: Maintain memory device spec in separate directory
  virtio-i2c: Maintain i2c device spec in separate directory
  virtio-scmi: Maintain scmi device spec in separate directory
  virtio-gpio: Maintain gpio device spec in separate directory
  virtio-pmem: Maintain pmem device spec in separate directory

 conformance.tex                               |  453 +-
 content.tex                                   | 4560 +----------------
 .../virtio-block/device-conformance.tex       |    8 +
 device-types/virtio-block/device.tex          | 1315 +++++
 .../virtio-block/driver-conformance.tex       |    8 +
 .../virtio-console/device-conformance.tex     |    8 +
 device-types/virtio-console/device.tex        |  231 +
 .../virtio-console/driver-conformance.tex     |    8 +
 .../virtio-crypto/device-conformance.tex      |   13 +
 .../virtio-crypto/device.tex                  |    0
 .../virtio-crypto/driver-conformance.tex      |   14 +
 .../virtio-entropy/device-conformance.tex     |    7 +
 device-types/virtio-entropy/device.tex        |   42 +
 .../virtio-entropy/driver-conformance.tex     |    7 +
 device-types/virtio-fs/device-conformance.tex |    9 +
 .../virtio-fs/device.tex                      |    0
 device-types/virtio-fs/driver-conformance.tex |   10 +
 .../virtio-gpio/device-conformance.tex        |    9 +
 .../virtio-gpio/device.tex                    |    0
 .../virtio-gpio/driver-conformance.tex        |    9 +
 .../virtio-gpu/device-conformance.tex         |    8 +
 .../virtio-gpu/device.tex                     |    0
 .../virtio-i2c/device-conformance.tex         |    7 +
 .../virtio-i2c/device.tex                     |    0
 .../virtio-i2c/driver-conformance.tex         |    7 +
 .../virtio-input/device-conformance.tex       |    8 +
 .../virtio-input/device.tex                   |    0
 .../virtio-input/driver-conformance.tex       |    8 +
 .../virtio-iommu/device-conformance.tex       |   16 +
 .../virtio-iommu/device.tex                   |    0
 .../virtio-iommu/driver-conformance.tex       |   17 +
 .../virtio-mem-balloon/device-conformance.tex |   12 +
 device-types/virtio-mem-balloon/device.tex    |  634 +++
 .../virtio-mem-balloon/driver-conformance.tex |   12 +
 .../virtio-mem/device-conformance.tex         |   13 +
 .../virtio-mem/device.tex                     |    0
 .../virtio-mem/driver-conformance.tex         |   13 +
 .../virtio-network/device-conformance.tex     |   16 +
 device-types/virtio-network/device.tex        | 1596 ++++++
 .../virtio-network/driver-conformance.tex     |   17 +
 .../virtio-pmem/device-conformance.tex        |    9 +
 .../virtio-pmem/device.tex                    |    0
 .../virtio-pmem/driver-conformance.tex        |    7 +
 .../virtio-rpmb/device-conformance.tex        |   13 +
 .../virtio-rpmb/device.tex                    |    0
 .../virtio-rpmb/driver-conformance.tex        |    7 +
 .../virtio-scmi/device-conformance.tex        |   10 +
 .../virtio-scmi/device.tex                    |    0
 .../virtio-scmi/driver-conformance.tex        |    8 +
 .../virtio-scsi/device-conformance.tex        |   10 +
 device-types/virtio-scsi/device.tex           |  709 +++
 .../virtio-scsi/driver-conformance.tex        |    9 +
 .../virtio-sound/device-conformance.tex       |   16 +
 .../virtio-sound/device.tex                   |    0
 .../virtio-sound/driver-conformance.tex       |   13 +
 .../virtio-vsock/device-conformance.tex       |    9 +
 .../virtio-vsock/device.tex                   |    0
 .../virtio-vsock/driver-conformance.tex       |   10 +
 virtio.tex                                    |    1 +
 59 files changed, 4965 insertions(+), 4961 deletions(-)
 create mode 100644 device-types/virtio-block/device-conformance.tex
 create mode 100644 device-types/virtio-block/device.tex
 create mode 100644 device-types/virtio-block/driver-conformance.tex
 create mode 100644 device-types/virtio-console/device-conformance.tex
 create mode 100644 device-types/virtio-console/device.tex
 create mode 100644 device-types/virtio-console/driver-conformance.tex
 create mode 100644 device-types/virtio-crypto/device-conformance.tex
 rename virtio-crypto.tex =3D> device-types/virtio-crypto/device.tex (100%)
 create mode 100644 device-types/virtio-crypto/driver-conformance.tex
 create mode 100644 device-types/virtio-entropy/device-conformance.tex
 create mode 100644 device-types/virtio-entropy/device.tex
 create mode 100644 device-types/virtio-entropy/driver-conformance.tex
 create mode 100644 device-types/virtio-fs/device-conformance.tex
 rename virtio-fs.tex =3D> device-types/virtio-fs/device.tex (100%)
 create mode 100644 device-types/virtio-fs/driver-conformance.tex
 create mode 100644 device-types/virtio-gpio/device-conformance.tex
 rename virtio-gpio.tex =3D> device-types/virtio-gpio/device.tex (100%)
 create mode 100644 device-types/virtio-gpio/driver-conformance.tex
 create mode 100644 device-types/virtio-gpu/device-conformance.tex
 rename virtio-gpu.tex =3D> device-types/virtio-gpu/device.tex (100%)
 create mode 100644 device-types/virtio-i2c/device-conformance.tex
 rename virtio-i2c.tex =3D> device-types/virtio-i2c/device.tex (100%)
 create mode 100644 device-types/virtio-i2c/driver-conformance.tex
 create mode 100644 device-types/virtio-input/device-conformance.tex
 rename virtio-input.tex =3D> device-types/virtio-input/device.tex (100%)
 create mode 100644 device-types/virtio-input/driver-conformance.tex
 create mode 100644 device-types/virtio-iommu/device-conformance.tex
 rename virtio-iommu.tex =3D> device-types/virtio-iommu/device.tex (100%)
 create mode 100644 device-types/virtio-iommu/driver-conformance.tex
 create mode 100644 device-types/virtio-mem-balloon/device-conformance.tex
 create mode 100644 device-types/virtio-mem-balloon/device.tex
 create mode 100644 device-types/virtio-mem-balloon/driver-conformance.tex
 create mode 100644 device-types/virtio-mem/device-conformance.tex
 rename virtio-mem.tex =3D> device-types/virtio-mem/device.tex (100%)
 create mode 100644 device-types/virtio-mem/driver-conformance.tex
 create mode 100644 device-types/virtio-network/device-conformance.tex
 create mode 100644 device-types/virtio-network/device.tex
 create mode 100644 device-types/virtio-network/driver-conformance.tex
 create mode 100644 device-types/virtio-pmem/device-conformance.tex
 rename virtio-pmem.tex =3D> device-types/virtio-pmem/device.tex (100%)
 create mode 100644 device-types/virtio-pmem/driver-conformance.tex
 create mode 100644 device-types/virtio-rpmb/device-conformance.tex
 rename virtio-rpmb.tex =3D> device-types/virtio-rpmb/device.tex (100%)
 create mode 100644 device-types/virtio-rpmb/driver-conformance.tex
 create mode 100644 device-types/virtio-scmi/device-conformance.tex
 rename virtio-scmi.tex =3D> device-types/virtio-scmi/device.tex (100%)
 create mode 100644 device-types/virtio-scmi/driver-conformance.tex
 create mode 100644 device-types/virtio-scsi/device-conformance.tex
 create mode 100644 device-types/virtio-scsi/device.tex
 create mode 100644 device-types/virtio-scsi/driver-conformance.tex
 create mode 100644 device-types/virtio-sound/device-conformance.tex
 rename virtio-sound.tex =3D> device-types/virtio-sound/device.tex (100%)
 create mode 100644 device-types/virtio-sound/driver-conformance.tex
 create mode 100644 device-types/virtio-vsock/device-conformance.tex
 rename virtio-vsock.tex =3D> device-types/virtio-vsock/device.tex (100%)
 create mode 100644 device-types/virtio-vsock/driver-conformance.tex

--=20
2.26.2


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

