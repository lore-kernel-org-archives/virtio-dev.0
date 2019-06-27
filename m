Return-Path: virtio-comment-return-767-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 27 Jun 2019 20:28:25 +0100
Message-Id: <20190627192830.5285-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-comment] [PATCH v5 0/5] Large shared memory regions
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, stefanha@redhat.com, cohuck@redhat.com
Cc: vgoyal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

  This series formalises the idea of shared memory regions I'd
previously discussed and is intended for use with virtio-fs.

I've split it into five parts:

  a) A general definition of the idea

  b) An addition of an 'id' field to allow multiple distinct
     capabilities of the same type.

  c) An addition of a 64bit capability type.

  d) A definition on virtio-pci using the layout previously
discussed.

  e) A definition on virtio-mmio.

v5:
  Based on Michael's comments, the 'id' field is now moved into
the main virtio_pci_cap, and the 64 bit cpaaibility is now a more
general type.
  Minor other rewordings.

Dr. David Alan Gilbert (5):
  shared memory: Define shared memory regions
  pci: Define id field
  pci: Define virtio_pci_cap64
  shared memory: Define PCI capability
  shared memory: Define mmio registers

 conformance.tex |  1 +
 content.tex     | 77 ++++++++++++++++++++++++++++++++++++++++++++++++-
 shared-mem.tex  | 42 +++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 shared-mem.tex

-- 
2.21.0


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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

