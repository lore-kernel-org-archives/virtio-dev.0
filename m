Return-Path: <virtio-dev-return-8755-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FCB09865FB
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Sep 2021 17:50:14 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Fri,  1 Oct 2021 01:50:06 +0800
Message-Id: <20210930175008.88352-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20210930175008.88352-1-xuanzhuo@linux.alibaba.com>
References: <20210930175008.88352-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v5 1/3] virtio: introduce virtqueue reset as basic facility
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: cohuck@redhat.com, jasowang@redhat.com
Cc: virtio-dev@lists.oasis-open.org
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
 content.tex | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/content.tex b/content.tex
index 37c45d3..dd095f4 100644
--- a/content.tex
+++ b/content.tex
@@ -350,6 +350,48 @@ \section{Virtqueues}\label{sec:Basic Facilities of a V=
irtio Device / Virtqueues}
 Every driver and device supports either the Packed or the Split
 Virtqueue format, or both.
=20
+\subsection{Virtqueue Reset}\label{sec:Basic Facilities of a Virtio Device=
 / Virtqueues / Virtqueue Reset}
+
+When VIRTIO_F_RING_RESET is negotiated, the driver can reset a virtqueue
+individually. The way to reset the virtqueue is transport specific.
+
+Virtqueue reset is divided into two parts. The driver first resets a queue=
 and
+can afterwards optionally re-enable it.
+
+\subsubsection{Virtqueue Reset}\label{sec:Basic Facilities of a Virtio Dev=
ice / Virtqueues / Virtqueue Reset / Virtqueue Reset}
+
+\devicenormative{\paragraph}{Virtqueue Reset}{Basic Facilities of a Virtio=
 Device / Virtqueues / Virtqueue Reset / Virtqueue Reset}
+
+After a queue has been reset by the driver, the device MUST NOT execute
+any requests from that virtqueue, or notify the driver for it.
+
+The device MUST reset any state of a virtqueue to be reset to the default =
state,
+including the available state and the used state.
+
+\drivernormative{\paragraph}{Virtqueue Reset}{Basic Facilities of a Virtio=
 Device / Virtqueues / Virtqueue Reset / Virtqueue Reset}
+
+After the driver tells the device to reset a queue, the driver MUST verify=
 that
+the queue has actually been reset.
+
+After the queue has been successfully reset, the driver MAY release any
+resource associated with that virtqueue.
+
+\subsubsection{Virtqueue Re-enable}\label{sec:Basic Facilities of a Virtio=
 Device / Virtqueues / Virtqueue Reset / Virtqueue Re-enable}
+
+This process is the same as the initialization process of a single queue d=
uring
+the initialization of the entire device.
+
+\devicenormative{\paragraph}{Virtqueue Re-enable}{Basic Facilities of a Vi=
rtio Device / Virtqueues / Virtqueue Reset / Virtqueue Re-enable}
+
+The device MUST observe any queue configuration that may have been
+changed by the driver, like the maximum queue size.
+
+\drivernormative{\paragraph}{Virtqueue Re-enable}{Basic Facilities of a Vi=
rtio Device / Virtqueues / Virtqueue Reset / Virtqueue Re-enable}
+
+When re-enabling a queue, the driver MUST configure the queue resources
+as during initial virtqueue discovery, but optionally with different
+parameters.
+
 \input{split-ring.tex}
=20
 \input{packed-ring.tex}
@@ -6673,6 +6715,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved F=
eature Bits}
   transport specific.
   For more details about driver notifications over PCI see \ref{sec:Virtio=
 Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And =
Device Operation / Available Buffer Notifications}.
=20
+  \item[VIRTIO_F_RING_RESET(40)] This feature indicates
+  that the driver can reset a queue individually.
+  See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueu=
e Reset}.
+
 \end{description}
=20
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
--=20
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

