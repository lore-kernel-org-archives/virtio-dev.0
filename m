Return-Path: virtio-dev-return-7526-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 521D89844F5
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Jul 2020 21:13:57 +0000 (UTC)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 06 Jul 2020 14:13:53 -0700
Message-ID: <20200706211314.20018.89695.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 0/3] virtio-balloon: Free page hinting clean-ups
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: david@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

This series contains a couple minor cleanups related to free page hinting.

The first patch addresses what I believe is a possible issue in which the
driver could potentially force the device out of the stop state and back
into the running state if it were to replay an earlier virtqueue element
containing the same ID it had submitted earlier.

The second patch takes care of a possible race due to a mutex lock not being
used when starting the hinting from the device-side.

The final patch takes care of renaming various hinting objects that were
using "reporting" in the name to try and clarify which objects are for free
page reporting and which are for free page hinting.

Changes from v1:
Split first patch into two patches as each addresses a separate issue.
Added acked-by for first patch.

---

Alexander Duyck (3):
      virtio-balloon: Prevent guest from starting a report when we didn't request one
      virtio-balloon: Add locking to prevent possible race when starting hinting
      virtio-balloon: Replace free page hinting references to 'report' with 'hint'


 hw/virtio/virtio-balloon.c         |   77 +++++++++++++++++++-----------------
 include/hw/virtio/virtio-balloon.h |   20 +++++----
 2 files changed, 51 insertions(+), 46 deletions(-)

--

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

