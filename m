Return-Path: <virtio-comment-return-3613-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sat, 24 Dec 2022 20:13:35 +0200
Message-ID: <20221224181335.74111-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH] virtio-network: Fix spelling errors
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Fix two spelling errors in the virtio network device specification.

This patch is on top of change of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202212/msg00042.html

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 virtio-network.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virtio-network.tex b/virtio-network.tex
index 92e3906..28ed343 100644
--- a/virtio-network.tex
+++ b/virtio-network.tex
@@ -331,7 +331,7 @@ \subsection{Device Initialization}\label{sec:Device Typ=
es / Network Device / Dev
   Otherwise, the driver assumes it's active.
=20
 \item A performant driver would indicate that it will generate checksumles=
s
-  packets by negotating the VIRTIO_NET_F_CSUM feature.
+  packets by negotiating the VIRTIO_NET_F_CSUM feature.
=20
 \item If that feature is negotiated, a driver can use TCP segmentation or =
UDP
   segmentation/fragmentation offload by negotiating the VIRTIO_NET_F_HOST_=
TSO4 (IPv4
@@ -1062,7 +1062,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Ty=
pes / Network Device / Devi
 \begin{itemize}
 \item VIRTIO_NET_CTRL_RX_PROMISC turns promiscuous mode on and
 off. The command-specific-data is one byte containing 0 (off) or
-1 (on). If promiscous mode is on, the device SHOULD receive all
+1 (on). If promiscuous mode is on, the device SHOULD receive all
 incoming packets.
 This SHOULD take effect even if one of the other modes set by
 a VIRTIO_NET_CTRL_RX class command is on.
--=20
2.26.2


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

