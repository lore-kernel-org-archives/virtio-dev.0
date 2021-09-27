Return-Path: <virtio-dev-return-8714-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD12798628C
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Sep 2021 12:31:58 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Mon, 27 Sep 2021 20:31:53 +0800
Message-Id: <20210927123153.20242-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20210927123153.20242-1-xuanzhuo@linux.alibaba.com>
References: <20210927123153.20242-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 2/2] virtio: pci support virtqueue reset
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: jasowang@redhat.com
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

PCI support virtqueue reset.

virtio_pci_common_cfg add "queue_reset" to support virtqueue reset.
The driver uses this to selectively reset the queue.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 content.tex | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/content.tex b/content.tex
index 603b1f1..35228dc 100644
--- a/content.tex
+++ b/content.tex
@@ -896,6 +896,7 @@ \subsubsection{Common configuration structure layout}\l=
abel{sec:Virtio Transport
         le64 queue_driver;              /* read-write */
         le64 queue_device;              /* read-write */
         le16 queue_notify_data;         /* read-only for driver */
+        le16 queue_reset;               /* read-write */
 };
 \end{lstlisting}
=20
@@ -975,6 +976,12 @@ \subsubsection{Common configuration structure layout}\=
label{sec:Virtio Transport
         may benefit from providing another value, for example an internal =
virtqueue
         identifier, or an internal offset related to the virtqueue number.
         \end{note}
+
+\item[\field{queue_reset}]
+        The driver uses this to selectively reset the queue.
+        This field exists only if VIRTIO_F_RING_RESET has been
+        negotiated. (see \ref{sec:Virtqueues / Virtqueue Reset}).
+
 \end{description}
=20
 \devicenormative{\paragraph}{Common configuration structure layout}{Virtio=
 Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common confi=
guration structure layout}
@@ -1016,6 +1023,14 @@ \subsubsection{Common configuration structure layout=
}\label{sec:Virtio Transport
=20
 The device MUST present a 0 in \field{queue_enable} on reset.
=20
+The device MUST present a 0 in \field{queue_reset} after the virtqueue is
+enabled with \field{queue_enable}. The device MUST reset the queue when 1 =
is
+written to \field{queue_reset}, and present a 1 in \field{queue_reset} unt=
il the
+queue is enabled with \field{queue_enable}. (see \ref{sec:Virtqueues / Vir=
tqueue Reset}).
+
+The device MUST present a 0 in \field{queue_enable} after the virtqueue is=
 reset
+with \field{queue_reset}. (see \ref{sec:Virtqueues / Virtqueue Reset}).
+
 The device MUST present a 0 in \field{queue_size} if the virtqueue
 corresponding to the current \field{queue_select} is unavailable.
=20
@@ -1040,6 +1055,12 @@ \subsubsection{Common configuration structure layout=
}\label{sec:Virtio Transport
=20
 The driver MUST NOT write a 0 to \field{queue_enable}.
=20
+If the VIRTIO_F_RING_RESET feature bit is negotiated, the driver can stop =
using
+the queue by writing a 1 to \field{queue_reset} and MUST read the value ba=
ck to
+ensure synchronization. Then optionally re-enable the queue by writing a 1=
 to
+\field{queue_enable} after configuring the other virtqueue fields. (see
+\ref{sec:Virtqueues / Virtqueue Reset}).
+
 \subsubsection{Notification structure layout}\label{sec:Virtio Transport O=
ptions / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
=20
 The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
--=20
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

