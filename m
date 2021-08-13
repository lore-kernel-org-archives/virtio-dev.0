Return-Path: <virtio-dev-return-8515-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 74403986459
	for <virtio-dev@lists.oasis-open.org>; Fri, 13 Aug 2021 02:31:09 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Fri, 13 Aug 2021 10:31:05 +0800
Message-Id: <20210813023105.84658-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio: introduce VIRTIO_F_RING_RESET for reset queue
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This patch allows the driver to reset a queue individually.

This is very common on general network equipment. By disabling a queue,
you can quickly reclaim the buffer currently on the queue. If necessary,
we can reinitialize the queue separately.

For example, when virtio-net implements support for AF_XDP, we need to
disable a queue to release all the original buffers when AF_XDP setup.
And quickly release all the AF_XDP buffers that have been placed in the
queue when AF_XDP exits.

Since mmio's QueueReady allows setting 0 to stop the queue, there is no
need to distinguish whether VIRTIO_F_RING_RESET is negotiated.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 content.tex | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 7cec1c3..70a9765 100644
--- a/content.tex
+++ b/content.tex
@@ -1001,7 +1001,13 @@ \subsubsection{Common configuration structure layout=
}\label{sec:Virtio Transport
 After writing 0 to \field{device_status}, the driver MUST wait for a read =
of
 \field{device_status} to return 0 before reinitializing the device.
=20
-The driver MUST NOT write a 0 to \field{queue_enable}.
+If the VIRTIO_F_RING_RESET feature bit is not negotiated,
+the driver MUST NOT write a 0 to \field{queue_enable}.
+
+Otherwise, if the VIRTIO_F_RING_RESET feature bit is negotiated,
+the driver can stop using the queue by writing a 0 to \field{queue_enable}=
 and
+MUST read the value back to ensure synchronization. Then optionally re-ena=
ble
+the queue.
=20
 \subsubsection{Notification structure layout}\label{sec:Virtio Transport O=
ptions / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
=20
@@ -6672,6 +6678,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Fe=
ature Bits}
   transport specific.
   For more details about driver notifications over PCI see \ref{sec:Virtio=
 Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And =
Device Operation / Available Buffer Notifications}.
=20
+  \item[VIRTIO_F_RING_RESET(40)] This feature indicates
+  that the driver can reset a queue individually.
+
 \end{description}
=20
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
--=20
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

