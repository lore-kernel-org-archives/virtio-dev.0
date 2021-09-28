Return-Path: <xuanzhuo@linux.alibaba.com>
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v4 1/3] virtio: introduce virtqueue reset as basic facility
Date: Tue, 28 Sep 2021 15:55:33 +0800
Message-Id: <20210928075535.100384-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20210928075535.100384-1-xuanzhuo@linux.alibaba.com>
References: <20210928075535.100384-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 content.tex | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/content.tex b/content.tex
index 37c45d3..05b05ba 100644
--- a/content.tex
+++ b/content.tex
@@ -407,6 +407,47 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
 types. It is RECOMMENDED that devices generate version 4
 UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
 
+\section{Virtqueue Reset}\label{sec:Virtqueues / Virtqueue Reset}
+
+When VIRTIO_F_RING_RESET is negotiated, the driver can reset a virtqueue
+individually. The way to reset the virtqueue is transport specific.
+
+Virtqueue reset is divided into two parts. The driver reset a queue
+first, and then re-enable the queue. The re-enable part is optional.
+
+\subsection{Virtqueue Reset}\label{sec:Virtqueues / Virtqueue Reset / Virtqueue Reset}
+
+\devicenormative{\subsubsection}{Virtqueue Reset}{Virtqueues / Virtqueue Reset / Virtqueue Reset}
+
+After a queue has been reset by the driver, the device MUST NOT execute
+any requests from that virtqueue, or notify the driver for it.
+
+The device MUST re-initialize any state of a virtqueue that has been
+reset, including available and used state.
+
+\drivernormative{\subsubsection}{Virtqueue Reset}{Virtqueues / Virtqueue Reset / Virtqueue Reset}
+
+After the driver tell the device to reset a queue, the driver MUST verify that
+the queue has actually been reset.
+
+After the queue has been successfully reset, the driver MAY release any
+resource associated with that virtqueue.
+
+\subsection{Virtqueue Re-enable}\label{sec:Virtqueues / Virtqueue Reset / Virtqueue Re-enable}
+
+This process is the same as the initialization process of a single queue during
+the initialization of the entire device.
+
+\devicenormative{\subsubsection}{Virtqueue Re-enable}{Virtqueues / Virtqueue Reset / Virtqueue Re-enable}
+
+The device MUST receive the new configuration from the driver. (i.e. the maximum
+Queue Size.)
+
+\drivernormative{\subsubsection}{Virtqueue Re-enable}{Virtqueues / Virtqueue Reset / Virtqueue Re-enable}
+
+The driver MUST apply for resources, set new configuration to the device, and
+finally activate the device.
+
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
 
 We start with an overview of device initialization, then expand on the
@@ -6673,6 +6714,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
   transport specific.
   For more details about driver notifications over PCI see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
 
+  \item[VIRTIO_F_RING_RESET(40)] This feature indicates
+  that the driver can reset a queue individually.
+  See \ref{sec:Virtqueues / Virtqueue Reset}.
+
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
-- 
2.31.0

