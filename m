Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v1 0/6] Split transport specific files
Date: Fri, 17 Feb 2023 03:30:02 +0200
Message-ID: <20230217013008.16062-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Problem statement:
Currently several tens of pages worth of transport specification
is situated in single file. Many parts of the specification
are already maintained in separate files.

Such separate files enables better maintenance of the specification overall=
.

Solution:
Follow the approach similar to rest of the spec, and keep
transport specific spec in their individual files.

This series is for fixing issue [1].

[1] Fixes: https://github.com/oasis-tcs/virtio-spec/issues/157

Please review.

Patch summary:
patch 1 moves pci transport to its own file
patch 2 moves mmio transport to its own file
patch 3 moves channel io transport to its own file
patch 4 to 6 fixes spelling errors existed in the spec which are
discovered during splitting the files



Parav Pandit (6):
  transport-pci: Split PCI transport to its own file
  transport-mmio: Split MMIO transport to its own file
  transport-channelio: Split Channel IO transport to its own file
  transport-pci: Correct spelling errors
  transport-mmio: Correct spelling errors
  transport-channelio: Correct spelling errors

 content.tex             | 2318 +--------------------------------------
 transport-channelio.tex |  601 ++++++++++
 transport-mmio.tex      |  552 ++++++++++
 transport-pci.tex       | 1160 ++++++++++++++++++++
 4 files changed, 2316 insertions(+), 2315 deletions(-)
 create mode 100644 transport-channelio.tex
 create mode 100644 transport-mmio.tex
 create mode 100644 transport-pci.tex

--=20
2.26.2

