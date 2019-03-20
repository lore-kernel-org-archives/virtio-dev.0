Return-Path: virtio-comment-return-709-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 20 Mar 2019 12:07:37 +0000
Message-Id: <20190320120740.8514-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-comment] [PATCH v4 0/3] Large shared memory regions
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Cc: stefanha@redha.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

  This series formalises the idea of shared memory regions I'd
previously discussed and is intended for use with virtio-fs.

I've split it into three parts:

  a) A general definition of the idea

  b) A definition on virtio-pci using the layout previously
discussed; this still uses the list of capabilities.

  c) A definition on virtio-mmio.

This v4 has one small tweak to the addressing comment in
patch 1, based partially on Stefan's feedback to v3.

Dr. David Alan Gilbert (3):
  shared memory: Define shared memory regions
  shared memory: Define PCI capability
  shared memory: Define mmio registers

 conformance.tex |  1 +
 content.tex     | 69 +++++++++++++++++++++++++++++++++++++++++++++++++
 shared-mem.tex  | 40 ++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 shared-mem.tex

-- 
2.20.1


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

