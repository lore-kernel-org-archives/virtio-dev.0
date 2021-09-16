Return-Path: <virtio-dev-return-8670-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 59A7B9863D0
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Sep 2021 07:53:39 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Thu, 16 Sep 2021 15:53:33 +0800
Message-Id: <20210916075333.26772-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio: introduce VIRTIO_F_RING_RESET for reset queue
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch allows the driver to reset a queue individually.

This is very common on general network equipment. By disabling a queue,
you can quickly reclaim the buffer currently on the queue. If necessary,
we can reinitialize the queue separately.

For example, when virtio-net implements support for AF_XDP, we need to
disable a queue to release all the original buffers when AF_XDP setup.
And quickly release all the AF_XDP buffers that have been placed in the
queue when AF_XDP exits.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 content.tex | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/content.tex b/content.tex
index 3aeb4a4..235cbf9 100644
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
@@ -1964,9 +1970,15 @@ \subsection{MMIO Device Register Layout}\label{sec:V=
irtio Transport Options / Vi
 \field{QueueNum}, \field{QueueDescLow}, \field{QueueDescHigh},
 \field{QueueDriverLow}, \field{QueueDriverHigh}, \field{QueueDeviceLow}, \=
field{QueueDeviceHigh}.
=20
-To stop using the queue the driver MUST write zero (0x0) to this
+If the VIRTIO_F_RING_RESET feature bit is not negotiated,
+to stop using the queue the driver MUST write zero (0x0) to this
 \field{QueueReady} and MUST read the value back to ensure
-synchronization.
+synchronization. But the queue cannot be re-enabled.
+
+Otherwise, if the VIRTIO_F_RING_RESET feature bit is negotiated,
+the driver can stop using the queue by writing a 0 to \field{QueueReady} a=
nd
+MUST read the value back to ensure synchronization. Then optionally re-ena=
ble
+the queue.
=20
 The driver MUST ignore undefined bits in \field{InterruptStatus}.
=20
@@ -6673,6 +6685,20 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved F=
eature Bits}
   transport specific.
   For more details about driver notifications over PCI see \ref{sec:Virtio=
 Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And =
Device Operation / Available Buffer Notifications}.
=20
+  \item[VIRTIO_F_RING_RESET(40)] This feature indicates
+  that the driver can reset a queue individually.
+
+  "reset a queue" is divided into two parts. We can stop a queue first, an=
d then
+  re-enable the queue. The re-enable part is optional.
+
+  In the process of independently stopping a queue, we MUST first notify t=
he
+  device and confirm that we have successfully stopped a queue. Then we de=
stroy
+  the state and memory of the queue.
+
+  Re-enable the queue, just like the process of a queue during the reset p=
rocess.
+  Reallocate memory and set the state. For example, the avail index MUST b=
e the
+  same as the reset process, set to 0.
+
 \end{description}
=20
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
--=20
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

