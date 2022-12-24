Return-Path: <virtio-comment-return-3606-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sat, 24 Dec 2022 20:06:13 +0200
Message-ID: <20221224180619.73959-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH 0/6] Split device spec to its individual files
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Relatively several of the recent device specification are maintained
in their own specification file. Such separate files enables better
maintenance of the specification overall.
However, several of the initial virtio device specifications
are located in single file.

Hence, split them into their individual files.

Parav Pandit (6):
  virtio-scsi: Maintain scsi device spec in separate file
  virtio-mem-balloon: Maintain memory balloon device spec in separate
    file
  virtio-entropy: Maintain entropy device spec in separate file
  virtio-console: Maintain console device spec in separate file
  virtio-block: Maintain block device spec in separate file
  virtio-network: Maintain network device spec in separate file

 content.tex            | 4535 +---------------------------------------
 virtio-block.tex       | 1315 ++++++++++++
 virtio-console.tex     |  233 +++
 virtio-entropy.tex     |   42 +
 virtio-mem-balloon.tex |  636 ++++++
 virtio-network.tex     | 1596 ++++++++++++++
 virtio-scsi.tex        |  711 +++++++
 7 files changed, 4539 insertions(+), 4529 deletions(-)
 create mode 100644 virtio-block.tex
 create mode 100644 virtio-console.tex
 create mode 100644 virtio-entropy.tex
 create mode 100644 virtio-mem-balloon.tex
 create mode 100644 virtio-network.tex
 create mode 100644 virtio-scsi.tex

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

