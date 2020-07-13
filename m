Return-Path: virtio-dev-return-7546-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4212E985CDD
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Jul 2020 20:35:42 +0000 (UTC)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 13 Jul 2020 13:35:39 -0700
Message-ID: <20200713203539.17140.71425.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio-balloon: Document byte ordering of poison_val
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: david@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

The poison_val field in the virtio_balloon_config is treated as a
little-endian field by the host. Since we are currently only having to deal
with a single byte poison value this isn't a problem, however if the value
should ever expand it would cause byte ordering issues. Document that in
the code so that we know that if the value should ever expand we need to
byte swap the value on big-endian architectures.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/virtio/virtio_balloon.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f157d2f4952..d0fd8f8dc6ed 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -974,6 +974,11 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		/*
 		 * Let the hypervisor know that we are expecting a
 		 * specific value to be written back in balloon pages.
+		 *
+		 * If the PAGE_POISON value was larger than a byte we would
+		 * need to byte swap poison_val here to guarantee it is
+		 * little-endian. However for now it is a single byte so we
+		 * can pass it as-is.
 		 */
 		if (!want_init_on_free())
 			memset(&poison_val, PAGE_POISON, sizeof(poison_val));


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

