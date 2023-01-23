Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v5] virtio-net: Avoid confusion between a card and a device
Date: Mon, 23 Jan 2023 03:03:31 +0200
Message-ID: <20230123010331.803858-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, pasic@linux.ibm.com, jasowang@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Historically virtio network device is documented as an Ethernet card.
A modern card in the industry has one to multiple ports, one to multiple
PCI functions. However the virtio network device is usually just a
single link/port network interface controller.

Hence, avoid this confusing term 'card' and align the specification
to adhere to widely used specification term as 'device' used for all
virtio device types.

Replaced 'card' with 'network interface controller'.

This patch is on top of change [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202301/msg00210.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/154
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v4->v5:
- replaced 'network card' with 'device' in the device initialization
  section description
- net device checksum feature bit description updated
- rename card to network interface controller
v3->v4:
- rebased to new directory name
v2->v3:
- rebased to new file name
v1->v2:
- adapt to new file path
v0->v1:
- removed device word twice
- corrected grammar for changing from card to device
---
 content.tex                      |  6 +++---
 device-types/net/description.tex | 22 +++++++++++-----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/content.tex b/content.tex
index 0118b8a..df5ce16 100644
--- a/content.tex
+++ b/content.tex
@@ -619,7 +619,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Tran=
sport Options / Virtio Ov
 \hline
 Transitional PCI Device ID  &  Virtio Device    \\
 \hline \hline
-0x1000      &   network card     \\
+0x1000      &   network device     \\
 \hline
 0x1001     &   block device     \\
 \hline
@@ -635,7 +635,7 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Tran=
sport Options / Virtio Ov
 \hline
 \end{tabular}
=20
-For example, the network card device with the Virtio Device ID 1
+For example, the network device with the Virtio Device ID 1
 has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
=20
 The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
@@ -2912,7 +2912,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline \hline
 0          & reserved (invalid) \\
 \hline
-1          &   network card     \\
+1          &   network device     \\
 \hline
 2          &   block device     \\
 \hline
diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index d3f9b52..41ae7f5 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1,13 +1,14 @@
 \section{Network Device}\label{sec:Device Types / Network Device}
=20
-The virtio network device is a virtual ethernet card, and is the
-most complex of the devices supported so far by virtio. It has
-enhanced rapidly and demonstrates clearly how support for new
-features are added to an existing device. Empty buffers are
-placed in one virtqueue for receiving packets, and outgoing
-packets are enqueued into another for transmission in that order.
-A third command queue is used to control advanced filtering
-features.
+The virtio network device is a virtual network interface controller.
+It consist of a virtual Ethernet link which connects the device
+to the Ethernet network. It is the most complex of the devices
+supported so far by virtio. It has enhanced rapidly and demonstrates
+clearly how support for new features are added to an existing
+device. Empty buffers are placed in one virtqueue for receiving
+packets, and outgoing packets are enqueued into another for
+transmission in that order. A third command queue is used to
+control advanced filtering features.
=20
 \subsection{Device ID}\label{sec:Device Types / Network Device / Device ID=
}
=20
@@ -32,8 +33,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Network =
Device / Virtqueues}
 \subsection{Feature bits}\label{sec:Device Types / Network Device / Featur=
e bits}
=20
 \begin{description}
-\item[VIRTIO_NET_F_CSUM (0)] Device handles packets with partial checksum.=
   This
-  ``checksum offload'' is a common feature on modern network cards.
+\item[VIRTIO_NET_F_CSUM (0)] Device handles packets with partial checksum =
offload.
=20
 \item[VIRTIO_NET_F_GUEST_CSUM (1)] Driver handles packets with partial che=
cksum.
=20
@@ -323,7 +323,7 @@ \subsection{Device Initialization}\label{sec:Device Typ=
es / Network Device / Dev
=20
 \item If the VIRTIO_NET_F_MAC feature bit is set, the configuration
   space \field{mac} entry indicates the ``physical'' address of the
-  network card, otherwise the driver would typically generate a random
+  device, otherwise the driver would typically generate a random
   local MAC address.
=20
 \item If the VIRTIO_NET_F_STATUS feature bit is negotiated, the link
--=20
2.26.2

