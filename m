Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH] virtio-net: Improve control vq introductory description
Date: Mon, 23 Jan 2023 03:16:51 +0200
Message-ID: <20230123011651.804147-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The control VQ of the virtio network device is used for controlling
multiple features, not just advanced steering control. The control VQ
dynamically changes multiple features of the initialized device.

Hence, update this area of control VQ introductory description.

This patch is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00272.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/156
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/net/description.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index 41ae7f5..56bd672 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -8,7 +8,7 @@ \section{Network Device}\label{sec:Device Types / Network D=
evice}
 device. Empty buffers are placed in one virtqueue for receiving
 packets, and outgoing packets are enqueued into another for
 transmission in that order. A third command queue is used to
-control advanced filtering features.
+dynamically manipulate various features of the initialized device.
=20
 \subsection{Device ID}\label{sec:Device Types / Network Device / Device ID=
}
=20
--=20
2.26.2

