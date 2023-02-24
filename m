Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH 0/2] Move transitional dev req to legacy interface
Date: Sat, 25 Feb 2023 01:12:30 +0200
Message-ID: <20230224231232.340814-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Currently, the PCI transitional device discovery requirements
are located in two sections. One it located in the regular device
section mixed with non-transitional device normative statements.
Some of them are already located in the second legacy interface
section.

=E2=80=98Legacy interfaces=E2=80=99 is the section to describe transitional=
 device
requirements as mentioned in the first legacy interface section
2.2.3.

Hence move these normative statements and requirements to the
Legacy interface section.

This is only an editorial change.

It is on top of series [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00578.html

patch summary:
patch-1 use capital alphabets to define device id
patch-2 move pci device id normative statements adjacent to other
requirements


Parav Pandit (2):
  transport-pci: Use capital alphabets
  transport-pci: Move transitional device id to legacy section

 transport-pci.tex | 74 ++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

--=20
2.26.2

