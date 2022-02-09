Return-Path: <virtio-dev-return-9287-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 291CA9863C3
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Feb 2022 09:02:03 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Wed,  9 Feb 2022 17:01:58 +0800
Message-Id: <20220209090158.49162-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio-net: support reset queue
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch defines some requirements for virtio-net to support reset
queues.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 conformance.tex |  2 ++
 content.tex     | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/conformance.tex b/conformance.tex
index 42f8537..52b4879 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -136,6 +136,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
 \item \ref{drivernormative:Device Types / Network Device / Device Operatio=
n / Packet Transmission}
 \item \ref{drivernormative:Device Types / Network Device / Device Operatio=
n / Setting Up Receive Buffers}
 \item \ref{drivernormative:Device Types / Network Device / Device Operatio=
n / Processing of Incoming Packets}
+\item \ref{drivernormative:Device Types / Network Device / Device Operatio=
n / Reset Virtqueue}
 \item \ref{drivernormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Packet Receive Filtering}
 \item \ref{drivernormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Setting MAC Address Filtering}
 \item \ref{drivernormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Gratuitous Packet Sending}
@@ -396,6 +397,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Packet Transmission}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Setting Up Receive Buffers}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Processing of Incoming Packets}
+\item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Reset Virtqueue}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Packet Receive Filtering}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Setting MAC Address Filtering}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Gratuitous Packet Sending}
diff --git a/content.tex b/content.tex
index c6f116c..ce8e37a 100644
--- a/content.tex
+++ b/content.tex
@@ -4000,6 +4000,25 @@ \subsubsection{Processing of Incoming Packets}\label=
{sec:Device Types / Network
 #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
 \end{lstlisting}
=20
+\subsubsection{Reset Virtqueue}\label{sec:Device Types / Network Device / =
Device Operation / Reset Virtqueue}
+
+The receive and transmission virtqueues can implement reset based on Virtq=
ueue
+Reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Vir=
tqueue Reset}).
+
+\drivernormative{\paragraph}{Gratuitous Packet Sending}{Device Types / Net=
work Device / Device Operation / Reset Virtqueue}
+
+The driver MUST NOT reset the control virtqueue.
+
+\devicenormative{\paragraph}{Gratuitous Packet Sending}{Device Types / Net=
work Device / Device Operation / Reset Virtqueue}
+
+After automatic receive steering or RSS receive steering has completed the
+selection of the queue, if the destination receive queue is in reset state=
,
+the device MUST re-select a different random queue. If all receive queues =
are in
+reset state, the device can drop the packet.
+
+A virtio-net device MUST support the above requirements in order to suppor=
t
+VIRTIO_F_RING_RESET.
+
 \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device =
/ Device Operation / Control Virtqueue}
=20
 The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
--=20
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

