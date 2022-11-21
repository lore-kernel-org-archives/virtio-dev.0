Return-Path: <virtio-comment-return-3478-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 21 Nov 2022 11:30:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20221121162756.350032-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH RFC 0/3] virtio-rng based entropy leak reporting
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Cali, Marco" <xmarcalx@amazon.co.uk>, "Graf (AWS), Alexander" <graf@amazon.de>, "Chalios, Babis" <bchalios@amazon.es>, "Jason A. Donenfeld" <Jason@zx2c4.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Generally, entropy only grows. However, there are cases where
it goes down - for example, consider generating a one time
pad where someone managed to use a side channel to
steal its contents. By combining the seemingly random
pad with the stolen contents we have reversed the entropy.

This actually happens within VMs e.g. when time is reversed due
to snapshoting. Existing approaches for VMs include Microsoft's
VM GEN ID.

This draft proposes a feature in virtio rng for reporting such
leaks.

Patches 1,2 refactor existing draft text. Patch 3 adds new functionality.

TODO:
	document theory of operation
	add conformance clauses


Michael S. Tsirkin (3):
  rng: move to a file of its own
  rng: be specific about the virtqueue
  rng: leak detection support

 content.tex    |  43 +--------------------
 virtio-rng.tex | 102 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 42 deletions(-)
 create mode 100644 virtio-rng.tex

-- 
MST


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

