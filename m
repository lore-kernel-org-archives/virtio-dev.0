Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v1 0/2] Move transitional dev req to legacy interface
Date: Sun, 26 Feb 2023 00:06:34 +0200
Message-ID: <20230225220636.429990-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Currently the PCI transitional device discovery requirements
are located in two sections. One it located in regular device
section mixed with non transitional device normative statements.
Some of them are already located in the second legacy interface
section.

Legacy interfaces is the section to describe transitional device
requirements as mentioned in the first legacy interface section
2.2.3.

Hence move these normative statements and requirements to the
Legacy interface section.

This is only an editorial change.

patch summary:
patch-1 use capital alphabets to define device id
patch-2 move pci device id normative statements adjacent to other
requirements

changelog:
1. use lowercase letters
2. add missing '.'

Parav Pandit (2):
  transport-pci: Use lowecase alphabets
  transport-pci: Move transitional device id to legacy section

 transport-pci.tex | 82 ++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

--=20
2.26.2

