Return-Path: <virtio-dev-return-9322-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02AD0986373
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 Feb 2022 06:52:46 +0000 (UTC)
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Tue, 22 Feb 2022 14:52:41 +0800
Message-Id: <20220222065241.89602-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v4] virtio-net: support reset queue
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch defines some requirements for virtio-net to support reset
queues.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 content.tex | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/content.tex b/content.tex
index c6f116c..45751f4 100644
--- a/content.tex
+++ b/content.tex
@@ -4337,6 +4337,10 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
 \field{virtqueue_pairs} once it has placed the
 VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command in a used buffer.
=20
+If the destination receive queue is in reset state(See \ref{sec:Basic Faci=
lities of a Virtio Device / Virtqueues / Virtqueue Reset}),
+the device SHOULD re-select a different random queue. If all receive queue=
s are
+in reset state, the device MUST drop the packet.
+
 \subparagraph{Legacy Interface: Automatic receive steering in multiqueue m=
ode}\label{sec:Device Types / Network Device / Device Operation / Control V=
irtqueue / Automatic receive steering in multiqueue mode / Legacy Interface=
: Automatic receive steering in multiqueue mode}
 When using the legacy interface, transitional devices and drivers
 MUST format \field{virtqueue_pairs}
@@ -4425,6 +4429,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
pes / Network Device / Devi
 \item Calculate the hash of the packet as defined in \ref{sec:Device Types=
 / Network Device / Device Operation / Processing of Incoming Packets / Has=
h calculation for incoming packets}.
 \item If the device did not calculate the hash for the specific packet, th=
e device directs the packet to the receiveq specified by \field{unclassifie=
d_queue} of virtio_net_rss_config structure (value of 0 corresponds to rece=
iveq1).
 \item Apply \field{indirection_table_mask} to the calculated hash and use =
the result as the index in the indirection table to get 0-based number of d=
estination receiveq (value of 0 corresponds to receiveq1).
+\item If the destination receive queue is in reset state(See \ref{sec:Basi=
c Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the devic=
e MUST drop the packet.
 \end{itemize}
=20
 \paragraph{Offloads State Configuration}\label{sec:Device Types / Network =
Device / Device Operation / Control Virtqueue / Offloads State Configuratio=
n}
--=20
2.31.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

