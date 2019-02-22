Return-Path: virtio-comment-return-638-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 22 Feb 2019 11:54:30 +0000
Message-Id: <20190222115433.7160-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-comment] [PATCH v2 0/3] Large shared memory regions
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This series formalises the idea of shared memory regions I'd
previously discussed and is intended for use with virtio-fs.

I've split it into three parts:

  a) A general definition of the idea

  b) A definition on virtio-pci using the layout previously
discussed; this still uses the list of capabilities.

  c) A definition on virtio-mmio; this is untested
however I thought best to include it since it shows that
it isn't tied to PCI.


This v2 addresses (hopefully all) comments from the initial posting,
except for CCW and the GPU/dynamic usage currently being
discussed by Frank.  Cornelia has a suggested approach for CCW
that is being discussed, so it looks like we're getting there on
that.  The GPU usage being discussed by Frank is diverging to a
very different usage.

Dave

Dr. David Alan Gilbert (3):
  shared memory: Define shared memory regions
  shared memory: Define PCI capability
  shared memory: Define mmio registers

 content.tex    | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++
 shared-mem.tex | 33 +++++++++++++++++++++++
 2 files changed, 104 insertions(+)
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

