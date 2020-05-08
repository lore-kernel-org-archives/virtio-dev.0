Return-Path: virtio-comment-return-1220-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 08 May 2020 10:16:14 -0700
Message-ID: <158895811782.529821.115832709184722087.stgit@ahduyck-workstation>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH 0/3] virtio-spec: Add documentation for recently added balloon
 features
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: virtio-comment@lists.oasis-open.org, mst@redhat.com, david@redhat.com, cohuck@redhat.com
Cc: virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch set is meant to add documentation for balloon features that have
been recently added to the Linux kernel[1,2] and that we are currently
working on adding to QEMU[3].

Changes since RFC:
Incorporated suggestions from Cornelia Huck
Fixed a few additional spelling errors

[1]: https://lore.kernel.org/lkml/20200211224416.29318.44077.stgit@localhost.localdomain/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0c504f154718904ae49349147e3b7e6ae91ffdc
[3]: https://lists.oasis-open.org/archives/virtio-dev/202004/msg00180.html

---

Alexander Duyck (3):
      content: Document balloon feature free page hints
      content: Document balloon feature page poison
      content: Document balloon feature free page reporting


 content.tex |  248 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 242 insertions(+), 6 deletions(-)

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

