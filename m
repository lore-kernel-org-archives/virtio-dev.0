Return-Path: <virtio-dev-return-8715-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C36B8986248
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Sep 2021 12:32:04 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Mon, 27 Sep 2021 20:31:52 +0800
Message-Id: <20210927123153.20242-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20210927123153.20242-1-xuanzhuo@linux.alibaba.com>
References: <20210927123153.20242-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 1/2] virtio: introduce virtqueue reset as basic facility
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: jasowang@redhat.com
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
 content.tex | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/content.tex b/content.tex
index 37c45d3..603b1f1 100644
--- a/content.tex
+++ b/content.tex
@@ -407,6 +407,43 @@ \section{Exporting Objects}\label{sec:Basic Facilities=
 of a Virtio Device / Expo
 types. It is RECOMMENDED that devices generate version 4
 UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
=20
+\section{Virtqueue Reset}\label{sec:Virtqueues / Virtqueue Reset}
+
+When VIRTIO_F_RING_RESET is negotiated, the driver can reset a virtqueue
+individually. The way to reset the virtqueue is transport specific.
+
+Virtqueue reset is divided into two parts. The driver MUST reset stop a qu=
eue
+first, and then re-enable the queue. The re-enable part is optional.
+
+\devicenormative{\subsection}{Virtqueue Reset Stop}{Virtqueues / Virtqueue=
 Reset}
+The device MUST not executes the requests from this virtqueue, and notify =
the
+driver.
+
+And the device MUST initialize all states of this virtqueue, including the
+available state and the used state.
+
+\drivernormative{\subsection}{Virtqueue Reset Stop}{Virtqueues / Virtqueue=
 Reset}
+
+The driver MUST first notify the device and confirm that we have successfu=
lly
+stopped a queue.
+
+Then the driver can release all the resources occupied by this virtqueue.
+And reinitialize the state of this queue.
+
+\devicenormative{\subsection}{Virtqueue Reset Re-enable}{Virtqueues / Virt=
queue Reset}
+
+This process is the same as the initialization process of a single queue d=
uring
+the initialization of the entire device. After the device has accepted all=
 the
+configuration from the driver, it will start working under the notificatio=
n of the
+driver.
+
+\drivernormative{\subsection}{Virtqueue Reset Re-enable}{Virtqueues / Virt=
queue Reset}
+
+This process is the same as the initialization process of a single queue d=
uring
+the entire device initialization process. After the driver allocates resou=
rces
+and completes the configuration of the queue status, it notifies the devic=
e to
+start working.
+
 \chapter{General Initialization And Device Operation}\label{sec:General In=
itialization And Device Operation}
=20
 We start with an overview of device initialization, then expand on the
@@ -6673,6 +6710,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved F=
eature Bits}
   transport specific.
   For more details about driver notifications over PCI see \ref{sec:Virtio=
 Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And =
Device Operation / Available Buffer Notifications}.
=20
+  \item[VIRTIO_F_RING_RESET(40)] This feature indicates
+  that the driver can reset a queue individually.
+  See \ref{sec:Virtqueues / Virtqueue Reset}.
+
 \end{description}
=20
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
--=20
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

