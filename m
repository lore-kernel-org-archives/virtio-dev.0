Return-Path: virtio-comment-return-1408-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 18 Aug 2020 10:32:28 -0700
Message-ID: 
 <159777170579.321346.6847340295291298122.stgit@ahduyck-workstation>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH RESEND v6 0/3] virtio-spec: Add documentation for recently
 added balloon features
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: mst@redhat.com, david@redhat.com, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

I am resending this patch set with the hope of getting final reviews sorted
out as I had no feedback on v6. If there are no further comments to be made
I will create an issue and ask for inclusion of this patch set.

This patch set is meant to add documentation for balloon features that have
been recently added to the Linux kernel[1,2] and that were recently added
to QEMU[3].

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

Changes since v4:
Further clean-ups for page hinting based on input from David Hildenbrand

Changes since v5:
Reverted patcher order changes from v3 placing hinting as first patch
Addressed comments and added Reviewed-by from Cornelia Huck
Addressed further items I found in free page hinting
  Added requirement that output buffers be 4 bytes in size
  Replaced reference to descriptor with buffer
  Replaced references to free_page_hint_vq with free_page_vq

[1]: https://lore.kernel.org/lkml/20200211224416.29318.44077.stgit@localhost.localdomain/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0c504f154718904ae49349147e3b7e6ae91ffdc
[3]: https://lists.oasis-open.org/archives/virtio-dev/202004/msg00180.html

---

Alexander Duyck (3):
      content: Document balloon feature free page hints
      content: Document balloon feature page poison
      content: Document balloon feature free page reporting


 conformance.tex |    6 +
 content.tex     |  287 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 287 insertions(+), 6 deletions(-)

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

