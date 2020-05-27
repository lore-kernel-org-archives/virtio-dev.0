Return-Path: virtio-comment-return-1295-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 26 May 2020 21:06:43 -0700
Message-ID: 
 <159055235065.209072.12017445428967301686.stgit@ahduyck-workstation>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v4 0/3] virtio-spec: Add documentation for recently added
 balloon features
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: mst@redhat.com, david@redhat.com, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch set is meant to add documentation for balloon features that have
been recently added to the Linux kernel[1,2] and that we are currently
working on adding to QEMU[3].

Changes since RFC:
Incorporated suggestions from Cornelia Huck
Fixed a few additional spelling errors

Changes since v1:
Incorporated additional suggestions from Cornelia Huck
Dropped documentation referring to free page reporting from page poison patch

Changes since v2:
Rewrote multiple statements based on input from David Hildenbrand
  Dropped use of balloon and deflate from page hinting description
  Dropped use of free page reporting from page poison description
  Cleaned up several spots that didn't match RFC2119 style comments
  Added conformance links.
  Various other clean-ups.
Updated balloon command IDs based on input from Cornelia Huck

Changes since v3:
Reordered patches to place free page hinting at end of patch set
  Moved contents out of patch to poison and free page reporting patches
  Updated patch description to document some known issues with feature
Further clean-ups based on input from David Hildenbrand

[1]: https://lore.kernel.org/lkml/20200211224416.29318.44077.stgit@localhost.localdomain/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0c504f154718904ae49349147e3b7e6ae91ffdc
[3]: https://lists.oasis-open.org/archives/virtio-dev/202004/msg00180.html

---

Alexander Duyck (3):
      content: Document balloon feature page poison
      content: Document balloon feature free page reporting
      content: Document balloon feature free page hints


 conformance.tex |    6 +
 content.tex     |  269 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 269 insertions(+), 6 deletions(-)

--


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

