Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v4] virtio-net: Improve introductory description
Date: Sat, 11 Feb 2023 18:30:49 +0200
Message-ID: <20230211163049.261776-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The control VQ of the virtio network device is used beyond advance
steering control. The control VQ dynamically changes multiple features
of the initialized device.

Hence, update this area of control VQ introductory description at few
places and also place the link to its description.

Also update the introduction section to better describe receive and
transmit virtqueues.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/156
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
This patch is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00280.html
---
changelog:
v3->v4:
- write buffer add/remove, instead of enqueue/dequeue, post
v2->v3:
- further improve introduction
v1->v2:
- corrected/added article before transmit and receive virtqueue
- replaced listed with described
- updated set to negotiated for CTRL_VQ
- improved introduction wordings
v0->v1:
- replaced command queue to control virtqueue to reflect current state
- added link of control vq to its detailed section
- removed reference of cvq from more places that limits it to steering
- Addressed Cornelia's review comments:
- updated introduction section to better describe rq, sq, cvq.
- explicitly wrote that cvq is optional along with its feature bit
  related description
- dropped few items from Cornelia's review as they do not exactly
  fit with latest 1.2 specification as below.
  - avoided listing number of queues in introduction as its linked to q
    reset which can disable all queues
  - avoid mentioning cvq as optional as there is better section for it
  - avoid talking about queue pairs as spec and use cases allows not
    operate in pairs mode
---
 device-types/net/description.tex | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index 88a5770..09462bc 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -2,13 +2,15 @@ \section{Network Device}\label{sec:Device Types / Network=
 Device}
=20
 The virtio network device is a virtual network interface controller.
 It consists of a virtual Ethernet link which connects the device
-to the Ethernet network. It is the most complex of the devices
-supported so far by virtio. It has enhanced rapidly and demonstrates
-clearly how support for new features are added to an existing
-device. Empty buffers are placed in one virtqueue for receiving
-packets, and outgoing packets are enqueued into another for
-transmission in that order. A third command queue is used to
-control advanced filtering features.
+to the Ethernet network. The device has transmit and receive
+queues. The driver adds empty buffers to the receive virtqueue.
+The device receives incoming packets from the link; the device
+places these incoming packets in the receive virtqueue buffers.
+The driver adds outgoing packets to the transmit virtqueue. The device
+removes these packets from the transmit virtqueue and sends them to
+the link. The device may have a control virtuqueue. The driver
+uses the control virtqueue to dynamically manipulate various
+features of the initialized device.
=20
 \subsection{Device ID}\label{sec:Device Types / Network Device / Device ID=
}
=20
@@ -28,7 +30,8 @@ \subsection{Virtqueues}\label{sec:Device Types / Network =
Device / Virtqueues}
  N=3D1 if neither VIRTIO_NET_F_MQ nor VIRTIO_NET_F_RSS are negotiated, oth=
erwise N is set by
  \field{max_virtqueue_pairs}.
=20
- controlq only exists if VIRTIO_NET_F_CTRL_VQ set.
+controlq is optional; it only exists if VIRTIO_NET_F_CTRL_VQ is
+negotiated.
=20
 \subsection{Feature bits}\label{sec:Device Types / Network Device / Featur=
e bits}
=20
@@ -389,8 +392,8 @@ \subsection{Device Operation}\label{sec:Device Types / =
Network Device / Device O
 };
 \end{lstlisting}
=20
-The controlq is used to control device features such as
-filtering.
+The controlq is used to control many device features described further in
+section \ref{sec:Device Types / Network Device / Device Operation / Contro=
l Virtqueue}.
=20
 \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types =
/ Network Device / Device Operation / Legacy Interface: Device Operation}
 When using the legacy interface, transitional devices and drivers
--=20
2.26.2

