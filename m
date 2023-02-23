Return-Path: <virtio-comment-return-4490-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Thu, 23 Feb 2023 20:13:52 +0200
Message-ID: <20230223181354.189697-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v5 0/2] virtio-net: Improve dev config layout
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, david.edmondson@oracle.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This two patches improve dev configuration layout in two ways.

1. Define device configuration layout before describing it fields
2. Avoid duplicate description of its read only fields and whole
layout

Patch summary:
patch-1: consolidate read only field at one place in driver
requirements
patch-2: define device configuration layout before describing its
fields.

changelog:
v4->v5:
- grammar correction
- smaller commit message
v3->v4:
- wrote driver requirement as normative statement
- moved read only line to description section
v2->v3:
- split into two patches
- move read only description to driver requirements section



Parav Pandit (2):
  virtio-net: Describe dev cfg fields read only
  virtio-net: Define cfg fields before description

 device-types/net/description.tex | 49 ++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 21 deletions(-)

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

