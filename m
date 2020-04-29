Return-Path: virtio-comment-return-1197-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 29 Apr 2020 11:57:38 -0700
Message-ID: <20200429184122.1248.4817.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH RFC 0/3] virtio-spec: Add documentation for recently added
 balloon features
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: cohuck@redhat.com, david@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This patch set is meant to add documentation for balloon features that have
been recently added to the Linux kernel[1,2] and that we are currently
working on adding to QEMU[3].

I am submitting them as an RFC as it has been a while since I have written
any requirements or specification documents, so my wording on things will
likely need some updates. In addition I have not before submitted
virtio-spec updates. As such I would appreciate information on if this is
the correct process for updating the document, or if I need to take some
other/additional steps.

[1]: https://lore.kernel.org/lkml/20200211224416.29318.44077.stgit@localhost.localdomain/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0c504f154718904ae49349147e3b7e6ae91ffdc
[3]: https://lists.oasis-open.org/archives/virtio-dev/202004/msg00180.html

---

Alexander Duyck (3):
      content: Document balloon feature free page hints
      content: Document balloon feature page poison
      content: Document balloon feature free page reporting


 content.tex |  232 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 229 insertions(+), 3 deletions(-)

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

