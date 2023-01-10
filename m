Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v3 02/20] virtio-network: Fix spelling errors
Date: Wed, 11 Jan 2023 01:03:40 +0200
Message-ID: <20230110230358.528098-3-parav@nvidia.com>
In-Reply-To: <20230110230358.528098-1-parav@nvidia.com>
References: <20230110230358.528098-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Fix two spelling errors in the virtio network device specification.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/virtio-network/description.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/device-types/virtio-network/description.tex b/device-types/vir=
tio-network/description.tex
index 367681d..82d7374 100644
--- a/device-types/virtio-network/description.tex
+++ b/device-types/virtio-network/description.tex
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

